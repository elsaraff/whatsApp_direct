import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

final TextEditingController phoneNumberController = TextEditingController();
final TextEditingController messageController = TextEditingController();

PhoneNumber number = PhoneNumber(isoCode: 'EG');

String finalPhoneNumber = '';
String finalMessage = 'try my app WhatsApp Direct';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp Direct'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/images/three.png'),
                    height: 150.0,
                    width: 150.0,
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'WhatsApp Direct allows you to send WhatsApp messages directly to the phone number,\nWithout saving it to your contacts.',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  InternationalPhoneNumberInput(
                    inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    cursorColor: Colors.green,
                    textFieldController: phoneNumberController,
                    keyboardType: const TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
                    initialValue: number,
                    selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        setSelectorButtonAsPrefixIcon: true,
                        useEmoji: true),
                    onInputChanged: (PhoneNumber number) {
                      //debugPrint(number.phoneNumber.toString());
                      finalPhoneNumber = number.phoneNumber.toString();
                    },
                    selectorTextStyle: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Your Message. (optional)',
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    onChanged: (String value) {
                      //debugPrint(value);
                      finalMessage = value.toString();
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //debugPrint(finalPhoneNumber.toString());
                        //debugPrint(finalMessage.toString());
                        openWhatsapp(finalPhoneNumber, finalMessage);
                      }
                    },
                    child: const Text(
                      'Send Direct WhatsApp Message',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void openWhatsapp(finalPhoneNumber, finalMessage) async {
  if (!await launch("https://wa.me/$finalPhoneNumber?text=$finalMessage")) {
    throw 'Could not launch';
  }
}
