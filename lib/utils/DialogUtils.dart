import 'package:flutter/material.dart';

class DialogUtils {
  late VoidCallback onTap;
  late BuildContext context;
  late String title, content;
  late Function(String, String) funcreturn;
  TextEditingController name_controller = TextEditingController();
  TextEditingController age_controller = TextEditingController();
  DialogUtils({
    required this.context,
    this.title = 'TITLE',
    this.content = 'Add content',
    required this.onTap,
    required this.funcreturn,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Set the M
              children: [
                const Center(
                  child: Text(
                    'TITLE',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                TextField(
                  controller: name_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: age_controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter age',
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (name_controller.text.isEmpty ||
                          age_controller.text.isEmpty) {
                        print('add something first');
                        return;
                      }
                      funcreturn(name_controller.text, age_controller.text);
                      onTap();
                      Navigator.pop(context);
                    },
                    child: const Text('Add'))
              ],
            ),
          ),
        );
      },
    );
  }
}
