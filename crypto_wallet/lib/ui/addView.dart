import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  List<String> coins = ['bitcoin', 'tether', 'ethereum'];
  String dropdownValue = 'bitcoin';
  final TextEditingController _amoutControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: coins.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            controller: _amoutControler,
            decoration: const InputDecoration(labelText: 'Coin Amount'),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.4,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: MaterialButton(
              onPressed: () async {
                await addCoin(dropdownValue, _amoutControler.text);
                Navigator.pop(context);
              },
              child: const Text("Add")),
        ),
      ]),
    );
  }
}
