import 'package:flutter/material.dart';
import '../ModelClass/note_model.dart';
import '../Services/database_helper.dart';
import 'note_display_screen.dart';

class NoteScreen extends StatefulWidget {
  final Note? note;

  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.note == null ? 'Add a note' : 'Edit note',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  'What are you thinking about?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  labelText: 'Note title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.75,
                    ),
                  ),
                ),
              ),
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Type here the note',
                labelText: 'Note description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.75,
                  ),
                ),
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
              maxLines: 5,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    final title = titleController.value.text;
                    final description = descriptionController.value.text;

                    if (title.isEmpty || description.isEmpty) {
                      return;
                    }

                    final int id = widget.note?.id ?? 0;

                    final Note model = Note(
                      id: id,
                      title: title,
                      description: description,
                    );

                    if (widget.note == null) {
                      await DatabaseHelper.addNote(model);
                    } else {
                      await DatabaseHelper.updateNote(model);
                    }

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    widget.note == null ? 'Save' : 'Edit',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => NotesScreen()),
                );
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
