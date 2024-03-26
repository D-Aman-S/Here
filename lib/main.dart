import 'package:hereAssignment/common_components/bottom_tabbar.dart';
import 'package:hereAssignment/common_components/loading/loading_screen.dart';
import 'package:hereAssignment/common_components/loading/loading_widget.dart';
import 'package:hereAssignment/home_bloc/home_bloc_bloc.dart';
import 'package:hereAssignment/home_bloc/home_bloc_repository.dart';
import 'package:hereAssignment/models/tab_icons.dart';
import 'package:hereAssignment/pages/auto_detect_city/screen/auto_detect_city_page.dart';
import 'package:hereAssignment/pages/search_city/screen/search_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/color_constants.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) =>
          HomeBlocBloc(HomeBlockRepository())..add(HomeBlocLoadEvent()),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocConsumer<HomeBlocBloc, HomeBlocState>(
        listener: (context, state) {
          if (state is HomeBlockLoadingState) {
            LoadingScreen().show(context: context);
          } else {
            LoadingScreen().hide();
          }
        },
        builder: (context, state) {
          if (state is HomeBlockLoadedState) {
            return const MyHomePage();
          }
          if (state is HomeBlockLoadedByCityState) {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: <Widget>[
                    AutoDetectCity(
                        animationController: AnimationController(
                            duration: const Duration(milliseconds: 600),
                            vsync: this),
                        isSearch: true)
                  ],
                ));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = AutoDetectCity(
      animationController: animationController,
      isSearch: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBlocBloc, HomeBlocState>(
      listener: (context, state) {},
      child: Container(
        color: background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = AutoDetectCity(
                    animationController: animationController,
                    isSearch: false,
                  );
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = TrainingScreen(
                    animationController: animationController,
                  );
                });
              });
            }
          },
        ),
      ],
    );
  }
}
