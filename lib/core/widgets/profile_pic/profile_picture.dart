import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loop/core/theme/colors.dart';
import 'package:loop/core/widgets/image_picker/avatar_picker.dart';
import '../image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  final Function(dynamic val) onSelect;
  final String? profileUrl;
  const ProfilePic({super.key, required this.onSelect, this.profileUrl});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 85,
              color: AppColors.blue25,
              // padding: EdgeInsets.symmetric(vertical: 20),
            ),
            Container(
              height: 80,
              color: const Color(
                0xffF5F8FC,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        )
                      ],
                      border: Border.all(width: 5, color: Colors.white),
                      color: const Color(
                        0xffF5F8FC,
                      )),
                  child: ClipOval(
                    child: widget.profileUrl != null &&
                            widget.profileUrl!.isNotEmpty
                        ? Image.network(
                            widget.profileUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              // Show loading indicator while image loads
                              return Container(
                                width: 108,
                                height: 108,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/images/avatars/avatar1.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/avatars/avatar1.png',
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Handle button tap
                      picPicker(
                          context: context,
                          onImagePic: (selectedImg) {
                            if (selectedImg != null) {
                              widget.onSelect(selectedImg);
                              setState(() {
                                selectedImage = selectedImg;
                              });
                            }
                          });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.blue500,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> picPicker({
    required BuildContext context,
    required Function onImagePic,
    bool disableAvatarPicker = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true, // Dismiss when tapping outside the modal
      builder: (BuildContext context) {
        List<Tab> tab = disableAvatarPicker
            ? [const Tab(text: "Upload")]
            : [
                const Tab(text: "Avatar"),
                const Tab(text: "Upload"),
              ];
        List<Widget> tabScreen = [];
        if (!disableAvatarPicker) {
          tabScreen.add(AvatarPicker(
            onAvatarSelect: (selectedAvatar) async {
              File imageFile = await loadAssetAsFile(selectedAvatar);

              onImagePic(imageFile);

              Navigator.of(context).pop();
            },
          ));
        }
        tabScreen.add(Upload(
          onImageChange: (selectedImage) {
            print('$selectedImage');
            File imageFile = File(selectedImage.path);
            onImagePic(imageFile);

            Navigator.of(context).pop();
          },
        ));

        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.black54, // Semi-transparent background
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Select image",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(); // Dismiss dialog
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.blue25,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xff1F2937),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: DefaultTabController(
                              length: 2,
                              child: Column(
                                children: [
                                  TabBar(
                                    isScrollable: true,
                                    dividerColor: const Color(0xffdfe8f0),
                                    dividerHeight: 1,
                                    indicatorWeight: 0.5,
                                    indicatorColor: AppColors.blue500,
                                    tabAlignment: TabAlignment.start,
                                    labelStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.neutral600,
                                    ),
                                    unselectedLabelStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.neutral400,
                                    ),
                                    tabs: tab,
                                  ),
                                  Flexible(
                                      child: TabBarView(children: tabScreen))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<File> loadAssetAsFile(String assetPath) async {
  // Load the asset
  final ByteData data = await rootBundle.load(assetPath);

  String fileName = assetPath.split('/').last;

  // Get the temporary directory where you can store the file
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${fileName}');

  // Write the asset to the file
  await file.writeAsBytes(data.buffer.asUint8List());

  return file;
}
