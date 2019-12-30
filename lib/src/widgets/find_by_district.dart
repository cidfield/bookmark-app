import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mixins/validation_mixins.dart';
import '../widgets/employee_result.dart';
import '../models/employee.dart';
import '../widgets/employee_list.dart';
import '../mixins/fetch_api_mixins.dart';
import '../models/filtered_employees.dart';
import '../widgets/districts_list.dart';

// class FindByDistrict extends StatefulWidget {
//   createState() {
//     return FindByDistrictState();
//   }
// }

class FindByDistrict extends StatelessWidget 
    with ValidationMixins, FetchApiMixins {
    final List<Employee> employees;
    final List<String> districts;
  FindByDistrict(this.employees, this.districts);

  Widget build(BuildContext context) {
    //  print(districts.length);
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'دليل الهاتف',
            style: TextStyle(color: Colors.white),
          )),
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
      body: Column(
        children: <Widget>[
          Card(child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xffc8973b),
              foregroundColor: Colors.white,
              child: Icon(Icons.work),
            ),
            title: Text(
              'الدوائر المتواجدة في محكمة القضاء الإداري',
              style: TextStyle(color: Color(0xffc8973b), fontSize: 13.5),
            ),
            isThreeLine: false,
          ),),
          
          Expanded(child: DistrictList(employees, districts)),
        ],
      ),
    );
  }
}
