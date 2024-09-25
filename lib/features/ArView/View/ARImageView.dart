// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:serviceandstore/Constant/Styles.dart';
//
// class ArImageView extends StatefulWidget {
//   final data;
//   const ArImageView({super.key, required this.data});
//
//   @override
//   State<ArImageView> createState() => _ArImageViewState();
// }
//
// class _ArImageViewState extends State<ArImageView> {
//   String imageUrl = "";
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       imageUrl = widget.data["Multi-Images"]["Images"][0];
//     });
//   }
//
//   late ARSessionManager arSessionManager;
//   late ARObjectManager arObjectManager;
//
//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//
//     this.arSessionManager.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           showWorldOrigin: true,
//           handleTaps: false,
//         );
//
//     this.arObjectManager.onInitialize();
//     _addARObject(imageUrl);
//   }
//
//   Future<void> _addARObject(var imageUrl) async {
//     final newNode = ARNode(
//       type: NodeType.webGLB,
//       uri: imageUrl,
//       scale: vector.Vector3(0.1, 0.1, 0.1),
//       position: vector.Vector3(0, 0, -1),
//     );
//     await arObjectManager.addNode(newNode);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Ar Preview", style: StylesOfApp.heading),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // ArCoreView(
//           //   onArCoreViewCreated: _onArCoreViewCreated,
//           //   enableUpdateListener: true,
//           //   type: ArCoreViewType.AUGMENTEDIMAGES,
//           //   debug: true,
//           //   enablePlaneRenderer: true,
//           //   enableTapRecognizer: true,
//           // )
//           Text("Hello World"),
//         ],
//       ),
//     );
//   }
// }
