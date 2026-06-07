// Path: lib/features/profile/presentation/pages/language_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/profile_provider.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('es'));

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final profileState = ref.watch(profileProvider);
    final currentLanguage = profileState is ProfileLoaded
        ? profileState.profile.language
        : currentLocale.languageCode;

    Future<void> changeLanguage(String language) async {
      ref.read(localeProvider.notifier).state = Locale(language);
      if (profileState is ProfileLoaded) {
        final p = profileState.profile;
        await ref.read(profileProvider.notifier).updateProfile(
          name: p.name,
          language: language,
          notifications: p.notifications,
          notificationsGeneral: p.notificationsGeneral,
          notificationsTransactions: p.notificationsTransactions,
          notificationsBudgets: p.notificationsBudgets,
          notificationsReports: p.notificationsReports,
        );
      }
      if (context.mounted) Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.language),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _LanguageTile(
            flag: '🇪🇸',
            language: 'Español',
            code: 'es',
            isSelected: currentLanguage == 'es',
            onTap: () => changeLanguage('es'),
          ),
          _LanguageTile(
            flag: '🇬🇧',
            language: 'English',
            code: 'en',
            isSelected: currentLanguage == 'en',
            onTap: () => changeLanguage('en'),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String flag;
  final String language;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.flag,
    required this.language,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 1,
        child: ListTile(
          leading: Text(flag, style: const TextStyle(fontSize: 28)),
          title: Text(language, style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}