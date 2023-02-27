import 'package:flutter/cupertino.dart';
import 'package:todo_app/presentations/screens/home/viewmodels/checkbox_list_item_model.dart';

class TaskProvider with ChangeNotifier {
  List<CheckBoxItemListModel> taskList = [];
  List<CheckBoxItemListModel> removedTasks = [];
  List indexList = [];
  List documentList=[];

  void addTask(CheckBoxItemListModel item) {
    taskList.add(item);
    notifyListeners();
  }

  void removeTask() {
    taskList.removeWhere((task) {
      if (task.isChecked == true) {
        removedTasks.add(task);
      }
      return task.isChecked == true;
    });

    for (var task in removedTasks) {
      if (task.isChecked == true) {
        task.isChecked = false;
      }
    }
    indexList.clear();
    notifyListeners();
  }

  void addChecksIndex(int index) {
    indexList.add(index);
    notifyListeners();
  }

  void removeChecksIndex(index) {
    indexList.remove(index);
    notifyListeners();
  }

  void getCheckedDocuments(bool value,String id){
    if(value){
      documentList.add(id);
    }else{
       documentList.remove(id);
    }
  }
}
