import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Controllers/ReadingController.dart';
import 'package:ielts_app/Widgets/IrregularVerbCard.dart';
import 'package:ielts_app/Widgets/SlangCard.dart';
import '../Widgets/InputFiled.dart';

class SearchIrregularSlangView extends StatefulWidget {
  final String title;
  const SearchIrregularSlangView({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchIrregularSlangView> createState() => _SearchIrregularSlangViewState();
}

class _SearchIrregularSlangViewState extends State<SearchIrregularSlangView> {

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
      body: GetBuilder<ReadingController>(
        builder: (controller)
        {
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                InputField(
                  controller: controller.searchController,
                  hintText: "Enter Text To Search ${widget.title}",
                  labelText: "Search",
                  preIcon: const Icon(Icons.search),
                  focusNode: _focusNode,
                  onChanged: (val)
                  {
                    if(widget.title == "Slang")
                      {
                        controller.getSearchSlangs();
                      }
                    else
                      {
                        controller.getSearchVerbs();
                      }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:widget.title == "Slang" ? controller.searchSlangs.length : controller.searchIrregularVerbs.length,
                      itemBuilder: (context, index)
                      {
                        if(widget.title == "Slang")
                          {
                            return SlangCard(
                                slang: controller.searchSlangs[index],
                                isSearch: true
                            );
                          }
                        else
                          {
                            return IrregularVerbCard(
                                verb: controller.searchIrregularVerbs[index],
                                isSearch: true
                            );
                          }
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
