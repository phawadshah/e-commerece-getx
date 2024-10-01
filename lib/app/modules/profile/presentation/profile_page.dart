import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/loading.dart';
import 'package:shop/app/modules/profile/presentation/widgets/guest_widget.dart';
import 'package:shop/app/modules/profile/presentation/widgets/text_widget.dart';
import 'package:shop/app/utils/constants/enums.dart';
import 'package:shop/app/utils/helper.dart';

import 'profile_controller.dart';
import 'widgets/profile_row.dart';
import 'widgets/profile_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(
        () => _buildView(),
      ),
    );
  }

  Widget _buildView() {
    if (controller.state == ControllerState.LOADING) {
      return const KLoadingWidget();
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.height,
          maxWidth: Get.width,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              controller.isLoggedIn.value
                  ? ProfileWidget(
                      name: controller.user.name ?? 'Welcom',
                      email: controller.user.email ?? 'example@gmail.com',
                    )
                  : GuestWidget(
                      ontap: controller.onLoginTap,
                    ),
              addVerticleSpace(20),
              ListView.separated(
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      addVerticleSpace(10),
                      const Divider(),
                      addVerticleSpace(10),
                    ],
                  );
                },
                itemBuilder: (_, index) {
                  return index != 3
                      ? ProfileRow(
                          title: controller.titles[index],
                          icon: controller.icons[index],
                          onTap: () {
                            controller.onItemTap(index);
                          },
                        )
                      : controller.isLoggedIn.value
                          ? ProfileRow(
                              title: controller.titles[index],
                              icon: controller.icons[index],
                              onTap: () {
                                controller.onItemTap(index);
                              },
                            )
                          : null;
                },
              ),
              const Spacer(),
              const TextWidget(),
            ],
          ),
        ),
      );
    }
  }
}
