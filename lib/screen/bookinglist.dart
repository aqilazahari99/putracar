import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingList extends StatefulWidget {
  String id;
  BookingList(String id) {
    this.id = id;
  }
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFC52F45),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
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
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Bookings')
                      .where("CarId", isEqualTo: id)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Text("Loading..");
                      default:
                        return ListView(
                          children: snapshot.data.docs.map((document) {
                            return Padding(
                              padding: EdgeInsets.all(10),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (document.data() as Map<String, dynamic>)[
                                                  "Imageurl"] !=
                                              null
                                          ? Image(
                                              image: NetworkImage(
                                                (document.data() as Map<String,
                                                    dynamic>)["Imageurl"],
                                              ),
                                              height: 150,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(),
                                      Text(
                                        (document.data()
                                            as Map<String, dynamic>)["Title"],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        (document.data() as Map<String,
                                                dynamic>)["Price"] +
                                            ' per hour ',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Renting period",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "From :" +
                                            (document.data() as Map<String,
                                                dynamic>)["DateFrom"] +
                                            ' at ' +
                                            (document.data() as Map<String,
                                                dynamic>)["TimeFrom"],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Until :" +
                                            (document.data() as Map<String,
                                                dynamic>)["DateTo"] +
                                            ' at ' +
                                            (document.data() as Map<String,
                                                dynamic>)["TimeTo"],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Please contact :" +
                                            (document.data() as Map<String,
                                                dynamic>)["RecipientPhone"],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Booked by :" +
                                            (document.data() as Map<String,
                                                dynamic>)["RecipientName"],
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          var collection = FirebaseFirestore
                                              .instance
                                              .collection('Bookings');
                                          await collection
                                              .doc(document.id)
                                              .delete();
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text('Delete'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
