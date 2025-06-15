import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_exports.dart';
import '../profile_exports.dart';

class SettingsDrawer extends StatelessWidget {
  final BuildContext dialogContext;
  const SettingsDrawer({super.key, required this.dialogContext});

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Settings",
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: SettingsDrawer(dialogContext: dialogContext),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0), // Slide from left
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget buildListTile(BuildContext context, IconData icon, String text,
      {IconData? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.visible,
            ),
          ),
          if (trailing != null) Icon(trailing, color: Colors.black),
        ],
      ),
      onTap: onTap ?? () => Navigator.pop(dialogContext),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 0), // Reduce padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onInverseSurface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Consumer<ProfileService>(
          builder: (context, profileService, child) {
            final user = profileService.userData;

            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 80),
                user.authProvider != 'email'
                    ? const SizedBox.shrink()
                    : buildListTile(
                        context,
                        LucideIcons.lockKeyhole,
                        'Change Password',
                        trailing: LucideIcons.chevronRight,
                        onTap: () {
                          dialogContext.push('/change_password');
                        },
                      ),
                buildListTile(
                  context,
                  LucideIcons.bell,
                  'Notifications',
                  trailing: LucideIcons.chevronRight,
                  onTap: () {
                    dialogContext.push('/notificationscreen');
                  },
                ),
                buildListTile(
                  context,
                  LucideIcons.bookmark,
                  'Saved Treks',
                  trailing: LucideIcons.chevronRight,
                  onTap: () {
                    dialogContext.push('/savedtreks');
                  },
                ),
                buildListTile(
                  context,
                  LucideIcons.mountain,
                  'My Treks',
                  trailing: LucideIcons.chevronRight,
                  onTap: () {
                    dialogContext.push('/mytreks');
                  },
                ),
                user.isOrganizer == true
                    ? buildListTile(
                        context,
                        LucideIcons.hammer,
                        'Organizer a Trek',
                        trailing: LucideIcons.chevronRight,
                        onTap: () {
                          dialogContext.push('/addtreks');
                        },
                      )
                    : buildListTile(
                        context,
                        LucideIcons.hammer,
                        'Become an organizer',
                        trailing: LucideIcons.chevronRight,
                        onTap: () {
                          dialogContext.push('/becometrekorganizer');
                        },
                      ),
                buildListTile(
                  context,
                  LucideIcons.headset,
                  'Support',
                  trailing: LucideIcons.chevronRight,
                  onTap: () {
                    dialogContext.push('/support-page');
                  },
                ),
                buildListTile(
                  context,
                  LucideIcons.clipboardList,
                  'Terms & Conditions',
                  trailing: LucideIcons.chevronRight,
                  onTap: () {
                    dialogContext.push('/terms-conditions');
                  },
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 237, 41, 27),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(
                    LucideIcons.logOut,
                    color: Colors.white,
                  ),
                  label: const Text('Sign Out'),
                  onPressed: () {
                    context.pop();
                    Provider.of<AuthServices>(context, listen: false)
                        .logout(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
