import 'dart:async';
import 'dart:io';

import 'package:admin_panel/services/firstore_add_category.dart';
import 'package:admin_panel/widgets.dart/custom_button.dart';
import 'package:admin_panel/widgets.dart/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  File? _imageFile;
  Future<void> _pickImageFromGallery(BuildContext context) async {
    
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePicture(BuildContext context) async {
    Navigator.pop(context);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Custom Popup'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextField(
                                  controller: textEditingController,
                                  hintText: "Enter Your Category",
                                  label: "Category",
                                  validate: (value) {
                                    return value == null
                                        ? 'Fill the Field'
                                        : null;
                                  }),
                                  SizedBox(height: 20,),
                            
                                  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Select Image',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
            ),
            Expanded(
              child: CustomButton(
                height: 40,              
                buttonName:"select", onPressed: () {
                  _pickImageFromGallery(context);
                
                
              },),
            ), // Replace CustomButton with your actual button widget
          ],
        ),
      
                              SizedBox(height: 20),
                              CustomButton(
                                height: 40,
                                buttonName: "Submit",
                                onPressed: () async {
                                  if (textEditingController.text.isEmpty) {
                                    MotionToast.warning(
                                            title: const Text("Warning"),
                                            description: Text("Fill the Field"))
                                        .show(context);
                                  } else {
                                    await FirebaseAddCategory().addCat(
                                      image:_imageFile! ,
                                        catgory: textEditingController.text);
                                    Navigator.pop(context);
                                    textEditingController.clear();
                                    MotionToast.success(
                                      title: const Text("Success"),
                                      description:
                                          const Text("Submition Successful"),
                                    ).show(context);
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      Text(
                        'Categories',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
