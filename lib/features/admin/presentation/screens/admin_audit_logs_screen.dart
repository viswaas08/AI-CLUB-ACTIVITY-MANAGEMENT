import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/skeuo_theme.dart';
import '../../application/admin_providers.dart';

class AdminAuditLogsScreen extends ConsumerWidget {
  const AdminAuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(adminAuditLogsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.terminal_rounded, color: SkeuoColors.activeGreen, size: 28),
              const SizedBox(width: 10),
              Text(
                'IMMUTABLE AUDIT LOGS LEDGER',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Terminal-style real-time audit feed tracking all administrative triggers, certificate mints, and role changes.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Green-on-Black Terminal Screen
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFF0D1117),
              border: Border.all(color: SkeuoColors.activeGreen, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: SkeuoColors.activeGreen,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.circle, color: Colors.red, size: 10),
                    SizedBox(width: 6),
                    Icon(Icons.circle, color: Colors.yellow, size: 10),
                    SizedBox(width: 6),
                    Icon(Icons.circle, color: Colors.green, size: 10),
                    SizedBox(width: 12),
                    Text(
                      'root@aiclubs-portal:~/audit-logs# tail -f /var/log/audit.log',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: SkeuoColors.activeGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Divider(color: SkeuoColors.activeGreen, height: 24),

                logsAsync.when(
                  data: (logs) {
                    if (logs.isEmpty) {
                      return const Text(
                        '[SYSTEM LOG] No administrative audit entries recorded yet.\n[READY] Awaiting event triggers...',
                        style: TextStyle(fontFamily: 'monospace', color: SkeuoColors.activeGreen, fontSize: 13),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '[${log.timestamp.toIso8601String()}] ACTION: ${log.action} | TARGET: ${log.targetCollection}/${log.targetDocumentId} | BY: ${log.performedByUserId}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              color: SkeuoColors.activeGreen,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  loading: () => const Text('[SYS] Connecting to Firestore audit log stream...', style: TextStyle(fontFamily: 'monospace', color: SkeuoColors.activeGreen)),
                  error: (err, stack) => Text('[SYS ERROR] $err', style: const TextStyle(fontFamily: 'monospace', color: Colors.redAccent)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
