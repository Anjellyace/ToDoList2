import 'package:flutter/material.dart';

class ToDoListTile extends StatelessWidget {
  final Function() onPressed;
  final Function() onDelete;
  final String data;
  const ToDoListTile({
    super.key,
    required this.data,
    required this.onPressed,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data),
                Column(
                  children: [
                    IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
