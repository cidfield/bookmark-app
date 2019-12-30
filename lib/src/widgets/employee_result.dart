

import 'package:flutter/material.dart';
import '../widgets/employee_list.dart';

class EmployeeResult extends StatelessWidget {
  final EmployeeList employees;
  EmployeeResult(this.employees, );
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child:  Scaffold(
      appBar: AppBar(title: Text('نتائج البحث', style: TextStyle(color: Colors.white),), iconTheme: IconThemeData(color:Colors.white)),
      body: employees,
    ) ,);
  }
}