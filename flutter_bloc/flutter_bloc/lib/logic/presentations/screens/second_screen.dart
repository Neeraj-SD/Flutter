import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/logic/cubit/counter_cubit.dart';

class SecondScreen extends StatelessWidget {
  final String title;
  final Color color;

  const SecondScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ui rebuilt');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You pressed the button this ,many times',
            style: Theme.of(context).textTheme.headline6,
          ),
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              return Text('${state.counterValue}',
                  style: Theme.of(context).textTheme.headline2);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<CounterCubit>(context).decrement(),
                child: const Icon(Icons.remove),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24),
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    BlocProvider.of<CounterCubit>(context).increment(),
                child: const Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(24),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => BlocProvider.of<CounterCubit>(context).reset(),
              child: const Text('Reset')),
        ],
      ),
    );
  }
}
