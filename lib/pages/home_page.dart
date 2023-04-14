import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductInfo {
  final String name;
  final int price;

  ProductInfo(this.name, this.price);
}

final products = [
  ProductInfo('Wireless mouse', 3),
  ProductInfo('Keyboard', 5),
  ProductInfo('Camera', 8),
  ProductInfo('Speaker', 4),
  ProductInfo('iPad', 1000),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  int? _inputPrice;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 80)),
            Text(products[_index].name),
            const Padding(padding: EdgeInsets.only(top: 80)),
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => {_inputPrice = int.parse(value)},
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 80)),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _result =
                        products[_index].price == _inputPrice ? 'pass' : 'fail';
                  });
                },
                child: const Text('Check')),
            Visibility(
              visible: _result.isNotEmpty,
              child: Text(_result),
            ),
            Visibility(
                visible: _result.isNotEmpty,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_index < products.length - 1) {
                          _index++;
                        }
                      });
                    },
                    child: const Text('Next')))
          ],
        ),
      ),
    );
  }
}
