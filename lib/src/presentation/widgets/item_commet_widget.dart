import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCommentWidget extends StatelessWidget {
  final String name;
  final String email;
  final String body;

  ItemCommentWidget(this.name, this.email, this.body);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Icon(
                Icons.comment_sharp,
                color: Colors.blue,
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name:",
                        style: TextStyle(fontSize: 12, color: Colors.blue)),
                    Text(name),
                    SizedBox(height: 8,),
                    Text("Emai:",
                        style: TextStyle(fontSize: 12, color: Colors.blue)),
                    Text(email),
                    SizedBox(height: 8,),
                    Text("Body:",
                        style: TextStyle(fontSize: 12, color: Colors.blue)),
                    Text(body),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
