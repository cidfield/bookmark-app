import 'package:employee_bookmark/src/widgets/employee_list.dart';
import 'package:employee_bookmark/src/widgets/employee_result.dart';
import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../mixins/fetch_api_mixins.dart';

// final recentEmployees = ['سعيد عبدالله الزعابي', 'عبدالمجيد ابراهيم البلوشي'];

class DataSearch extends SearchDelegate<String> with FetchApiMixins {
  final List<Employee> employees;
  DataSearch(this.employees);

  @override
  List<Widget> buildActions(BuildContext context) {
    
    
  }

  @override
  Widget buildLeading(BuildContext context) {
    return RotatedBox(
        quarterTurns: 90,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: IconButton(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: transitionAnimation),
              onPressed: () {
                close(context, null);
              },
            )));
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Card();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Color primaryColor = Color(0xffc8973b);
    Color secondaryColor = Color(0xffac110c);

    final mappedEmployeesList = query.isEmpty
        ? employees
        : isTheNameSpecial(query) == null
            ? employees
                .where((emp) => emp.shortNameWithOutTitle().startsWith(query))
                .toList()
            : employees
                .where((emp) =>
                    emp
                        .shortNameWithOutTitle()
                        .startsWith(isTheNameSpecial(query)[0]) ||
                    emp
                        .shortNameWithOutTitle()
                        .startsWith(isTheNameSpecial(query)[1]))
                .toList();

    return FutureBuilder(
      future: returnResponse(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              int selectedEmpId = mappedEmployeesList[index].id;

              final selectedEmployee =
                  employees.where((emp) => emp.id == selectedEmpId).toList();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EmployeeResult(EmployeeList(selectedEmployee.toList(),
                    (index.isEven ? primaryColor : secondaryColor)));
              }));
            },
            leading: CircleAvatar(
              backgroundColor: (index.isEven ? primaryColor : secondaryColor),
              foregroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: RichText(
              text: TextSpan(
                  text: mappedEmployeesList[index].titleOnly(),
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                        text: mappedEmployeesList[index]
                            .shortNameWithOutTitle()
                            .substring(0, query.length),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                        text: mappedEmployeesList[index]
                            .shortNameWithOutTitle()
                            .substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
            subtitle: Text("${mappedEmployeesList[index].district}",
                style: TextStyle(fontSize: 11.0)),
            isThreeLine: false,
          ),
          itemCount: mappedEmployeesList.length,
        ));
        } else {
           return new Center(child: CircularProgressIndicator());
        }
      },
    ); 
  }
}

class DataSearchByNumber extends SearchDelegate<String> with FetchApiMixins {
  final List<Employee> employees;
  DataSearchByNumber(this.employees);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return RotatedBox(
        quarterTurns: 90,
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: IconButton(
              icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_arrow,
                  progress: transitionAnimation),
              onPressed: () {
                close(context, null);
              },
            )));
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Card();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Color primaryColor = Color(0xffc8973b);
    Color secondaryColor = Color(0xffac110c);

    final mappedEmployeesList = query.isEmpty
        ? employees
        : employees.where((emp) => emp.gsm.startsWith(query)).toList();

    return FutureBuilder(
      future: returnResponse(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              int selectedEmpId = mappedEmployeesList[index].id;

              final selectedEmployee =
                  employees.where((emp) => emp.id == selectedEmpId).toList();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EmployeeResult(EmployeeList(selectedEmployee.toList(),
                    (index.isEven ? primaryColor : secondaryColor)));
              }));
            },
            leading: CircleAvatar(
              backgroundColor: (index.isEven ? primaryColor : secondaryColor),
              foregroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: RichText(
              text: TextSpan(
                  text: mappedEmployeesList[index]
                      .shortNameWithTitle()
                      .substring(0, query.length),
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: mappedEmployeesList[index]
                            .shortNameWithTitle()
                            .substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ]),
            ),
            subtitle: RichText(
              text: TextSpan(
                  text: mappedEmployeesList[index].districtOnly() +
                      (mappedEmployeesList[index].gsmOnly().isEmpty
                          ? ""
                          : " - "),
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0),
                  children: [
                    TextSpan(
                        text: mappedEmployeesList[index]
                            .gsmOnly()
                            .substring(0, query.length),
                        style: TextStyle(color: Colors.black, fontSize: 11.0)),
                    TextSpan(
                        text: mappedEmployeesList[index]
                            .gsmOnly()
                            .substring(query.length),
                        style: TextStyle(color: Colors.grey, fontSize: 11.0))
                  ]),
            ),
            isThreeLine: false,
          ),
          itemCount: mappedEmployeesList.length,
        ));
        } else {
           return new Center(child: CircularProgressIndicator());
        }
      },
    ); 
  }
}

