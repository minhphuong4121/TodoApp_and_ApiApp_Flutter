import 'package:flutter/material.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_bloc.dart';
import 'package:flutter_application_1/custom_todo_app/bloc/todo_event.dart';
import 'package:flutter_application_1/custom_todo_app/model/todo_model.dart';
import 'package:provider/provider.dart';

class ListViewBody extends StatefulWidget {
  ListViewBody({super.key});

  @override
  _ListViewBodyState createState() => _ListViewBodyState();
}

class _ListViewBodyState extends State<ListViewBody> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<TodoBloc2>(context);
    bloc.initData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ListViewBody oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  final TextEditingController _textEditUpdate = TextEditingController();
  bool _isEmpty = false;

  @override
  Widget build(BuildContext context) {
    print('list view');
    var bloc = Provider.of<TodoBloc2>(context);
    return StreamBuilder<List<TodoModel>>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          snapshot.data!.isEmpty ? _isEmpty = true : _isEmpty = false;
          return _isEmpty
              ? const Center(
                  child: Text(
                    'Empty Todo...',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    // final todoList = snapshot.data!;
                    // if (index < todoList.length && todoList[index].content != null) {
                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: const Color.fromARGB(255, 65, 216, 239),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: ListTile(
                              title: Text(
                                  snapshot.data![index].content.toString()),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _textEditUpdate.text =
                                snapshot.data![index].content.toString();

                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Padding(
                                  //color: Colors.red,
                                  padding: EdgeInsets.only(
                                      top: 30,
                                      left: 15,
                                      right: 15,
                                      bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom +
                                          50),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextField(
                                        controller: _textEditUpdate,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            print(
                                                '${snapshot.data![index].id}');
                                            bloc.event.add(UpdateEvent(
                                                snapshot.data![index].id!,
                                                _textEditUpdate.text));
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Update'))
                                    ],
                                  )),
                              elevation: 50,
                              isScrollControlled: true,
                            );
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.yellow),
                                        height: 200,

                                        // width: 100,
                                        // height: 100,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              textAlign: TextAlign.center,
                                              'Do you want delete this todo:',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              snapshot.data![index].content
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    223,
                                                                    127,
                                                                    120))),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'CANCEL',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.green)),
                                                    onPressed: () {
                                                      bloc.event.add(DeleEvent(
                                                          snapshot
                                                              .data![index]));
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                });
                            //bloc.event.add(DeleEvent(snapshot.data![index]));
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    );
                    // } else {
                    //   // Handle if content or snapshot data at index is null
                    //   return const SizedBox(); // Placeholder or alternative widget
                    // }
                  },
                  itemCount: snapshot.data!.length,
                );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
