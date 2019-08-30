import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pet.dart';
import '../providers/pets.dart';

class EditPetScreen extends StatefulWidget {
  static const routeName = '/edit-pet';

  @override
  _EditPetScreenState createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedPet = Pet(
    id: null,
    name: '',
    price: 0,
    description: '',
    email: '',
    imageUrl: '',
  );

  var _initValues = {
    'name': '',
    'price': '',
    'description': '',
    'email': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false; //dla wskaznika ladowania

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final petId = ModalRoute.of(context).settings.arguments as String;
      if (petId != null) {
        _editedPet = Provider.of<Pets>(context, listen: false).findById(petId);
        _initValues = {
          'name': _editedPet.name,
          'price': _editedPet.price.toString(),
          'description': _editedPet.description,
          'email': _editedPet.email,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedPet.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _emailFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedPet.id != null) {
      await Provider.of<Pets>(context, listen: false)
          .updatePet(_editedPet.id, _editedPet);
    } else {
      try {
        await Provider.of<Pets>(context, listen: false).addPet(_editedPet);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok, got it'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pet Annoucement'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              //jesli prawda jest ze mamy ladowanie, to wyskoczy Circular (czyli wskaznik ladowania), jesli nie to normalnie pojawi sie ekran
              padding: const EdgeInsets.all(14.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add proper data';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPet = Pet(
                          name: value,
                          price: _editedPet.price,
                          description: _editedPet.description,
                          email: _editedPet.email,
                          imageUrl: _editedPet.imageUrl,
                          id: _editedPet.id,
                          isFavorite: _editedPet.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) < 0) {
                          return 'Please do not enter a negative number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPet = Pet(
                            name: _editedPet.name,
                            price: double.parse(value),
                            description: _editedPet.description,
                            email: _editedPet.email,
                            imageUrl: _editedPet.imageUrl,
                            id: _editedPet.id,
                            isFavorite: _editedPet.isFavorite);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPet = Pet(
                          name: _editedPet.name,
                          price: _editedPet.price,
                          description: value,
                          email: _editedPet.email,
                          imageUrl: _editedPet.imageUrl,
                          id: _editedPet.id,
                          isFavorite: _editedPet.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['email'],
                      decoration: InputDecoration(labelText: 'Email'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add proper data';
                        }
                        if (!value.contains('@')) {
                          return 'Your email address should contain @ sign';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPet = Pet(
                          name: _editedPet.name,
                          price: _editedPet.price,
                          description: _editedPet.description,
                          email: value,
                          imageUrl: _editedPet.imageUrl,
                          id: _editedPet.id,
                          isFavorite: _editedPet.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter an URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedPet = Pet(
                                name: _editedPet.name,
                                price: _editedPet.price,
                                description: _editedPet.description,
                                email: _editedPet.email,
                                imageUrl: value,
                                id: _editedPet.id,
                                isFavorite: _editedPet.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
