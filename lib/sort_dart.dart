
import 'dart:async';

import 'package:flutter/services.dart';

import 'dart:ffi' as ffi; // For FFI
import 'dart:io';

// typedef init_float_pointer = ffi.Pointer<ffi.Float> Function(ffi.Int32);
// typedef InitFloatPointer = ffi.Pointer<ffi.Float> Function(int);

// final ffi.DynamicLibrary dylib = Platform.isAndroid
//     ? ffi.DynamicLibrary.open("libnative_add.so")
//     : ffi.DynamicLibrary.process();

final ffi.DynamicLibrary nativeAddLib =
    Platform.isAndroid ? ffi.DynamicLibrary.open("libnative_with_opencv.so") : ffi.DynamicLibrary.process();

final int Function(int x, int y) nativeAdd =
    nativeAddLib.lookup<ffi.NativeFunction<ffi.Int32 Function(ffi.Int32, ffi.Int32)>>("native_add").asFunction();

// InitFloatPointer initFloatPointer = dylib
//         .lookup<ffi.NativeFunction<init_float_pointer>>('Navtive_InitFloatList')
//         .asFunction();

class SortDart {
  static const MethodChannel _channel =
      const MethodChannel('sort_dart');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
