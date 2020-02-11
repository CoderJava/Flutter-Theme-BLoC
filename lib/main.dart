import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData themeData;
          if (state is ThemeChangeState) {
            themeData = state.themeData;
          }
          return MaterialApp(
          title: 'Flutter Theme BLoC',
          theme: themeData ?? ThemeData.light(),
          home: MyHomePage(),
        );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Theme BLoC'),
      ),
      body: Center(
        child: Wrap(
          children: <Widget>[
            RaisedButton(
              child: Text('Light Theme'),
              onPressed: () {
                BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(ThemeData.light()));
              },
            ),
            SizedBox(width: 16.0),
            RaisedButton(
              child: Text('Dark Theme'),
              onPressed: () {
                BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(ThemeData.dark()));
              },
            ),
          ],
        )
      ),
    );
  }
}

abstract class ThemeState {}

class ThemeInitialState extends ThemeState {}

class ThemeChangeState extends ThemeState {
  final ThemeData themeData;

  ThemeChangeState(this.themeData);
}

class ThemeEvent {
  final ThemeData themeData;

  ThemeEvent(this.themeData);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeInitialState();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    yield ThemeChangeState(event.themeData);
  }

}

