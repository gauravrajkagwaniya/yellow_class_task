import 'package:firebase_auth/firebase_auth.dart';import 'package:flutter/material.dart';import 'package:yellow_class/first_screen.dart';import 'presentation/task.dart';class LogIn extends StatefulWidget {  var cameras;  LogIn(this.cameras);  @override  _LogInState createState() => _LogInState();}class _LogInState extends State<LogIn> {  final _phoneController = TextEditingController();  final _codeController = TextEditingController();  Future<bool> loginUser(String phone, BuildContext context) async {    FirebaseAuth _auth = FirebaseAuth.instance;    _auth.verifyPhoneNumber(        phoneNumber: phone,        timeout: Duration(seconds: 60),        verificationCompleted: (AuthCredential credential) async {          Navigator.of(context).pop();          AuthResult result = await _auth.signInWithCredential(credential);          FirebaseUser user = result.user;          if (user != null) {            Navigator.push(                context,                MaterialPageRoute(                    builder: (context) => Task(widget.cameras)));          } else {            print("Error");          } //This callback would gets called when verification is done auto maticlly        },        verificationFailed: (AuthException exception) {          print(exception);        },        codeSent: (String verificationId, [int forceResendingToken]) {          showDialog(              context: context,              barrierDismissible: false,              builder: (context) {                return AlertDialog(                  title: Text("Give the code?"),                  content: Column(                    mainAxisSize: MainAxisSize.min,                    children: <Widget>[                      TextField(                        controller: _codeController,                      ),                    ],                  ),                  actions: <Widget>[                    FlatButton(                      child: Text("Confirm"),                      textColor: Colors.white,                      color: Colors.blue,                      onPressed: () async {                        final code = _codeController.text.trim();                        AuthCredential credential =                            PhoneAuthProvider.getCredential(                                verificationId: verificationId, smsCode: code);                        AuthResult result =                            await _auth.signInWithCredential(credential);                        FirebaseUser user = result.user;                        if (user != null) {                          Navigator.push(                              context,                              MaterialPageRoute(                                  builder: (context) =>                                      Task(widget.cameras)));                        } else {                          print("Error");                        }                      },                    )                  ],                );              });        },        codeAutoRetrievalTimeout: null);  }  @override  Widget build(BuildContext context) {    return Scaffold(        //backgroundColor: Colors.yellow[200],        body: SingleChildScrollView(      child: Container(        height: MediaQuery.of(context).size.height,        width: MediaQuery.of(context).size.width,        //color: Colors.amber,        // margin: EdgeInsets.symmetric(horizontal: 30, vertical: 100),        decoration: BoxDecoration(          gradient: LinearGradient(            begin: Alignment.center,            end:                Alignment(10, -7), // 10% of the width, so there are ten blinds.            colors: [Colors.greenAccent[400], Colors.black54],            tileMode: TileMode.repeated, // repeats the gradient over the canvas          ),        ),        child: Center(            child: Form(          child: Column(            crossAxisAlignment: CrossAxisAlignment.start,            mainAxisAlignment: MainAxisAlignment.start,            children: <Widget>[              SizedBox(                height: MediaQuery.of(context).size.height * .30,              ),              Container(              //  color: Colors.amber,                  width: MediaQuery.of(context).size.width*.70,                  child: RichText(                text: TextSpan(children: <TextSpan>[                  TextSpan(                    text: 'Yellow',                    style: TextStyle(                        fontWeight: FontWeight.bold,                        fontSize: 50,                        color: Colors.yellow,                        letterSpacing: 10),                  ),                  TextSpan(                    text: 'Class',                    style: TextStyle(                        fontWeight: FontWeight.bold,                        fontSize: 15,                        color: Colors.black,                        letterSpacing: 40),                  ),                ]),              )),              SizedBox(                height: 16,              ),              Container(                  margin: EdgeInsets.symmetric(horizontal: 10),                  child: TextFormField(                    keyboardType: TextInputType.phone,                    decoration: InputDecoration(                        enabledBorder: OutlineInputBorder(                            borderRadius: BorderRadius.all(Radius.circular(8)),                            borderSide: BorderSide(color: Colors.grey[200])),                        focusedBorder: OutlineInputBorder(                            borderRadius: BorderRadius.all(Radius.circular(8)),                            borderSide: BorderSide(color: Colors.grey[300])),                        filled: true,                        fillColor: Colors.grey[100],                        hintText: "Mobile Number"),                    controller: _phoneController,                  )),              SizedBox(                height: 16,              ),              Container(                margin: EdgeInsets.symmetric(horizontal: 100),                width: double.infinity,                child: FlatButton(                  child: Text("LOGIN"),                  textColor: Colors.white,                  padding: EdgeInsets.all(16),                  onPressed: () {                    final phone = _phoneController.text.trim();                    loginUser(phone, context);                  },                  color: Colors.green,                ),              ),              /* Container(                    width: double.infinity,                    child: FlatButton(                      child: Text("task"),                      textColor: Colors.white,                      padding: EdgeInsets.all(16),                      onPressed: () {                        Navigator.push(context,                            MaterialPageRoute(builder: (context) => FirstScreen(widget.cameras)));                      },                      color: Colors.blue,                    ),                  )*/            ],          ),        )),      ),    ));  }}