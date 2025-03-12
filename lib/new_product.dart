import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/product_controller.dart';
import 'package:get/get.dart';

class NewProductScreen extends StatefulWidget {
  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ProductController>();

  // Variables to store form input
  String _name = '';
  String _description = '';
  int _price = 0;
  XFile? _pickedImage;
  Uint8List? _pickedImageBytes; // Used on Flutter Web

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        // On web, read the image as bytes and store them
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _pickedImage = pickedImage;
          _pickedImageBytes = bytes;
        });
      } else {
        // On mobile, we can use the file path directly
        setState(() {
          _pickedImage = pickedImage;
        });
      }
    }
  }

  // Widget to display the picked image
  Widget _buildImagePreview() {
    if (_pickedImage == null) {
      return Center(child: Text('No image selected'));
    }
    if (kIsWeb) {
      return _pickedImageBytes != null
          ? Image.memory(
        _pickedImageBytes!,
        fit: BoxFit.cover,
      )
          : Center(child: Text('Loading image...'));
    } else {
      return Image.file(
        File(_pickedImage!.path),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Product Name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 16),
                // Description
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),
                SizedBox(height: 16),
                // Price
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product price';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) => _price = int.tryParse(value!) ?? 0,
                ),
                SizedBox(height: 16),
                // Image Picker Section
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: _buildImagePreview(),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Make sure an image has been selected
                      if (_pickedImage != null) {
                        controller.addProduct(_name, _description, _price, _pickedImage!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product saved successfully')),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please pick an image')),
                        );
                      }
                    }
                  },
                  child: Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
