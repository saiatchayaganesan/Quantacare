import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qc/screens/features/health_monitoring/sensor_data_screen.dart';
import 'package:qc/screens/features/Settings/faq_page.dart';
import 'package:qc/screens/features/Settings/privacy_policy_page.dart';
import 'package:qc/screens/features/Settings/terms_page.dart';
import 'package:qc/main.dart';  // ✅ Import main.dart to access QuantacareAppState


class SettingsPage extends StatefulWidget {
  final User user;

  const SettingsPage({super.key, required this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  final List<BluetoothDevice> _connectedDevices = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _getConnectedDevices();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
      _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
      _selectedLanguage = prefs.getString('selected_language') ?? 'English';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', _notificationsEnabled);
    await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
    await prefs.setString('selected_language', _selectedLanguage);
  }

  Future<void> _getConnectedDevices() async {
    var devices = FlutterBluePlus.connectedDevices;
    setState(() {
      _connectedDevices.clear();
      _connectedDevices.addAll(devices);
    });
  }

  Future<void> _startScanAndNavigate(BuildContext context) async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SensorDataScreen(),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildDeviceCard(BluetoothDevice device) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.bluetooth_connected, color: Colors.blue),
        title: Text(device.platformName),
        subtitle: Text(device.remoteId.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Device specific settings
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildSettingsSection(
              'Profile',
              [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.photoURL ?? ''),
                  ),
                  title: Text(widget.user.displayName ?? ''),
                  subtitle: Text(widget.user.email ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Edit profile functionality
                    },
                  ),
                ),
              ],
            ),

            // Connected Devices
            _buildSettingsSection(
              'Connected Devices',
              [
                ..._connectedDevices.map(_buildDeviceCard),
                ListTile(
                  title: const Text('Connect New Device'),
                  leading: const Icon(Icons.add_circle_outline),
                  onTap: () => _startScanAndNavigate(context),
                ),
              ],
            ),

            // App Settings
            _buildSettingsSection(
              'App Settings',
              [
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Enable push notifications'),
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                      _saveSettings();
                    });
                  },
                ),

                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  value: _darkModeEnabled,
                  onChanged: (bool value) async {
                    setState(() {
                      _darkModeEnabled = value;
                    });

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('dark_mode_enabled', value);

                    // Find the QuantacareApp state and toggle the theme
                    final appState = context.findAncestorStateOfType<QuantacareAppState>();
                    appState?.toggleTheme(value);
                  },
                ),



                ListTile(
                  title: const Text('Language'),
                  subtitle: Text(_selectedLanguage),
                  leading: const Icon(Icons.language),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Select Language'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('English'),
                              onTap: () {
                                setState(() {
                                  _selectedLanguage = 'English';
                                  _saveSettings();
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            // Help & Support
            _buildSettingsSection(
              'Help & Support',
              [
                ListTile(
                  title: const Text('FAQs'),
                  leading: const Icon(Icons.help_outline),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FAQPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Privacy Policy'),
                  leading: const Icon(Icons.policy),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Terms of Service'),
                  leading: const Icon(Icons.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TermsOfServicePage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            // App Information
            _buildSettingsSection(
              'About',
              [
                const ListTile(
                  title: Text('Version'),
                  subtitle: Text('1.0.0'),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '© ${DateTime.now().year} Quantacare',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
