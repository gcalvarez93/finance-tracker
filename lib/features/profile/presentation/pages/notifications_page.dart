// Path: lib/features/profile/presentation/pages/notifications_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_provider.dart';
import '../widgets/notification_tile.dart';

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
        notificationsTransactions:
        notificationsTransactions ?? profile.notificationsTransactions,
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
          NotificationTile(
            title: l10n.notificationsGeneral,
            subtitle: l10n.notificationsGeneralSubtitle,
            value: profile.notificationsGeneral,
            onChanged: (value) => save(notificationsGeneral: value),
          ),
          NotificationTile(
            title: l10n.notificationsTransactions,
            subtitle: l10n.notificationsTransactionsSubtitle,
            value: profile.notificationsTransactions,
            onChanged: (value) => save(notificationsTransactions: value),
          ),
          NotificationTile(
            title: l10n.notificationsBudgets,
            subtitle: l10n.notificationsBudgetsSubtitle,
            value: profile.notificationsBudgets,
            onChanged: (value) => save(notificationsBudgets: value),
          ),
          NotificationTile(
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