import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/data/base_data_bloc.dart';
import 'package:t_photos/base/bloc/data/base_state.dart';

class BaseBlocBuilder
    extends BlocBuilder<BaseBloc, BaseState> {
  final BaseBloc bloc;
  final BlocBuilderCondition<BaseState> buildWhenCondition;
  final BlocWidgetBuilder<BaseState> builder;
  final Function? onRetry;

  const BaseBlocBuilder(
      {Key? key,
        required this.bloc,
        required this.buildWhenCondition,
        required this.builder,
        this.onRetry})
      : super(
      key: key,
      builder: builder,
      bloc: bloc,
      buildWhen: buildWhenCondition);

  @override
  Widget build(BuildContext context, BaseState state) {
    return builder(context, state);
  }
}

