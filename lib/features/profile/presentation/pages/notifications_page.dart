// Path: lib/features/profile/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final profileState = ref.watch(profileProvider);

    if (profileState is! ProfileLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final profile = profileState.profile;

    Future<void> save({
      bool? notificationsGeneral,
      bool? notificationsTransactions,
      bool? notificationsBudgets,
      bool? notificationsReports,
    }) async {
      await ref.read(profileProvider.notifier).updateProfile(
        name: profile.name,
        language: profile.language,
        notifications: profile.notifications,
        notificationsGeneral: notificationsGeneral ?? profile.notificationsGeneral,
        notificationsTransactions: notificationsTransactions ?? profile.notificationsTransactions,
        notificationsBudgets: notificationsBudgets ?? profile.notificationsBudgets,
        notificationsReports: notificationsReports ?? profile.notificationsReports,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.notifications),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _NotificationTile(
            title: l10n.notificationsGeneral,
            subtitle: l10n.notificationsGeneralSubtitle,
            value: profile.notificationsGeneral,
            onChanged: (value) => save(notificationsGeneral: value),
          ),
          _NotificationTile(
            title: l10n.notificationsTransactions,
            subtitle: l10n.notificationsTransactionsSubtitle,
            value: profile.notificationsTransactions,
            onChanged: (value) => save(notificationsTransactions: value),
          ),
          _NotificationTile(
            title: l10n.notificationsBudgets,
            subtitle: l10n.notificationsBudgetsSubtitle,
            value: profile.notificationsBudgets,
            onChanged: (value) => save(notificationsBudgets: value),
          ),
          _NotificationTile(
            title: l10n.notificationsReports,
            subtitle: l10n.notificationsReportsSubtitle,
            value: profile.notificationsReports,
            onChanged: (value) => save(notificationsReports: value),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
              Switch(value: value, onChanged: onChanged, activeColor: Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}