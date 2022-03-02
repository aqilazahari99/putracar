import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:putracar/model/car_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  String title, price, owner, imageurl, location, id, userphone, userDname;
  DetailScreen(String Title, String Price, String Owner, String ImageUrl,
      String Location, String id, String userphone, String userDname) {
    this.title = Title;
    this.price = Price;
    this.owner = Owner;
    this.imageurl = ImageUrl;
    this.location = Location;
    this.id = id;
    this.userphone = userphone;
    this.userDname = userDname;
  }

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  String DateFrom, DateTo, TimeFrom, TimeTo;

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  var user, useremail, recipientphone, recipientName;
  getCurrentUser() {
    setState(() {
      user = _auth.currentUser;
      useremail = user.email;
    });
    _firestore
        .collection('Users')
        .where('email', isEqualTo: useremail.toString())
        .snapshots()
        .listen((data) {
      setState(() {
        recipientphone = data.docs[0].data()["phoneNum"];
        recipientName = data.docs[0].data()["name"];
      });
    });
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  String title, price, owner, imageurl, location, id, userphone, userDname;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    price = widget.price;
    owner = widget.owner;
    imageurl = widget.imageurl;
    location = widget.location;
    id = widget.id;
    userphone = widget.userphone;
    userDname = widget.userDname;
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC52F45),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Date From :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateTimePicker(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMMM yyyy',
                  initialValue: " ",
                  firstDate: DateTime.now().subtract(Duration(days: 2)),
                  lastDate: DateTime(2300),
                  // icon: Icon(Icons.event),
                  // dateLabelText: 'Date',
                  // timeLabelText: "Hour",
                  onChanged: (val) {
                    DateFrom =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                  validator: (val) {
                    return DateFrom =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                  onSaved: (val) {
                    DateFrom =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Date untill :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateTimePicker(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMMM yyyy',
                  initialValue: " ",
                  firstDate: DateTime.now().subtract(Duration(days: 2)),
                  lastDate: DateTime(2300),
                  // icon: Icon(Icons.event),
                  // dateLabelText: 'Date',
                  // timeLabelText: "Hour",
                  onChanged: (val) {
                    DateTo =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                  validator: (val) {
                    return DateTo =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                  onSaved: (val) {
                    DateTo =
                        DateFormat("dd MMMM yyyy").format(DateTime.parse(val));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Time From :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateTimePicker(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  type: DateTimePickerType.time,
                  initialValue: " ",
                  locale: Locale('ms', 'MY'),
                  onChanged: (value) {
                    TimeFrom = value;
                  },
                  validator: (value) {
                    return TimeFrom = value;
                  },
                  onSaved: (value) {
                    TimeFrom = value;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Time To :",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DateTimePicker(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  type: DateTimePickerType.time,
                  initialValue: " ",
                  locale: Locale('ms', 'MY'),
                  onChanged: (value) {
                    TimeTo = value;
                  },
                  validator: (value) {
                    return TimeTo = value;
                  },
                  onSaved: (value) {
                    TimeTo = value;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () async {
                      if (DateFrom != null &&
                          DateTo != null &&
                          TimeTo != null &&
                          TimeFrom != null) {
                        await _firestore.collection('Bookings').add({
                          'CarId': id,
                          'Imageurl': imageurl,
                          'Title': title,
                          'Location': location,
                          'Price': price,
                          'Owner': owner,
                          'OwnerPhone': userphone,
                          'OwnerName': userDname,
                          'RecipientEmail': useremail.toString(),
                          'RecipientPhone': recipientphone,
                          'RecipientName': recipientName,
                          'DateFrom': DateFrom,
                          'DateTo': DateTo,
                          'TimeFrom': TimeFrom,
                          'TimeTo': TimeTo,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Booking Submit!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Please Choose Date and Time!'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Book now",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFC52F45),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 2000,
              maximumYear: 2025,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select booking date',
      cancelText: 'Not now',
      confirmText: 'Book',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Booking date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
