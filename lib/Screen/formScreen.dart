import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../provider/drinkmenuProvider.dart';
import '../model/drinkmenuItem.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _drinkName = '';
  double _price = 0.0;
  String _category = '';
  String _description = '';
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final drinkMenuProvider = Provider.of<DrinkMenuProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Drink Menu')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Drink Name'),
                  validator: (value) => value!.isEmpty ? 'Enter drink name' : null,
                  onSaved: (value) => _drinkName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter price' : null,
                  onSaved: (value) => _price = double.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) => value!.isEmpty ? 'Enter category' : null,
                  onSaved: (value) => _category = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) => value!.isEmpty ? 'Enter description' : null,
                  onSaved: (value) => _description = value!,
                ),
                SizedBox(height: 20),
                _image != null
                    ? Image.file(_image!, height: 100, width: 100, fit: BoxFit.cover)
                    : Text('No image selected'),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newDrink = DrinkMenuItem(
                        drinkName: _drinkName,
                        price: _price,
                        category: _category,
                        description: _description,
                        imageUrl: _image?.path,
                      );
                      drinkMenuProvider.addDrink(newDrink);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Drink'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}