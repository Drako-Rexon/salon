import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salon/components/colors_used.dart';

class NavConatiner extends StatefulWidget {
  const NavConatiner({
    Key? key,
  }) : super(key: key);

  @override
  State<NavConatiner> createState() => _NavConatinerState();
}

class _NavConatinerState extends State<NavConatiner> {
  @override
  Widget build(BuildContext context) {
    // String defLocation = "Choose your location";

    var dropDownItems = [
      "Choose your location",
      "Dwarka",
      "Uttam Nagar",
      "Laxmi Nagar",
      "South Ex"
    ];

    Size size = MediaQuery.of(context).size;
    String dropdownValue = 'Choose your location';

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 7,
        top: 12,
        bottom: 12,
      ),
      width: size.width,
      // height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            AppColors.gradient3,
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.solidBell,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ), // ! this is for the first row of navigation top
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: [
                Text(
                  'Pikashi Jain',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsReg',
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ), // ! This is for the username in navigation top
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              Container(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  focusColor: Colors.black,
                  // elevation: 16,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontFamily: 'PoppinsReg'), // TODO this need to improve
                  underline: Container(height: 0),
                  items: dropDownItems.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
            ],
          ), // ! This is for the location dropdown menu
        ],
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.bottomLeft,
          radius: 0.5,
          colors: <Color>[Colors.purple, Colors.amberAccent],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
