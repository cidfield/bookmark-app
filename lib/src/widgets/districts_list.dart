import 'package:employee_bookmark/src/mixins/fetch_api_mixins.dart';
import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../widgets/employee_result.dart';
import '../widgets/employee_list.dart';
import '../app.dart';

class DistrictList extends StatelessWidget with FetchApiMixins {
  final List<Employee> employees;
  final List<String> districts;

  DistrictList(this.employees, this.districts);

  Widget build(context) {

    return FutureBuilder(
      future: returnResponse(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: districts.length,
            itemBuilder: (context, int index) {
              return buildDistricts(context, employees, districts[index]);
            },
          );
        } else {
           return new Center(child: CircularProgressIndicator());
        }
      },
    );
    // return ListView.builder(
    //   itemCount: districts.length,
    //   itemBuilder: (context, int index) {
    //     return buildDistricts(context, employees, districts[index]);
    //   },
    // );
  }

 

  Widget buildDistricts(
      BuildContext context, List<Employee> employees, String district) {
    employees = employees.where((emp) => emp.district == district).toList();
    return Container(
      padding: EdgeInsets.only(top: 0, right: 5, bottom: 0, left: 5),
      child: ExpansionTile(
        title: Text(
          district,
          style: TextStyle(color: Color(0xffc8973b), fontSize: 13),
        ),
        subtitle: Text('عدد الموظفين فيها: ${employees.length}',
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        children: employees
            .map(
              (emp) => ListTile(
                contentPadding: EdgeInsets.only(right: 25, bottom: 0, top: 0),
                leading: Icon(
                  Icons.person,
                  size: 22,
                  color: Color(0xffc8973b),
                ),
                title: Text(
                  emp.shortNameWithTitle(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {
                  int selectedEmpId = emp.id;

                  final selectedEmployee = employees
                      .where((emp) => emp.id == selectedEmpId)
                      .toList();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EmployeeResult(EmployeeList(
                        selectedEmployee.toList(), Color(0xffc8973b)));
                  }));
                },
              ),
            )
            .toList(),
      ),
    );
  }

  returnEmpsForEachDistrict(String district) {
    ListView.builder(
      itemCount: employees.length,
      itemBuilder: (context, int index) {
        return ListTile(
          contentPadding: EdgeInsets.only(right: 25, bottom: 0, top: 0),
          leading: Icon(
            Icons.person,
            size: 22,
            color: Color(0xffc8973b),
          ),
          title: Text(
            employees[index].district == district
                ? employees[index].district
                : false,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        );
      },
    );
  }
}
