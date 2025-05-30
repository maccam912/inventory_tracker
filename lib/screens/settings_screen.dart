import 'package:flutter/material.dart';
import '../settings/deletion_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deletionSettings = DeletionSettingsProvider.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Card(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Danger!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Enable Deletion',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Switch(
                        value: deletionSettings.isDeletionEnabled,
                        onChanged: (value) {
                          deletionSettings.toggleDeletion(value);
                        },
                      ),
                    ],
                  ),
                  if (deletionSettings.isDeletionEnabled)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Warning: Deletion is currently enabled. You can now delete items from the inventory.',
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        ),
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
}
