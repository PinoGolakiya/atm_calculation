import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app_srk/view/practice_view_local/practice_controller.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({Key? key}) : super(key: key);

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final practiceController = Get.put<PracticeController>(PracticeController());

  @override
  void initState() {
    practiceController.getDataName();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Add name',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SafeArea(
          top: false,
          bottom: false,
          child: GetBuilder(
            init: PracticeController(),
            builder: (controller) => ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: controller.name,
                  keyboardType: TextInputType.name,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      controller.insertData();
                      controller.storeData();
                      controller.name.clear();
                    },
                    child: const Text('Submit')),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.listData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.listData[index]),
                      leading: IconButton(
                          onPressed: () {
                            controller.nameEdit.text =
                                controller.listData[index];
                            editDeleteDialog(index, 'edit');
                          },
                          icon: const Icon(Icons.edit)),
                      trailing: IconButton(
                          onPressed: () {
                            editDeleteDialog(index, 'delete');
                          },
                          icon: const Icon(Icons.delete)),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }

  editDeleteDialog(int index, String type) {
    final practiceController =
        Get.put<PracticeController>(PracticeController());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          title: Text(type == "edit" ? 'Edit' : 'Delete'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              type == "edit"
                  ? TextField(
                      controller: practiceController.nameEdit,
                      keyboardType: TextInputType.name,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onChanged: (value) {},
                    )
                  : const SizedBox(),
              type == 'delete'
                  ? const Text('Are you sure you want delete??')
                  : const SizedBox(),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    type == "edit"
                        ? practiceController.updateData(index)
                        : practiceController.deleteData(index);
                  },
                  child: const Text('Submit')),
            ],
          ),
        );
      },
    );
  }
}
