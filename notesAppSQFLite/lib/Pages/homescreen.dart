import 'package:flutter/material.dart';
import 'package:restart_sqflite/Data/Local/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  List<Map<String, dynamic>> allNotes = [];
  DbHelper? dbRef;
  int? editingNoteId;

  @override
  void initState() {
    super.initState();
    initializeDb();
  }

  void initializeDb() async {
    dbRef = DbHelper.getInstance;
    if (dbRef != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      getNotes();
    } else {
      debugPrint("Database reference is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber
                    ),
                  ),
                  title: Text(allNotes[index][DbHelper.COLUMN_TITLE]),
                  subtitle: Text(allNotes[index][DbHelper.COLUMN_DESCRIPTION]),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.green,
                        onPressed: () {
                          showAddNoteModal(editNote: allNotes[index]);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        color: Colors.red,
                        onPressed: () {
                          deleteData(allNotes[index][DbHelper.COLUMN_S_NO]);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text("No Notes Yet")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddNoteModal();
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddNoteModal({Map<String, dynamic>? editNote}) {
    String errorMessage = '';
    if (editNote != null) {
      editingNoteId = editNote[DbHelper.COLUMN_S_NO];
      titleController.text = editNote[DbHelper.COLUMN_TITLE];
      descriptionController.text = editNote[DbHelper.COLUMN_DESCRIPTION];
    } else {
      editingNoteId = null;
      titleController.clear();
      descriptionController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    editingNoteId == null ? "Add Note" : "Edit Note",
                    style: const TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 21),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  TextField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Enter Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  const SizedBox(height: 21),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          var titleText = titleController.text.trim();
                          var descText = descriptionController.text.trim();

                          if (titleText.isEmpty || descText.isEmpty) {
                            setModalState(() {
                              errorMessage = "Fill all the required fields!";
                            });
                            return;
                          }

                          if (dbRef == null) {
                            debugPrint("Database is not initialized yet");
                            return;
                          }

                          if (editingNoteId == null) {
                            await dbRef!.addNote(
                              myTitle: titleText,
                              myDesc: descText,
                            );
                          } else {
                            await dbRef!.updateNote(
                              sNo: editingNoteId!,
                              myTitle: titleText,
                              myDesc: descText,
                            );
                          }

                          getNotes();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          editingNoteId == null ? 'Save' : 'Update',
                          style: const TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void getNotes() async {
    if (dbRef == null) return;
    List<Map<String, dynamic>> notes = await dbRef!.getAllNotes();
    setState(() {
      allNotes = notes;
    });
  }

  void deleteData(int id) async {
    if (dbRef == null) return;

    await dbRef!.deleteNotes(id);
    getNotes();

    if (allNotes.isEmpty) {
      await dbRef!.resetAutoIncrement(); // Reset auto-increment when all notes are deleted
    }
  }
}
