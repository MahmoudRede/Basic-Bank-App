import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkfoundation/Bloc/cubit.dart';
import 'package:sparkfoundation/Bloc/states.dart';
import 'package:sparkfoundation/Components/constants.dart';

class TransferMoney extends StatelessWidget {
  const TransferMoney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text( 'Transfers Money',style:TextStyle(
                color: mainColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            ),
            backwardsCompatibility: false,
            iconTheme: IconThemeData(
                color: mainColor
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return itemBlock(AppCubit.get(context).moneyTransfer[index],context);
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 0,);
                      },
                      itemCount:AppCubit.get(context).moneyTransfer.length
                  ),
                ),
              ],
            ),
          ),
        );
    },
    );
  }
}


Widget itemBlock(model,context){
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),

    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('From :',style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 10,),
                    Text('${model['sender']}',style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('To :',style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 10,),
                    Text('${model['receiver']}',style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Money Transfer :',style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                    const SizedBox(width: 10,),
                    Text('${model['money']}',style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ],
            ) ,
            const Spacer(),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/bag.png'),
            )
          ],
        ),
      ],
    ),
  );

}