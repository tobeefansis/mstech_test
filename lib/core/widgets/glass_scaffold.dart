import 'dart:ui';

import 'package:flutter/material.dart';

/// Reusable scaffold that renders a deep dark-purple gradient background with
/// three blurred colour-blobs, giving every screen the same canvas that makes
/// [BackdropFilter]-based glass effects look their best.
class GlassScaffold extends StatelessWidget {
  const GlassScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // ── Gradient background ───────────────────────────────────────────
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF090928),
                  Color(0xFF0F0F2E),
                  Color(0xFF070715),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
        ),

        // ── Blob 1 – top-left, purple ─────────────────────────────────────
        Positioned(
          top: -100,
          left: -80,
          child: _Blob(size: 340, color: const Color(0x608B6FF9)),
        ),

        // ── Blob 2 – mid-right, blue ──────────────────────────────────────
        Positioned(
          top: size.height * 0.32,
          right: -80,
          child: _Blob(size: 280, color: const Color(0x504C8EF0)),
        ),

        // ── Blob 3 – bottom-centre, pink ──────────────────────────────────
        Positioned(
          bottom: -80,
          left: size.width * 0.1,
          child: _Blob(size: 260, color: const Color(0x48E040FB)),
        ),

        // ── Scaffold (transparent) ────────────────────────────────────────
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