// class FilteredEmployees {
List specialCharacters = [
  ['اح', 'أح'],
  ['اس', 'أس'],
  ['ه', 'ة'],
  ['اب', 'إب']
];
String secondLetter;
String secondName;

//   Iterable<Employee> findByFirstName(
//       List<Employee> employees, String nameFieldText) {
//     if (isTheNameSpecial(nameFieldText) == null) {
//       return employees
//           .where((emp) => emp.firstName.trim() == nameFieldText.trim());
//     } else {
//       return employees.where((emp) =>
//           emp.firstName.trim() == isTheNameSpecial(nameFieldText)[0].trim()||
//           emp.firstName.trim() == isTheNameSpecial(nameFieldText)[1].trim());
//     }
//   }

//   Iterable<Employee> findByAnyName(
//       List<Employee> employees, String nameFieldText) {
//     if (isTheNameSpecial(nameFieldText) == null) {
//       return employees.where((emp) =>
//           emp.firstName.trim() == nameFieldText.trim() ||
//           emp.secondName.trim() == nameFieldText.trim() ||
//           emp.thirdName.trim() == nameFieldText.trim() ||
//           emp.familyName.trim() == nameFieldText.trim());
//     } else {
//       return employees.where((emp) =>
//           emp.firstName.trim() == isTheNameSpecial(nameFieldText)[0].trim() ||
//           emp.firstName.trim() == isTheNameSpecial(nameFieldText)[1].trim() ||
//           emp.secondName.trim() == isTheNameSpecial(nameFieldText)[0].trim() ||
//           emp.secondName.trim() == isTheNameSpecial(nameFieldText)[1].trim() ||
//           emp.secondName.trim() == isTheNameSpecial(nameFieldText)[1].trim() ||
//           emp.thirdName.trim() == isTheNameSpecial(nameFieldText)[0].trim() ||
//           emp.thirdName.trim() == isTheNameSpecial(nameFieldText)[1].trim() ||
//           emp.familyName.trim() == isTheNameSpecial(nameFieldText)[0].trim() ||
//           emp.familyName.trim() == isTheNameSpecial(nameFieldText)[1].trim() );
//     }
//   }

//   predictedNames(List<Employee> employees, String nameFieldText) {
//     // if(isTheNameSpecial(nameFieldText) == null) {
//       return employees.where((emp) => emp.firstName.trim().substring(0, 2) == nameFieldText.trim().substring(0, 2)
//        ||  emp.firstName.trim().substring(emp.firstName.trim().length - 2,)
//         == nameFieldText.trim().substring(nameFieldText.trim().length - 2,));

//     // } ليل

//   }

isTheNameSpecial(String nameFieldText) {
  for (var i = 0; i < specialCharacters.length; i++) {
    for (var character in specialCharacters[i]) {
      if (nameFieldText.indexOf(character) != -1) {
        for (var char in specialCharacters[i]) {
          if (char != character) {
            secondLetter = char;
          }
        }
        secondName = nameFieldText.replaceFirst(character, secondLetter);
        print(nameFieldText);
        print(secondName);
        return [nameFieldText, secondName];
      }
    }
  }
}
// }
