

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/bloc/bloc_event.dart';
import 'package:notes_bloc/bloc/bloc_state.dart';
import 'package:notes_bloc/dbhelper/dbhelper.dart';
import 'package:notes_bloc/model/notesmodel.dart';

class notes_bloc extends Bloc<NotesEvent,NotesState> {
  DB_helper db_helper;
  notes_bloc({required this.db_helper}) : super(NotesInitialState()){
    on<AddNotesEvent>((event,emit)async{
      emit(NotesLoading());
      bool check=await db_helper.addNotes(event.newnotes);
      if(check){
        var arrnotes=await db_helper.fetchAllNotes();
        emit(NotesLoaded(arrnotes: arrnotes));
      }
  });
    on<FetchNotesEvent>((event, emit) async{
      emit(NotesLoading());
      var arrnotes=await db_helper.fetchAllNotes();
      emit(NotesLoaded(arrnotes: arrnotes));
    });
    on<UpdateEvent>((event, emit) async{
      emit(NotesLoading());
      bool check = await db_helper.updateNotes(noteModel(title: event.title,desc: event.desc,note_id: event.id));
      if(check)
        {
          var arrnotes=await db_helper.fetchAllNotes();
          emit(NotesLoaded(arrnotes: arrnotes));
        }
    });
    on<DeleteEvent>((event, emit) async{
      emit(NotesLoading());
      bool check = await db_helper.deleteNotes(event.id);
      if(check)
        {
          var arrnotes=await db_helper.fetchAllNotes();
          emit(NotesLoaded(arrnotes: arrnotes));
        }
    });
}
}
