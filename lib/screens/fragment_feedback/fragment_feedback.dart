import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:rive/rive.dart';
import 'package:venu/screens/fragment_feedback/thank_you_dialog.dart';
import 'package:venu/services/network_helper.dart';

import '../../redux/store.dart';
import '../../services/dialog_manager.dart';

class FragmentFeedback extends StatefulWidget {
  const FragmentFeedback({Key? key}) : super(key: key);

  @override
  State<FragmentFeedback> createState() => _FragmentFeedbackState();
}

class _FragmentFeedbackState extends State<FragmentFeedback> {
  late BuildContext _appStateContext;
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _sendFeedback() async {
    if (!_formKey.currentState!.validate()) return;
    DialogManager.showLoadingDialog(context);
    String googleToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    Map<String, dynamic> res = await NetworkHelper.sendFeedback(
      googleToken,
      _subjectController.text,
      _messageController.text,
    );

    if (res['success']) {
      _subjectController.clear();
      _messageController.clear();
      if (!mounted) return;
      DialogManager.hideDialog(context);
      DialogManager.showCustomDialog(
        context,
        ThankYouDialog(
          message: res['message'],
          formLink: res['formLink'],
        ),
        true,
      );
    } else {
      if (!mounted) return;
      DialogManager.hideDialog(context);
      DialogManager.showErrorDialog(
        'Could not submit, try later!',
        context,
        false,
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          _appStateContext = context;
          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                const SizedBox(
                  width: 75.0,
                  height: 25.0,
                  child: RiveAnimation.asset(
                    'assets/images/venu-logo.riv',
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 40.0,
                  ),
                  child: const Text(
                    'We are always looking to improve our app. Please let us know what you think.',
                    style: TextStyle(
                      fontFamily: "Google-Sans",
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 40.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _subjectController,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffA7D1D7),
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Subject',
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: _messageController,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontFamily: "Google-Sans",
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field cant be empty';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: "Google-Sans",
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffA7D1D7),
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Message',
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 0.0,
                  ),
                  child: ElevatedButton(
                    onPressed: _sendFeedback,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: const Size(double.infinity, 56),
                      backgroundColor: const Color(0xffA7D1D7),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: "Google-Sans",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(
                //     vertical: 0.0,
                //     horizontal: 40.0,
                //   ),
                //   child: ElevatedButton(
                //     onPressed: _sendFeedback,
                //     style: ElevatedButton.styleFrom(
                //       minimumSize: const Size(double.infinity, 50),
                //       backgroundColor: const Color(0xffA7D1D7),
                //     ),
                //     child: const Text(
                //       'Submit',
                //       style: TextStyle(
                //         fontFamily: "Google-Sans",
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.w500,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
