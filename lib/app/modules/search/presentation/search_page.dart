import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/empty.dart';
import 'package:shop/app/common/widgets/error.dart';
import 'package:shop/app/modules/search/presentation/widgets/history_widget.dart';
import 'package:shop/app/modules/search/presentation/widgets/prediction_widget.dart';
import 'package:shop/app/modules/search/presentation/widgets/search_widget.dart';

import 'search_controller.dart';

class SearchPage extends GetView<SearchControllerr> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => SearchWidget(
              textEditingController: controller.searchController,
              focusNode: controller.searchFocusNode,
              searchText: controller.searchText.value,
              onClearTap: controller.onClearTap,
            ),
          ),
        ),
      ),
      body: Obx(() => _buildView()),
    );
  }

  Widget _buildView() {
    if (controller.hasError.value) {
      return KErrorWidget(error: controller.error.value);
    } else if (controller.searchResults.isEmpty &&
        controller.previousSearches.isEmpty) {
      return KEmptyWidget(
        title: controller.searchController.text.isNotEmpty
            ? null
            : "Search something to get started",
      );
    }
    return GestureDetector(
      onTap: controller.onScreenTap,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => controller.searchResults.isEmpty &&
                      controller.searchText.isEmpty
                  ? HistoryWidget(
                      previousSearches: controller.previousSearches,
                      onTap: controller.onSearchItemTap,
                      onClearHistoryTap: controller.onRemoveHistoryItemTap,
                      onClearAllTap: controller.onClearAllTap,
                    )
                  : PredictionWidget(
                      searchResults: controller.searchResults,
                      onTap: controller.onSearchItemTap,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
