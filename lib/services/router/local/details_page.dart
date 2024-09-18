import 'package:flutter/material.dart';

class DetailsPage<T> extends Page<T> {
  const DetailsPage({required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width > 600;
    if (!isWide) {
      return ModalBottomSheetRoute<T>(
        settings: this,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.5,
              maxChildSize: 1,
              expand: false,
              builder: (context, scrollController) => SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ));
        },
      );
    }
    return RawDialogRoute<T>(
      settings: this,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 400,
              height: double.infinity,
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  )
                      .chain(CurveTween(curve: Curves.easeOutCubic))
                      .animate(animation),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child: ColoredBox(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child:
                          SingleChildScrollView(child: Material(child: child)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
