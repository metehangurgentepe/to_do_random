import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    List<String> words =taskName.split(' ');
    print(words);
    List<String> firstRow=[];
    List<String> secondRow=[];
    if(words.length<4){
      for(int i =0;i<words.length;i++){
        firstRow.add(words[i]);
      }
    }
    if(words.length>4){
      for(int i =0;i<5;i++){
        firstRow.add(words[i]);
      }
      for(int i =5;i<words.length;i++){
        secondRow.add(words[i]);
      }
    }
    else{
      for(int i =0;i<4;i++){
        firstRow.add(words[i]);
      }
      for(int i =4;i<words.length;i++){
        secondRow.add(words[i]);
      }
    }




    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Color(0xff253a42),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // checkbox
              Checkbox(
                side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.white,width: 2.0)),
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),

              // task name
              Center(child:Text(
               '${firstRow.join(' ')}\n${secondRow.join(' ')}',
                style: TextStyle(
                  color: Colors.white,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}