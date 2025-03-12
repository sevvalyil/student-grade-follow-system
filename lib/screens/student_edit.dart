import '../validation/student_validator.dart';
import 'package:flutter/material.dart';
import '../models/student.dart';


class StudentEdit extends StatefulWidget {
  Student selectedStudent;
  StudentEdit({required this.selectedStudent});

  @override
  State<StatefulWidget> createState() {
    return _StudentEditState(selectedStudent);
  }
}

class _StudentEditState extends State<StudentEdit> with StudentValidationMixin {
  Student selectedStudent;
  var formKey = GlobalKey<FormState>();

  _StudentEditState(this.selectedStudent);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni öğrenci ekle"),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0), //tüm köşelerden boşluk bırakır (dışardan)
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeField(),
                buildSubmitButton()

              ],
            ),
          ),
        ) // ekranda sağdan soldan boşluk bırakmamızı sağlıyor
    );
  }

  Widget buildFirstNameField() {
    return  TextFormField(
      initialValue: selectedStudent.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı",hintText: "İsim giriniz"),
      validator: (value) => validateFirstName(value ?? ""),
      onSaved: (String? value){
        selectedStudent.firstName = value;
      },
    );
  }
  Widget buildLastNameField() {
    return  TextFormField(
      initialValue: selectedStudent.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı",hintText: "Soyadı giriniz"),
      validator: (value) => validateLastName(value ?? ""),
      onSaved: (String? value){
        selectedStudent.lastName = value;
      },
    );
  }
  Widget buildGradeField() {
    return  TextFormField(
      initialValue: selectedStudent.grade.toString(),
      decoration: InputDecoration(labelText: "Öğrenci Notu",hintText: "Not giriniz"),
      validator: (value) => validateGrade(value ?? ""),
      onSaved: (String? value){
        selectedStudent.grade = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text ("Kaydet"),
      onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
           saveStudent();
          Navigator.pop(context, selectedStudent);
        }
      },
    );
  }

  void saveStudent() {
    print(selectedStudent.firstName);
    print(selectedStudent.lastName);
    print(selectedStudent.grade);

  }
}
