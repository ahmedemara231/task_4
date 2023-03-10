import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:untitled3/Database/Database.dart';
import 'package:untitled3/Database/database_model.dart';

class Update extends StatefulWidget {
   int? id;
   String userName;
   String email;
   Update({
     Key? key,
     required this.id,
     required this.userName,
     required this.email,
   });

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  var userNameCont = TextEditingController();
  @override
  void initState() {
    userNameCont.text = widget.userName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              onFieldSubmitted: (newUser)
              {
                DatabaseHelper.instanse.updateData('$newUser', widget.id).then((value)
                {
                  Navigator.pop(context);
                  print('updated');
                });
              } ,
              controller: userNameCont,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
