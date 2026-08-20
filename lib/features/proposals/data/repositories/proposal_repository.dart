import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../backend/firebase_providers.dart';
import '../../../../core/data/sample_seeds.dart';
import '../../domain/models/proposal_model.dart';

abstract class ProposalRepository {
  Stream<List<ProposalModel>> streamProposals();
  Future<void> submitProposal(ProposalModel proposal);
  Future<void> upvoteProposal(String proposalId, String userId);
}

class FirestoreProposalRepository implements ProposalRepository {
  final FirebaseFirestore _firestore;

  FirestoreProposalRepository(this._firestore);

  @override
  Stream<List<ProposalModel>> streamProposals() {
    try {
      return _firestore
          .collection('proposals')
          .snapshots()
          .map((snap) {
            final list = snap.docs.map((d) {
              final data = d.data();
              return ProposalModel.fromJson({'id': d.id, ...data});
            }).toList();
            return list.isNotEmpty ? list : SampleSeeds.proposals;
          })
          .handleError((_) => SampleSeeds.proposals);
    } catch (_) {
      return Stream.value(SampleSeeds.proposals);
    }
  }

  @override
  Future<void> submitProposal(ProposalModel proposal) async {
    try {
      final docRef = _firestore.collection('proposals').doc();
      final data = proposal.copyWith(id: docRef.id).toJson();
      await docRef.set(data);
    } catch (_) {}
  }

  @override
  Future<void> upvoteProposal(String proposalId, String userId) async {
    try {
      final docRef = _firestore.collection('proposals').doc(proposalId);
      await _firestore.runTransaction((tx) async {
        final snap = await tx.get(docRef);
        if (!snap.exists) return;
        final data = snap.data()!;
        final upvotedUsers = List<String>.from(data['upvotedUserIds'] ?? []);
        int count = (data['upvoteCount'] as int? ?? 0);

        if (upvotedUsers.contains(userId)) {
          upvotedUsers.remove(userId);
          count = mathMax(0, count - 1);
        } else {
          upvotedUsers.add(userId);
          count += 1;
        }

        tx.update(docRef, {
          'upvoteCount': count,
          'upvotedUserIds': upvotedUsers,
          if (count >= 50 && data['status'] == 'pending') 'status': 'escalated',
        });
      });
    } catch (_) {}
  }

  int mathMax(int a, int b) => a > b ? a : b;
}

final proposalRepositoryProvider = Provider<ProposalRepository>((ref) {
  return FirestoreProposalRepository(ref.watch(firebaseFirestoreProvider));
});

final proposalsStreamProvider = StreamProvider<List<ProposalModel>>((ref) {
  return ref.watch(proposalRepositoryProvider).streamProposals();
});
