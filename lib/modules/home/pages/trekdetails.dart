import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/modules/home/widgets/imagesliderwithindicator.dart';

class Trekdetails extends StatefulWidget {
  const Trekdetails({super.key});

  @override
  State<Trekdetails> createState() => _TrekdetailsState();
}

class _TrekdetailsState extends State<Trekdetails> {
  @override
  Widget build(BuildContext context) {
//temp
    final String itineraryData = """
## Schedule:

### **Day 1: Travel & Base Camp**
- **5:00 AM**: Depart from Mumbai/Pune
- **9:00 AM**: Breakfast at Mahad
- **11:00 AM**: Start Trek from Pachad
- **1:00 PM**: Reach & Rest
- **2:00 PM**: Lunch at the Fort
- **3:00 PM**: Explore Key Fort Attractions
- **6:00 PM**: Sunset at Takmak Tok
- **8:00 PM**: Set up Camp & Dinner

### **Day 2: Exploration & Descent**
- **6:00 AM**: Sunrise
- **7:00 AM**: Breakfast
- **10:00 AM**: Start Descent
- **11:00 AM**: Arrive at Pachad Village
- **12:00 PM**: Recovery Descent
- **1:00 PM**: Lunch at Mahad
- **2:00 PM**: Return to Mumbai/Pune
- **6:00 PM**: Trip Ends
""";

    final String recommendationData = """
## Recommended Gear/Things:

### **Gear:**
- 🎒 Backpack
- 👟 Trekking Shoes
- 🥾 Rain Gear (If needed)
- 🚶‍♂️ Trekking Pole (Optional)
- 🔦 Torch/Headlamp
- 🗺️ Map/Guidebook

### **Essentials:**
- 💧 Water (2-3L)
- 🍫 Snacks
- 🏥 First Aid Kit
- 🌞 Sun Protection (Sunscreen, Hat)
- 📱 Mobile Phone & Power Bank
- 🆔 Personal ID & Emergency Cash
- 🗑️ Garbage Bag (Leave No Trace)
""";

    final String markdownText = """
Raigad Fort, located in the Raigad district of Maharashtra, India, is a historically significant fort and a popular trekking destination. Perched at an elevation of 2,700 feet (820 meters) in the Sahyadri mountain range, it is known as the capital of the Maratha Empire under Chhatrapati Shivaji Maharaj.

The fort's history dates back to the 11th century, but it gained prominence in 1674 when Shivaji Maharaj crowned himself as the King of the Maratha Empire here. Raigad Fort is renowned for its robust architecture, strategic location, and panoramic views of the surrounding region.

The trek to Raigad Fort is popular among history buffs, trekkers, and nature lovers. It offers a combination of historical exploration, physical challenge, and natural beauty, making it a well-rounded adventure.

""";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageSliderWithIndicators(
                    imageUrls: [
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                      'https://cloud.appwrite.io/v1/storage/buckets/67b092f00017108f379d/files/N5Il73UVVPU2CQ2ov4O7nfim59I2/view?project=67b091bf001f46b44886&mode=admin',
                    ],
                    title: "Rainbow Trek",
                  ),
                  Positioned(
                    top: 8,
                    left: 6,
                    right: 6,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(
                                BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface,
                                  width: 2,
                                ),
                              ),
                              iconColor: WidgetStateProperty.all(
                                Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              size: 28,
                            ),
                            onPressed: () {
                              context.pop();
                            },
                          ),
                          Text(
                            "[Trek name]",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //bookmark action
                            },
                            icon: Icon(
                              LucideIcons.bookmark,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.star,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "{4.8}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "[reviews]",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          IconButton(
                            onPressed: () => context.push('/reviewscreen'),
                            style: ButtonStyle(
                              iconColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.primary),
                            ),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.chevron_right_sharp,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            LucideIcons.map,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "View Itinerary",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.push('/viewitinery', extra: {
                                "trekname": '[trekName]',
                                "itinerary": itineraryData,
                                "recommendations": recommendationData,
                              });
                            },
                            style: ButtonStyle(
                              iconColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.primary),
                            ),
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.chevron_right_sharp,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoIcon(Icons.timer, "1.2 hr"),
                  _infoIcon(Icons.directions_walk, "3 km"),
                  _infoIcon(Icons.terrain, "469 ft"),
                  _infoIcon(Icons.error_outline, "Easy"),
                ],
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Overview',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: MarkdownBody(
                  data: markdownText,
                  selectable: false, // Allows text selection
                  styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                    h2: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                    p: TextStyle(fontSize: 18, color: Colors.black87),
                    strong: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                    em: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue),
                    listBullet: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ),
              ),
              //payment widget
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                margin: EdgeInsets.all(14),
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.all(Radius.circular(22)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "🔥 Limited Slots!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            "Starting from ",
                            style: TextStyle(
                              fontSize: 20, // Slightly reduced font size
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "{widget.trekprice}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Slightly reduced font size
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoIcon(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(26),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
