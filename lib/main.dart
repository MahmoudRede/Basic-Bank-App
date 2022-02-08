import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkfoundation/Bloc/states.dart';
import 'package:sparkfoundation/CashHelper/cash_helper.dart';
import 'package:sparkfoundation/Components/constants.dart';
import 'package:sparkfoundation/HomeScreen/home_page.dart';
import 'package:sparkfoundation/SplashScreen/splash_screen.dart';
import 'package:sparkfoundation/CustomerScreen/customer_screen.dart';
import 'Bloc/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

   await CashHelper.init();

   checkBool=CashHelper.getBool(key: 'check')!;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>AppCubit()..createData()..createTransferData(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      )
    );
  }
}


