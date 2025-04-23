import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String? selectedGender;
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    String name = nameController.text;
    String weight = weightController.text;
    String age = ageController.text; // Get age input
    String address = addressController.text;
    String contact = contactController.text;

    if (name.isEmpty ||
        selectedGender == null ||
        weight.isEmpty ||
        age.isEmpty || // Ensure age is filled out
        address.isEmpty ||
        contact.isEmpty ||
        _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill out all fields and pick an image")),
      );
      return;
    }

    // Handle form submission here (send to API, etc.)
    print("Pet Name: $name");
    print("Gender: $selectedGender");
    print("Weight: $weight");
    print("Weight: $age");
    print("Address: $address");
    print("Contact: $contact");

    print("Image Path: ${_pickedImage!.path}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pet submitted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final genderOptions = ['Male', 'Female'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PetL",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Icon(FontAwesomeIcons.paw, color: Colors.white, size: 24),
            Text("ve",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Add Pet",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Pet Name"),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Gender"),
              items: genderOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedGender = value),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ageController, // Added text field for age
              decoration: const InputDecoration(labelText: "Age (years)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              decoration: const InputDecoration(labelText: "Contact Number"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Upload Picture"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            if (_pickedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.file(_pickedImage!, height: 150),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
