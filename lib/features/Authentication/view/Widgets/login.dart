import 'package:attendance_app/Common/Config/Palette.dart';
import 'package:attendance_app/features/Authentication/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController pass = TextEditingController();
  final FocusNode _pass = FocusNode();
  final FocusNode _save = FocusNode();
  bool _passwordInVisible = true;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<UserController>(context, listen: false)
          .autoLogin()
          .then((_) => {
                if (Provider.of<UserController>(context, listen: false).user !=
                    null)
                  {Navigator.pushReplacementNamed(context, '/home')}
              })
          .catchError((Error) => {print(Error)});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(builder: (context, model, child) {
      return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 120, left: 30, right: 30),
          width: 600,
          height: 350,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Palette.primaryColor1, Palette.primaryColor2],
                    begin: const FractionalOffset(0.0, 0.1),
                    end: const FractionalOffset(.5, 1.5),
                    tileMode: TileMode.clamp),
              ),
              child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Palette.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          style: TextStyle(
                            color: Palette.white,
                          ),
                          cursorColor: Palette.black,
                          cursorWidth: 3,
                          cursorHeight: 25,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Palette.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Palette.white, width: 3),
                            ),
                            focusColor: Palette.white,
                            hintText: "userName",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Palette.white),
                            iconColor: Palette.white,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Palette.white,
                            ),
                            filled: true,
                          ),
                          controller: userName,
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(_pass),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                            style: TextStyle(
                              color: Palette.white,
                            ),
                            cursorColor: Palette.black,
                            cursorWidth: 3,
                            cursorHeight: 25,
                            textInputAction: TextInputAction.done,
                            focusNode: _pass,
                            obscureText: _passwordInVisible,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Palette.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Palette.white, width: 3),
                              ),
                              focusColor: Palette.white,
                              hintText: "password",
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Palette.white),
                              iconColor: Palette.white,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Palette.white,
                              ),
                              filled: true,
                              suffixIcon: IconButton(
                                  color: Palette.primaryColor1,
                                  icon: _passwordInVisible
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: Palette.white,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: Palette.white,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordInVisible = !_passwordInVisible;
                                    });
                                  }),
                            ),
                            controller: pass,
                            onFieldSubmitted: (term) {
                              FocusScope.of(context).requestFocus(_save);
                            }),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      model.userStatus == UserStatus.Loading
                          ? CircularProgressIndicator(
                              color: Palette.white,
                            )
                          : Container(
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                gradient: LinearGradient(
                                    colors: [
                                      Palette.warningColor2,
                                      Palette.warningColor
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1, 0),
                                    tileMode: TileMode.clamp),
                              ),
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              child: TextButton(
                                focusNode: _save,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "login",
                                      style: TextStyle(
                                          color: Palette.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      width: 70,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Palette.black,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  _save.unfocus();
                                  model
                                      .login(userName.text, pass.text)
                                      .then((_) => {
                                            if (model.userStatus ==
                                                UserStatus.Error)
                                              {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("error"),
                                                      content: Text(
                                                          model.errorMessage),
                                                      actions: <Widget>[
                                                        TextButton(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width: 70,
                                                              height: 34,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Palette
                                                                    .errorColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'okay',
                                                                style: TextStyle(
                                                                    color: Palette
                                                                        .white),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            })
                                                      ],
                                                    );
                                                  },
                                                )
                                              }
                                            else
                                              {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/home')
                                              }
                                          });
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
