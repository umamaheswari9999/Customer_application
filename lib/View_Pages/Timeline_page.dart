import 'package:flutter/material.dart';
import 'package:flutter_showcase/flutter_showcase.dart';
import 'package:timeline_tile/timeline_tile.dart';
class ShowcaseDeliveryTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      title: 'Delivery Timeline',
      app: _DeliveryTimelineApp(),
      description:
      'A simple timeline with few steps to show the current status of '
          'an order.',
      template: SimpleTemplate(reverse: false),
      theme: TemplateThemeData(
        frameTheme: FrameThemeData(
          statusBarBrightness: Brightness.dark,
          frameColor: const Color(0xFF215C3F),
        ),
        flutterLogoColor: FlutterLogoColor.original,
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFFE9E9E9),
        // titleTextStyle: GoogleFonts.neuton(
        //   fontSize: 80,
        //   fontWeight: FontWeight.bold,
        //   color: const Color(0xFF2C7B54),
        // ),
        // descriptionTextStyle: GoogleFonts.yantramanav(
        //   fontSize: 24,
        //   height: 1.2,
        //   color: const Color(0xFF2C7B54),
        // ),
        buttonTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
        buttonIconTheme: const IconThemeData(color: Colors.white),
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFF2C7B54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class _DeliveryTimelineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery TimelineTile',
      builder: Frame.builder,
      home: _DeliveryTimeline(),
    );
  }
}
class _DeliveryTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF379A69),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: const Color(0xFF27AA69).withOpacity(0.2),
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: _AppBar(),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                _Header(),
                Expanded(child: _TimelineDelivery()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _TimelineDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(

              title: 'Order Placed',
              message: 'We have received your order.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(


              title: 'Order Confirmed',
              message: 'Your order has been confirmed.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF2B619C),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(

              title: 'Order Processed',
              message: 'We are preparing your order.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFF27AA69),
            ),
            afterLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isLast: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFFDADADA),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              disabled: true,

              title: 'Ready to Pickup',
              message: 'Your order is ready for pickup.',
            ),
            beforeLineStyle: const LineStyle(
              color: Color(0xFFDADADA),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,

    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);


  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[

          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text(
              //   title,
              //   style: GoogleFonts.yantramanav(
              //     color: disabled
              //         ? const Color(0xFFBABABA)
              //         : const Color(0xFF636564),
              //     fontSize: 18,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              const SizedBox(height: 6),
              // Text(
              //   message,
              //   style: GoogleFonts.yantramanav(
              //     color: disabled
              //         ? const Color(0xFFD5D5D5)
              //         : const Color(0xFF636564),
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE9E9E9),
            width: 3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Text(
                  //   'ESTIMATED TIME',
                  //   style: GoogleFonts.yantramanav(
                  //     color: const Color(0xFFA2A2A2),
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   '30 minutes',
                  //   style: GoogleFonts.yantramanav(
                  //     color: const Color(0xFF636564),
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Text(
                  //   'ORDER NUMBER',
                  //   style: GoogleFonts.yantramanav(
                  //     color: const Color(0xFFA2A2A2),
                  //     fontSize: 16,
                  //   ),
                  // ),
                  // Text(
                  //   '#2482011',
                  //   style: GoogleFonts.yantramanav(
                  //     color: const Color(0xFF636564),
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF27AA69),
      leading: const Icon(Icons.menu),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            // child: Text(
            //   'CANCEL',
            //   style: GoogleFonts.neuton(
            //     color: Colors.white,
            //     fontSize: 16,
            //   ),
            // ),
          ),
        ),
      ],
      // title: Text(
      //   'Track Order',
      //   style: GoogleFonts.neuton(
      //       color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
