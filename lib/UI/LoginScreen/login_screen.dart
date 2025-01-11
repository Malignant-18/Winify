import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:winify/Constants/constants.dart';
import 'package:winify/Services/API/base_url.dart';
import 'package:winify/UI/BuyerScreen/buyer_obtain_address_screen.dart';
import 'package:winify/UI/LoginScreen/LoginScreenComponents/input_field.dart';
import 'package:winify/UI/SellerScreen/seller_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final api = "${BaseUrl.baseURL}/seller/generate-id";
  final usernameTextField = TextEditingController();
  final passwordTextField = TextEditingController();
  String userType = 'Buyer';
  bool isBuyer = true;
  final List<Map<String, dynamic>> _userTypes = [
    {'label': 'Buyer', 'value': 'Buyer', 'icon': Icons.person},
    {'label': 'Vendor', 'value': 'Vendor', 'icon': Icons.store},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/loginHello.png"),
          ),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFFFFFFFF), Color(0xFF9333EA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              "Welcome to Winify",
              style: GoogleFonts.sarpanch(
                fontSize: 35,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            "Your gateway to secure digital transactions",
            style: GoogleFonts.sarpanch(color: smallTextColor, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
          InputField(controller: usernameTextField, hintText: "Username"),
          SizedBox(
            height: 25,
          ),
          InputField(controller: passwordTextField, hintText: "Password"),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: DropdownButtonFormField(
              items: _userTypes.map<DropdownMenuItem<String>>((userType) {
                return DropdownMenuItem<String>(
                  value: userType['value'],
                  child: Row(
                    children: [
                    Icon(userType['icon'], color: smallTextColor),
                    SizedBox(width: 20),
                    Text(
                      userType['label'],
                      style: GoogleFonts.sarpanch(
                          color: smallTextColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  userType = newValue!;
                  isBuyer = newValue == 'Buyer';
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: primaryGrey,
                labelText: 'Select your Role',
                labelStyle: GoogleFonts.sarpanch(
                  color: hintTextColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: smallTextColor, width: 0.7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: smallTextColor, width: 0.7),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: smallTextColor, width: 0.7),
                ),
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 22, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0),
              onPressed: () {
                if(isBuyer){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BuyerObtainAddressScreen())
                  );
                } else {
                  fetchSellerID();
                }
              },
              child: Ink(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: primaryGradient,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.sarpanch(
                          fontSize: 16,
                          color: primaryWhite, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.fromLTRB(10, 32, 10, 0),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.transparent,
          //         shape: ContinuousRectangleBorder(
          //             borderRadius: BorderRadius.circular(12)),
          //         elevation: 0),
          //     onPressed: () {},
          //     child: Ink(
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //           gradient: primaryGradient,
          //           shape: BoxShape.rectangle,
          //           borderRadius: BorderRadius.circular(12)),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 20),
          //         child: Center(
          //           child: Text(
          //             "New? Register",
          //             style: GoogleFonts.sarpanch(
          //               fontSize: 16,
          //               color: primaryWhite, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 20,
          // )
        ],
      ),
    );
  }
  Future<void> fetchSellerID() async {
    final uri = Uri.parse(api);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String id = responseData['sellerId'];
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SellerScreen(sellerID: id)
            )
          );
        }
      } else {
        print("Request failed with Status: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }
}