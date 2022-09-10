

import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({ Key? key }) : super(key: key);

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> with SingleTickerProviderStateMixin {
  String _image = 'https://ouch-cdn2.icons8.com/6boodRWWm-xX52hMmQY9nSdEV9c1_VwUWg_QE1mCHu4/rs:fit:256:256/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTQy/Lzc0Y2YzMDU2LTc2/MGMtNDkxYy05OTk1/LTk5YTlkNDcyM2M3/ZC5zdmc.png';
  bool _ismore = false;
  bool _isfile = false;
  bool _isupload = false;

  File ? _file;
  PlatformFile? _platformFile;

  _selectfile() async{
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg']
    );

    if(file != null){
      setState((){
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
        _isfile = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100,),
            Text('Upload your image', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Text('Extensions allowed jpg, png, jpeg', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
            Image.network(_image, width: 300,),
            const SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  setState((){
                    _ismore = !_ismore;
                  });
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _ismore ? _isfile ? Colors.green.shade50.withOpacity(0.5): Colors.red.shade50.withOpacity(0.5) : Colors.grey.shade100,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child:Row(
                                children: [
                                  const SizedBox(width: 10.0,),
                                  const Text('Add Image', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                  _ismore ? const SizedBox(width: 160.0,): const SizedBox(width: 180.0,),
                                  _ismore ? Container() : Icon(Icons.arrow_forward_ios,size: 30,)
                                ],
                              ),),
                            const Spacer(),
                            _ismore ? _isfile ?
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade100.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(Icons.check, color: Colors.green, size: 20,)
                            ) :
                            Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.shade100.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Icon(Icons.close_rounded, color: Colors.red, size: 20,)
                            ) :
                            const SizedBox()
                          ],
                        ),
                        _ismore ?
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0,),
                              GestureDetector(
                                onTap: () {
                                  _selectfile();
                                },
                                child: DottedBorder(
                                  borderType: BorderType.Rect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [8, 8],
                                  strokeCap: StrokeCap.round,
                                  color: Colors.deepPurple,
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blue.shade50.withOpacity(.3),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child:_isfile ?Text("you choose ${_platformFile!.name}", style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.rubik().fontFamily)) : Text("Click here to choose image", style: TextStyle(fontSize: 18, fontFamily: GoogleFonts.rubik().fontFamily),),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ) : const SizedBox()
                      ],
                    )
                ),

              ),
            ),
            _platformFile != null
                ?  Column(
              children: [
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(_file!),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child:MaterialButton(
                      onPressed: (){

                        /// here if you want upload image to data base but this just for animation
                        setState((){
                          _isupload = true;
                        });
                        Timer(Duration(seconds: 3), () {
                          setState((){
                            _isupload = false;
                          });
                        });

                      },
                      height: 45,
                      color: _isupload ? Colors.white : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child:  Center(
                        child: _isupload ? Container(
                          width: 30,
                          height: 30,
                          child: const LoadingIndicator(
                            indicatorType: Indicator.ballSpinFadeLoader,
                            colors: [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.deepPurple,Colors.grey],
                            strokeWidth: 2,
                          ),
                        ) : Text("Upload to Database", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                      )
                  ),
                ),

              ],
            )
                : Container(
              height: 50,
              child: Center(
                child: Text("No images choosed"),
              ),
            ),
            SizedBox(height: 150,),
          ],
        ),
      ),
    );
  }
}