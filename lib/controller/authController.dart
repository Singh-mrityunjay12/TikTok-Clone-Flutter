import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tic_tok/model/userModel.dart';
import 'package:tic_tok/view/screen/HomeScreen.dart';
import 'package:tic_tok/view/screen/laginScreen.dart';
import 'package:tic_tok/view/screen/signUpScreen.dart';

class Registrations extends GetxController {
  static Registrations instance = Get.find();
  File? proimg;

  // static var instance;
//pic image or select image from the device means from the gallery we can select image ,multiImage,video from this method
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == 0) {
      return;
    }
    final img = File(image!.path);
    proimg = img;
  }

  //user state Persistance
  //onReady() simillar to oninit() function ham ise yaha isiliye kar rahe kyoki ham ise main.dart file me Registraition()class ko initilise kiya hu
  late Rx<User?>
      _user; //here user null bhi ho sakata h isiliye ? is sign ka use hua h
  User get user1 => _user.value!;
  //_user yaha nadi h
  //_user.bindStream ko nadi me color show karata
  //ever function ko ham ap ho jo lagatar observe kar rahe h kya chages ho raha h jaise hi change hoga vise hi ham ak function ko call karenge aur usame _user pass karenge
  //aur yaha _user ak listner h
  @override
  void onReady() {
    //this function similar to init function this function use for user loggedIn or not
    //is controller ko hamlog main.dart file method initialized kar diya h isliye is class ham log chake kar rahe h ki user loggedIn h or not
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    //currentUser me jo bhi changes hoga vo hame _user me milega
    //Rx()=>Observable keyword h jo continuously  chake karata h ki usame jo  variable ki value set ki gayi h vo change ho raha h ki nahi
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user,
        _setInitialView); //ever function continuously chake listen karate h or observe karata h _user ko
    //_setInitialView is a type function _user work as argument of the _setInitialView
  }

  _setInitialView(User? user) {
    if (user == null) {
      //user is not loggedIn
      Get.offAll(() => const LoginScreen());
    } else {
      //user is loggedIn
      Get.offAll(() => const HomeScreen1());
    }
  }

//User Registrations

  void SignUp(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // Future<String> downloadUrl=  _uploadProfilePic(image);
        //OR
        String downloadUrl = await _uploadProfilePic(
            image); //upload image url in FirebaseStorage and cloudFirestore(FirebaseFirestore)
        myUser user1 = myUser(
            //instance of myUser class
            name: userName,
            profilePhoto: downloadUrl,
            email: email,
            uid: userCredential.user!.uid);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user1.toJson1());

        ///yha ofJosn1() vahi h jo map ko jason me convert karata h here per user1 ak instance or object h jise map me convert phir json me
      } else {
        Get.snackbar(
            "Error Creating Account", "Please Enter all the required field");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occured", e.toString());
    }
  }

  Future<String> _uploadProfilePic(File image) async {
    //yaha Future isliye laga h ki kyoki yaha per async and await ka use ho raha h
    //ye refrence FirebaseStorage ka package h

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);
    //yaha per current user id ke name se han profilePic ko upload kar dete h
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  } //yah method private method h is method ko kaeval is class ke sivay koi aur use nahi kar skata h underscore lagakar private method banate h
  // pfofilepics ak perticular folder h jisame image upload isilye reference liya ja raha h image ka
  //here image ka name  FirebaseAuth.instance.currentUser!.uid ke name se set hoga

  //login user method
  void loginUser(String email1, String password1) async {
    try {
      if (email1.isNotEmpty && password1.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email1, password: password1)
            .then((value) {
          Get.snackbar("Login Succesfuly", value.toString());
        });
      } else {
        Get.snackbar("Error logging in", "Please enter all the field");
      }
    } catch (e) {
      Get.snackbar("Error Occure", e.toString());
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => const SignUpScreen());
  }
}
