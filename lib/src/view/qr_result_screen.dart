import 'package:barcode_scanner_test/src/view/qr_scanner_screen.dart';
import 'package:barcode_scanner_test/src/widget/app_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcompleted extends StatefulWidget {
  List<Barcode>? results = [];
   QRcompleted({super.key,this.results});

  @override
  State<QRcompleted> createState() => _QRcompletedState();
}

class _QRcompletedState extends State<QRcompleted> {
  late Future<void> _init;

  @override
  void initState() {
    _init=_launchInBrowserView(this.widget?.results ?? [] );
    // TODO: implement initState
    super.initState();
  }
  @override

  Future<void> _launchInBrowserView(List<Barcode> barcode) async {
    if(barcode?.first?.rawValue == null) {
      return ;

    }
      try {
        Uri url = Uri.parse(barcode.first!.rawValue!.toString());
        if(await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.inAppBrowserView);

        }
        else {
          throw 'Could not launch application'; // `throw could` is used for error handling

        }

      }catch (err) {

        print(err.toString());

      }



  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text( 'Scan Result',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: FutureBuilder
          (future: _init ,

            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.connectionState == ConnectionState.none) {
                return Center(child:Text("Could not find this qr code"));

              }
              else {
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImageView(
                      data:  this.widget.results?.first.url?.url?.toString() ?? '',
                      version: QrVersions.auto,
                      size: 250.0,
                    ),

                    SizedBox(height: 20,),
                    Center(
                      child: Text(
                          this.widget.results?.first.rawValue.toString() ?? ''
                      ),

                    ),


                    SizedBox(height: 20,),
                    appButton(placeholder: 'Copy to clipboard',onpress: () {
                      copytoClipboard(this.widget.results?.first?.rawValue ?? '',context);

                    }),
                    SizedBox(height: 10,),
                    appButton(placeholder: 'Scan Again',onpress: () {
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) {
                        return QRScanner();
                      },), (route) => false);
                    })

                  ],
                );
              }

        },)
      ),
    );
  }

  void copytoClipboard(url,context) async  {
    await Clipboard.setData(ClipboardData(text: url.toString()));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          backgroundColor: Colors.blue,


            content: const  Text("QR link has copied to clipboard ") ));



  }
}
