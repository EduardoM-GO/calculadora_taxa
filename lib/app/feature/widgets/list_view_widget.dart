import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  final List<Widget> children;
  final bool? shrinkWrap;
  final EdgeInsetsGeometry? padding;

  const ListViewWidget({
    super.key,
    required this.children,
    this.shrinkWrap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        padding: padding ??
            EdgeInsets.only(
              top: 16,
              bottom: 16 + MediaQuery.of(context).padding.bottom,
              right: 16,
              left: 16,
            ),
        shrinkWrap: shrinkWrap ?? false,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      );
}
