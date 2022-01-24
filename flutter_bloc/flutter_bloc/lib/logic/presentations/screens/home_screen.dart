import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/constants/enum.dart';
import 'package:flutter_bloc_demo/constants/enum.dart';
import 'package:flutter_bloc_demo/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_demo/logic/cubit/internet_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ui rebuilt');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async =>
                  await Navigator.of(context).pushNamed('/settings'),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetConnected &&
              state.connectionType == ConnectionType.wifi) {
            BlocProvider.of<CounterCubit>(context).increment();
          } else if (state is InternetConnected &&
              state.connectionType == ConnectionType.mobile) {
            BlocProvider.of<CounterCubit>(context).decrement();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text(
                    'WIFI',
                    style: TextStyle(color: Colors.red, fontSize: 60),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text(
                    'MOBILE',
                    style: TextStyle(color: Colors.green, fontSize: 60),
                  );
                } else if (state is InternetLoading) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text(
                    'DISCONNECTED',
                    style: TextStyle(color: Colors.yellow, fontSize: 60),
                  );
                }
              },
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async =>
                  await Navigator.of(context).pushNamed('/second'),
              child: const Text('Next'),
            ),
            ElevatedButton(
              onPressed: () async =>
                  await Navigator.of(context).pushNamed('/albums'),
              child: const Text('Albums'),
            ),
            ElevatedButton(
              onPressed: () async =>
                  await Navigator.of(context).pushNamed('/posts'),
              child: const Text('Posts'),
            ),
          ],
        ),
      ),
    );
  }
}
