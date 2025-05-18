import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../data/remote/network/network_service.dart';
import 'how_do_you_feel_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String route = '/Login';

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  TextEditingController textController = TextEditingController();
  final walletAddress = ValueNotifier<String>('');
  final balance = ValueNotifier<String>('');
  final buttonText = ValueNotifier<String>('Conectar à carteira');

  void nextScreen() {
    if (mounted) {
      Navigator.of(context).pushNamed(HowDoYouFeelView.route);
    }
  }

  Future<void> connectWallet() async {
    if (buttonText.value == 'Continuar') {
      nextScreen();
      return;
    }

    buttonText.value = 'Conectando...';

    // var blockchainAddress =
    //     dotenv.env[NetworkEnv.BLOCKCHAINURL.name] ??
    //     'https://9dcf-2804-7f3-480-958c-4b67-6f12-2bd5-5629.ngrok-free.app';

    // var httpClient = Client();
    // var ethClient = Web3Client(blockchainAddress, httpClient);

    // var credentials = EthPrivateKey.fromHex(textController.text);
    // var address = credentials.address;
    // walletAddress.value = address.hex;

    // EtherAmount balanceEth = await ethClient.getBalance(address);

    // balance.value = balanceEth
    //     .getValueInUnit(EtherUnit.ether)
    //     .toStringAsFixed(2);

    buttonText.value = 'Continuar';
  }

  @override
  void initState() {
    super.initState();

    textController.text =
        '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
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
                      SizedBox(height: 70),
                      SizedBox(
                        child: TextFormField(
                          controller: textController,
                          keyboardType: TextInputType.text,
                          maxLength: 255,
                          decoration: InputDecoration(
                            counterText: '',
                            errorStyle: const TextStyle(height: 0),
                            filled: true,
                            fillColor: Color(0xffA4B1C0),
                            hintText: 'Token de autenticação',
                            hintStyle: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Color(0xff6E7B8F),
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: walletAddress,
                        builder: (context, value, _) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Wallet address: $value',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: balance,
                        builder: (context, value, _) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Saldo: $value',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        child: ValueListenableBuilder(
                          valueListenable: buttonText,
                          builder: (context, value, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffB8AEE0),
                                textStyle: const TextStyle(color: Colors.white),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                value,
                                style: GoogleFonts.quicksand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () async {
                                await connectWallet();
                              },
                            );
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
