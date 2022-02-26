import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_photos/base/bloc/navigator/base_nav_state.dart';
import 'package:t_photos/base/bloc/navigator/base_navigator_bloc.dart';

class BaseNavigatorBlocBuilder<B extends BaseNavigatorBloc>
    extends BlocBuilder<BaseNavigatorBloc, BaseNavigatorState> {
  final B bloc;
  final BlocBuilderCondition<BaseNavigatorState> buildWhenCondition;
  final BlocWidgetBuilder<BaseNavigatorState> navigatorBlocWidgetBuilder;

  const BaseNavigatorBlocBuilder(
      {Key? key,
      required this.bloc,
      required this.buildWhenCondition,
      required this.navigatorBlocWidgetBuilder})
      : super(
            key: key,
            builder: navigatorBlocWidgetBuilder,
            bloc: bloc,
            buildWhen: buildWhenCondition);

  @override
  Widget build(BuildContext context, BaseNavigatorState state) {
    return builder(context, state);
  }
}
