import 'package:blood_donation_app/Authentication.dart';
import 'package:blood_donation_app/SaveToDatabase.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

var _formKey = GlobalKey<FormState>();
SaveData _saveData = new SaveData();
TextEditingController name = new TextEditingController();
TextEditingController dob = new TextEditingController();
TextEditingController mobile = new TextEditingController();
TextEditingController city = new TextEditingController();
TextEditingController address = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController password = new TextEditingController();
TextEditingController confirmPassword = new TextEditingController();
var gender, bloodGroup, country, province, availability, id;
String btn = 'Submit', appBar = "Register as Donor";
bool _visible = true;

class Register extends StatefulWidget {
  void getData(String bar, Map<String, dynamic> data, String ID, String btnTxt,
      bool vis) {
    appBar = bar;
    _visible = vis;
    if (btnTxt == "Update") {
      name.text = data['name'];
      dob.text = data['dob'];
      mobile.text = data['mobile'];
      city.text = data['city'];
      address.text = data['address'];
      gender = data['gender'];
      bloodGroup = data['blood group'];
      country = data['country'];
      province = data['province'];
      availability = data['availability'];
      email.text = data['email'];
      id = ID;
      btn = btnTxt;
    }
  }

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final auth = FirebaseAuth.instance;
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(appBar),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  //form
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Your Name',
                                labelText: 'Name:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-z,\ ,\-]+'))
                            ],
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              controller: dob,
                              format: format,
                              decoration: InputDecoration(
                                  hintText: 'Date of Birth',
                                  labelText: 'Select Date of Birth:',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder()),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1950),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime.now());
                              },
                              validator: (value) => value == null
                                  ? 'Please Select your date of Birth'
                                  : null,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(
                                child: Text('Male'),
                                value: 'Male',
                              ),
                              DropdownMenuItem(
                                child: Text('Female'),
                                value: 'Female',
                              ),
                            ],
                            decoration: InputDecoration(
                                hintText: 'Select Gender',
                                labelText: 'Gender:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            onChanged: (value) {
                              setState(() {
                                gender = value;
                              });
                            },
                            value: gender,
                            validator: (value) => value == null
                                ? 'Please fill in your gender'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            items: [
                              DropdownMenuItem(child: Text("A+"), value: 'A+'),
                              DropdownMenuItem(child: Text("B+"), value: 'B+'),
                              DropdownMenuItem(child: Text("O+"), value: 'O+'),
                              DropdownMenuItem(
                                  child: Text("AB+"), value: 'AB+'),
                              DropdownMenuItem(child: Text("A-"), value: 'A-'),
                              DropdownMenuItem(child: Text("B-"), value: 'B-'),
                              DropdownMenuItem(child: Text("O-"), value: 'O-'),
                              DropdownMenuItem(
                                  child: Text("AB-"), value: 'AB-'),
                            ],
                            decoration: InputDecoration(
                                hintText: 'Select Blood Group',
                                labelText: 'Blood Group:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            onChanged: (value) {
                              setState(() {
                                bloodGroup = value;
                              });
                            },
                            value: bloodGroup,
                            validator: (value) => value == null
                                ? 'Please Select your Blood Group'
                                : null,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: mobile,
                            keyboardType: TextInputType.phone,
                            autofillHints: [AutofillHints.telephoneNumber],
                            decoration: InputDecoration(
                                hintText: '+923001122333',
                                labelText: 'Phone:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              if (value.length != 13) {
                                return 'No Format should be +923001122333';
                              }
                              if (!RegExp(
                                r'(^(?:[+92]+92)?[0-9]{10}$)',
                              ).hasMatch(value)) {
                                return "Invalid Format!";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  hintText: 'Select Availability',
                                  labelText: 'Availability',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder()),
                              items: [
                                DropdownMenuItem(
                                    child: Text('Available'),
                                    value: 'Available'),
                                DropdownMenuItem(
                                    child: Text('Unavailable'),
                                    value: 'Unavailable'),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  availability = value;
                                });
                              },
                              value: availability,
                              validator: (value) => value == null
                                  ? 'Please Select Availability'
                                  : null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              items: [
                                DropdownMenuItem(
                                  child: Text('Pakistan'),
                                  value: 'Pakistan',
                                ),
                              ],
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  labelText: 'Country:',
                                  hintText: 'Select Country',
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                setState(() {
                                  country = value;
                                });
                              },
                              value: country,
                              validator: (value) => value == null
                                  ? 'Please Select your Blood Group'
                                  : null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              items: [
                                DropdownMenuItem(
                                  child: Text("Punjab"),
                                  value: 'Punjab',
                                ),
                                DropdownMenuItem(
                                    child: Text("Sindh"), value: 'Sindh'),
                                DropdownMenuItem(
                                    child: Text("Khyber Pakhtunkhwa"),
                                    value: 'Khyber Pakhtunkhwa'),
                                DropdownMenuItem(
                                    child: Text("Balochistan"),
                                    value: 'Balochistan'),
                                DropdownMenuItem(
                                    child: Text("Gilgit Baltistan"),
                                    value: 'Gilgit Baltistan'),
                              ],
                              decoration: InputDecoration(
                                  hintText: 'Select Province',
                                  labelText: 'Province:',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                setState(() {
                                  province = value;
                                });
                              },
                              value: province,
                              validator: (value) =>
                                  value == null ? 'Field is required' : null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: city,
                            decoration: InputDecoration(
                                hintText: 'Enter City Name',
                                labelText: 'City:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: address,
                            maxLines: 4,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter Address',
                                labelText: 'Address:',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Visibility(
                            visible: _visible,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: email,
                                    autofillHints: [AutofillHints.email],
                                    decoration: InputDecoration(
                                        hintText: 'Enter Email Address',
                                        labelText: 'Email Address:',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder()),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'This field is required';
                                      }
                                      if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                      ).hasMatch(value)) {
                                        return "a valid email like abc122@gmail.com";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: 'Enter Password',
                                        labelText: 'Password:'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be of 6 digits';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: confirmPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Confirm Password',
                                        hintText: 'Enter Confirm Password'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Field is required';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be of 6 digits';
                                      }
                                      print(password.text);
                                      print(confirmPassword.text);
                                      if (confirmPassword.text !=
                                          password.text) {
                                        return 'Password is not matching';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  reset();
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red),
                                child: Text('Reset')),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, dynamic> data = {
                                      'Name': name.text.trim(),
                                      'Gender': gender,
                                      'DOB': dob.text,
                                      'Blood Group': bloodGroup,
                                      'Mobile': mobile.text,
                                      'Country': country,
                                      'Province': province,
                                      'City': city.text,
                                      'Address': address.text,
                                      'Availability': availability
                                    };
                                    if (btn == "Submit") {
                                      auth
                                          .createUserWithEmailAndPassword(
                                              email: email.text.trim(),
                                              password: password.text.trim())
                                          .catchError((e) {
                                        switch (e.toString()) {
                                          case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
                                            _showMyDialog(
                                                'User Already Registered',
                                                'Please check your email address carefully',
                                                'If your are not registered then contact  to admin');
                                            break;
                                          case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                            _showMyDialog(
                                                'No Internet Connection',
                                                'Please connect your device to internet',
                                                '');
                                            break;
                                          case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
                                            _showMyDialog(
                                                'Request Blocked',
                                                'We are detect unusual Activity from this device',
                                                'Try again later');
                                            break;
                                          case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later. is not yet implemented':
                                            _showMyDialog(
                                                'Request Blocked',
                                                'We are detect unusual Activity from this device.',
                                                'Try again later!');
                                            break;
                                          case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
                                            _showMyDialog(
                                                'User Blocked',
                                                'Your Blocked by Admin',
                                                'Please Contact to Admin');
                                            break;
                                          default:
                                            print(
                                                'Case $e is not yet implemented');
                                        }
                                      }).then((authResult) {
                                        if (authResult.user!.uid.isNotEmpty) {
                                          var user = auth.currentUser;
                                          data['ID'] = user!.uid;
                                          _saveData.insertData(
                                              'Register', data, user.uid);
                                          _showMyDialog(
                                              'Registration Successfully',
                                              'Now you are registered as Donor',
                                              'Thank for joining us');
                                          reset();
                                          Navigator.pop(context);
                                        }
                                      });
                                    } else {
                                      _saveData.updateData(
                                          'Register', data, id);
                                      _showMyDialog('Successfully',
                                          'Data Updated Successfully', '');
                                      reset();
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                child: Text(btn)),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String msg1, var msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg1),
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void reset() {
    setState(() {
      email.clear();
      password.clear();
      confirmPassword.clear();
      name.clear();
      dob.clear();
      mobile.clear();
      city.clear();
      address.clear();
      gender = null;
      bloodGroup = null;
      country = null;
      province = null;
      availability = null;
      id = null;
      _visible = true;
      btn = "Submit";
      appBar = "Register as Donor";
    });
  }
}
