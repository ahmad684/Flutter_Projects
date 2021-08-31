import 'package:blood_donation_app/SaveToDatabase.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

SaveData _saveData = new SaveData();
TextEditingController title = new TextEditingController();
TextEditingController patientName = new TextEditingController();
TextEditingController patientAge = new TextEditingController();
TextEditingController needed = new TextEditingController();
TextEditingController reason = new TextEditingController();
TextEditingController mobile = new TextEditingController();
TextEditingController city = new TextEditingController();
TextEditingController address = new TextEditingController();
var gender, bloodGroup, country, province, id;
String btn = 'Submit', appBar = "Post Request";

class PostReq extends StatefulWidget {
  void getData(
      String bar, Map<String, dynamic> data, String ID, String btnTxt) {
    appBar = bar;
    if (btnTxt == "Update") {
      title.text = data['title'];
      patientName.text = data['patientname'];
      patientAge.text = data['patientage'];
      needed.text = data['dateofneed'];
      reason.text = data['reason'];
      mobile.text = data['mobile'];
      city.text = data['city'];
      address.text = data['address'];
      gender = data['gender'];
      bloodGroup = data['blood group'];
      country = data['country'];
      province = data['province'];
      id = ID;
      btn = btnTxt;
    }
  }

  @override
  _PostReqState createState() => _PostReqState();
}

class _PostReqState extends State<PostReq> {
  DateTime selectedDate = DateTime.now();
  final format = DateFormat("dd-MM-yyyy");

  var _formKey = GlobalKey<FormState>();

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
                                hintText: 'Enter Title',
                                labelText: 'Title:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            controller: title,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Title';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Patient Name',
                                labelText: 'Patient Name:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-z,\ ,\-]+'))
                            ],
                            controller: patientName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Patient Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Enter Patient Age',
                                labelText: 'Patient Age:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            controller: patientAge,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Patient Age';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              controller: needed,
                              format: format,
                              decoration: InputDecoration(
                                  hintText: 'Date of Need',
                                  labelText: 'Select Date of Need:',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder()),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month + 1,
                                        DateTime.now().day));
                              },
                              validator: (value) => value == null
                                  ? 'Please Select your date of Need'
                                  : null,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: 'Enter Need Reason',
                                labelText: 'Reason:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: OutlineInputBorder()),
                            controller: reason,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Reason';
                              }
                              return null;
                            },
                          ),
                        ),
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
                                      'Title': title.text.trim(),
                                      'patientName': patientName.text.trim(),
                                      'patientAge': patientAge.text,
                                      'DateOfNeed': needed.text,
                                      'Reason': reason.text,
                                      'Gender': gender,
                                      'Blood Group': bloodGroup,
                                      'Mobile': mobile.text,
                                      'Country': country,
                                      'Province': province,
                                      'City': city.text,
                                      'Address': address.text,
                                      'Entry Date':
                                          DateFormat('dd-MM-yyyy kk:mm:ss')
                                              .format(DateTime.now()),
                                    };
                                    if (btn == "Submit") {
                                      _saveData.insertData('PostRequest', data);
                                      _showMyDialog('Successfully',
                                          'Request Submitted Successfully', '');
                                    } else {
                                      _showMyDialog('Successful',
                                          'Data Updated Successfully', ' ');
                                      _saveData.updateData(
                                          'PostRequest', data, id);
                                    }
                                    reset();
                                    Navigator.pop(context);
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
      title.clear();
      needed.clear();
      patientAge.clear();
      patientName.clear();
      mobile.clear();
      reason.clear();
      city.clear();
      address.clear();
      gender = null;
      bloodGroup = null;
      country = null;
      province = null;
      id = null;
      btn = "Submit";
      appBar = "Post Request";
    });
  }
}
