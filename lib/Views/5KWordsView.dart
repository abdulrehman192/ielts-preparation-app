import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ielts_app/Constants/AppColors.dart';
import 'package:ielts_app/Controllers/WordsController.dart';
import 'package:ielts_app/Models/WordModel.dart';
import 'package:ielts_app/Views/WordSearchView.dart';
import 'package:ielts_app/Widgets/WordCard.dart';

class WordsView extends StatefulWidget {
  final String title;
  const WordsView({Key? key, required this.title}) : super(key: key);

  @override
  State<WordsView> createState() => _WordsViewState();
}

class _WordsViewState extends State<WordsView> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    WordsController w = Get.find();
    tabController = TabController(length: w.characters.length, vsync: this);
    tabController.addListener(() {
      w.letter = w.characters[tabController.index];
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WordsController>(
      builder: (controller) {
        return GetBuilder<AppColors>(
          builder: (color) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: [
                  IconButton(
                      onPressed: (){
                        Get.to(() => const WordSearchView());
                      },
                      splashRadius: 20,
                      icon: const Icon(Icons.search)
                  ),
                  IconButton(
                      onPressed: (){
                        color.toggleThemeColor();
                      },
                      splashRadius: 20,
                      icon: const Icon(Icons.brightness_4)
                  ),
                  PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      splashRadius: 20,
                      onSelected: (val)
                      {
                        if(val == 'rate')
                        {

                        }
                        else if(val == 'share')
                        {

                        }

                      },
                      itemBuilder: (context)
                      {
                        return [
                          PopupMenuItem(
                              value: 'rate',
                              child: _menuItem(icon: 'R', title: 'Help Us! Rate 5 Stars')
                          ),
                          PopupMenuItem(
                              value: 'share',
                              child: _menuItem(icon: 'S', title: 'Share App With Friends')
                          ),

                        ];
                      }
                  )
                ],
                bottom: TabBar(
                  controller: tabController,

                  isScrollable: true,
                  tabs: controller.characters.map((e) => Tab(text: e,)).toList(),
                ),
              ),
              body: TabBarView(
                controller: tabController,
                children: controller.characters.map((e) {
                  return  controller.loading ? const Center(child: CircularProgressIndicator(),) :
                    controller.words.isEmpty ? const Center(child: Text("No Words Found"),) :
                    ListView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.all(8.w),
                      itemCount: controller.loadingMore ? controller.words.length + 1 : controller.words.length,
                      itemBuilder: (context, index)
                      {
                        if(index < controller.words.length)
                          {
                            return WordCard(
                              word: controller.words[index],
                              isImportant: false,
                              isSearch: false,
                            );
                          }
                        else
                          {
                            return const Center(child: CircularProgressIndicator());
                          }
                      }
                  );

                }).toList(),
              ),
            );
          }
        );
      }
    );
  }
  Widget _menuItem({required String icon, required String title})
  {
    return Row(
      children: [
        Container(
          width: 25.w,
          height: 25.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.w),
              color: Colors.red
          ),
          child: Text(icon, style: const TextStyle(color: Colors.white),),
        ),
        SizedBox(width: 8.w,),
        Text(title, )
      ],
    );
  }

}
