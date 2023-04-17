import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_first_demo/firebaseCore_feature/cloud_query.dart';
import 'package:firebase_first_demo/login_feature/login_screen.dart';
import 'package:firebase_first_demo/register_feature/core/Auth.dart';
import 'package:firebase_first_demo/register_feature/core/login_auth.dart';
import 'package:firebase_first_demo/utils/DialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final nauth = context.read<Auth>();
    final nloginauth = context.read<LoginAuth>();
    final livedata = LiveDataFetch();
    String? name, age;
    String? server_name, server_age;
    //using flutte_bloc object access created on app start
    return Scaffold(
      appBar: AppBar(
        title: Text(' Live Firebase Data'),
        actions: [
          IconButton(
            onPressed: () {
              nauth.signOut();
              nloginauth.removeLoginDetails();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: StreamBuilder<QuerySnapshot>(
              stream: livedata.GetAllDocuments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Extract the data from QuerySnapshot
                  List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      // Access the fields in the DocumentSnapshot
                      //  String documentId = documents[index].id;
                      // Access the fields in the DocumentSnapshot
                      try {
                        Map<String, dynamic> data = documents[index].data()
                            as Map<String,
                                dynamic>; // Cast to Map<String, dynamic>
                        server_name = data['name'] as String;
                        server_age = data['age'] as String;
                      } on Exception catch (e) {
                        print(e.toString());
                      }

                      // Create widgets to represent each list item
                      return ListTile(
                        title: Text('$server_name'),
                        subtitle: Text('Age: $server_age'),
                        onTap: () {
                          // Handle item tap
                        },
                      );
                    },
                  );
                } else {
                  return Text('No data found');
                }
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        DialogUtils dialogUtils = DialogUtils(
                          funcreturn: (nm, ag) {
                            setState(() {
                              name = nm;
                              age = ag;
                            });
                          },
                          context: context,
                          title: 'ADD TO SERVER',
                          onTap: () {
                            livedata.addDocument(name: name, age: age);
                          },
                        );
                      },
                      child: const Text('Add to server'))))
        ],
      ),
    );
  }
}
