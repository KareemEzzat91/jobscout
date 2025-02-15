import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobscout/Login&SignUp/SignUpScreen.dart';
import 'package:jobscout/Login&SignUp/cubit/sign_cubit.dart';
import '../HomeScreen/HomeScreen.dart';
import '../customtextfiled/customtextfiled.dart';
import '../kconstnt/constants.dart';

class Loginscreen extends StatelessWidget {
   Loginscreen({super.key});
   Future signInWithGoogle(BuildContext context) async {
     // Trigger the authentication flow
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("1111111111111111111111111111");
     // Obtain the auth details from the request
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
     print("@22222222222222222222222222211");
     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     print("33333333333333333333333333333333");

     // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
     print("444444444444444444444444444");

     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => Homescreen()),
     );


   }

   late final String? Function(String?)? validator ;
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignCubit>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  BlocListener <SignCubit, SignState>(
      listener: (BuildContext context, state) {
        if (state is SignFaliureState) {
          Get.snackbar(
            "Error",
            state.error,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }

      },
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/photo_2024-09-16_15-28-23-removebg-preview.png",scale: 0.5,height:height/5,width: width/4, )
                ,  const Row(
                    children: [
                      Text("Lets Get You Login! ",style :TextStyle(fontSize: 25,shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black38,
                        ),
                      ],
                      ),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text("Enter Your information Below ",style: TextStyle(color: Colors.grey.shade400),)
                  ,Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:bloc.FacbookLogin
                           ,
                            child: Container(
                              height:height/11.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey, // You can customize the color of the border
                                    width: 0.35 // Adjust the width of the border
                                ),
                                borderRadius: BorderRadius.circular(20), // Optional: Rounded corners
                              ),
                              child: const Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(Icons.facebook, color: Colors.blue,size: 30,), // Added color to the icon
                                  SizedBox(width: 8),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                            onTap:() {signInWithGoogle(context );},

                            child: Container(
                              height:height/11.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey, // You can customize the color of the border
                                  width: 0.35, // Adjust the width of the border
                                ),
                                borderRadius: BorderRadius.circular(20), // Optional: Rounded corners
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Image.network("https://www.vhv.rs/dpng/d/0-6167_google-app-icon-png-transparent-png.png",width: 30,),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Google",
                                    style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("-------------------- Or Login With --------------------",style: TextStyle(color: Colors.black.withOpacity(0.6)),),

                  ],),
                  Form(
                      key: _key,
                      child: Container(
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextField(
                                icon: Icon(Icons.email_outlined),
                                controller: _nameController,
                                height: height,
                                text: "Email",
                                validator: (val) {
                                  if (!val!.isEmail) {
                                    return "this should be valid Email.";
                                  } else if (val.length < 10) {
                                    return " email should be more than 10 letters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Padding(

                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextField(
                                icon: Icon(Icons.lock),
                                height: height,
                                controller: _passwordController,
                                text: "Password",
                                isPassword: true,
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "Password should be more than 7 letters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ) ,
                      )

                  ),
                  Row(children: [Spacer(),InkWell(onTap: (){}, child: Text("Forgot Password ?",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold),))],)
                  ,SizedBox(height:40,),
                GestureDetector(
                  onTap: (){
                    bloc.Login(context,_key,_nameController,_passwordController);

                  },
                  child: Container (
                      decoration: BoxDecoration(
                        color:  Colors.cyan,
                          borderRadius: BorderRadius.circular(20), // Optional: Rounded corners
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset:Offset(0.5, 0.5)
                        )]

                      ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder <SignCubit, SignState>(

                          builder: (BuildContext context, SignState state) {
                            if (state is SignLoadingState)
                              {
                                return CircularProgressIndicator();
                              }
                            return Center(
                              child: Text(
                                "Login",style: GoogleFonts.abyssinicaSil(fontSize: 40,color: Colors.white),),
                            );


                          },
                        )],),
                  ),
                )
                ,SizedBox(height:40,)

                , Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                    Text("Dont have any account ? "),
                    InkWell(onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Signupscreen()),
                      );

                    }, child: Text("Register Now",style: GoogleFonts.agbalumo(color: Colors.cyan),))
                  ],)


                ],
              ),
            ),
          ),
      ),
    );
  }
}
