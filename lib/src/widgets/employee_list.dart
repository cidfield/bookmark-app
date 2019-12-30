import 'package:flutter/material.dart';
import '../models/employee.dart';
import 'package:url_launcher/url_launcher.dart';



class EmployeeList extends StatelessWidget {
  final List<Employee> employees;
  final Color colorRetrieved;
  final Color secondaryColor = Color(0xffac110c);

  EmployeeList(this.employees, this.colorRetrieved);

  

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: buildEmployee(employees[index]),
        );
      },
    );
  }

  Widget buildEmployee(Employee employee) {
    String gsmNumberIs = 'رقم المحول: ';
    String mobileNumberIs = 'رقم المحمول: ';
    String empFullName = employee.shortNameWithTitle();
    String empDistrict = '${employee.district}';
    double fontSizeForName;
    double fontSizeForDistrict;
    if (empFullName.length >= 27) {
      fontSizeForName = 11.8;
    } else {
      fontSizeForName = 14.0;
    }

    if (empDistrict.length >= 27) {
      fontSizeForDistrict = 11.0;
    } else {
      fontSizeForDistrict = 12.0;
    }

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
            child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                child: ListTile(
                    leading: Transform.scale(
                      child: CircleAvatar(
                        backgroundColor:  colorRetrieved,
                        foregroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 25,
                        ),
                      ),
                      scale: 2,
                    ),
                    title: Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        empFullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSizeForName,
                        ),
                      ),
                    ),
                    subtitle: Container(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        empDistrict,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeForDistrict,
                            color: Colors.grey),
                      ),
                    ))),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
              child: Text(
                'بيانات الموظف',
                style: TextStyle(color: colorRetrieved, fontSize: 15),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, right: 20, bottom: 5, left: 40),
              child: Divider(),
            ),
            Container(
                padding:
                    EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.work,
                    color: colorRetrieved
                  ),
                  title: Container(
                    child: Text(
                      '${employee.designation == '' ? 'لا يوجد مسمى وظيفي له' : employee.designation}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )),
            Container(
                padding:
                    EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: colorRetrieved,
                  ),
                  title: Container(
                    child: Text(
                      '${employee.gsm == '' ? 'لا يوجد رقم محول له' : gsmNumberIs + employee.gsm}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(top: 0, right: 33, bottom: 0, left: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 0),
                  leading: Icon(
                    Icons.phone_android,
                    color: colorRetrieved,
                  ),
                  trailing: FloatingActionButton(
                    backgroundColor: (colorRetrieved != secondaryColor ? colorRetrieved : secondaryColor),
                    mini: true,
                    child: Icon(
                      Icons.phone,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      employee.mobile.toString() == ''
                          ? showAlertSnackBar()
                          : launch("tel:" + employee.mobile.toString());
                    },
                  ),
                  title: Container(
                    child: Text(
                      '${employee.mobile.toString() == '' ? 'لا يوجد رقم محمول له' : mobileNumberIs + employee.mobile.toString()}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )),
            Container(
                padding:
                    EdgeInsets.only(top: 0, right: 20, bottom: 0, left: 20),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: colorRetrieved,
                  ),
                  title: Container(
                    child: Text(
                      '${employee.email == null ? 'لا يوجد ايميل له' : employee.email}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ))
          ],
        )));
  }

  Widget showAlertSnackBar() {
    return SnackBar(
      content: Text('عذرا, لا يوجد رقم متوفر لهذا الموظف.'),
      duration: Duration(milliseconds: 2500),
      backgroundColor: Colors.red,
    );
  }
}
