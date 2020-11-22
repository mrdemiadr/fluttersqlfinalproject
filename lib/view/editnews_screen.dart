import 'package:flutter/material.dart';
import 'package:fluttermysql/models/constant.dart';
import 'package:fluttermysql/models/newsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'round_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditNews extends StatefulWidget {
  final NewsModel model;
  final VoidCallback reload;
  EditNews(this.model, this.reload);
  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  String title, content, description, idUser;
  File _imageFile;
  final picker = ImagePicker();
  final _key = GlobalKey<FormState>();
  TextEditingController titleText, contentText, descriptionText;

  void _check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      _submit();
    }
  }

  _getDataToEdit() async {
    titleText = TextEditingController(text: widget.model.title);
    contentText = TextEditingController(text: widget.model.content);
    descriptionText = TextEditingController(text: widget.model.description);
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
      var uri = Uri.parse(BaseURL.kEditUrl);
      var request = http.MultipartRequest('POST', uri);
      request.files
          .add(await http.MultipartFile.fromPath('image', _imageFile.path));
      request.fields['title'] = title;
      request.fields['content'] = content;
      request.fields['description'] = description;
      request.fields['id_user'] = idUser;
      request.fields['id_news'] = widget.model.idNews;
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Uploading Success');
        setState(() {
          widget.reload();
        });
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
    _getDataToEdit();
  }

  @override
  Widget build(BuildContext context) {
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
                        ? Image.network(BaseURL.kImageUrl + widget.model.image)
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
                  controller: titleText,
                  decoration: kTextFieldDecoration.copyWith(labelText: 'Title'),
                  onSaved: (value) => title = value,
                ),
                TextFormField(
                  controller: contentText,
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
                  controller: descriptionText,
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
