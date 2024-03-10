import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/bloc/bloc_bloc.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/model/notesmodel.dart';

class addscreen extends StatelessWidget {
  const addscreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController desc = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              GestureDetector(
                onTap:()
                {
                  showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Text("Save"),
                    content: Text("You want to save the correction"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("Dont'Save"),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("cancal"),
                      ),
                      TextButton(
                        onPressed: (){
                          noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
                          context.read<notes_bloc>().add(AddNotesEvent(newnotes: Notesmodel));
                          context.read<notes_bloc>().add(FetchNotesEvent());
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("ok"),
                      ),
                    ],
                  )
                  );
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10,top: 10),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Icon(Icons.arrow_back_ios_new,size: 30,)
                    )
                ),
              ),
              Customtextfield(title,"Title :)",50),
              Customtextfield(desc,"Description",30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          log("click");
          noteModel Notesmodel = noteModel(title: title.text.toString(),desc: desc.text.toString());
          context.read<notes_bloc>().add(AddNotesEvent(newnotes: Notesmodel));
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  Customtextfield(TextEditingController controller,String hintext,double size){
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      maxLines: null,
      style:  TextStyle(color: Colors.grey,fontSize: size),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.grey,fontSize: size),
      ),
    );
  }

// customalertbox(){
//   return
// }
}
