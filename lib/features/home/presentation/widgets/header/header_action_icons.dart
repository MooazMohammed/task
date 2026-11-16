import 'package:flutter/material.dart';
import 'more_menu_button.dart';
import 'notification_bell_button.dart';
import 'chat_action_button.dart';

/// The 3 action icons on the left of header: [More (3 lines)] [Notification Bell] [Chat]
class HeaderActionIcons extends StatelessWidget {
  final VoidCallback onOpenMore;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onChatTap;
  final int notificationCount;
  final int chatCount;

  const HeaderActionIcons({
    super.key,
    required this.onOpenMore,
    this.onNotificationsTap,
    this.onChatTap,
    this.notificationCount = 2,
    this.chatCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MoreMenuButton(onTap: onOpenMore),
          const SizedBox(width: 10),
          NotificationBellButton(badge: notificationCount, onTap: onNotificationsTap),
          const SizedBox(width: 10),
          ChatActionButton(badge: chatCount, onTap: onChatTap),
        ],
      ),
    );
  }
}
