import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/homescreen.dart';
import 'package:phone_authentication/otp_screen.dart';
main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(My_App());
}
class My_App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'phone',
      routes: {
        'phone':(context)=>MyOTP(),
        'otp':(context)=>OTP(),
        'home':(context)=>HomeScreen()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyOTP(),
    );
  }
}
class MyOTP extends StatefulWidget{
  static String verify="";
  @override
  State<StatefulWidget> createState()=>MyOTP_Page();
}
class MyOTP_Page extends State<MyOTP>{
  TextEditingController countrycode=TextEditingController();
  var phone="";
  @override
  void initState() {
    countrycode.text="+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 30,right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:120),
              Image.network('https://www.tyntec.com/drimage/920/0/1886/authentification_header_v2.png'),
              SizedBox(height: 20),
              Text('Phone Verification',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Text('We need to Register Your Phone Number',style: TextStyle(fontSize: 16),),
              SizedBox(height: 30),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('|',style: TextStyle(fontSize: 33,color: Colors.grey)),
                    SizedBox(width: 10),
                    Expanded(child: TextField(keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone=value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone'
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:ElevatedButton(onPressed: ()async{
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countrycode.text+phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      MyOTP.verify=verificationId;
                      Navigator.pushNamed(context, 'otp');
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                }, child: Text('Send the code'),style: ElevatedButton.styleFrom(primary: Colors.green.shade600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),)
              )
            ],
          ),
        ),
      ),
    );
  }

}