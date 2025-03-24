// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:offbeat_pravasi_v2/modules/module_exports.dart';
import 'package:provider/provider.dart';
import '../../../common/common_exports.dart';
import '../../../helpers/helper_exports.dart';

class Addtreks extends StatefulWidget {
  const Addtreks({super.key});

  @override
  State<Addtreks> createState() => _AddtreksState();
}

class _AddtreksState extends State<Addtreks> {
  late DateTime dateTime;
  final _formKey = GlobalKey<FormState>();
  List<File> selectedImages = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _elevationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _itineraryController = TextEditingController();
  final TextEditingController dateTextEditingController =
      TextEditingController();
  final TextEditingController _recommendgearController =
      TextEditingController();
  final TextEditingController _recommendessentialsController =
      TextEditingController();
  final SingleValueDropDownController _difficultyController =
      SingleValueDropDownController();
  final SingleValueDropDownController _seasonController =
      SingleValueDropDownController();
  final SingleValueDropDownController _locationController =
      SingleValueDropDownController();

  void preview() async {
    final helperServices = Provider.of<Helperservices>(context, listen: false);

    // Compress images before previewing
    List<File> compressedImages = [];
    for (File file in selectedImages) {
      File? compressed = await helperServices.compressImage(file);
      if (compressed != null) {
        compressedImages.add(compressed);
      }
    }

    // Update selectedImages with compressed images
    setState(() {
      selectedImages = compressedImages;
    });

    context.push(
      '/trekpreview',
      extra: {
        "trekName": _nameController.text.trim(),
        "trekLocation": _locationController.dropDownValue!.value.toString(),
        "trekDate": DateTime.now().toIso8601String(),
        "trekOverview": Provider.of<Trekservices>(context, listen: false)
            .convertToMarkdownParagraph(_overviewController.text.trim()),
        "trekImages": selectedImages, // Now contains compressed images
        "trekDuration": _durationController.text.trim(),
        "trekDistance": _distanceController.text.trim(),
        "trekElevation": _elevationController.text.trim(),
        "trekDifficulty": _difficultyController.dropDownValue!.value.toString(),
        "trekItinerary": Provider.of<Trekservices>(context, listen: false)
            .convertToMarkdown(_itineraryController.text.trim()),
        "recommendedGear": Provider.of<Trekservices>(context, listen: false)
            .convertToMarkdown(_recommendgearController.text.trim()),
        "recommendedEssentials":
            Provider.of<Trekservices>(context, listen: false)
                .convertToMarkdown(_recommendessentialsController.text.trim()),
      },
    );
  }

