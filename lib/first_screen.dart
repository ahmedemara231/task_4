import 'package:flutter/material.dart';
import 'package:untitled3/Database/Database.dart';
import 'package:untitled3/Database/database_model.dart';
import 'package:untitled3/Shared_prefs.dart';
import 'package:untitled3/second_screen.dart';
import 'main.dart';

ValueNotifier<bool> darkMode = ValueNotifier(false);
CacheHelper cacheHelper = CacheHelper();

class FirstScreen extends StatefulWidget {
   const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // var mode = cacheHelper.getMode(key: 'darkMode');
  var userNameCont = TextEditingController();
  var emailCont = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cacheHelper.init();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users App'),
        actions: [
          IconButton(
              onPressed: ()
                {
                  setState(() {
                    darkMode.value= !darkMode.value;
                  });
                  print(darkMode.value);
                  cacheHelper.setMode(key: 'darkMode', value: darkMode.value).then((value)
                  {
                    print('value : $value');
                  });
                }, icon: darkMode.value? const Icon(Icons.nights_stay) : const Icon(Icons.sunny)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (userName) {
                  if (userName!.isEmpty) {
                    return 'This Field is required';
                  }
                  return null;
                },
                controller: userNameCont,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 2),
                  ),
                  hintText: 'User Name',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'This Field is required';
                  }
                  return null;
                },
                controller: emailCont,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2),
                    ),
                    hintText: 'email'
                ),
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        DatabaseHelper.instanse
                            .insertIntoDatabase(Users(
                                userName: userNameCont.text,
                                email: emailCont.text)).then((value) {
                          userNameCont.clear();
                          emailCont.clear();
                          debugPrint('$value');
                        });
                      }
                    },
                    child: Text(
                      'Add User',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SecondScreen(),
                          ));
                    },
                    child: Text(
                      'View users',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
