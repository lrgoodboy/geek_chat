import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geek_chat/controller/chat_list_controller.dart';
import 'package:geek_chat/controller/chat_message_controller.dart';
import 'package:geek_chat/models/session.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatListComponent extends StatelessWidget {
  ChatListComponent({super.key});

  ChatMessageController chatMessageController =
      Get.find<ChatMessageController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatListController>(builder: ((controller) {
      return ListView(
        padding: const EdgeInsets.only(
            left: 10.0, top: 0.0, right: 20.0, bottom: 0.0),
        children: [
          for (SessionModel sm in controller.sessions)
            Slidable(
              key: ValueKey("itemid-${sm.sid}"),
              // ignore: sort_child_properties_last
              child: SizedBox(
                  height: 58,
                  child: ListTile(
                    // dense: true,
                    title: Text(
                      sm.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      sm.promptContent,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: const Icon(Icons.chat_bubble_outline_outlined),
                    trailing: const Icon(Icons.chevron_right_outlined),
                    onTap: () {
                      Get.toNamed('/chat', parameters: {'sid': sm.sid});
                    },
                  )),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (value) {
                    // controller.remove(sm.sid);
                    chatMessageController.cleanSessionMessages(sm.sid);
                    controller.remove(sm);
                    controller.reloadSessions();
                    controller.update();
                  },
                  icon: Icons.delete,
                  label: 'Delete'.tr,
                ),
                SlidableAction(
                  onPressed: (value) {
                    Get.toNamed('/editchat',
                        parameters: {'opt': 'edit', 'sid': sm.sid});
                  },
                  icon: Icons.mode_edit_outline,
                  label: 'Edit'.tr,
                )
              ]),
            )
        ],
      );
    }));
  }
}