  void addtreks() async {
    final trekservice = Provider.of<Trekservices>(context, listen: false);
    if (_formKey.currentState!.validate() && selectedImages.isNotEmpty) {
      // Add trek logic
      await trekservice.addTreks(
        context: context,
        trekName: _nameController.text.trim(),
        trekLocation: _locationController.dropDownValue!.value.toString(),
        trekDate: DateTime.now(),
        trekOverview:
            trekservice.convertToMarkdownParagraph(_overviewController.text),
        trekImages: selectedImages,
        trekRating: 0.0,
        trekReviews: [],
        trekAltitude: int.parse(_elevationController.text),
        trekDifficulty: _difficultyController.dropDownValue!.value,
        trekDuration: "${_durationController.text} hrs",
        trekDistance: double.parse(_distanceController.text),
        trekCost: double.parse(_priceController.text),
        trekItinerary: trekservice.convertToMarkdown(_itineraryController.text),
        recommendedGear:
            trekservice.convertToMarkdown(_recommendgearController.text),
        recommendedEssentials:
            trekservice.convertToMarkdown(_recommendessentialsController.text),
      );
      _difficultyController.dropDownValue = null;
      _locationController.dropDownValue = null;
      _nameController.clear();
      _overviewController.clear();
      _durationController.clear();
      _distanceController.clear();
      _elevationController.clear();
      _priceController.clear();
      _itineraryController.clear();
      _recommendgearController.clear();
      _recommendessentialsController.clear();
      selectedImages = [];
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final helperServices = Provider.of<Helperservices>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add new Treks',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leadingWidth: 80,
        leading: CommonExitbutton(
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UploadPhotoField(
                    onPressed: () async {
                      // Handle upload photo functionality
                      bool success = await Provider.of<Helperservices>(context,
                              listen: false)
                          .pickImages(context);
                      if (success) {
                        setState(() {
                          selectedImages = helperServices.images;
                        });
                      }
                    },
                  ),
                  if (selectedImages.isNotEmpty) ...[
                    SizedBox(height: 16.0),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: false,
                      ),
                      items: selectedImages.map((file) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                              child: Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                  SizedBox(height: 16.0),
                  _buildTextField(
                      "Name of Trek:", "Enter Trek Name", _nameController),
                  _buildTextField(
                      "Duration:", "Enter Duration", _durationController,
                      keyboardType: TextInputType.number),
                  _buildTextField(
                      "Distance:", "Enter trek Distance", _distanceController,
                      keyboardType: TextInputType.number),
                  _buildTextField("Elevation:", "Enter trek Elevation (ft)",
                      _elevationController,
                      keyboardType: TextInputType.number),
                  _buildTextField(
                      "Price:", "Enter trek Price", _priceController,
                      keyboardType: TextInputType.number),
                  SizedBox(height: 6.0),
                  Text(
                    "Date of Trek:",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CommonTextfield(
                    hintText: "DD/MM/YYYY",
                    controller: dateTextEditingController,
                    readOnly: true,
                    obscureText: false,
                    keyboardType: TextInputType.datetime,
                    onTap: () async {
                      await helperServices.futureDatePicker(context);
                      setState(() {
                        if (helperServices.date != null) {
                          dateTextEditingController.text =
                              helperServices.formatDate(helperServices.date!);
                        }
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  _buildLargeTextField(
                      "Overview:", "Enter trek overview", _overviewController),
                  _buildLargeTextField("Itinerary:", "Enter trek Itinerary",
                      _itineraryController),
                  _buildLargeTextField("Recommended Gear:",
                      "Enter trek Recommended Gear", _recommendgearController),
                  _buildLargeTextField(
                      "Recommended Essentials:",
                      "Enter trek Recommended Essentials",
                      _recommendessentialsController),
                  SizedBox(height: 6.0),
                  CustomDropdown(
                    labelText: "Difficulty Level:",
                    controller: _difficultyController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Beginner', value: "Beginner"),
                      DropDownValueModel(
                          name: 'Intermediate', value: "Intermediate"),
                      DropDownValueModel(name: 'Advanced', value: "Advanced"),
                    ],
                  ),
                  CustomDropdown(
                    labelText: 'Location',
                    controller: _locationController,
                    dropDownList:
                        Provider.of<Trekservices>(context, listen: false)
                            .states
                            .map((state) =>
                                DropDownValueModel(name: state, value: state))
                            .toList(),
                  ),
                  CustomDropdown(
                    labelText: 'Season',
                    controller: _seasonController,
                    dropDownList: const [
                      DropDownValueModel(name: 'Winter', value: "Winter"),
                      DropDownValueModel(name: 'Spring', value: "Spring"),
                      DropDownValueModel(name: 'Summer', value: "Summer"),
                      DropDownValueModel(name: 'Fall', value: "Fall"),
                    ],
                  ),
                  SizedBox(height: 26.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: preview,
                      style: ButtonStyle(
                        fixedSize: WidgetStateProperty.all<Size>(
                          const Size(500, 50),
                        ),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondary,
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'preview',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  LargeButton(
                    text: 'Add Trek',
                    onPressed: addtreks,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        CommonTextfield(
          hintText: hint,
          controller: controller,
          readOnly: false,
          obscureText: false,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildLargeTextField(
      String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.0),
        CommonLargeTextfield(
          hintText: hint,
          controller: controller,
          readOnly: false,
          obscureText: false,
          keyboardType: TextInputType.multiline,
          maxLength: 1000,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${label.toLowerCase()}';
            }
            return null;
          },
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
