import 'package:flutter/material.dart';
import 'package:pin_view/pin_view.dart';



import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icook_mobile/ui/shared/resetButton.dart';
import 'package:icook_mobile/ui/shared/state_responsive.dart';
import 'package:icook_mobile/ui/signup_screen/signupmodel.dart';
import 'package:icook_mobile/ui/ui_helper.dart';
import 'package:stacked/stacked.dart';

class ConfirmResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        height: double.infinity, width: 375, allowFontScaling: true);

    return ViewModelBuilder<SignUpModel>.reactive(
      viewModelBuilder: () => SignUpModel(),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldKey,
        appBar: AppBar(
            title: Text(
          "Reset Password",
        )),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 34,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: model.formkey,
                child: FocusScope(
                  node: model.node,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              'Please enter below the 5-digit unique code sent\n to your registered email or number ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.normal))
                        ],
                      ),
                      SizedBox(height: 102),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 5 / 5,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: PinView(
                                      obscureText: false,
                                      count: 5,
                                      autoFocusFirstField: true,
                                      submit: (String pin) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(
                                                      "Code received successfully."),
                                                  content: Text(
                                                      "Entered code is: $pin"));
                                            });
                                      }),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 106),
                      StateResponsive(
                          state: model.state,
                          busyWidget: Center(
                            child: CircularProgressIndicator(),
                          ),
                          idleWidget: Center(
                              child: ResetButton(
                            title: 'Confirm',
                            onPressed: () {
                              // model.signUp();
                              FocusScope.of(context).unfocus();
                            },
                            textColor: Colors.white,
                            isEnabled: true,
                          ))),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Resend Code',
                              style: GoogleFonts.poppins(
                                  color: Constants.kbuttonColor1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}