import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class AdaptiveScrollView extends StatefulWidget {
  final List<Widget> slivers;

  const AdaptiveScrollView({super.key, required this.slivers});

  @override
  State<AdaptiveScrollView> createState() => _AdaptiveScrollViewState();
}

class _AdaptiveScrollViewState extends State<AdaptiveScrollView> {
  PointerDeviceKind? _pointerDeviceKind;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (event) {
        event.kind != _pointerDeviceKind
            ? setState(() => _pointerDeviceKind = event.kind)
            : null;
      },
      child: GestureDetector(
        onTapDown: (_) => _pointerDeviceKind == PointerDeviceKind.mouse
            ? setState(() => _pointerDeviceKind = PointerDeviceKind.touch)
            : null,
        child: _pointerDeviceKind == PointerDeviceKind.mouse
            ? WebSmoothScroll(
                controller: _scrollController,
                child: CustomScrollView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: widget.slivers,
                ),
              )
            : CustomScrollView(
                controller: _scrollController,
                shrinkWrap: true,
                slivers: widget.slivers,
              ),
      ),
    );
  }
}
