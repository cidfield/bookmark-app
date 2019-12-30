import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mixins/validation_mixins.dart';
import '../widgets/employee_result.dart';
import '../models/employee.dart';
import '../widgets/employee_list.dart';
import '../mixins/fetch_api_mixins.dart';
import '../models/filtered_employees.dart';

class FindByName extends StatefulWidget {
  final List<Employee> employees;
  FindByName(this.employees);
  createState() {
    return FindByNameState(this.employees);
  }
}

class FindByNameState extends State<FindByName>
    with ValidationMixins, FetchApiMixins {
  final List<Employee> employees;
  FindByNameState(this.employees);
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    // print(employees.length);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:Colors.white),
        title: Text('دليل الهاتف', style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(employees));
            },
          )
        ],
        
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('القائمة', style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                color: Color(0xffc8973b)
              ),
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
          children: <Widget>[

          ],
        ),
      )),
    );
  }

  // Widget findByNameRadioListTile() {
  //   return RadioListTile(
  //     value: 1,
  //     title: Text("البحث عن طريق الإسم الأول"),
  //     subtitle: Text("يمكنك إيجاد معلومات الموظف عن طريقة كتابة اسمه الأول"),
  //     groupValue: selectedRadio,
  //     activeColor: Colors.blue,
  //     onChanged: (val) {
  //       setSelectedRadio(val);
  //     },
  //   );
  // }

  // Widget findByAnyNameRadioListTile() {
  //   return RadioListTile(
  //     value: 2,
  //     title: Text("البحث عن طريق أي اسم او قبيلة"),
  //     subtitle: Text(
  //         "يمكنك إيجاد معلومات الموظف عن طريقة كتابة اي جزء من اسمه او القبيلة"),
  //     groupValue: selectedRadio,
  //     activeColor: Colors.blue,
  //     onChanged: (val) {
  //       setSelectedRadio(val);
  //     },
  //   );
  // }

  // Widget nameField() {
  //   return TextFormField(
  //     textInputAction: TextInputAction.go,
  //     controller: nameFieldController,
  //     validator: validateName,
  //     decoration: InputDecoration(
  //       labelText: 'الإسم',
  //       hintText: 'فيصل',
  //     ),
  //     onFieldSubmitted: (term) {
  //       Iterable<Employee> mappedEmployees;

  //       setState(() {
  //         isLoading = true;
  //       });

  //       Future.delayed(const Duration(milliseconds: 400), () {
  //         if (formKey.currentState.validate()) {
  //           if (selectedRadio == 1) {
  //             mappedEmployees = FilteredEmployees()
  //                 .findByFirstName(employees, nameFieldController.text.trim());
  //           } else if (selectedRadio == 2) {
  //             mappedEmployees = FilteredEmployees()
  //                 .findByAnyName(employees, nameFieldController.text.trim());

  //             // for (var i = 0; i < nameFieldController.text.trim().length; i++) {
  //             //   print(nameFieldController.text.trim()[i]);
  //             // }
  //           }

  //           // print(FilteredEmployees()
  //           //     .predictedNames(employees, nameFieldController.text.trim()));
  //           // print(selectedRadio);
  //           // print(FilteredEmployees().isTheNameSpecial(nameFieldController.text.trim()));

  //           // print(employees);

  //           if (mappedEmployees.length > 0) {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) {
  //               return EmployeeResult(EmployeeList(mappedEmployees.toList()),
  //                   mappedEmployees.toList().length);
  //             }));
  //           } else {
  //             Scaffold.of(context).showSnackBar(showAlertSnackBar());
  //           }

  //           //   مروةاحمد فيصل الغيثي  طلال  عبدالمجيد  ميمونة ميمونه جليله سالم عبدالله اسماء فيسال
  //         }
  //         setState(() {
  //           isLoading = false;
  //         });
  //       });
  //     },
  //   );
  // }

  // Widget buttonField() {
  //   Iterable<Employee> mappedEmployees;

  //   return ButtonTheme(
  //     minWidth: double.infinity,
  //     child: RaisedButton(
  //       onPressed: () {
  //         setState(() {
  //           isLoading = true;
  //         });

  //         Future.delayed(const Duration(milliseconds: 300), () {
  //           if (formKey.currentState.validate()) {
  //             if (selectedRadio == 1) {
  //               mappedEmployees = FilteredEmployees().findByFirstName(
  //                   employees, nameFieldController.text.trim());
  //             } else if (selectedRadio == 2) {
  //               mappedEmployees = FilteredEmployees()
  //                   .findByAnyName(employees, nameFieldController.text.trim());

  //               // for (var i = 0; i < nameFieldController.text.trim().length; i++) {
  //               //   print(nameFieldController.text.trim()[i]);
  //               // }
  //             }

  //             print(FilteredEmployees()
  //                 .predictedNames(employees, nameFieldController.text.trim()));
  //             // print(selectedRadio);
  //             // print(FilteredEmployees().isTheNameSpecial(nameFieldController.text.trim()));

  //             // print(employees);

  //             if (mappedEmployees.length > 0) {
  //               Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                 return EmployeeResult(EmployeeList(mappedEmployees.toList()),
  //                     mappedEmployees.toList().length);
  //               }));
  //             } else {
  //               Scaffold.of(context).showSnackBar(showAlertSnackBar());
  //             }

  //             //   مروةاحمد فيصل الغيثي  طلال  عبدالمجيد  ميمونة ميمونه جليله سالم عبدالله اسماء فيسال
  //           }
  //           setState(() {
  //             isLoading = false;
  //           });
  //         });
  //       },
  //       child: Text('بحث'),
  //       textColor: Colors.white,
  //     ),
  //   );
  // }

  // Widget showAlertSnackBar() {
  //   return SnackBar(
  //     content: Text('عذرا, لا يوجد موظف بهذا الإسم.'),
  //     duration: Duration(milliseconds: 2500),
  //     backgroundColor: Colors.red,
  //   );
  // }
}
