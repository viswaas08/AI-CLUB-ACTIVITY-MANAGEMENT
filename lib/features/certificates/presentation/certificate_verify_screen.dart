import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/repositories/certificate_repository.dart';
import '../domain/models/certificate_model.dart';

class CertificateVerifyScreen extends ConsumerStatefulWidget {
  final String certificateId;

  const CertificateVerifyScreen({super.key, required this.certificateId});

  @override
  ConsumerState<CertificateVerifyScreen> createState() =>
      _CertificateVerifyScreenState();
}

class _CertificateVerifyScreenState extends ConsumerState<CertificateVerifyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _stampController;
  late Animation<double> _stampScaleAnimation;
  late Animation<double> _stampOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _stampController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _stampScaleAnimation = CurvedAnimation(
      parent: _stampController,
      curve: Curves.elasticOut,
    );

    _stampOpacityAnimation = CurvedAnimation(
      parent: _stampController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _stampController.forward();
  }

  @override
  void dispose() {
    _stampController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final certAsync = ref.watch(publicCertificateProvider(widget.certificateId));

    return Scaffold(
      backgroundColor: const Color(0xFF1E2124),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: certAsync.when(
              loading: () => _buildLoadingState(),
              error: (err, _) => _buildErrorCard(err.toString()),
              data: (cert) => cert == null
                  ? _buildNotFoundCard()
                  : _buildTactileCertificateCard(cert),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTactileCertificateCard(CertificateModel cert) {
    final isValid = cert.status == CertificateStatus.valid;
    final formattedDate = DateFormat('MMMM dd, yyyy').format(cert.issueDate);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF282B30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF383C42), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            offset: Offset(8, 12),
            blurRadius: 24,
          ),
          BoxShadow(
            color: Color(0x1AFFFFFF),
            offset: Offset(-2, -2),
            blurRadius: 6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header Plaque
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.shield_outlined, color: Color(0xFF7289DA), size: 24),
                  SizedBox(width: 8),
                  Text(
                    "AUTHENTIC RECORD",
                    style: TextStyle(
                      color: Color(0xFFB9BBBE),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2124),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  cert.certificateNumber,
                  style: const TextStyle(
                    color: Color(0xFF99AAB5),
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Certificate Subject Details
          Text(
            cert.achievementTitle.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Awarded by ${cert.clubName}",
            style: const TextStyle(color: Color(0xFF7289DA), fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),

          // Recessed Student Details Plaque
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2124),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66000000),
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "THIS CERTIFIES THAT",
                  style: TextStyle(color: Color(0xFF72767D), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                const SizedBox(height: 6),
                Text(
                  cert.studentName,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Roll No: ${cert.studentRollNo}",
                  style: const TextStyle(color: Color(0xFFB9BBBE), fontSize: 12),
                ),
                const SizedBox(height: 12),
                Text(
                  "For successfully completing and participating in '${cert.eventTitle}'.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFFDCDDDE), fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Verification Status Seal & Stamp
          ScaleTransition(
            scale: _stampScaleAnimation,
            child: FadeTransition(
              opacity: _stampOpacityAnimation,
              child: _buildVerificationStamp(isValid, cert.revocationReason),
            ),
          ),
          const SizedBox(height: 28),

          // Metadata Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetaItem("DATE ISSUED", formattedDate),
              _buildMetaItem("ISSUED BY", cert.issuerName),
            ],
          ),
          const SizedBox(height: 32),

          // Download Action Button (Tactile Skeuomorphic)
          if (isValid)
            GestureDetector(
              onTap: () => launchUrl(Uri.parse(cert.pdfUrl)),
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4752C4), Color(0xFF3C45A5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF5865F2)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x66000000),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Color(0x33FFFFFF),
                      offset: Offset(0, -1),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "DOWNLOAD OFFICIAL PDF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerificationStamp(bool isValid, String? reason) {
    final borderColor = isValid ? const Color(0xFF43B581) : const Color(0xFFF04747);
    final bgColor = isValid ? const Color(0x1A43B581) : const Color(0x1AF04747);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.2),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isValid ? Icons.verified_rounded : Icons.cancel_rounded,
            color: borderColor,
            size: 28,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isValid ? "CERTIFICATE VERIFIED & VALID" : "CERTIFICATE REVOKED",
                style: TextStyle(
                  color: borderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              if (!isValid && reason != null)
                Text(
                  "Reason: $reason",
                  style: const TextStyle(color: Color(0xFFF04747), fontSize: 11),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF72767D), fontSize: 10, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF282B30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFF7289DA)),
      ),
    );
  }

  Widget _buildNotFoundCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF282B30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.warning_amber_rounded, color: Color(0xFFFAA61A), size: 48),
          SizedBox(height: 16),
          Text(
            "Certificate Not Found",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "The requested certificate ID does not exist on this ledger.",
            style: TextStyle(color: Color(0xFFB9BBBE), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF282B30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("Error verifying certificate: $error", style: const TextStyle(color: Colors.redAccent)),
    );
  }
}
