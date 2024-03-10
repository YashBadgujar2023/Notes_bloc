import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/Screen/addscreen.dart';
import 'package:notes_bloc/Screen/textshowing.dart';
import 'package:notes_bloc/bloc/bloc_bloc.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/bloc/bloc_state.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController search = TextEditingController();
  int i = 0;
  List<Color> arr =[
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
    Colors.orange.shade50,
  ];
  @override
  void initState() {
    super.initState();
    context.read<notes_bloc>().add(FetchNotesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("My Notes", style: TextStyle(fontFamily: "yash",
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
              Center(
                child: Icon(
                  Icons.settings, size: 35, color: Colors.white,),
              ),
            ],
          ),
          BlocBuilder<notes_bloc,NotesState>(
            builder: (context,state) {
              if (state is NotesLoading) {
                return Center(child: Text("error"),);
              }
              else if (state is NotesLoaded) {
                return state.arrnotes.isNotEmpty ?  SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount:state.arrnotes.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // color: arr[Random().nextInt(2)],
                                      color:Colors.amber.shade50,
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>textshowing(dataindex: index)));
                                    },
                                    onLongPress: (){
                                      showModalBottomSheet(context: context, builder: (context){
                                        return ElevatedButton(
                                            onPressed: ()async{
                                              context.read<notes_bloc>().add(DeleteEvent(id: state.arrnotes[index].note_id!));
                                              Navigator.pop(context);
                                            },
                                            child:const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.delete,size: 30,color: Colors.black,),
                                                Text("Delete",style: TextStyle(fontSize: 25,color: Colors.black),),
                                              ],
                                            ));
                                      },
                                      );
                                    },
                                    title: Text(state.arrnotes[index].title.toString(), style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),),
                                    subtitle: Text(
                                        state.arrnotes[index].desc.toString(), maxLines: 4),
                                  ),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ) :  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Image.asset("assets/image/download(1).png"),
                      width: 200,
                      height: 200,
                    ),
                    Text("No Data",style:  TextStyle(color: Colors.white,fontSize: 30),),
                    SizedBox(height: 10,),
                    Text("Please Enter Add the note to Show",style: TextStyle(fontSize: 22,color: Colors.white54),),
                  ],
                );
              }
              else {
                return Container(
                );
              }
            }
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>addscreen()));
        },
        label: Text("Add",style: TextStyle(fontSize: 20),),
        icon: Icon(Icons.add,size: 30,),
      ),
    );
  }
}
