import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          // ── About the App ──────────────────────────────────────────────────
          Text(
            'О приложении',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
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
              _InfoRow(
                icon: Icons.build_rounded,
                label: 'Сборка',
                value: '1',
              ),
            ],
          ),

          const SizedBox(height: 28),

          // ── Developer ──────────────────────────────────────────────────────
          Text(
            'Разработчик',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          _InfoCard(
            children: [
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

          // ── Legal ──────────────────────────────────────────────────────────
          Text(
            'Правовая информация',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            onPressed: () => _openPrivacyPolicy(context),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.privacy_tip_rounded),
                SizedBox(width: 10),
                Text(
                  'Политика конфиденциальности',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reusable card ────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Divider(
                height: 1,
                indent: 52,
                color: Theme.of(
                  context,
                ).colorScheme.outline.withValues(alpha: 0.15),
              ),
          ],
        ],
      ),
    );
  }
}

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
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.primary),
          const SizedBox(width: 14),
          Text(label, style: theme.textTheme.bodyMedium),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
