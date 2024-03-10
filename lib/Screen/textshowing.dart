import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/bloc/bloc_bloc.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/bloc/bloc_state.dart';

class textshowing extends StatefulWidget {
  const textshowing({super.key,required this.dataindex});
  final int dataindex;
  @override
  State<textshowing> createState() => _textshowingState();
}

class _textshowingState extends State<textshowing> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  late int id_index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<notes_bloc,NotesState>(
        builder: (context,state){
          if(state is NotesLoading)
          {
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is NotesLoaded)
          {
            id_index = state.arrnotes[widget.dataindex].note_id!;
            return SafeArea(
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
                              child: Text("Don't Save"),
                            ),TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text("cancal"),
                            ),
                            TextButton(
                              onPressed: (){
                                context.read<notes_bloc>().add(UpdateEvent(desc: desc.text.toString(), title:title.text.toString(), id:id_index));
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
                    Customtextfield(title .. text = state.arrnotes[widget.dataindex].title.toString(),"Title:)",50),
                    Customtextfield(desc.. text = state.arrnotes[widget.dataindex].desc.toString(),"Description",30),
                  ],
                ),
              ),
            );
          }
          else{
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.read<notes_bloc>().add(UpdateEvent(desc: desc.text.toString(), title:title.text.toString(), id:id_index));
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
}

