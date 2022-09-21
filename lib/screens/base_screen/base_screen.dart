import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/home_screen/home_screen.dart';
import 'package:party/screens/parties_screen/parties.dart';
import 'package:party/screens/trending_screen/trending_screen.dart';
import 'package:party/screens/widgets/drawer/advanced_drawer.dart';
import 'package:party/screens/widgets/drawer/drawer_components.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen(this.usuario, this.placemark);
  Usuario usuario;
  Placemark placemark;

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  ScrollController _scrollController;
  bool _isScrolled = false;
  int _currentPage = 0;
  final _pageController = PageController();

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);

    Future.delayed(Duration(seconds: 1)).then((value){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white),
              const SizedBox(width: 10,),
              Text(
                '${widget.placemark.subAdministrativeArea} - ${widget.placemark.administrativeArea}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.deepPurpleAccent[700].withOpacity(0.6),
        ),
      );
      }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAdvancedDrawer(
      backdropColor: Colors.lightBlue,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: DrawerComponents(widget.usuario, widget.placemark),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Image.asset('images/partyEscritoLogo.png', fit: BoxFit.scaleDown, scale: 25,),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/partyAppBar.jpg'),
                fit: BoxFit.cover
              ),
            ),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Iconsax.close_square : Ionicons.grid_outline,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(Ionicons.search_outline),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(Iconsax.notification),
            ),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [
                HomeScreen(widget.usuario, _pageController, widget.placemark),
                TrendingScreen(widget.placemark),
                PartiesScreen(widget.placemark),
                Container(),
              ],
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 0.5,
                  color: Colors.grey[300],
                )
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            setState(() => _currentPage = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: const Icon(Ionicons.home_outline),
              title: const Text('Home'),
              activeColor: Colors.redAccent[400],
            ),
            BottomBarItem(
              icon: const Icon(Icons.local_fire_department),
              title: Text('trending'.i18n()),
              activeColor: Colors.orange.shade900,
              darkActiveColor: Colors.red.shade400, // Optional
            ),
            BottomBarItem(
              icon: const Icon(Ionicons.storefront_outline),
              title: Text('locals'.i18n()),
              activeColor: Colors.blue.shade700,
            ),
            BottomBarItem(
              icon: const Icon(Ionicons.calendar_number_outline),
              title: Text('events'.i18n()),
              activeColor: Colors.deepPurpleAccent[700],
            ),
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}