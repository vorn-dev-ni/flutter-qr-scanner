import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerController {

 static late final MobileScannerController mobileScannerController ;

 ScannerController();


 static void init() {


   mobileScannerController = MobileScannerController(
     detectionSpeed: DetectionSpeed.normal,
     facing: CameraFacing.back,
     torchEnabled: false,
     returnImage: true,


   );
   mobileScannerController.stop();

 }


 static void onscan() {
   mobileScannerController.start();

 }

 static void onstop() {
   mobileScannerController.stop();

 }



}