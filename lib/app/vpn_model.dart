// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class VpnModel extends Equatable {
  String? flagPath;
  String? content;
  String? vpnName;
  String? username;
  String? password;
  bool? certIsRequired;
  VpnModel({
    this.flagPath,
    this.content,
    this.vpnName,
    this.username,
    this.password,
    this.certIsRequired,
  });
  @override
  List<Object?> get props {
    return [
      flagPath,
      content,
      vpnName,
      username,
      password,
      certIsRequired,
    ];
  }
}

class VpnList {
  static List<VpnModel> list = [
    VpnModel(
      flagPath: "",
      certIsRequired: true,
      content: "assets/fovpn/az/az1.vpnjantit-tcp-992.ovpn",
      password: "test1",
      username: "test1-vpnjantit.com",
      vpnName: "az tcp 992",
    ),
    VpnModel(
      flagPath: "",
      certIsRequired: true,
      content: "assets/fovpn/az/az1.vpnjantit-tcp-1194.ovpn",
      password: "test1",
      username: "test1-vpnjantit.com",
      vpnName: "az tcp 1194",
    ),
    VpnModel(
      flagPath: "",
      certIsRequired: true,
      content: "assets/fovpn/az/az1.vpnjantit-udp-992.ovpn",
      password: "test1",
      username: "test1-vpnjantit.com",
      vpnName: "az udp 992",
    ),
    VpnModel(
      flagPath: "",
      certIsRequired: true,
      content: "assets/fovpn/az/az1.vpnjantit-udp-1194.ovpn",
      password: "test1",
      username: "test1-vpnjantit.com",
      vpnName: "az udp 1194",
    ),
    VpnModel(
      flagPath: "",
      certIsRequired: true,
      content: "assets/fovpn/az/az1.vpnjantit-udp-2500.ovpn",
      password: "test1",
      username: "test1-vpnjantit.com",
      vpnName: "az udp 2500",
    ),
  ];
}
