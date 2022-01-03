import 'package:flutter_svg/flutter_svg.dart';

class AppAssets {
  // system UI
  static const check = 'assets/images/check.svg';
  static const plus = 'assets/images/plus.svg';
  static const threeDots = 'assets/images/three-dots.svg';
  static const delete = 'assets/images/delete.svg';
  static const navigationClose = 'assets/images/navigation-close.svg';
  static const navigationBack = 'assets/images/navigation-back.svg';

  // tasks
  static const basketball = 'assets/images/basketball-ball.svg';
  static const beer = 'assets/images/beer.svg';
  static const bike = 'assets/images/bike.svg';
  static const book = 'assets/images/book.svg';
  static const carrot = 'assets/images/carrot.svg';
  static const chef = 'assets/images/chef.svg';
  static const dentalFloss = 'assets/images/dental-floss.svg';
  static const dog = 'assets/images/dog.svg';
  static const dumbell = 'assets/images/dumbell.svg';
  static const guitar = 'assets/images/guitar.svg';
  static const homework = 'assets/images/homework.svg';
  static const html = 'assets/images/html-coding.svg';
  static const karate = 'assets/images/karate.svg';
  static const mask = 'assets/images/mask.svg';
  static const meditation = 'assets/images/meditation.svg';
  static const painting = 'assets/images/paint-board-and-brush.svg';
  static const phone = 'assets/images/phone.svg';
  static const pushups = 'assets/images/pushups-man.svg';
  static const rest = 'assets/images/rest.svg';
  static const run = 'assets/images/run.svg';
  static const smoking = 'assets/images/smoking.svg';
  static const stretching = 'assets/images/stretching-exercises.svg';
  static const sun = 'assets/images/sun.svg';
  static const swimmer = 'assets/images/swimmer.svg';
  static const toothbrush = 'assets/images/toothbrush.svg';
  static const vitamins = 'assets/images/vitamins.svg';
  static const washHands = 'assets/images/wash-hands.svg';
  static const water = 'assets/images/water.svg';

  static const allTaskIcons = [
    basketball,
    beer,
    bike,
    book,
    carrot,
    chef,
    dentalFloss,
    dog,
    dumbell,
    guitar,
    homework,
    html,
    karate,
    mask,
    meditation,
    painting,
    phone,
    pushups,
    rest,
    run,
    smoking,
    stretching,
    sun,
    swimmer,
    toothbrush,
    vitamins,
    washHands,
    water,
  ];

  static Future<void> preloadSVGs() async {
    final assets = [
      // system UI
      check,
      plus,
      threeDots,
      delete,
      navigationClose,
      navigationBack,
      // tasks
      ...allTaskIcons,
    ];
    for (final asset in assets) {
      await precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, asset),
        null,
      );
    }
  }
}
