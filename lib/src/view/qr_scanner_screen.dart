import 'dart:typed_data';
import 'package:barcode_scanner_test/src/controller/scanner_controller.dart';
import 'package:barcode_scanner_test/src/view/qr_result_screen.dart';
import 'package:barcode_scanner_test/src/widget/app_button.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanner extends StatefulWidget {
   QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  MobileScannerController mobileScannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
    returnImage: true,


  );
  var isloading = false;
  var isscan =false;
  var results ;

  @override
  void initState() {
    mobileScannerController.stop();

    super.initState();
  }

  @override
  void didChangeDependencies() {
   print("Changes");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    mobileScannerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text( 'QR Scanner',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
          decoration: BoxDecoration(

          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              Scannerhead(),
              Expanded(
                flex: 1,

                child: Stack(
                  children: [
                    MobileScanner(


                      startDelay: true,
                      controller:    mobileScannerController,


                      errorBuilder: (p0, p1, p2) {


                        return Center(child: Text("Error ${p1}"),);
                      },


                      onDetect: (capture) {

                        if(!isscan  ) {
                          final List<Barcode> barcodes = capture.barcodes;
                          final Uint8List? image = capture.image;
                          print("Detected");
                          for (final barcode in barcodes) {
                            print('Barcode found! ${barcode.rawValue}');
                            print('Barcode found! ${barcode.type}');
                            print('Barcode found! ${barcode.url}');

                          }

                          setState(() {
                            isscan = true;

                          });
                         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                           return QRcompleted(results:barcodes);
                         },), (route) => false);



                        }
                        else {
                          setState(() {
                            isscan = false;

                          });
                        }




                      },

                      fit: BoxFit.contain,

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:80,horizontal: 20),
                      child: QRScannerOverlay(
                        scanAreaHeight: double.maxFinite,
                        scanAreaWidth: double.maxFinite,
                        borderColor: Colors.blueAccent,
                        overlayColor: Colors.black.withOpacity(0),),
                    )


                  ],
                ),
              ),



            ],
          ),
        ),
      )
    );
  }

  Widget Scannerhead() {
    return Container(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(11)


              ),
              child:const  Column(
                children: [
                  Text("Scan QR Code",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 15,),
                  Text("Please place your camera on QR code scanner directly and make sure it a qr code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,


                  ),),

                ],
              ),
            );
  }
}
