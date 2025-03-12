import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/product_controller.dart';
import 'package:get/get.dart';
import 'utils/app_constants.dart';

class EditProductScreen extends StatefulWidget {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl; 

  const EditProductScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ProductController>();

  // Variables to store the updated input values
  late String _name;
  late String _description;
  late int _price;
  XFile? _pickedImage;
  Uint8List? _pickedImageBytes; // Used on Flutter Web

  @override
  void initState() {
    super.initState();
    // Set the initial values from the widget's parameters
    _name = widget.name;
    _description = widget.description;
    _price = widget.price;
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (kIsWeb) {
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _pickedImage = pickedImage;
          _pickedImageBytes = bytes;
        });
      } else {
        setState(() {
          _pickedImage = pickedImage;
        });
      }
    }
  }

  // Widget to display the picked image or initial image from URL if no new image is selected
  Widget _buildImagePreview() {
        return Image.network(AppConstants.BASE_URL+"/uploads/"+widget.imageUrl!, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Product Name Field
                TextFormField(
                  initialValue: _name,
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
                // Description Field
                TextFormField(
                  initialValue: _description,
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
                // Price Field
                TextFormField(
                  initialValue: _price.toString(),
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
                  onSaved: (value) =>
                  _price = int.tryParse(value!) ?? widget.price,
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
                      // Call the edit method from the controller.
                      controller.editProduct(
                        widget.id,
                        _name,
                        _description,
                        _price,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Product updated successfully')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
