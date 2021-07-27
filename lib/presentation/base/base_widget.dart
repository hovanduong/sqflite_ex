import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_viewmodel.dart';

class BaseWidget<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;

  final T viewModel;
  // final Widget child;
  final Function(T viewModel) onViewModelReady;

  const BaseWidget({
    Key? key,
    required this.builder,
    required this.viewModel,
    // required this.child,
    required this.onViewModelReady,
  }) : super(key: key);
  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseViewModel> extends State<BaseWidget<T>> {
  late T viewModel;

  @override
  void initState() {
    viewModel = widget.viewModel;
    widget.onViewModelReady(viewModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => viewModel..setContext(context),
      child: Consumer<T>(
        builder: widget.builder,
        // child: widget.child,
      ),
    );
  }
}
