import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:sparkfoundation/Bloc/cubit.dart';
import 'package:sparkfoundation/Components/constants.dart';
import 'package:sparkfoundation/CustomerScreen/customer_screen.dart';
import 'package:sparkfoundation/TransferMoney/transfer_money.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 0.0,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),
        ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*.07,),
          Lottie.asset('assets/images/payment.json'),
          SizedBox(height: MediaQuery.of(context).size.height*.05,),
          MaterialButton(
            minWidth: 300,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            padding: const EdgeInsets.all(22),
            color: mainColor,
            onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (_){
                return const CustomerScreen();
              }));

            },
            child: const Text('View Customers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.04,),
          MaterialButton(
            minWidth: 300,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            padding: const EdgeInsets.all(20),
            color: mainColor,
            onPressed: (){
                AppCubit.get(context).getTransferData(AppCubit.get(context).databaseTransfer);
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return const TransferMoney();
                }));
            },
            child: const Text('Transfers Money',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

        ],
      ),
    );
  }
}
