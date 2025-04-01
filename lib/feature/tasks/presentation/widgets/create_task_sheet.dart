import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/theme/text_styles.dart';
import 'package:loop/core/widgets/buttons/appbutton.dart';
import '../../../../core/uiBloc/uiInteraction/ui_interaction_cubit.dart';
import '../../../../core/widgets/inputs/app_nude_textfield.dart';

final titleController = TextEditingController();
final descController = TextEditingController();
final titleFocus = FocusNode();

class CreateTaskSheet extends StatefulWidget {
  const CreateTaskSheet({super.key});

  @override
  State<CreateTaskSheet> createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  @override
  void initState() {
    titleFocus.requestFocus();
    titleController.addListener((){
      if(titleController.text.isNotEmpty||titleController.text==''){
        setState(() {

        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(12),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                    context.read<UIInteractionCubit>().closeSheet();
                  },
                  child: Text(
                    "Cancel",
                    style: AppTextStyles.paragraphMedium.copyWith(
                      color: AppColors.textButton,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    "Create",
                    style: AppTextStyles.paragraphMedium.copyWith(
                      color:
                          titleController.text.isEmpty
                              ? AppColors.textButton
                              : AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Gap(28),
            //TODO : change the fonts weight of this
            AppNudeTextField(
              hintText: 'Task title',
              textStyle: AppTextStyles.headingH5.copyWith(
                fontWeight: FontWeight.w600,
              ),
              focusNode: titleFocus,
              controller: titleController,
            ),
            Gap(20),
            AppNudeTextField(
              hintText: 'Description...',
              hintStyle: AppTextStyles.paragraphMedium,
            ),
            // const SizedBox(height: 12),
            // Wrap(
            //   spacing: 8,
            //   runSpacing: 8,
            //   children: const [
            //     TagButton(label: 'Goal'),
            //     TagButton(label: 'Priority'),
            //     TagButton(label: 'Labels'),
            //     TagButton(label: 'Due Date'),
            //   ],
            // ),
            // const SizedBox(height: 12),
            // const BottomBar(),
          ],
        ),
      ),
    );
  }
}
