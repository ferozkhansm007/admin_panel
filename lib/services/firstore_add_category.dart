import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseAddCategory{


  final _firebaseStore = FirebaseFirestore.instance;
  final _storage= FirebaseStorage.instance;


  Future<void> addCat({ required String catgory, required File image }) async{

    try{
  
     String fileName= basename(image.path);
      Reference ref = _storage.ref().child('Category/$fileName');

      UploadTask uploadTask = ref.putFile(image);
      await uploadTask;
      String downloadURL = await ref.getDownloadURL();
      
      await _firebaseStore.collection('category').doc().set({
      
        'category' : catgory,
        'image': downloadURL
        
      });

    }catch(e){
      print(e);
    }
  }
}