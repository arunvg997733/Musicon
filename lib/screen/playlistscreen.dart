import 'package:flutter/material.dart';
import 'package:musicon/List/songnotifierlist.dart';
import 'package:musicon/db_function.dart/db_function.dart';
import 'package:musicon/function/function.dart';
import 'package:musicon/model/playlistmodel.dart';
import 'package:musicon/screen/newplaylistscreen.dart';
import 'package:musicon/widgets/widget.dart';

class Playlistscreen extends StatelessWidget {
  const Playlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    playlistdatabasetolist();
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
            )
          ),
          width: double.infinity,
         
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ValueListenableBuilder(valueListenable: playlistnotifier, builder:(BuildContext ctx, List<Playlistmodel> newlist, Widget? child){
              return playlistnotifier.value.isNotEmpty ? ListView.separated(
                itemBuilder: (context, index) {
                  final data = newlist[index];
                  return ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                color: const Color.fromARGB(204, 158, 158, 158),
                child:  ListTile(
                  onTap: () {
                    
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => Newplaylistscreen(data: data,)));
                  },
                  leading: const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/musiconlogo.png')
                  ),
                  title: Text(data.playlistname),
                  subtitle: data.playlistarray.isNotEmpty ? Text('${data.playlistarray.length.toString()} Songs'):const Text('Empty'),
                  trailing: Wrap(
                  children: [
                    IconButton(onPressed: () {
                      playlistshowdialogupdate(context,data,index);
                    }, icon: const Icon(Icons.edit)),
                    
                    IconButton(onPressed: () {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text('Do you want to delete'),
                          actions: [
                            TextButton(onPressed: () {
                              deleteplaylistdatabase(data);
                              Navigator.pop(context);
                            }, child: const Text('Yes')),
                            TextButton(onPressed: () {
                              Navigator.pop(context);
                            }, child: const Text('No'))

                          ],
                        );
                      },);
                      
                    }, icon: const Icon(Icons.delete)),
                  ],
        )
                
      ),
    ),
  );
                  
                }, 
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 15,);
                }, 
                itemCount: newlist.length): Center(child: headtext('No Playlist'));
            }),
          ),
        
        ),
      ),
    );
  }
}