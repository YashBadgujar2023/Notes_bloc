import 'package:notes_bloc/model/notesmodel.dart';

abstract class NotesState{}

class NotesInitialState extends NotesState{}

class NotesLoading extends NotesState{}

class NotesLoaded extends NotesState{
  List<noteModel>arrnotes;
  NotesLoaded({required this.arrnotes});
}

class NotesError extends NotesState{}