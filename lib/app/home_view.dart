import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isConnectted = false;
  final List<String> vpnPaths = [
    "assets/fovpn/az/az1.vpnjantit-tcp-992.ovpn",
    "assets/fovpn/az/az1.vpnjantit-tcp-1194.ovpn",
    "assets/fovpn/az/az1.vpnjantit-udp-992.ovpn",
    "assets/fovpn/az/az1.vpnjantit-udp-1194.ovpn",
    "assets/fovpn/az/test1-az1.vpnjantit-udp-2500.ovpn",
  ];
  String selectedVpn = "";
  late OpenVPN openvpn;
  VpnStatus? status;
  VPNStage? stage;
  final info = NetworkInfo();
  String wifiip = "";

  @override
  void initState() {
    getWifiIp();
    init();
    super.initState();
  }

  Future<void> init() async {
    openvpn = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
    try {
      await openvpn.initialize(
          groupIdentifier: "group.com.example.sampleVpnApp",
          providerBundleIdentifier: "com.dogukan.sampleVpnApp.VPNExtension",
          localizedDescription: "LOCALIZED_DESCRIPTION");
    } catch (e) {
      print(e);
    }
  }

  Future<void> getWifiIp() async {
    var ip = await info.getWifiGatewayIP();
    setState(() {
      wifiip = ip!;
    });
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {
    setState(() {
      status = vpnStatus;
    });
  }

  void _onVpnStageChanged(VPNStage? vpnStage, String rawStage) {
    setState(() {
      stage = vpnStage;
    });
  }

  Future<void> connect() async {
    var contennt = await rootBundle.loadString(selectedVpn);
    openvpn.connect(
      contennt,
      selectedVpn,
      username: "test1-vpnjantit.com",
      password: "test12345",
      certIsRequired: true,
    );
  }

  void disconnect() {
    openvpn.disconnect();
  }

  void select(String vpn) {
    setState(() {
      selectedVpn = vpn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (selectedVpn.isEmpty) {
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
              connect();
              getWifiIp();
            },
            child: const Icon(Icons.check),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                selectedVpn = "";
              });
              disconnect();
              getWifiIp();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(selectedVpn),
            Text(wifiip),
            Text(stage?.toString() ?? VPNStage.disconnected.toString()),
            Text(status?.toJson().toString() ?? ""),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var vpnPath = vpnPaths[index];
                  return ListTile(
                    title: Text(vpnPath),
                    onTap: () {
                      select(vpnPath);
                    },
                    selected: selectedVpn == vpnPath,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 12);
                },
                itemCount: vpnPaths.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
