

class Employee {
  String firstName;
  String secondName;
  String thirdName;
  String familyName;
  String title;
  String district;
  var gsm;
  var mobile;
  int id;
  String designation;
  String email;

  Employee.fromJSON(responseJSON) {
    firstName = (responseJSON['EMP_NAM1_A'] == null) ? '' : responseJSON['EMP_NAM1_A'] + ' ';
    secondName = (responseJSON['EMP_NAM2_A'] == null) ? '' : responseJSON['EMP_NAM2_A'] + ' ';
    thirdName = (responseJSON['EMP_NAM3_A'] == null) ? '' : responseJSON['EMP_NAM3_A'] + ' ';
    familyName = (responseJSON['EMP_TRIB_NAM4_A'] == null) ? '' : responseJSON['EMP_TRIB_NAM4_A'];
    district = (responseJSON['DEPT_DESP_A'] == null) ? '' : responseJSON['DEPT_DESP_A'];
    title = (responseJSON['TITLE_DESP_A'] == null) ? '' : responseJSON['TITLE_DESP_A'] + ' ' ;
    designation = (responseJSON['DESIGNATION'] == null) ? '' : responseJSON['DESIGNATION'] + ' ' ;
    gsm = (responseJSON['EXT_NO'] == null || responseJSON['EXT_NO'] == 0) ? '' : '${responseJSON['EXT_NO'].floor()}';
    mobile = (responseJSON['OMAN_PHONE_NO'] == null || responseJSON['OMAN_PHONE_NO'] == 0) ? '' : '${responseJSON['OMAN_PHONE_NO']}';
    id = this.id;
    email = this.email;
  }

  String shortNameWithTitle() {
    return "${this.title}${this.firstName}${this.secondName}${this.thirdName}${this.familyName}";
  }

  String shortNameWithOutTitle() {
    return "${this.firstName}${this.secondName}${this.thirdName}${this.familyName}";
  }

  String titleOnly() {
    return "${this.title}";
  }

  String districtOnly() {
    return "${this.district}";
  }

  String gsmOnly() {
    return "${this.gsm}";
  }
}