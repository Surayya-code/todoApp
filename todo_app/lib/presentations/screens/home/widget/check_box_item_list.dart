import 'package:flutter/material.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/styles/app_text_styles.dart';
import '../../../../themes/app_colors.dart';
import '../viewmodels/checkbox_list_item_model.dart';

class CheckBoxItemList extends StatefulWidget {
  final TaskProvider taskProvider;
  final CheckBoxItemListModel item;
  final int index;
  final List<CheckBoxItemListModel> taskList;
  
  const CheckBoxItemList({
    super.key,
    required this.item,
    required this.taskProvider,
    required this.index,
    required this.taskList,
  });

  @override
  State<CheckBoxItemList> createState() => _CheckBoxItemListState();
}

class _CheckBoxItemListState extends State<CheckBoxItemList> {

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.taskList[widget.index].isChecked,
      controlAffinity: ListTileControlAffinity.leading,
      tileColor: AppColors.tileColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(widget.item.title,
        style: AppTextStyles.listTileTitleStyle(widget.taskList[widget.index].isChecked),
      ),
      subtitle: Text(
        widget.item.subtitle,
        style: AppTextStyles.listTileSubtitleStyle(false),
      ),
      onChanged: (value) {
        widget.taskList[widget.index].isChecked = value!;
        if(value){
          widget.taskProvider.addChecksIndex(widget.index);
        }else{
          widget.taskProvider.removeChecksIndex(widget.index);
        }
        setState(() {
          
        });
      },
    );
  }
}


// secondary: GestureDetector(
      //     onTap: () {
      //       widget.taskProvider.removeAt(widget.index);
      //     },
      //     child: const Icon(
      //       Icons.delete_rounded,
      //       color: AppColors.trashIconColor,
      //     )),