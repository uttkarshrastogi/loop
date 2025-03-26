import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/colors.dart';

class Upload extends StatelessWidget {
  Function onImageChange;
  Upload({
    super.key,
    required this.onImageChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: AppColors.border,
          ))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 18,
            ),
            child: InkWell(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                onImageChange(pickedFile);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: AppColors.neutral600,
                    size: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Choose from the gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 18,
          ),
          child: InkWell(
            onTap: () async {
              final picker = ImagePicker();
              final pickedFile =
                  await picker.pickImage(source: ImageSource.camera);

              onImageChange(pickedFile);
            },
            child: Row(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.neutral600,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  'Take a photo',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
