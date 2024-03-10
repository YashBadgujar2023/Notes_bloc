import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/bloc/bloc_bloc.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/model/notesmodel.dart';

class firstscreen extends StatefulWidget {
  const firstscreen({super.key});

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Customtextfield(title, "Enter the title", 25),
          Customtextfield(desc, "Enter the desc", 25),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(onPressed:(){
            noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
            context.read<notes_bloc>().add(AddNotesEvent(newnotes: Notesmodel));
          }, child: Text("Save")),
        ],
      ),
    );
  }
    Customtextfield(
        TextEditingController controller, String hintext, double size) {
      return TextField(
        controller: controller,
        cursorColor: Colors.white,
        maxLines: null,
        style: TextStyle(color: Colors.grey, fontSize: size),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintext,
          hintStyle: TextStyle(color: Colors.grey, fontSize: size),
        ),
      );
    }
}
