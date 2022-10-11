import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:graphz/features/weather/presentation/routes/router.gr.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details page"),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(),
          ),
        ),
      ),
    );
  }
}
