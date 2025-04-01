import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';
import '../../feature/tasks/presentation/widgets/create_task_sheet.dart';
import '../services/analytics_service.dart';
import '../theme/colors.dart';
import '../uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../utils/prefrence_utils.dart';

class Index extends StatefulWidget {
  final int? altIndex;
  static const routeName = '/';
  const Index({super.key, this.altIndex});

  @override
  _IndexState createState() => _IndexState();
}
bool _isSheetOpen = false;


final pageDefault = [
  const DashboardPage(),
  const DashboardPage(),
  const DashboardPage(),
  const DashboardPage(),
  const DashboardPage(),
  // const Home(),
  // const VasFinanceHome(),
  // const VasIntro(),
  // const ShopLandingScreen(),
  // Container(),
  // Container(),
];

class _IndexState extends State<Index> {
  String fullName = "";
  int _selectedIndex = 0;
  bool isVehicleAvailable = false;
  List pages = pageDefault;

  // @override
  // void initState() {
  //   super.initState();
  //   // context.read<ProfileBloc>().add(
  //   //       const ProfileEvent.getProfile(),
  //   //     );
  //   context.read<SelectedVehicleBloc>().add(
  //         const SelectedVehicleEvent.clearSelectVehicle(),
  //       );
  //   context.read<VehicleBloc>().add(
  //         const VehicleEvent.getVehicle(),
  //       );
  //   _selectedIndex = widget.altIndex ?? 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 34),
        color: AppColors.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildNavItem(
              unSelectedIcon: Icon(
                Icons.home_filled,
                color: AppColors.textSecondary,
                size: 25,
              ),
              selectedIcon: Icon(
                Icons.home_filled,
                color: Colors.white,
                size: 26,
              ),
              label: "Home",
              index: 0,
            ),Spacer(),
            _buildNavItem(
              unSelectedIcon: Icon(Icons.create, color: AppColors.textSecondary, size: 25),
              selectedIcon: Icon(Icons.create, color: Colors.white, size: 26),
              label: "create",
              index: 1,
            ),Spacer(),
            _buildNavItem(
              unSelectedIcon: Icon(
                Icons.settings,
                color: AppColors.textSecondary,
                size: 25,
              ),
              selectedIcon: Icon(Icons.settings, color: Colors.white, size: 26),
              label: "settings",
              index: 2,
            ),Spacer(),
            _buildNavItem(
              unSelectedIcon: Icon(Icons.search, color: AppColors.textSecondary, size: 25),
              selectedIcon: Icon(Icons.search, color: Colors.white, size: 26),
              label: "create",
              index: 3,
            ),
            // Spacer(),
            // _buildNavItem(
            //     unSelectedIcon: 'assets/images/bottomtab/finance1.svg',
            //     selectedIcon: 'assets/images/bottomtab/finance2.svg',
            //     label: "Finance",
            //     index: 1),
            // Spacer(),
            // _buildNavItem(
            //     unSelectedIcon: 'assets/images/bottomtab/vahicle1.svg',
            //     selectedIcon: 'assets/images/bottomtab/vahicle2.svg',
            //     label: "Vehicle",
            //     index: 2),
            // Spacer(),
            // _buildNavItem(
            //     unSelectedIcon: 'assets/images/unselected_shop.svg',
            //     selectedIcon: 'assets/images/selected_shop.svg',
            //     label: "Shop",
            //     index: 3),
            // _buildNavItem(Icons.fitness_center, "Health", 3),
            // _buildNavItem(
            //     unSelectedIcon: 'assets/images/bottomtab/shop1.svg',
            //     selectedIcon: 'assets/images/bottomtab/shop2.svg',
            //     label: "Shop",
            //     index: 3),
          ],
        ),
      ),
      drawerScrimColor: Colors.black.withOpacity(0.5),
      // drawer: const AppHamburgerMenu(),
      // onDrawerChanged: (bool isOpen) {
      //   if (isOpen) {
      //     final currentState = context.read<ProfileBloc>().state;
      //     currentState.maybeWhen(
      //       fetched: (policies) {},
      //       orElse: () {
      //         context.read<ProfileBloc>().add(
      //               const ProfileEvent.getProfile(),
      //             );
      //       },
      //     );
      //   }
      // },
      body:pages[_selectedIndex == 1 ? 0 : _selectedIndex],


    );
  }

  Widget _buildNavItem({
    required Icon unSelectedIcon,
    required Icon selectedIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () async {
        if (index == 1) {
          setState(() {
            _isSheetOpen = true;
          });
          context.read<UIInteractionCubit>().openSheet();
          //


          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.93,
              child: const CreateTaskSheet(),
            ),
          );


        } else {
          setState(() {
            _selectedIndex = index;
          });
          context.read<UIInteractionCubit>().closeSheet();
          setState(() {
            _isSheetOpen = false;
          });
        }
      }

,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [isSelected ? selectedIcon : unSelectedIcon],
      ),
    );
  }
}
