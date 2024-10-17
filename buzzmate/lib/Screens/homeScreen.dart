import 'package:buzzmate/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;

  final TextEditingController _search = TextEditingController();

  void onSearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => logOut(context),
                icon: const Icon(Icons.logout))
          ],
          backgroundColor: Colors.amber,
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height / 20,
                  width: size.width / 20,
                  child: const CircularProgressIndicator(),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: TextField(
                        controller: _search,
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  ElevatedButton(
                    onPressed: onSearch,
                    child: const Text("Search"),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  userMap != null
                      ? ListTile(
                          leading: const Icon(
                            Icons.account_box,
                            color: Colors.black,
                          ),
                          onTap: () {},
                          title: Text(
                            userMap?['name'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(userMap?['email']),
                          trailing: const Icon(
                            Icons.chat,
                            color: Colors.black,
                          ),
                        )
                      : Container(),
                ],
              ));
  }
}
