import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Widgets/ProverbIdiomCard.dart';

import '../Controllers/ProverbIdiomController.dart';
import '../Widgets/InputFiled.dart';

class SearchIdiomsAndProverbsView extends StatefulWidget {
  const SearchIdiomsAndProverbsView({Key? key}) : super(key: key);

  @override
  State<SearchIdiomsAndProverbsView> createState() => _SearchIdiomsAndProverbsViewState();
}

class _SearchIdiomsAndProverbsViewState extends State<SearchIdiomsAndProverbsView> {

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: GetBuilder<ProverbIdiomController>(
        builder: (controller)
        {
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                InputField(
                  controller: controller.searchController,
                  hintText: "Enter Text To Search",
                  labelText: "Search",
                  preIcon: const Icon(Icons.search),
                  focusNode: _focusNode,
                  onChanged: (val)
                  {
                    controller.getSearchItems();
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.searchItems.length,
                      itemBuilder: (context, index)
                          {
                            return ProverbIdiomCard(item: controller.searchItems[index], isSearch: true,);
                          }
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
