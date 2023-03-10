import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Database/Database.dart';
import 'package:untitled3/Database/database_model.dart';
import 'package:untitled3/update_user.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Users> users = [];
  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  void getAllUsers() async {
    await DatabaseHelper.instanse.initDatabase();
    users = await DatabaseHelper.instanse.getDataFromDatabase();
    setState(() {

    });
  }
  void searchOnUsersList(String pattern)async
  {
    users = await DatabaseHelper.instanse.getDataFromDatabase();
    users = users.where((element) => element.userName.contains(pattern)).toList();
    setState(() {

    });
  }
  void searchUsers(String pattern)async
  {
      if(pattern.isEmpty)
      {
        users =await DatabaseHelper.instanse.getDataFromDatabase();
      }
      else
      {
        users = users.where((element) => element.userName.contains(pattern)).toList();
      }
      setState(() {

      });
  }
  void searehOnDatabase(String pattern) async {
    users = await DatabaseHelper.instanse.search(pattern);
    if (kDebugMode) {
      print(users);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                hintText: 'Search a user',
              ),
              onChanged: (pattern) async
              {
                searchOnUsersList(pattern);
                if (kDebugMode) {
                  print(pattern);
                }
              } ,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => Card(
                elevation: 3,
                child: ListTile(
                  title: Text(users[index].userName),
                  subtitle: Text(users[index].email),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: ()
                          {
                            Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => Update(
                                    id: users[index].id,
                                    userName: users[index].userName,
                                    email: users[index].email,
                                  ),
                                ),

                            );
                          }, icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: ()
                          {
                            showDialog(
                              context: context,
                              builder: (context) =>  AlertDialog(
                                title: const Text('Are you sure to delete this ?'),
                                actions: [
                                  MaterialButton(
                                    onPressed: ()
                                    {
                                      DatabaseHelper.instanse.deleteItem(users[index].id).then((value)
                                      {
                                        if (kDebugMode) {
                                          print('Deleted successfully');
                                        }
                                      });
                                      Navigator.pop(context);
                                    },child: const Text('Delete'),),
                                  MaterialButton(
                                    onPressed: ()
                                    {
                                      Navigator.pop(context);
                                      if (kDebugMode) {
                                        print('Canceled');
                                      }
                                    },child:const Text('Cancel'),)
                                ],
                              ),
                            );

                          }, icon: const Icon(Icons.delete,color: Colors.red,)),

                    ],
                  ),
                ),
              ),
              itemCount: users.length,
            ),
          ),
        ],
      ),
    );
  }
}
