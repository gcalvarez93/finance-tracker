// Path: lib/features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/profile_option.dart';
import 'edit_profile_page.dart';
import 'notifications_page.dart';
import 'language_page.dart';
import 'help_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authProvider);
    final user = authState is AuthAuthenticated ? authState.user : null;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(l10n.navProfile),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              backgroundImage:
              user?.photoUrl != null ? NetworkImage(user!.photoUrl!) : null,
              child: user?.photoUrl == null
                  ? Text(
                user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(user?.name ?? 'Usuario',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(user?.email ?? '',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
            const SizedBox(height: 32),
            ProfileOption(
              icon: Icons.person_outline,
              title: l10n.editProfile,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              ),
            ),
            ProfileOption(
              icon: Icons.notifications_outlined,
              title: l10n.notifications,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              ),
            ),
            ProfileOption(
              icon: Icons.language_outlined,
              title: l10n.language,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguagePage()),
              ),
            ),
            ProfileOption(
              icon: Icons.help_outline,
              title: l10n.help,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HelpPage()),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async => ref.read(authProvider.notifier).logout(),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(l10n.logout,
                    style: const TextStyle(color: Colors.red, fontSize: 16)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}