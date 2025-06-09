// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:heroicons/heroicons.dart';
// import 'package:intl/intl.dart';
// import 'package:loop/core/theme/colors.dart';
// import 'package:loop/core/widgets/buttons/appbutton.dart';
// import 'package:loop/core/widgets/cards/app_card.dart';
// import 'package:loop/core/widgets/template/page_template.dart';
// import 'package:loop/feature/journey/presentation/pages/generate_screen.dart';
// import 'package:loop/feature/journey/presentation/pages/routine_input_screen.dart';
// import '../../../../core/theme/text_styles.dart';
// import '../../../../core/utils/data_conversion.dart';
// import '../../../goal/data/models/create_goal_model.dart';
// import '../../../user/data/models/user_routine_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../widgets/goal_edit_card.dart';
// import 'add_goal_dialog.dart';
//
// class GeneratePreviewScreen extends StatelessWidget {
//   static const routeName = '/GeneratePreviewScreen';
//   final CreateGoalModel goalModel;
//   final UserRoutineModel routineModel;
//
//   const GeneratePreviewScreen({
//     super.key,
//     required this.goalModel,
//     required this.routineModel,
//   });
//
//   String _formatDate(String? dateStr) {
//     if (dateStr == null) return "N/A";
//     final date = DateTime.tryParse(dateStr);
//     return date != null ? DateFormat.yMMMMd().format(date) : "Invalid Date";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PageTemplate(
//       showBackArrow: true,
//       showBottomGradient: true,
//       content: ListView(
//         children: [
//           // Center(
//           //   child: Image.asset(
//           //     "assets/loop_mascot_preview.png",
//           //     height: MediaQuery.of(context).size.height / 6,
//           //   ),
//           // ),
//           const SizedBox(height: 24),
//           _sectionCard(
//             onEdit: () async{
//
//               // final updatedGoal = await showDialog<CreateGoalModel>(
//               //   context: context,
//               //   // isScrollControlled: true,
//               //   // backgroundColor: Colors.transparent,
//               //   builder: (context) => Padding(
//               //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
//               //     child: FractionallySizedBox(
//               //       heightFactor: 0.8,
//               //       child: GoalEditCard(initialGoal: goalModel),
//               //     ),
//               //   ),
//               // );
//
//               // if (updatedGoal != null) {
//               //   setState(() => goalModel = updatedGoal);
//               //   // ⚡ you update your UI with the new goal info
//               // }
//               context.go(AddGoalDialog.routeName, extra: {
//                 "goalModel": goalModel,
//                 "routineModel": routineModel,
//               });
//             },
//             title: "Your Goal",
//             icon: HeroIcons.flag,
//             children: [
//               _labelValue(label: "Title", value: goalModel.title ?? "No title"),
//               _labelValue(label: "Description", value: goalModel.description ?? "—"),
//               _labelValue(label: "Deadline", value: _formatDate(goalModel.endDate)),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _sectionCard(
//             onEdit: () {
//               context.go(RoutineInputScreen.routeName,  extra: {
//                 "goalModel": goalModel,
//                 "routineModel": routineModel,
//               });
//             },
//             title: "Your Routine",
//             icon: HeroIcons.clock,
//             children: [
//               _labelValue(label: "Wake Up Time", value:formatTo12Hour( routineModel.wakeUpTime)),
//               _labelValue(label: "Sleep Time", value:formatTo12Hour( routineModel.sleepTime)),
//               _labelValue(
//                 label: "Work Hours",
//                 value: "${formatTo12Hour(routineModel.workHours['start'])} - ${formatTo12Hour(routineModel.workHours['end'])}",
//               ),
//               if (routineModel.fixedActivities.isNotEmpty) ...[
//                 const SizedBox(height: 16),
//                 Text(
//                   "Fixed Activities",
//                   style: AppTextStyles.headingH6.copyWith(
//                     color: AppColors.textSecondary,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 for (final activity in routineModel.fixedActivities)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: Text(
//                       "• ${activity.name} (${activity.startTime} - ${activity.endTime}) on ${activity.daysOfWeek.join(', ')}",
//                       style: AppTextStyles.paragraphMedium.copyWith(
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                   ),
//               ],
//             ],
//           ),
//           const SizedBox(height: 10),
//           Center(
//             child: Text(
//               "You can always tweak later.",
//               style: AppTextStyles.paragraphXSmall.copyWith(
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ),
//           const SizedBox(height: 40),
//           AppButton(
//             backGroundColor: AppColors.brandColor,
//             text: "Build My Loop", // Changed Button Text (More Motivating)
//             height: 48,
//             onPressed: () => _saveGoalAndRoutine(context),
//           ),
//           // const SizedBox(height: 12),
//           // Center(
//           //   child: TextButton(
//           //     onPressed: () => Navigator.pop(context),
//           //     child: Text(
//           //       "Go Back & Edit",
//           //       style: AppTextStyles.paragraphSmall.copyWith(
//           //         color: AppColors.textSecondary,
//           //       ),
//           //     ),
//           //   ),
//           // ),
//
//         ],
//       ),
//     );
//   }
//
//   Future<void> _saveGoalAndRoutine(BuildContext context) async {
//     try {
//       final userId = routineModel.userId;
//
//       // Save goal
//       final docRef = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('goal')
//           .add(goalModel.toJson());
//
//       final routineWithId = routineModel.copyWith(id: docRef.id);
//
//       // Save or replace routine (single doc with fixed ID)
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('routine')
//           .doc('main')
//           .set(routineWithId.toFirestore());
//
//       context.push(
//         GenerateScreen.routeName,
//         extra: {
//           'createGoalModel': goalModel,
//           'userRoutineModel': routineWithId,
//         },
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error saving data: $e')),
//       );
//     }
//   }
//
//   Widget _labelValue({required String label, required String value}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ConstrainedBox(
//             constraints: const BoxConstraints(minWidth: 90),
//             child: Text(
//               "$label:",
//               style: AppTextStyles.paragraphXSmall.copyWith(
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               value,
//               style: AppTextStyles.paragraphSmall.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.textSecondary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _sectionCard({
//     required String title,
//     required List<Widget> children,
//     HeroIcons? icon,
//     VoidCallback? onEdit, // <-- NEW: optional edit callback
//   }) {
//     return AppCard(
//       padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               if (icon != null) ...[
//                 HeroIcon(icon, color: AppColors.brandColor, size: 20),
//                 const SizedBox(width: 8),
//               ],
//               Expanded(
//                 child: Text(
//                   title,
//                   style: AppTextStyles.paragraphMedium.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//               if (onEdit != null) ...[
//                 IconButton(
//                   icon: const HeroIcon(HeroIcons.pencil, size: 18, color: AppColors.textSecondary),
//                   onPressed: onEdit,
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ]
//             ],
//           ),
//           // const SizedBox(height: 16),
//           ...children,
//         ],
//       ),
//     );
//   }
//
// }
