import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:fluttermysql/models/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'round_button.dart';

class AddNewsScreen extends StatefulWidget {
  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  String title, content, description, idUser;
  File _imageFile;
  final picker = ImagePicker();
  final _key = GlobalKey<FormState>();

  void _check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submit();
    }
  }

  _seletcImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No Image Selected');
      }
    });
  }

  _submit() async {
    try {
      var uri = Uri.parse(BaseURL.kAddnewsrUrl);
      var request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('image', _imageFile.path));
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_user'] = idUser;
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Uploading Success');
        Navigator.pop(context);
      } else {
        print('Uploading Failed');
      }
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUser = pref.getString('id_user');
      print(idUser);
    });
  }

  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeHolder = Container(
      width: double.infinity,
      height: 150,
      child: Image.asset('assets/img/blankimage.png'),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150.0,
                  child: InkWell(
                    child: _imageFile == null
                        ? placeHolder
                        : Image.file(
                            _imageFile,
                            fit: BoxFit.fitHeight,
                          ),
                    onTap: () {
                      _seletcImage();
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Title'),
                  onSaved: (value) => title = value,
                ),
                TextFormField(
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Content'),
                  onSaved: (value) => content = value,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Description'),
                  onSaved: (value) => description = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                FullWidthRoundButton(
                  getPressed: () {
                    _check();
                  },
                  textButton: 'Submit',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
