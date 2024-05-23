// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<VpnModel> vpns;
  final VpnModel selectedVpn;
  final VPNStage stage;
  const HomeState({
    required this.vpns,
    required this.selectedVpn,
    required this.stage,
  });

  HomeState copyWith({
    List<VpnModel>? vpns,
    VpnModel? selectedVpn,
    VPNStage? stage,
  }) {
    return HomeState(
      vpns: vpns ?? this.vpns,
      selectedVpn: selectedVpn ?? this.selectedVpn,
      stage: stage ?? this.stage,
    );
  }

  @override
  List<Object> get props => [
        vpns,
        selectedVpn,
        stage,
      ];
}
