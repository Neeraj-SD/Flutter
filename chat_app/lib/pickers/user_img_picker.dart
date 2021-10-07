import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File img) pickImgFn;

  UserImagePicker(this.pickImgFn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  void _pickImage(ImageSource source) async {
    final _picker = ImagePicker();

    PickedFile image = await _picker.getImage(
      source: source,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(() {
      _pickedImage = File(image.path);
    });
    widget.pickImgFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          label: Text('Pick image'),
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Source Picker'),
                content: Text('Where to pick image'),
                actions: [
                  FlatButton.icon(
                      label: Text('Camera'),
                      icon: Icon(Icons.camera),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      }),
                  FlatButton.icon(
                      label: Text('Gallery'),
                      icon: Icon(Icons.image),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                ],
                elevation: 4,
              );
            },
          ),
        ),
      ],
    );
  }
}
