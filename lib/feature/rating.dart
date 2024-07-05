import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../core/service/real/crud.dart';

class rating extends StatefulWidget {
  final ValueChanged<double> onRatingSelected;

  const rating({Key? key, required this.onRatingSelected}) : super(key: key);

  @override
  State<rating> createState() => _ratingState();
}

class _ratingState extends State<rating> {
  // ignore: unused_field
  late String _rating;
  // ignore: unused_field
  final double _initialRating = 0.0;

  IconData? _selectedIcon;
  GlobalKey x = GlobalKey();
  @override
  void initState() {
    super.initState();
    _rating = _initialRating as String;
  }

  TextEditingController review_con = TextEditingController();
  final Crud _crud = Crud();
  GlobalKey<FormState> formstats = GlobalKey();
  late final String? Function(String?) valid;

  Rate() async {
    try {
      var response = await _crud.postrequest(linkrating, {
        //"book_id": user_name.text,
        "rate": _rating,
      });
      if (response is Map && response['success'] == true) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => const home()),
        // );
      } else {
        print("fail");
      }
    } catch (e) {
      print("ERROR $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating as String;
          widget.onRatingSelected(rating);
        });
      },
      updateOnDrag: true,
    );
  }
}
