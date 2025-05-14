import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
// ignore: depend_on_referenced_packages
import 'package:wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

import 'home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String route = '/Login';

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  Future<void> nextScreen() async {
    if (mounted) {
      Navigator.of(context).pushNamed(HomeView.route);
    }
  }

  Future<void> connectWallet() async {
    var apiUrl =
        "https://9dcf-2804-7f3-480-958c-4b67-6f12-2bd5-5629.ngrok-free.app";

    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    var credentials = EthPrivateKey.fromHex(
      "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80",
    );
    var address = credentials.address;

    print("Wallet address: $address");

    EtherAmount balance = await ethClient.getBalance(address);

    print(balance.getValueInUnit(EtherUnit.ether));

    await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(
          '0xC914Bb2ba888e3367bcecEb5C2d99DF7C7423706',
        ),
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromInt(EtherUnit.ether, 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await connectWallet();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: Color(0xff6E7B8F),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Color(0xff6E7B8F),
                child: FractionallySizedBox(
                  widthFactor:
                      MediaQuery.of(context).size.width > 600 ? 0.60 : 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png', scale: 1.5),
                      Text(
                        'Aqui você pode desabafar',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'em segurança',
                        style: GoogleFonts.quicksand(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffB8AEE0),
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'Começar agora',
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            await nextScreen();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
