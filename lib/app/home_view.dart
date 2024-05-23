import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_vpn_app/app/cubit/home_cubit.dart';
import 'package:sample_vpn_app/app/vpn_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var bloc = context.read<HomeCubit>();
        return Scaffold(
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (state.selectedVpn == VpnModel()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('snack'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'ACTION',
                        onPressed: () {},
                      ),
                    ));
                    return;
                  }
                  bloc.connect();
                },
                child: const Icon(Icons.check),
              ),
              FloatingActionButton(
                onPressed: () {
                  bloc.disconnect();
                },
                child: const Icon(Icons.close),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Text(state.selectedVpn.vpnName.toString()),
                Text(state.stage.toString()),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      var vpn = state.vpns[index];
                      return ListTile(
                        title: Text(vpn.vpnName.toString()),
                        onTap: () {
                          bloc.selectVpn(vpn);
                        },
                        selected: state.selectedVpn == vpn,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: state.vpns.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
