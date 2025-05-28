import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilFunctions {
  static Future<String?> pickLocalImage({ImageSource imageSource = ImageSource.gallery}) async{
    try{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: imageSource);
    return image?.path;
    }catch(ex){
      return null;
    }
  }

  static Future<Position?> getCurrentLocation() async{
    try{
      final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if(!isLocationServiceEnabled){
        showToast("Location Service not enabled !");
        return null;
      }else{
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            showToast("Location permission is denied !");
            return null;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          showToast("Allow location permission to access feature !");
          await Geolocator.openAppSettings();
          return null;
        }

        final positionData = await Geolocator.getCurrentPosition();
        return positionData;
      }
    }catch(ex){
      return null;
    }
  }

  static Future<String?> getPlaceFromLatLong(double? lat, double? long) async {
    if(lat==null||long==null){
      return null;
    }
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        final List<String> placeData = [];
        if(place.name!=null){
          placeData.add(place.name!);
        }
        if(place.street!=null){
          placeData.add(place.street!);
        }
        if(place.locality!=null){
          placeData.add(place.locality!);
        }
        if(place.subLocality!=null){
          placeData.add(place.subLocality!);
        }
        if(place.administrativeArea!=null){
          placeData.add(place.administrativeArea!);
        }
        if(place.country!=null){
          placeData.add(place.country!);
        }
        if(place.postalCode!=null){
          placeData.add(place.postalCode!);
        }

        return placeData.join(" ").trim();
      }else{
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static void showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  static Future<void> launchGoogleMaps(double? lat, double? long) async {
    if(lat==null||long==null){
      showToast("Invalid Coordinates");
      return;
    }
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$long';
    final Uri uri = Uri.parse(googleMapsUrl);

    try{
      await launchUrl(uri);
    }catch(ex){
      showToast("Can't launch map ! Something went wrong !");
    }
  }
}