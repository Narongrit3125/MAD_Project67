import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/drinkmenuProvider.dart';
import 'package:account/model/drinkmenuItem.dart';

class EditScreen extends StatefulWidget {
  final DrinkMenuItem drinkItem;

  EditScreen({required this.drinkItem});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _drinkName;
  late double _price;
  late String _category;
  late String _description;

  @override
  void initState() {
    super.initState();
    _drinkName = widget.drinkItem.drinkName;
    _price = widget.drinkItem.price;
    _category = widget.drinkItem.category;
    _description = widget.drinkItem.description;
  }

  @override
  Widget build(BuildContext context) {
    final drinkMenuProvider = Provider.of<DrinkMenuProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Drink Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _drinkName,
                decoration: InputDecoration(labelText: 'Drink Name'),
                onSaved: (value) => _drinkName = value!,
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _price = double.parse(value!),
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final updatedDrink = DrinkMenuItem(
                    keyID: widget.drinkItem.keyID,
                    drinkName: _drinkName,
                    price: _price,
                    category: _category,
                    description: _description,
                    imageUrl: widget.drinkItem.imageUrl,
                  );
                  drinkMenuProvider.updateDrink(updatedDrink);
                  Navigator.pop(context);
                },
                child: Text('Update Drink'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
