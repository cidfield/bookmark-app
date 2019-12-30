

import 'package:http/http.dart' show get;
import 'package:http/http.dart';
import 'dart:convert';
import '../models/employee.dart';

class FetchApiMixins {
  var response;
  fetchEmployees(employees) async {
     response = await get('http://10.151.45.23:52231/api/values');
    int id = 1;
    if(response.statusCode == 200) {
      var responseJSON = json.decode(response.body);
    
    
      for(var e in responseJSON) {
        var employeesJSON = Employee.fromJSON(e);
        employeesJSON.id = id;
        employees.add(employeesJSON);
        id++;
      }
      
      
      
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future returnResponse() async {
    response = await get('http://10.151.45.23:52231/api/values');
    return response;
  }
}

