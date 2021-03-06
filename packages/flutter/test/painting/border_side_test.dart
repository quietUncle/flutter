// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('BorderSide - asserts when constructed incorrectly', () {
    expect(
      const BorderSide(),
      const BorderSide(
        color: const Color(0xFF000000),
        width: 1.0,
        style: BorderStyle.solid,
      ),
    );
    // so that we can use `new` below, we use these:
    final Null $null = null;
    final double $minus1 = -1.0;
    expect(() => new BorderSide(color: $null), throwsAssertionError);
    expect(() => new BorderSide(width: $null), throwsAssertionError);
    expect(() => new BorderSide(style: $null), throwsAssertionError);
    expect(() => new BorderSide(width: $minus1), throwsAssertionError);
    expect(
      const BorderSide(width: -0.0),
      const BorderSide(
        color: const Color(0xFF000000),
        width: 0.0,
        style: BorderStyle.solid,
      ),
    );
  });
  test('BorderSide - merging', () {
    final BorderSide side2 = const BorderSide(width: 2.0);
    final BorderSide side3 = const BorderSide(width: 3.0);
    final BorderSide side5 = const BorderSide(width: 5.0);
    final BorderSide green = const BorderSide(color: const Color(0xFF00FF00));
    final BorderSide blue = const BorderSide(color: const Color(0xFF0000FF));
    final BorderSide solid = const BorderSide(style: BorderStyle.solid);
    final BorderSide none = const BorderSide(style: BorderStyle.none);
    expect(BorderSide.merge(null, null), isNull);
    expect(BorderSide.merge(null, side2), side2);
    expect(BorderSide.merge(side2, null), side2);
    expect(() => BorderSide.merge(green, blue), throwsAssertionError);
    expect(() => BorderSide.merge(solid, none), throwsAssertionError);
    expect(BorderSide.merge(side2, side3), side5);
    expect(BorderSide.merge(side3, side2), side5);
  });
  test('BorderSide - asserts when copied incorrectly', () {
    final BorderSide green2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0);
    final BorderSide blue3 = const BorderSide(color: const Color(0xFF0000FF), width: 3.0);
    final BorderSide blue2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0);
    final BorderSide green3 = const BorderSide(color: const Color(0xFF00FF00), width: 3.0);
    final BorderSide none2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0, style: BorderStyle.none);
    expect(green2.copyWith(color: const Color(0xFF0000FF), width: 3.0), blue3);
    expect(green2.copyWith(width: 3.0), green3);
    expect(green2.copyWith(color: const Color(0xFF0000FF)), blue2);
    expect(green2.copyWith(style: BorderStyle.none), none2);
  });
  test('BorderSide - scale', () {
    final BorderSide side3 = const BorderSide(width: 3.0, color: const Color(0xFF0000FF));
    final BorderSide side6 = const BorderSide(width: 6.0, color: const Color(0xFF0000FF));
    final BorderSide none = const BorderSide(style: BorderStyle.none, width: 0.0, color: const Color(0xFF0000FF));
    expect(side3.scale(2.0), side6);
    expect(side6.scale(0.5), side3);
    expect(side6.scale(0.0), none);
    expect(side6.scale(-1.0), none);
    expect(none.scale(2.0), none);
  });
  test('BorderSide - toPaint', () {
    final Paint paint1 = const BorderSide(width: 2.5, color: const Color(0xFFFFFF00), style: BorderStyle.solid).toPaint();
    expect(paint1.strokeWidth, 2.5);
    expect(paint1.style, PaintingStyle.stroke);
    expect(paint1.color, const Color(0xFFFFFF00));
    expect(paint1.blendMode, BlendMode.srcOver);
    final Paint paint2 = const BorderSide(width: 2.5, color: const Color(0xFFFFFF00), style: BorderStyle.none).toPaint();
    expect(paint2.strokeWidth, 0.0);
    expect(paint2.style, PaintingStyle.stroke);
    expect(paint2.color, const Color(0x00000000));
    expect(paint2.blendMode, BlendMode.srcOver);
  });
  test('BorderSide - canMerge', () {
    final BorderSide green2 = const BorderSide(color: const Color(0xFF00FF00), width: 2.0);
    final BorderSide green3 = const BorderSide(color: const Color(0xFF00FF00), width: 3.0);
    final BorderSide blue2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0);
    final BorderSide none2 = const BorderSide(color: const Color(0xFF0000FF), width: 2.0, style: BorderStyle.none);
    expect(BorderSide.canMerge(green2, green3), isTrue);
    expect(BorderSide.canMerge(green2, blue2), isFalse);
    expect(BorderSide.canMerge(green2, none2), isFalse);
    expect(BorderSide.canMerge(blue2, null), isTrue);
    expect(BorderSide.canMerge(null, null), isTrue);
    expect(BorderSide.canMerge(null, blue2), isTrue);
  });
  test('BorderSide - won\'t lerp into negative widths', () {
    final BorderSide side0 = const BorderSide(width: 0.0);
    final BorderSide side1 = const BorderSide(width: 1.0);
    final BorderSide side2 = const BorderSide(width: 2.0);
    expect(BorderSide.lerp(side2, side1, 10.0), side0);
    expect(BorderSide.lerp(side1, side2, -10.0), side0);
    expect(BorderSide.lerp(side0, side1, 2.0), side2);
    expect(BorderSide.lerp(side1, side0, 2.0), side0);
  });
  test('BorderSide - toString', () {
    expect(
      const BorderSide(color: const Color(0xFFAABBCC), width: 1.2345).toString(),
      'BorderSide(Color(0xffaabbcc), 1.2, BorderStyle.solid)',
    );
  });
}