import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_authentication/phone_auth.dart';
import 'package:pinput/pinput.dart';

class OTP extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>OTP_Page();
}
class OTP_Page extends State<OTP>{
  final FirebaseAuth  auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context,'phone');
          },
          icon: Icon(
              Icons.arrow_back,color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 30,right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.network('https://www.tyntec.com/drimage/920/0/1886/authentification_header_v2.png'),
              SizedBox(height: 20),
              Text('Phone Verification',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              SizedBox(height: 10),
              Text('We need to Register Your Phone Number',style: TextStyle(fontSize: 16),),
              SizedBox(height: 30),
            Pinput(
              length: 6,
              pinputAutovalidateMode:   PinputAutovalidateMode.onSubmit,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              showCursor: true,
              onChanged: (value){
                code=value;

              },
            ),
              SizedBox(height: 30),
              SizedBox(
                  height: 45,
                  width: double.infinity,
                  child:ElevatedButton(onPressed: ()async{
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyOTP.verify, smsCode: code);
                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
                    }
                    catch(e){
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('Wrong OTP'),
                          actions: [
                            TextButton(onPressed: (){}, child: Text('Ok'))
                          ],
                        );
                      });
                    }

                  }, child: Text('Verify phone number'),style: ElevatedButton.styleFrom(primary: Colors.green.shade600,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),)
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 6),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, 'phone');
                  }, child:Text('Edit Phone Number?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}