import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({Key? key}) : super(key: key);

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  double _inputValue = 0;
  double _outputValue = 0;
  String _selectedInputUnit = 'Celsius';
  String _selectedOutputUnit = 'Fahrenheit';

  void _convertTemperature(double inputValue) {
    setState(() {
      _inputValue = inputValue;
      if (_selectedInputUnit == 'Celsius' && _selectedOutputUnit == 'Fahrenheit') {
        _outputValue = (inputValue * 9 / 5) + 32; // Convert Celsius to Fahrenheit
      } else if (_selectedInputUnit == 'Fahrenheit' && _selectedOutputUnit == 'Celsius') {
        _outputValue = (inputValue - 32) * 5 / 9; // Convert Fahrenheit to Celsius
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Temperature in $_selectedInputUnit:',
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _convertTemperature(double.parse(value));
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter temperature',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: DropdownButton<String>(
                      value: _selectedInputUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedInputUnit = newValue!;
                        });
                        _convertTemperature(_inputValue);
                      },
                      items: <String>['Celsius', 'Fahrenheit']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Temperature in $_selectedOutputUnit:',
            ),
            Text(
              '$_outputValue',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Swap input and output units
                setState(() {
                  final temp = _selectedInputUnit;
                  _selectedInputUnit = _selectedOutputUnit;
                  _selectedOutputUnit = temp;
                  _convertTemperature(_inputValue);
                });
              },
              child: Text('Swap Units'),
            ),
          ],
        ),
      ),
    );
  }
}
