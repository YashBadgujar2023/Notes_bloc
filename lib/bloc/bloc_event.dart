import 'package:notes_bloc/model/notesmodel.dart';

abstract class NotesEvent{}

class AddNotesEvent extends NotesEvent{
  noteModel newnotes;
  AddNotesEvent({required this.newnotes});
}

class FetchNotesEvent extends NotesEvent{}

class UpdateEvent extends NotesEvent{
  int id;
  String title;
  String desc;
  UpdateEvent({required this.desc,required this.title,required this.id});
}

class DeleteEvent extends NotesEvent{
  int id;
  DeleteEvent({required this.id});
}