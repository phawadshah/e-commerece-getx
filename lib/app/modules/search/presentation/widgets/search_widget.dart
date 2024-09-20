import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/empty.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.textEditingController,
    this.focusNode,
    required this.searchText,
    this.onClearTap,
  });
  final Function()? onClearTap;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: textEditingController,
      focusNode: focusNode,
      backgroundColor: WidgetStatePropertyAll(Colors.grey.shade100),
      elevation: const WidgetStatePropertyAll(0),
      leading: const Icon(
        Icons.search,
        color: Colors.black38,
        size: 28,
      ),
      trailing: [
        searchText.trim().isEmpty
            ? const KEmptyWidget()
            : IconButton(
                onPressed: onClearTap,
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black38,
                  size: 24,
                ),
              )
      ],
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      hintText: "Search Products",
    );
  }
}
