import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_method.dart';
import 'package:crypto_wallet/ui/addView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('Coins')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Coin Name: ${document.id} '),
                    Text(
                        'Amount Owned: ${getValue(document.id, document.get('Amount'))}')
                  ],
                ));
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddView(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
