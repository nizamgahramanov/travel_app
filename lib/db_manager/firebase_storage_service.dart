import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/destination.dart';

class FirebaseStorageService {
  final ref = FirebaseStorage.instance;

  Future<String> saveDestinationImages(Destination destination,File destinationPhoto) async{
    final fileRef = ref.ref().child((destination.id).toString()).child("${destination.name}.jpg");
    final refPut = await fileRef.putFile(destinationPhoto);
    final url = await fileRef.getDownloadURL();
    print("URL ");
    print(url);
    return url;
  //   UploadTask uploadTask = fileRef.putFile(destinationPhoto);
  //   print("GETTING URL FROM");
  //   String url="";
  //   await uploadTask.whenComplete(() {
  //     fileRef.getDownloadURL().then((fileURL){
  //       print("GET DOWNLOAD URL");
  //       url = fileURL;
  //       print(url);
  //       return url;
  //     });
  //   });
  //   // final url = fileRef.getDownloadURL();
  //   // print("URL");
  //   print(url);
  // return url;
  }
}