import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image/image.dart';
import 'package:whatado/graphql/mutations_graphql_api.dart';
import 'package:whatado/models/interest.dart';
import 'package:whatado/providers/graphql/interest_provider.dart';

class AddEventState extends ChangeNotifier {
  PhotoViewController photoController;
  TextEditingController titleController;
  TextEditingController descriptionController;
  TextEditingController locationController;
  TextEditingController dateController;
  TextEditingController timeController;
  TextEditingController textModeController;
  TextEditingController addInterestController;
  Gender _selectedGender;
  AssetEntity? selectedImage;
  File? selectedImageFile;
  Uint8List? selectedImageBytes;
  double _scale;
  double _offsetx;
  double _offsety;

  double _filterAgeStart;
  double _filterAgeEnd;
  bool _textMode;
  bool _postLoading;
  bool _failed;
  bool _succeeded;

  List<Interest> popularInterests = [];
  List<Interest> customInterests = [];
  List<Interest> selectedInterests = [];

  void addInterest(Interest interest) {
    selectedInterests.add(interest);
    notifyListeners();
  }

  void removeInterest(Interest interest) {
    selectedInterests.remove(interest);
    notifyListeners();
  }

  void addCustomInterest(Interest interest) {
    customInterests.add(interest);
    notifyListeners();
  }

  void removeCustomInterest(Interest interest) {
    customInterests.remove(interest);
    notifyListeners();
  }

  AddEventState()
      : photoController = PhotoViewController(),
        titleController = TextEditingController(),
        descriptionController = TextEditingController(),
        locationController = TextEditingController(),
        dateController = TextEditingController(),
        timeController = TextEditingController(),
        textModeController = TextEditingController(),
        addInterestController = TextEditingController(),
        _filterAgeEnd = 40,
        _filterAgeStart = 18,
        _textMode = false,
        _selectedGender = Gender.both,
        _postLoading = false,
        _succeeded = false,
        _failed = false,
        _scale = 0,
        _offsetx = 0,
        _offsety = 0 {
    titleController.addListener(() => notifyListeners());
    textModeController.addListener(() => notifyListeners());
    descriptionController.addListener(() => notifyListeners());
    locationController.addListener(() => notifyListeners());
    dateController.addListener(() => notifyListeners());
    timeController.addListener(() => notifyListeners());
    init();
  }

  @override
  void dispose() {
    photoController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    textModeController.dispose();
    addInterestController.dispose();
    super.dispose();
  }

  Future<void> init() async {
    final provider = InterestGqlProvider();
    final result = await provider.popular();
    popularInterests.addAll(result.data ?? []);
    notifyListeners();
  }

  bool get succeeded => _succeeded;

  set succeeded(bool succeeded) {
    _succeeded = succeeded;
    notifyListeners();
  }

  bool get failed => _failed;

  set failed(bool failed) {
    _failed = failed;
    notifyListeners();
  }

  bool get postLoading => _postLoading;

  set postLoading(bool loading) {
    _postLoading = loading;
    notifyListeners();
  }

  Gender get selectedGender => _selectedGender;

  set selectedGender(Gender selectedGender) {
    _selectedGender = selectedGender;
    notifyListeners();
  }

  bool get textMode => _textMode;

  set textMode(bool textMode) {
    _textMode = textMode;
    notifyListeners();
  }

  double get filterAgeEnd => _filterAgeEnd;

  set filterAgeEnd(double filterAgeEnd) {
    _filterAgeEnd = filterAgeEnd;
    notifyListeners();
  }

  double get filterAgeStart => _filterAgeStart;

  set filterAgeStart(double filterAgeStart) {
    _filterAgeStart = filterAgeStart;
    notifyListeners();
  }

  Future<void> setImage(AssetEntity? _selectedImage) async {
    clearPhoto();
    selectedImage = _selectedImage;
    selectedImageFile = await _selectedImage?.loadFile();
    selectedImageBytes = await selectedImageFile?.readAsBytes();
    notifyListeners();
  }

  void clearPhoto() {
    selectedImage = null;
    selectedImageFile = null;
    selectedImageBytes = null;
    notifyListeners();
  }

  void savePhotoInfo() {
    _scale = photoController.scale?.toDouble() ?? 0.0;
    _offsetx = photoController.position.dx;
    _offsety = photoController.position.dy;
  }

  void clear() {
    selectedImage = null;
    _succeeded = false;
    _failed = false;
    _postLoading = false;
    photoController.reset();
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    dateController.clear();
    timeController.clear();
    textModeController.clear();
    addInterestController.clear();
    selectedInterests = [];
    customInterests = [];
    filterAgeEnd = 40;
    filterAgeStart = 18;
    selectedGender = Gender.both;
  }

  Future<Uint8List> cropResizeImage(double deviceWidth) async {
    if (selectedImageBytes == null) return Uint8List.fromList([]);
    // convert if heic
    final isHeic = selectedImageFile!.path.toLowerCase().endsWith('heic');
    if (isHeic) {
      final jpgPath = await HeicToJpg.convert(selectedImageFile!.path);
      selectedImageFile = File(jpgPath!);
      selectedImageBytes = await selectedImageFile?.readAsBytes();
    }
    final width = selectedImage!.orientatedWidth;
    final height = selectedImage!.orientatedHeight;
    // resizing image too small doesn't update controller on revert to min size
    final scale = max(deviceWidth / min(width, height), _scale);
    final offsetx = _offsetx / scale;
    final offsety = _offsety / scale;
    // get positions of TL & BR corners
    final length = deviceWidth / scale;
    final top = ((height / 2.0) - (length / 2.0) - offsety).round();
    final right = ((width / 2.0) - (length / 2.0) + offsetx).round();
    final bottom = ((height / 2.0) - (length / 2.0) + offsety).round();
    final left = ((width / 2.0) - (length / 2.0) - offsetx).round();
    // crop image and encode it as png
    final decodedImage = decodeImage(List.from(selectedImageBytes ?? []));
    if (decodedImage == null) return Uint8List.fromList([]);
    final exifData =
        await readExifFromBytes(List<int>.from(selectedImageBytes!));
    final iosAdjust = Platform.isIOS &&
            exifData.containsKey("Image Orientation") &&
            exifData["Image Orientation"].toString().contains("180")
        ? -180
        : 180;
    final isPortrait = height > width;
    final rotatedImage = copyRotate(
        decodedImage,
        Platform.isIOS && isPortrait
            ? 90
            : iosAdjust + selectedImage!.orientation);
    final face = copyCrop(
      rotatedImage,
      left,
      top,
      width - right - left,
      height - top - bottom,
    );
    final rerotatedImage = copyRotate(
        face,
        Platform.isIOS && isPortrait
            ? -90
            : iosAdjust + -selectedImage!.orientation);
    final resizedFace = copyResize(rerotatedImage, height: 1080, width: 1080);
    return Uint8List.fromList(encodePng(resizedFace));
  }
}
