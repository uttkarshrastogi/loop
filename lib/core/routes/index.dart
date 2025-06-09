import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/feature/dashboard/presentation/pages/dashboard_page.dart';
import '../../feature/dashboard/presentation/pages/dashboard_temp.dart';
import '../../feature/generate loop/presentation/widgets/create_task_sheet.dart';
import '../services/analytics_service.dart';
import '../theme/colors.dart';
import '../uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../utils/prefrence_utils.dart';

class IndexPage extends StatefulWidget {
  final int? altIndex;
  static const routeName = '/IndexPage';
  const IndexPage({super.key, this.altIndex});

  @override
  _IndexPageState createState() => _IndexPageState();
}
bool _isSheetOpen = false;


final pageDefault = [
  const DashboardTemp(),
  const DashboardTemp(),
  const DashboardTemp(),
  const DashboardTemp(),
  const DashboardTemp(),
];

class _IndexPageState extends State<IndexPage> {
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
              unSelectedIcon: 'assets/nav_3.png',
              selectedIcon:  'assets/nav_3.png',
              label: "Today",
              index: 0,
            ),
            Spacer(), _buildNavItem(
              unSelectedIcon: 'assets/nav_4.png',
              selectedIcon:  'assets/nav_4.png',
              label: "Loops",
              index: 1,
            ),
            Spacer(),
            _buildNavItem(
              unSelectedIcon: 'assets/nav_5.png',
              selectedIcon: 'assets/nav_5.png',
              label: "Insights",
              index: 2,
            ),Spacer(),

            _buildNavItem(
              unSelectedIcon: 'assets/nav_1.png',
              selectedIcon: 'assets/nav_1.png',
              label: "Schedule",
              index: 3,
            ),
            Spacer(),
            _buildNavItem(
              label: "Settings",
              unSelectedIcon: 'assets/nav_2.png',
              selectedIcon: 'assets/nav_2.png',
              index: 4,
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
    required String unSelectedIcon,
    required String selectedIcon,
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
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            builder: (context) => const CreateTaskSheet(),
          );
        } else {
          setState(() {
            _selectedIndex = index;
            _isSheetOpen = false;
          });
          context.read<UIInteractionCubit>().closeSheet();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 🔺 Indicator + Icon
          Stack(
            alignment: Alignment.topCenter,
            children: [
              if (isSelected)
                Positioned(
                  top: 0,
                  child: Container(
                    width: 36,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.brandColor, // or AppColors.primaryPink
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10), // pushes icon below the capsule
                child: Image.asset(
                  isSelected ? selectedIcon : unSelectedIcon,
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            label,
            style: AppTextStyles.paragraphXSmall.copyWith(
              color: isSelected ? Colors.black : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

}
