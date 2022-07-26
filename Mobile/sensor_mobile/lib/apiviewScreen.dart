import 'package:flutter/material.dart';
import 'package:sensor_mobile/models/post.dart';
import 'package:sensor_mobile/services/remote_service.dart';

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<Post>? posts;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("APi Veri"),
        ),
        body: Visibility(
          visible: isLoaded,
          child: ListView.builder(
              itemCount: posts?.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(posts![index].pil.toString()),
                );
              }),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
