import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../providers/user_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse("${dotenv.env['URL']}/mobile/v1/posts"));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['posts'];
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts from API');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Colors.black,
      child: Card(
        color: theme.colorScheme.background,
        child: Column(
          children: [
            Text('Home Page'),
            TextButton(
              onPressed: () {
                context.read<UserProvider>().logout().then(
                      (v) => context.go('/'),
                    );
              },
              child: Text('Logout'),
            ),
            FutureBuilder(
              future: posts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error da home page ${snapshot.error}");
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Post post = snapshot.data![index];
                        return Card(
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage('assets/images/nophoto.jpg'),
                                width: 40,
                                height: 40,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(post.user.username),
                                      Text('@${post.user.name}'),
                                    ],
                                  ),
                                  Text(post.description),
                                  post.imageUrl != null
                                      ? Image.network(
                                          "${dotenv.env['URL']}${post.imageUrl}")
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
