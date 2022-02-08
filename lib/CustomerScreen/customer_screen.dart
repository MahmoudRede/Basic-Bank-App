import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkfoundation/Bloc/cubit.dart';
import 'package:sparkfoundation/Bloc/states.dart';
import 'package:sparkfoundation/Components/constants.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text( 'All Customers',style:TextStyle(
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
            body: AppCubit.get(context).Customers.isNotEmpty?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.03,),
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index) => customerItem(AppCubit.get(context).Customers[index],context),
                            separatorBuilder: (context,index){
                              return SizedBox(height: MediaQuery.of(context).size.height*.0,);
                            },
                            itemCount: AppCubit.get(context).Customers.length
                        ),
                      ),
                    ],
                  )
                 :const Center(
                   child: CircularProgressIndicator(),
                 ),
          );

    },
    );
  }
}

Widget customerItem(Map model,context){
  return InkWell(
    onTap: (){

      if(transferValue==false){

        sender='${model['name']}';
        senderId=model['id'];
        senderValue='${model['currentBalance']}';

        showDialog(context: context, builder: (_){
          return AlertDialog(
            content: SizedBox(
              height:280,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: AssetImage('assets/images/customer.png'),
                    ),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  Row(
                    children:  [
                      const SizedBox(width: 10,),
                       Text('name :',style: TextStyle(
                          color: mainColor,
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(width: 15,),
                      Text('${model['name']}',style: const TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold
                      ),),

                    ],
                  ),

                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    child: Row(
                      children: [
                        Text('Current Balance : ',style: TextStyle(
                            color: mainColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        Text('${model['currentBalance']}',style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*.04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(15),
                        color: Colors.red,
                        child: const Text('Back',style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: (){
                          AppCubit.get(context).transferFunction();
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 25,),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(14),
                        color: mainColor,
                        child: const Text('Transfer To',style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: (){
                          AppCubit.get(context).transferFunction();
                          Navigator.pop(context);
                        },
                      ),


                    ],
                  )
                ],
              ),

            ),
          );
        });
      }
      else{

        receiver='${model['name']}';
        receiverId=model['id'];
        receiverValue='${model['currentBalance']}';
        showDialog(context: context, builder: (_){
          return AlertDialog(
            title: Container(
              margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.all(20),
              color: mainColor,
              child: const Text(
                'Transfer Money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),

              ),),
            content: SizedBox(
              height: 285,
              child: Column(
                children: [
                  Row(
                    children: [
                       Text('From :',style: TextStyle(
                        fontSize: 17,
                        color: mainColor
                      ),),
                      Text('${sender}',style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),),

                    ],
                  ) ,
                  SizedBox(height: MediaQuery.of(context).size.height*.015,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        Text('Current Balance : ',style: TextStyle(
                            color: mainColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        Text('${senderValue}',style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Row(
                    children: [
                       Text('to :',style: TextStyle(
                        fontSize: 17,
                        color: mainColor,

                      ),),
                      Text('${receiver}',style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ) ,
                  SizedBox(height: MediaQuery.of(context).size.height*.015,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Row(
                      children: [
                        Text('Current Balance : ',style: TextStyle(
                            color: mainColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        Text('${receiverValue}',style: const TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                            fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*.01,),
                  TextFormField(
                    decoration:  InputDecoration(
                      hintText: 'Enter Money Transfer',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      ),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: AppCubit.get(context).moneyController,
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(15),
                        color: Colors.red,
                        child: const Text('Back',style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*.06,),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.all(15),
                        color: mainColor,
                        child: const Text('Transfer',style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),),
                        onPressed: (){
                          senderNewValue= num.parse(senderValue) - num.parse(AppCubit.get(context).moneyController.text);
                          receiverNewValue= num.parse(receiverValue) + num.parse(AppCubit.get(context).moneyController.text);
                          AppCubit.get(context).transferFunction();
                          AppCubit.get(context).updateSender(value: '${senderNewValue}', id: senderId!).then((value) {
                            AppCubit.get(context).updateReceiver(value: '${receiverNewValue}', id: receiverId!).then((value) {
                              Navigator.pop(context);
                            }).then((value) {
                              AppCubit.get(context).insertTransferDate(sender: '${sender}', receiver: '${receiver}', money: '${AppCubit.get(context).moneyController.text}').then((value) {
                                AppCubit.get(context).moneyController.clear();
                              });
                            });
                          });

                        },
                      ),
                    ],
                  ),
                ],
              ),

            ),
          );
        });

      }
    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xff5569cd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children:  [
                const SizedBox(width: 10,),
                const Image(
                  image: AssetImage('assets/images/customer.png'),
                  height: 70,
                  width: 70,
                ),
                const SizedBox(width: 15,),
                const Text('name : ',style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
                Text('${model['name']}',style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: Row(
              children:  [
                const Text('Email : ',style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
                Text('${model['email']}',style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
            child: Row(
              children: [
                const Text('Current Balance : ',style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
                Text('${model['currentBalance']}',style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
              ],
            ),
          ),

        ],
      ),
    ),
  );

}


