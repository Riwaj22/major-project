
import 'dart:io';
import 'dart:math';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color(0XFF8b32a8),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  bool progress = false;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }

  }
  Future pickImagefromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA5A4A4),
      appBar: AppBar(
        title: Center(child: Text("Upload Image")),
        backgroundColor:Color(0XFF8b32a8) ,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: image == null
                    ? Text("No Image is picked")
                    : Image.file(image!),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: pickImage,
                tooltip: "Pick Image From Gallery",
                child: Icon(Icons.folder),
              ),
              FloatingActionButton(
                onPressed: pickImagefromCamera,
                tooltip: "Pick Image From Camera",
                child: Icon(Icons.camera_alt),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,

            child: ElevatedButton(

              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.red)
                  )
                )
              ),

                onPressed: () {
                Container(
                  child: image == null
                      ?Text('Please select an image')
                      :Image.file(image!)
                );

                 Container(child:showAlertDialog(context, 'hello'),);
                } ,

                child: Text(
                  'Predict',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,

                  ),
                )),
          )

        ],

      ),



    );

  }
  showAlertDialog(BuildContext context,String x) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,

      elevation: 0,

      title: Text("Predicted Text"),
      content: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          //     color: Colors.blue,
            height: h,
            width: w,
            child: Text(
              x, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
        ),
      ),

      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
    },
    child: Text('OK'),),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 10), () {

        });
        return alert;
      },
    );
  }
}
