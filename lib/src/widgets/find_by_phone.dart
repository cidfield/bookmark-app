import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mixins/validation_mixins.dart';
import '../widgets/employee_result.dart';
import '../models/employee.dart';
import '../widgets/employee_list.dart';
import '../mixins/fetch_api_mixins.dart';
import '../models/filtered_employees.dart';

class FindByPhone extends StatefulWidget {
  final List<Employee> employees;
  FindByPhone(this.employees);
  createState() {
    return FindByPhoneState(this.employees);
  }
}

class FindByPhoneState extends State<FindByPhone>
    with ValidationMixins, FetchApiMixins {
   final List<Employee> employees;
  FindByPhoneState(this.employees);
  TextEditingController nameFieldController = new TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    print(employees.length);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'دليل الهاتف',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearchByNumber(employees));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'القائمة',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: Color(0xffc8973b)),
            ),
            ListTile(
              title: Text('الخروج'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => SystemNavigator.pop(),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[],
        ),
      )),
    );
  }
}
