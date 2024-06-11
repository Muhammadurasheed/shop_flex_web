import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/category_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/dashboard_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/order_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/product_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/upload_banner_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/vendors_screen.dart';
import 'package:shop_flex_web_admin/views/screens/sidebar_screens/withdrawal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget _selectedScreen = DashboardScreen();

  screenSelector(item) {
    switch(item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedScreen = DashboardScreen();
        });
        break;
      case CategoryScreen.routeName:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;
      case OrderScreen.routeName:
        setState(() {
          _selectedScreen = OrderScreen();
        });
        break;
      case ProductScreen.routeName:
        setState(() {
          _selectedScreen = ProductScreen();
        });
        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedScreen = WithdrawalScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text('ShopFlex Admin Panel', style: TextStyle(color: Colors.white, letterSpacing: 3),),
        centerTitle: true,
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashboardScreen.routeName,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.routeName,
            icon: CupertinoIcons.person_3,
          ),
          
          AdminMenuItem(
            title: 'Withdrawals',
            route: WithdrawalScreen.routeName,
            icon: CupertinoIcons.money_dollar,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: OrderScreen.routeName,
            icon: CupertinoIcons.cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: CategoryScreen.routeName,
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: UploadBannerScreen.routeName,
            icon: CupertinoIcons.add,
          ),
          AdminMenuItem(
            title: 'Products',
            route: ProductScreen.routeName,
            icon: Icons.shop,
          ),
          
          
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Admin Page',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ), body: _selectedScreen,
    );
  }
}