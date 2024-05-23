import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:sample_vpn_app/app/vpn_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          vpns: VpnList.list,
          stage: VPNStage.unknown,
          selectedVpn: VpnModel(),
        ));

  OpenVPN openvpn = OpenVPN();

  Future<void> init() async {
    openvpn = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
    try {
      await openvpn.initialize(
        groupIdentifier: "group.com.dogukan.sampleVpnApp",
        providerBundleIdentifier: "com.dogukan.sampleVpnApp.VPNExtension",
        localizedDescription: "LOCALIZED_DESCRIPTION",
      );
    } catch (e) {
      print(e);
    }
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {
    print(vpnStatus.toString());
  }

  void _onVpnStageChanged(VPNStage? vpnStage, String rawStage) {
    emit(state.copyWith(stage: vpnStage));
  }

  void selectVpn(VpnModel vpn) {
    emit(state.copyWith(selectedVpn: vpn));
  }

  Future<void> connect() async {
    var content = await rootBundle.loadString(state.selectedVpn.content!);
    if (openvpn.initialized) {
      openvpn.connect(
        content,
        state.selectedVpn.vpnName ?? "",
        username: state.selectedVpn.username,
        password: state.selectedVpn.password,
        certIsRequired: state.selectedVpn.certIsRequired ?? false,
      );
    }
  }

  void disconnect() {
    openvpn.disconnect();
    emit(state.copyWith(selectedVpn: VpnModel()));
  }
}
