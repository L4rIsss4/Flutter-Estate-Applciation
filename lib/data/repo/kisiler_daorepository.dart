import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../entity/kisi.dart';



class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpUser(Kisiler kisi, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: kisi.kisi_eposta,
      password: password,
    );

    await _firestore.collection("kisiler").doc(userCredential.user!.uid).set({
      ...kisi.toJson(),
      "rol": "kullanici", // otomatik rol tanımlaması
    });
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
  Future<String?> getUserRole() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection("kisiler").doc(user.uid).get();
      return doc.data()?["rol"];
    }
    return null;
  }

  Future <bool> getUserEmail( String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('kisiler')
        .where('kisi_eposta', isEqualTo: email)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }



 Future<String> SplashScreenDatas(String email) async {
   final query = await FirebaseFirestore.instance
       .collection("kisiler")
       .where("kisi_eposta", isEqualTo: email)
       .get();

   if (query.docs.isNotEmpty) {
     return query.docs.first.data()["rol"] ?? "kullanici";
   }
   return "kullanici";
 }


  Future<String?> cloudDinaryProfilePhotoUpload(File imageFile) async {
    const String cloudName = 'dtknplf8p';
    const String uploadPreset = 'EmlakApp';
    final Uri url =
    Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final resData = await http.Response.fromStream(response);
        final data = json.decode(resData.body);
        return data['secure_url'];
      } else {
        print('Cloudinary yükleme başarısız: HTTP ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Cloudinary hata: $e');
      return null;
    }
  }









 }















