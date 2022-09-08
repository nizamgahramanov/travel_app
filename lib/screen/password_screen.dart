import 'package:flutter/material.dart';
import 'package:travel_app/helpers/custom_button.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password';
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "PLEASE SET A PASSWORD TO SIGN UP",
              ),
              background: Image.network(
                "https://i.picsum.photos/id/132/200/200.jpg?hmac=meVrCoOURNB7iKK3Mv-yuRrvxvXgv4h2vIRLM4sKwK4",
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 20,
          //       ),
          //       AppLightText(text: "Welcome hjh@gmail.com"),
          //       AppLightText(text: "Secure your new account with a password"),
          //       SizedBox(
          //         height: 30,
          //       ),
          //       Form(
          //         child: TextFormField(
          //           decoration: InputDecoration(
          //             focusedBorder: UnderlineInputBorder(
          //               borderSide: BorderSide(
          //                 color: AppColors.buttonBackgroundColor,
          //               ),
          //             ),
          //             labelText: "Password",
          //             labelStyle: const TextStyle(
          //               color: Colors.black,
          //             ),
          //           ),
          //           textInputAction: TextInputAction.done,
          //           onFieldSubmitted: (_) {
          //             // saveForm();
          //           },
          //           onSaved: (value) {
          //             // checkEmailIsRegistered(value);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 5),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomButton(
                    buttonText: "Continue",
                    borderRadius: 25,
                    onTap: () {},

                    // onChanged: (bool val) {
                    //   setState(() {
                    //     _pinned = val;
                    //   });
                    // },
                    // value: _pinned,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // SingleChildScrollView(
      //     child: Column(
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.3,
      //       width: double.maxFinite,
      //       child: Stack(
      //         children: [
      //           Positioned(
      //             child: Image.network(
      //               "https://i.picsum.photos/id/454/200/200.jpg?hmac=N13wDge6Ku6Eg_LxRRsrfzC1A4ZkpCScOEp-hH-PwHg",
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.6,
      //       child: Form(
      //         key: _form,
      //         child: TextFormField(
      //           decoration: InputDecoration(
      //
      //             focusedBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(
      //                 color: AppColors.buttonBackgroundColor,
      //               ),
      //             ),
      //             labelText: "Password",
      //             labelStyle: const TextStyle(
      //               color: Colors.black,
      //             ),
      //           ),
      //           textInputAction: TextInputAction.done,
      //           onFieldSubmitted: (_) {
      //             // saveForm();
      //           },
      //           onSaved: (value) {
      //             // checkEmailIsRegistered(value);
      //           },
      //         ),
      //       ),
      //     )
      //   ],
      // )),
    );
  }
}
