class SettingsService {
  SettingsService._();

  static final SettingsService instance = SettingsService._();

  AppSettings _settings = const AppSettings(notificationsEnabled: true);

  Future<AppSettings> getSettings() async {
    await Future.delayed(const Duration(milliseconds: 180));
    return _settings;
  }

  Future<AppSettings> updateNotifications(bool enabled) async {
    await Future.delayed(const Duration(milliseconds: 180));
    _settings = _settings.copyWith(notificationsEnabled: enabled);
    return _settings;
  }
}

class AppSettings {
  const AppSettings({
    required this.notificationsEnabled,
  });

  final bool notificationsEnabled;

  AppSettings copyWith({
    bool? notificationsEnabled,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}
