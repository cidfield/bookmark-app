import 'package:flutter/material.dart';
import 'widgets/find_by_name.dart';
import 'widgets/find_by_phone.dart';
import 'widgets/find_by_district.dart';
import 'mixins/fetch_api_mixins.dart';
import 'models/employee.dart';

class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

class AppState extends State<App> with FetchApiMixins {
  List<Employee> employees = [];
  List<Employee> employeesForDistricts = [];
  int _selectedPage = 0;
  List<String> districts = [];

  // final _pageOptions = [FindByName(), FindByPhone(), FindByDistrict(employees)];

    @override
  void initState() {
    super.initState();
    fetchEmps();
  }
  
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
        theme: ThemeData(primaryColor: Color(0xffc8973b), accentColor: Color(0xffc8973b), accentColorBrightness: Brightness.light) ,
        home: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: goToWidget(_selectedPage),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text(
                    'البحث بالإسم',
                    style: TextStyle(fontSize: 15.0),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.phone),
                  title: Text(
                    'البحث بالرقم',
                    style: TextStyle(fontSize: 15.0),
                  )),
              BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  title: Text(
                    'بالحث بالدائرة',
                    style: TextStyle(fontSize: 15.0),
                  ))
            ],
          ),
        ),
      ),
    )));
  }

  void fetchEmps() {
    fetchEmployees(employees).then((value) {
      _filterDistrictsOnly();
      setState(() {
        FindByName(employees);
        FindByPhone(employees);
        FindByDistrict(employees, districts);
      });
    });
  }

  void _filterDistrictsOnly() {
    employees.forEach((emp) {
      if(!districts.contains(emp.district)) {
        districts.add(emp.district);
      }
    });
  }


  goToWidget(int index) {
    if (index == 0) {
      return FindByName(employees);
    } else if(index == 1) {
      return FindByPhone(employees);
    } else if(index == 2) {
      return FindByDistrict(employees, districts);
    }
  }
}
