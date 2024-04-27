// ignore_for_file: must_be_immutable, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventary_go/utils/utils.dart';

class PaginatedListView extends StatefulWidget {
  final RxList? lista;
  final bool? ajuste;
  final Axis? scrollDireccion;
  final IndexedWidgetBuilder itemBuilder;
  Function()? loadNotifications;
  final int pageSize;
  int currentPage = 1;
  double? margin = 10;
  double? padding = 8;
  RxBool? hasMore;

  PaginatedListView({
    Key? key,
    required this.lista,
    required this.itemBuilder,
    required this.pageSize,
    required this.loadNotifications,
    this.ajuste = false,
    this.scrollDireccion = Axis.vertical,
    this.hasMore,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  State<PaginatedListView> createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      widget.loadNotifications!();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.lista!.isNotEmpty
        ? ListView.separated(
            padding: EdgeInsets.all(widget.padding!),
            scrollDirection: widget.scrollDireccion!,
            controller: scrollController,
            shrinkWrap: widget.ajuste!,
            itemCount: widget.lista!.length + 1,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: widget.margin!);
            },
            itemBuilder: (BuildContext context, int index) {
              if (index < widget.lista!.length) {
                return widget.itemBuilder(context, index);
              } else {
                return Obx(() => widget.hasMore!.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                            child: CircularProgressIndicator(
                                color: colorPrincipal)),
                      )
                    : Container());
              }
            },
          )
        : Container());
  }
}
