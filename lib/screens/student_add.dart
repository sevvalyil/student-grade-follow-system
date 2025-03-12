import '../validation/student_validator.dart';
import 'package:flutter/material.dart';
import '../models/student.dart';


class StudentAdd extends StatefulWidget {
  late List<Student> students;
  StudentAdd (  List<Student> students){
    this.students = students;
  }

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(students);
  }
}

class _StudentAddState extends State<StudentAdd> with StudentValidationMixin {
 late List<Student> students;

  var student = Student.withoutInfo() ;
  var formKey = GlobalKey<FormState>();

 _StudentAddState (  List<Student> students){
   this.students = students;
 }

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
      decoration: InputDecoration(labelText: "Öğrenci Adı",hintText: "İsim giriniz"),
      validator: (value) => validateFirstName(value ?? ""),
      onSaved: (String? value){
        student.firstName = value;
      },
    );
  }
  Widget buildLastNameField() {
    return  TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı",hintText: "Soyadı giriniz"),
      validator: (value) => validateLastName(value ?? ""),
      onSaved: (String? value){
        student.lastName = value;
      },
    );
  }
  Widget buildGradeField() {
    return  TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Notu",hintText: "Not giriniz"),
      validator: (value) => validateGrade(value ?? ""),
      onSaved: (String? value){
        student.grade = int.parse(value!);
      },
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      child: Text ("Kaydet"),
      onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          //yeni öğrenci listeye ekledik

            students.add(student);
            saveStudent();
            
            // Ana ekrana öğrencinin eklendiğini bildiriyoruz
            Navigator.pop(context, student);
    }
      },
    );
  }

  void saveStudent() {
    print(student.firstName);
    print(student.lastName);
    print(student.grade);
  }
}
