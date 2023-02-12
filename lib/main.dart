import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formkey = GlobalKey<FormState>();
  String firstname = '';
  String lasttname = '';
  String selectedGender = '';
  int age = 0;
  bool _isOption1 = false;
  bool _isOption2 = false;
  bool _isOption3 = false;
  List<String> selectedOptions = [];
  void _onRadioButtonChange(String value) {
    setState(() {
      selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              const Text('Firstname'),
              TextFormField(
                onSaved: (value) => setState(() {
                  firstname = value!;
                }),
              ),
              const Text('Lastirstname'),
              TextFormField(
                onSaved: (value) => setState(() {
                  lasttname = value!;
                }),
              ),
              const Text('Age'),
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) => setState(() {
                  age = int.parse(value!);
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text('Male'),
                  Radio(
                      value: 'Male',
                      groupValue: selectedGender,
                      onChanged: (value) => _onRadioButtonChange(value!)),
                  const Text('Female'),
                  Radio(
                      value: 'Female',
                      groupValue: selectedGender,
                      onChanged: (value) => _onRadioButtonChange(value!)),
                ],
              ),
              const Text('Symtompse'),
              Column(
                children: [
                  CheckboxListTile(
                      title: Text('ไอ'),
                      value: _isOption1,
                      onChanged: (val) {
                        setState(() {
                          _isOption1 = !_isOption1;
                          if (_isOption1) {
                            selectedOptions.add('ไอ');
                          } else {
                            selectedOptions.remove('ไอ');
                          }
                        });
                      })
                ],
              ),
              Column(
                children: [
                  CheckboxListTile(
                      title: Text('เจ็บคอ'),
                      value: _isOption2,
                      onChanged: (val) {
                        setState(() {
                          _isOption2 = !_isOption2;
                          if (_isOption2) {
                            selectedOptions.add('เจ็บคอ');
                          } else {
                            selectedOptions.remove('เจ็บคอ');
                          }
                        });
                      })
                ],
              ),
              Column(
                children: [
                  CheckboxListTile(
                      title: Text('มีไข้'),
                      value: _isOption3,
                      onChanged: (val) {
                        setState(() {
                          _isOption3 = !_isOption3;
                          if (_isOption3) {
                            selectedOptions.add('มีไข้');
                          } else {
                            selectedOptions.remove('มีไข้');
                          }
                        });
                      })
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState?.save();
                    print(firstname);
                    print(lasttname);
                    print(selectedGender);
                    print(selectedOptions);
                    print('save');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Page1(
                          firstname: firstname,
                          lasttname: lasttname,
                          age: age,
                          gender: selectedGender,
                          symtomps: selectedOptions,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  // ignore: use_key_in_widget_constructors

  const Page1(
      {required this.firstname,
      required this.lasttname,
      required this.age,
      required this.gender,
      required this.symtomps});

  final String firstname;
  final String lasttname;
  final int age;
  final String gender;
  final List<String> symtomps;
  final String description = 'We are united';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
                'https://www.tnnthailand.com/static/images/29bbdb0e-531a-4fb1-92a0-796577a6c1ca.jpg'),
            covidDetect(symtomps),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Page2(
              description: description,
            ),
          ),
        ),
        child: Text('ยืนยัน'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget covidDetect(List<String> symtomps) {
    if (symtomps.length == 3) {
      return Container(
        width: 300,
        height: 300,
        child: Center(
            child: Text('คุณ $firstname $lasttname อายุ $age คุณเป็นโควิด')),
      );
    } else {
      return Container(
        width: 300,
        height: 300,
        child: Center(
            child: Text('คุณ $firstname $lasttname อายุ $age คุณไม่เป็นโควิด')),
      );
    }
  }
}

// ignore: use_key_in_widget_constructors
class Page2 extends StatelessWidget {
  final String description;

  const Page2({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page2'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Text(description),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('BACK'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
