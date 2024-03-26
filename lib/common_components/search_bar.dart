import 'package:hereAssignment/constants/color_constants.dart';
import 'package:hereAssignment/home_bloc/home_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(38.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 8.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 4, bottom: 4),
                      child: TextField(
                        onChanged: (String txt) {},
                        controller: controller,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: const Color(0xff54d3c2),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Varanasi...',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: nearlyDarkBlue,
                  gradient: const LinearGradient(
                      colors: [nearlyDarkBlue, Color(0xff6a88e5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: nearlyDarkBlue.withOpacity(0.4),
                        offset: const Offset(8.0, 16.0),
                        blurRadius: 16.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      context.read<HomeBlocBloc>()
                        ..add(HomeBlocLoadEventByCity(city: controller.text));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(FontAwesomeIcons.magnifyingGlass,
                          size: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
