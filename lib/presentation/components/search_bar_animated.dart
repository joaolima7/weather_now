import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';

class SearchAnimated extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSuffixTap;
  final Function(String) onSubmitted;
  SearchAnimated({
    required this.controller,
    required this.onSuffixTap,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      animationDurationInMilli: 300,
      helpText: 'Pesquise aqui...',
      width: MediaQuery.of(context).size.width,
      textController: controller,
      onSuffixTap: onSuffixTap,
      onSubmitted: onSubmitted,
    );
  }
}
