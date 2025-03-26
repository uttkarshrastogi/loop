// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../services/analytics_service.dart';
//
// class Index extends StatefulWidget {
//   final int? altIndex;
//   static const routeName = '/';
//   const Index({super.key, this.altIndex});
//
//   @override
//   _IndexState createState() => _IndexState();
// }
//
// final pageOnAvailableVehicle = [
//   // const Home(),
//   // const VasFinanceHome(),
//   // const VasHome(),
//   // const ShopLandingScreen(),
//   // Container()
// ];
//
// final pageDefault = [
//   // const Home(),
//   // const VasFinanceHome(),
//   // const VasIntro(),
//   // const ShopLandingScreen(),
//   // Container(),
//   // Container(),
// ];
//
// class _IndexState extends State<Index> {
//   String fullName = "";
//   int _selectedIndex = 0;
//   bool isVehicleAvailable = false;
//   List pages = pageDefault;
//
//   @override
//   void initState() {
//     super.initState();
//     // context.read<ProfileBloc>().add(
//     //       const ProfileEvent.getProfile(),
//     //     );
//     context.read<SelectedVehicleBloc>().add(
//           const SelectedVehicleEvent.clearSelectVehicle(),
//         );
//     context.read<VehicleBloc>().add(
//           const VehicleEvent.getVehicle(),
//         );
//     _selectedIndex = widget.altIndex ?? 0;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<VehicleBloc, VehicleState>(
//       listener: (context, state) {
//         if (state is VehicleFetched) {
//           if (state.vehicle.isNotEmpty) {
//             setState(() {
//               isVehicleAvailable = true;
//               pages = pageOnAvailableVehicle;
//             });
//           } else {
//             setState(() {
//               isVehicleAvailable = false;
//               pages = pageDefault;
//             });
//           }
//         }
//       },
//       child: BlocListener<ProfileBloc, ProfileState>(
//         listener: (context, state) {
//           if (state is ProfileFetched) {
//             fullName = state.profile.fullName;
//             setState(() {});
//           }
//         },
//         child: Scaffold(
//             bottomNavigationBar: Container(
//               // height: 84,
//               color: _selectedIndex == 2 && !isVehicleAvailable
//                   ? const Color(0xff252525)
//                   : AppColors.blue25,
//               child: Container(
//                 height: 72,
//                 margin: const EdgeInsets.only(
//                     left: 15, right: 15, bottom: 5, top: 5),
//                 decoration: const BoxDecoration(
//                   color: AppColors.neutral1000,
//                   borderRadius: BorderRadius.all(Radius.circular(16)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 10,
//                       offset: Offset(0, -5),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildNavItem(
//                         unSelectedIcon: 'assets/images/bottomtab/home1.svg',
//                         selectedIcon: 'assets/images/bottomtab/home2.svg',
//                         label: "Home",
//                         index: 0),
//                     Spacer(),
//                     _buildNavItem(
//                         unSelectedIcon: 'assets/images/bottomtab/finance1.svg',
//                         selectedIcon: 'assets/images/bottomtab/finance2.svg',
//                         label: "Finance",
//                         index: 1),
//                     Spacer(),
//                     _buildNavItem(
//                         unSelectedIcon: 'assets/images/bottomtab/vahicle1.svg',
//                         selectedIcon: 'assets/images/bottomtab/vahicle2.svg',
//                         label: "Vehicle",
//                         index: 2),
//                     Spacer(),
//                     _buildNavItem(
//                         unSelectedIcon: 'assets/images/unselected_shop.svg',
//                         selectedIcon: 'assets/images/selected_shop.svg',
//                         label: "Shop",
//                         index: 3),
//                     // _buildNavItem(Icons.fitness_center, "Health", 3),
//                     // _buildNavItem(
//                     //     unSelectedIcon: 'assets/images/bottomtab/shop1.svg',
//                     //     selectedIcon: 'assets/images/bottomtab/shop2.svg',
//                     //     label: "Shop",
//                     //     index: 3),
//                   ],
//                 ),
//               ),
//             ),
//             drawerScrimColor: Colors.black.withOpacity(0.5),
//             drawer: const AppHamburgerMenu(),
//             onDrawerChanged: (bool isOpen) {
//               if (isOpen) {
//                 final currentState = context.read<ProfileBloc>().state;
//                 currentState.maybeWhen(
//                   fetched: (policies) {},
//                   orElse: () {
//                     context.read<ProfileBloc>().add(
//                           const ProfileEvent.getProfile(),
//                         );
//                   },
//                 );
//               }
//             },
//             body: pages[_selectedIndex]),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(
//       {required String unSelectedIcon,
//       required String selectedIcon,
//       required String label,
//       required int index}) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () async {
//         AnalyticsService.logEvent(AnalyticsEvent(label));
//         setState(() {
//           _selectedIndex = index;
//         });
//
//         if (index == 2) {
//           var now = DateTime.now();
//           await SharedPrefHelper.setString(vasTime, now.toString());
//         }
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         // padding: const EdgeInsets.all(16),
//         padding:
//             EdgeInsets.fromLTRB( 24, 16,24,16),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xff32363D) : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Row(
//
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(0),
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: isSelected
//                       ? const RadialGradient(colors: [
//                           Color(0xff1b4d7e),
//                           const Color(0xff32363D)
//                         ])
//                       : null),
//               child: SvgPicture.asset(
//                 isSelected ? selectedIcon : unSelectedIcon,
//                 height: 24,
//                 width: 24,
//                 fit: BoxFit.fitHeight,
//               ),
//             ),
//             if (isSelected) const SizedBox(width: 8),
//             if (isSelected)
//               Container(
//                 // color: Colors.green,
//                 child: Text(
//                   label,
//                   textAlign: TextAlign.right,
//                   style: const TextStyle(
//
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 13,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
