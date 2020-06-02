import 'package:farma_reagente/components/unknown_error.dart';
import 'package:flutter/material.dart';
import 'loader.dart';

class FutureBuilderHandler<T> extends StatefulWidget {
  final Future<List<T>> future;
  final Widget Function(List<T> data) none;
  final Widget Function(List<T> data) waiting;
  final Widget Function(List<T> data) active;
  final Function(List<T> data) done;

  const FutureBuilderHandler({
    Key key,
    @required this.future,
    this.none,
    this.waiting,
    this.active,
    this.done,
  }) : super(key: key);

  @override
  _FutureBuilderHandlerState<T> createState() => _FutureBuilderHandlerState<T>();
}

class _FutureBuilderHandlerState<T> extends State<FutureBuilderHandler<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      initialData: List<T>(),
      future: widget.future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            if (widget.none != null) {
              return widget.none(snapshot.data);
            }
            break;
          case ConnectionState.waiting:
            if (widget.waiting != null) {
              return widget.waiting(snapshot.data);
            } else {
              return Loader();
            }
            break;
          case ConnectionState.active:
            if (widget.active != null) {
              return widget.active(snapshot.data);
            }
            break;
          case ConnectionState.done:
            if (widget.done != null) {
              return widget.done(snapshot.data);
            }
            break;
        }
        return UnknownError();
      },
    );
  }
}
