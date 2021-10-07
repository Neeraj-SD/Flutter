import 'package:flutter/material.dart';

enum ViewMode {
  Edit,
  View,
}

class PasswordExpanded extends StatefulWidget {
  const PasswordExpanded({Key key}) : super(key: key);
  static const routeName = '/passwordExpanded';

  @override
  _PasswordExpandedState createState() => _PasswordExpandedState();
}

class _PasswordExpandedState extends State<PasswordExpanded> {
  ViewMode view;

  @override
  void initState() {
    super.initState();
    view = ViewMode.Edit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('ID/Username'),
                  subtitle: view == ViewMode.View
                      ? Text('username')
                      : EditableText('username'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.copy),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.password),
                  title: Text('Password'),
                  subtitle: TextField(
                    controller: TextEditingController(text: 'password'),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.copy),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.web_asset),
                  title: Text('Website'),
                  subtitle: Text('website name'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.launch),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.notes),
                    title: Text('Notes'),
                    subtitle: Text('')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EditableText extends StatefulWidget {
  EditableText(this.initialvalue);
  String initialvalue;

  @override
  _EditableTextState createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableText> {
  bool _isEditingText;
  String initialText;
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _isEditingText = false;
    initialText = widget.initialvalue;
    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditingText) {
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              _isEditingText = false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    }
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        initialText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
