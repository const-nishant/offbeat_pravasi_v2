import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:offbeat_pravasi_v2/modules/auth/auth_exports.dart';
import 'package:offbeat_pravasi_v2/modules/home/home_exports.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              //header
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.onInverseSurface,
                ),
                width: double.maxFinite,
                child: Column(
                  children: [
                    //user info
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.transparent,
                                    child: Icon(
                                      LucideIcons.circleUserRound,
                                      size: 48,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        "Hi !👋 , [name]",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                          ),
                                          Text(
                                            "New York, USA",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 6,
                                child: IconButton(
                                  onPressed: () {
                                    Provider.of<AuthServices>(context,
                                            listen: false)
                                        .logout(context);
                                  }, //sos logic here
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Theme.of(context)
                                            .colorScheme
                                            .inversePrimary),
                                    iconColor:
                                        WidgetStatePropertyAll(Colors.red),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  icon: Icon(Icons.sos_sharp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          //search bar row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CommonTextfield(
                                  hintText: "Search",
                                  controller: searchController,
                                  readOnly: true,
                                  obscureText: false,
                                  focusNode: FocusNode(),
                                  onTap: () => context.push('/search'),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      //filter here
                                      //temp
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Mainonboarding(),
                                          ));
                                    },
                                    iconSize: 24,
                                    style: ButtonStyle(
                                      fixedSize: WidgetStatePropertyAll(
                                        Size(42, 42),
                                      ),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .inversePrimary),
                                      iconColor: WidgetStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(22),
                                          ),
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(
                                      LucideIcons.slidersHorizontal,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          //notifications here
                                          context.push('/notificationscreen');
                                        },
                                        iconSize: 24,
                                        style: ButtonStyle(
                                          fixedSize: WidgetStatePropertyAll(
                                            Size(42, 42),
                                          ),
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                            Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                          iconColor: WidgetStatePropertyAll(
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(22),
                                                ),
                                                side: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                )),
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.notifications_active_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.red,
                                          ),
                                          height: 18,
                                          width: 18,
                                          child: Center(
                                            child: Text(
                                              "{1}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //states
                    SizedBox(height: 14),
                    Consumer<HomeServices>(
                      builder: (context, ref, child) {
                        return SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ref.states.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Statecard(state: ref.states[index]);
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 22),
                  ],
                ),
              ),
              SizedBox(height: 22),
              //main content
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor: Colors.grey,
                      labelColor: Theme.of(context).colorScheme.primary,
                      // indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelPadding: const EdgeInsets.all(0),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      tabs: [
                        Tab(
                          text: "Popular",
                        ),
                        Tab(
                          text: "Recent",
                        ),
                        Tab(
                          text: "Top-rated",
                        ),
                        Tab(
                          text: "Seasonal",
                        ),
                        Tab(
                          text: "New",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.44,
                      child: TabBarView(
                        children: [
                          //popular
                          PopularTab(),
                          //recent
                          RecentTab(),
                          //top-rated
                          TopratedTabs(),
                          //seasonal
                          SeasonalTabs(),
                          //new
                          NewtreksTabs(),
                        ],
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
}
