import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/context_extension.dart';
import 'package:todo_app/presentations/screens/home/widget/check_box_item_list.dart';
import 'package:todo_app/presentations/screens/remove/remove_screen.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/styles/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController titleController;
  late final TextEditingController subtitleController;
  final CollectionReference taskCollection = 
  FirebaseFirestore.instance.collection('Tasks');

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    subtitleController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    subtitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ToDo App',
          style: AppTextStyles.appBarTitleStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const RemoveScreen(),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 30,
                  ),
                  if (taskProvider.removedTasks.isNotEmpty)
                    Positioned(
                      top: 5,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child:
                            Text(taskProvider.removedTasks.length.toString()),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: taskCollection.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData){
              return const Center(child:CircularProgressIndicator());
          }
          //List documents = snapshot.data!.docs;
          List<QueryDocumentSnapshot<Map<String,dynamic>>> documents =
           snapshot.data!.docs;

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: documents.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
            Map item = documents[index].data();
              return CheckBoxItemList(
                  item: item,
                  taskProvider: taskProvider,
                  index: index,
                  //taskList: taskProvider.taskList);
                  taskList: documents);
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: taskProvider.indexList.isEmpty
            ? const Icon(Icons.add_rounded)
            : const Icon(Icons.delete),
        onPressed: () {
          if (taskProvider.indexList.isEmpty) {
            triggerBottomSheet();
          }else{
           //taskProvider.removeTask();
           taskCollection.get().then((value) {
             for(var element in value.docs){
                 taskCollection.doc(element.id)
                 .update({
                'isRemoved':true,
              });
           }
           });    
          //       taskCollection.doc('3XRINREJ0uDMAsHgni9W').update({'isRemoved':true})
          //  .then((value) => print('update data'));
          }
         
        },
      ),
    );
  }

  void triggerBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView(
                shrinkWrap: true,
                padding: context.paddingAll24,
                children: [
                  TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Title',
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                      controller: subtitleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Subtitle',
                      )),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(context.deviceWidth, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        // Provider.of<TaskProvider>(context, listen: false)
                        //     .addTask(
                        //   CheckBoxItemListModel(
                        //     title: titleController.text,
                        //     subtitle: subtitleController.text,
                        //   ),
                        // );
                         taskCollection.add({
                         'title':titleController.text,
                         'subtitle':subtitleController.text,
                         //'isChecked':true,
                        //  'color':null,
                          'isRemoved': false,
                        });
                        titleController.clear();
                        subtitleController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Add')),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          );
        });
  }
}
