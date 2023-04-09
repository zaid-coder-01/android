import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class ProjectStatusScreen extends StatefulWidget {
  @override
  _ProjectStatusScreenState createState() => _ProjectStatusScreenState();
}

class _ProjectStatusScreenState extends State<ProjectStatusScreen> {
  final _formKey = GlobalKey<FormState>();
  final _departmentController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _businessBenefitController = TextEditingController();
  final _projectBriefController = TextEditingController();
  DateTime? _selectedDate;
  File? _selectedFile;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Process form data here, like uploading the file to a server

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Form submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _departmentController.dispose();
    _projectNameController.dispose();
    _businessBenefitController.dispose();
    _projectBriefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Project'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _departmentController,
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _projectNameController,
                  decoration: InputDecoration(
                    labelText: 'Department Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter department name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _businessBenefitController,
                  decoration: InputDecoration(
                    labelText: 'Business Benefit',
                    border: OutlineInputBorder(),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter business benefit';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _projectBriefController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Project Brief',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter project brief';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text('Select Date:'),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _selectDate,
                      child: Text(_selectedDate == null
                          ? 'Choose Date'
                          : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text('Upload Document:'),
                    SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: _selectFile,
                      child: Text(_selectedFile == null
                          ? 'Choose File'
                          : _selectedFile!
                          .path
                          .split('/')
                          .last),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
