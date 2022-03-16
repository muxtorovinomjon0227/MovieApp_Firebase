import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_aplicetion_fair_base/models/movie.dart';

import '../models/movie.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {

    final moviesRef = FirebaseFirestore.instance
        .collection('firestore-example-app')
        .withConverter<MyMovie>(
      fromFirestore: (snapshots, _) => MyMovie.fromJson(snapshots.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<MyMovie>>(
        stream: moviesRef.snapshots(),
        builder: (context, snapshot){
          if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data?.size,
              itemBuilder: (context, index) {
            return Text(snapshot.data!.docs[index].data().name!);
          });
        }
      ),
    );
  }
}
