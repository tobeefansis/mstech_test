import 'package:flutter/material.dart';
import 'package:flutter_glass_morphism/flutter_glass_morphism.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/glass_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const _privacyPolicyUrl =
      'https://example.com/privacy'; // TODO: Replace with real URL

  Future<void> _openPrivacyPolicy(BuildContext context) async {
    final uri = Uri.parse(_privacyPolicyUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Не удалось открыть ссылку')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: GlassMorphismAppBar(
          backgroundColor: const Color(0xFF4A2B70),

          title: const Text(
            'Настройки',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // ── About ────────────────────────────────────────────────────────
          _SectionHeader(label: 'О приложении'),
          const SizedBox(height: 10),
          _GlassCard(
            children: const [
              _InfoRow(
                icon: Icons.apps_rounded,
                label: 'Название',
                value: 'MSTech App',
              ),
              _InfoRow(
                icon: Icons.tag_rounded,
                label: 'Версия',
                value: '1.0.0',
              ),
              _InfoRow(icon: Icons.build_rounded, label: 'Сборка', value: '1'),
            ],
          ),

          const SizedBox(height: 28),

          // ── Developer ────────────────────────────────────────────────────
          _SectionHeader(label: 'Разработчик'),
          const SizedBox(height: 10),
          _GlassCard(
            children: const [
              _InfoRow(
                icon: Icons.person_rounded,
                label: 'Компания',
                value: 'MSTech',
              ),
              _InfoRow(
                icon: Icons.email_rounded,
                label: 'Контакт',
                value: 'support@mstech.dev',
              ),
              _InfoRow(
                icon: Icons.language_rounded,
                label: 'Сайт',
                value: 'mstech.dev',
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ── Legal ────────────────────────────────────────────────────────
          _SectionHeader(label: 'Правовая информация'),
          const SizedBox(height: 10),

          SizedBox(
            height: 52,
            child: GlassMorphismButton(
              onPressed: () => _openPrivacyPolicy(context),
              style: GlassMorphismButtonStyle(
                backgroundColor: const Color(0xFF8B6FF9),
                borderRadius: BorderRadius.circular(16),
                blurIntensity: 12,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.privacy_tip_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Политика конфиденциальности',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ─── Section header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.5),
        letterSpacing: 0.8,
      ),
    );
  }
}

// ─── Glass info card ──────────────────────────────────────────────────────────

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassMorphismMaterial(
      blurIntensity: 20,
      opacity: 0.12,
      glassThickness: 1.5,
      borderRadius: BorderRadius.circular(20),
      enableGlassBorder: true,
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Divider(
                height: 1,
                indent: 52,
                color: Colors.white.withValues(alpha: 0.1),
              ),
          ],
        ],
      ),
    );
  }
}

// ─── Info row ─────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF9C8FFF)),
          const SizedBox(width: 14),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}
