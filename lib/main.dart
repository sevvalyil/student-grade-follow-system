import 'package:flutter/material.dart';
import 'package:temel_widget/models/student.dart';
import 'package:temel_widget/screens/student_add.dart';
import 'package:temel_widget/screens/student_edit.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState(); // return _MyAppState(); de aynı şeyi yapar
}

class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Sistemi";

  Student selectedStudent = Student.withId(0," "," ",0);

  List<Student> students = [
    Student.withId(1,"Şevval", "Yıldız", 65),
    Student.withId(2,"İbrahim", "Tunç", 45),
    Student.withId(3,"Hayri", "Bodur", 15)
  ];

  var ogrenciler = [
    "Şevval Yıldız",
    "İbrahim Tunç",
    "Şevval Tunç",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mesaj),
      ),
      body: buildBody(context),
    );
  }


  void mesajGoster(BuildContext context, String mesaj) {
    var alert = AlertDialog(
      title: Text("işlem sonucu"),
      content: Text(mesaj),
    );

    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://galeri14.uludagsozluk.com/827/whatsapp-profiline-kendi-fotografini-koymayan-kisi_1132920.jpg"),
                    ),
                    title: Text(students[index].firstName! +
                        " " +
                        students[index].lastName!),
                    subtitle: Text("Sınavdan aldığı not : " +
                        students[index].grade.toString() +
                        "[" +
                        students[index].getStatus +
                        "]"),
                    trailing: buildStatusIcon(students[index].grade!),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                      print(selectedStudent.firstName);
                    },
                  );
                })),
        Text("Seçili Öğrenci: " + (selectedStudent.firstName ?? "Seçilmedi")),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Butonun arka plan rengi
                  foregroundColor: Colors.black,       // Butonun yazı ve ikon rengi
                  padding: EdgeInsets.symmetric(vertical: 9), // Daha iyi görünüm için boşluk
                ),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 5.0,),
                    Text("Yeni Öğrenci  "),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students )))
                  .then((value) {
                    if (value != null) {
                      setState(() {
                        // Öğrenci zaten StudentAdd içinde listeye eklendi, sadece UI'ı güncelliyoruz
                      });
                      mesajGoster(context, "${value.firstName} başarıyla eklendi");
                    }
                  });
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent, // Butonun arka plan rengi
                  foregroundColor: Colors.black,       // Butonun yazı ve ikon rengi
                ),
                child: Row(
                  children: [
                    Icon(Icons.update),
                    SizedBox(width: 5.0,),  // şekil ile yazı arasında boşluk bırakmak için
                    Text("Güncelle"),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent: selectedStudent)))
                  .then((value) {
                    if (value != null) {
                      setState(() {
                        // UI'ı güncelliyoruz
                      });
                      mesajGoster(context, "${value.firstName} başarıyla güncellendi");
                    }
                  });
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent, // Butonun arka plan rengi
                  foregroundColor: Colors.black,       // Butonun yazı ve ikon rengi
                ),
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 5.0,),
                    Text("Sil"),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    students.remove(selectedStudent);

                  });
                  var mesaj = "Silindi: " + (selectedStudent.firstName ?? "Bilinmiyor");
                  mesajGoster(context, mesaj);
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
