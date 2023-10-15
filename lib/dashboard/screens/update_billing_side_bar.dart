import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:work_management/dashboard/sections/create_billing_sections.dart';
import 'package:work_management/dashboard/sections/read_billing_sections.dart';
import 'package:work_management/dashboard/sections/update_billing_sections.dart';
import 'package:work_management/dashboard/utils/app_colors.dart';

class UpdateBillingSideBar extends StatefulWidget {
  const UpdateBillingSideBar({Key? key}) : super(key: key);
  @override
  _UpdateBillingSideBarState createState() => _UpdateBillingSideBarState();
}

class _UpdateBillingSideBarState extends State<UpdateBillingSideBar> {
  final _controller = SidebarXController(selectedIndex: -1, extended: true);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Row(
        children: [
          SideBarLeftWidget(controller: _controller),
          SideBarRightWidget(controller: _controller),
        ],
      )),
    );
  }
}

class SideBarLeftWidget extends StatelessWidget {
  const SideBarLeftWidget({Key? key, required SidebarXController controller})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      showToggleButton: true,
      collapseIcon: Icons.keyboard_arrow_left_outlined,
      extendIcon: Icons.keyboard_arrow_right_outlined,
      theme: SidebarXTheme(
        hoverTextStyle: GoogleFonts.montserrat(
            color: const Color(0xff26D0CE),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14),
        selectedItemDecoration: const BoxDecoration(
          color: Color(0xff1A2980),
        ),
        decoration: BoxDecoration(color: AppColors.appPrimaryColor),
        hoverColor: Colors.redAccent,
        itemTextPadding: const EdgeInsets.only(left: 15),
        selectedItemTextPadding: const EdgeInsets.only(left: 15),
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 20),
        textStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 14),
        selectedTextStyle: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal),
      ),
      extendedTheme: const SidebarXTheme(width: 250),
      footerDivider: Divider(
        color: Colors.white.withOpacity(0.8),
        height: 10,
      ),
      items: [
        SidebarXItem(
          onTap: () {
            context.push('/create');
          },
          iconWidget: const Icon(
            Icons.add_business_outlined,
            color: Colors.white,
          ),
          label: 'Create Billing',
        ),
        SidebarXItem(
            onTap: () {
              context.push('/view');
            },
            iconWidget: const Icon(
              Icons.system_update_alt,
              color: Colors.white,
            ),
            label: 'View Billing'),
      ],
    );
  }
}

class SideBarRightWidget extends StatelessWidget {
  final SidebarXController controller;
  const SideBarRightWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          switch (controller.selectedIndex) {
            case -1:
              return const UpdateBillingSections();
            case 0:
              return const CreateBillingSections();
            case 1:
              return const ReadBillingSections();
            case 2:
              return const UpdateBillingSections();
            default:
              return const CreateBillingSections();
          }
        },
      ),
    ));
  }
}
