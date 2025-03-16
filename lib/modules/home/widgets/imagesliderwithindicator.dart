import 'package:flutter/material.dart';

class ImageSliderWithIndicators extends StatefulWidget {
  final List<String> imageUrls;
  final String title;

  const ImageSliderWithIndicators(
      {super.key, required this.imageUrls, required this.title});

  @override
  State<ImageSliderWithIndicators> createState() =>
      _ImageSliderWithIndicatorsState();
}

class _ImageSliderWithIndicatorsState extends State<ImageSliderWithIndicators> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),

          // Custom Indicator
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imageUrls.length, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentPage == index ? Colors.orange : Colors.grey,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
