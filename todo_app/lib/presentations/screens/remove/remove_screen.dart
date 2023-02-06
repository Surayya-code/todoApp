import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentations/screens/home/widget/check_box_item_list.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/styles/app_text_styles.dart';

import '../../../themes/app_colors.dart';
import '../home/viewmodels/checkbox_list_item_model.dart';

class RemoveScreen extends StatelessWidget {
  const RemoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Removed Tasks", style: AppTextStyles.appBarTitleStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.delete_forever_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: taskProvider.removedTasks.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          CheckBoxItemListModel item = taskProvider.removedTasks[index];
          return Dismissible(
            key: Key(item.toString()),
            background: Container(
            color: AppColors.primaryColor),
            onDismissed:(direction) {
              if(direction.name=='enToStart'){

              }else{

              }
            },
            child: GestureDetector(
              onLongPress: () {
                print('longpressed');
              },
              child: CheckBoxItemList(
                index: index,
                item: item,
                taskProvider: taskProvider,
                taskList: taskProvider.removedTasks,
              ),
            ),
          );
        },
      ),
    );
  }
}
