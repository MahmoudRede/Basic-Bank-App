
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparkfoundation/Bloc/states.dart';
import 'package:sparkfoundation/CashHelper/cash_helper.dart';
import 'package:sparkfoundation/Components/constants.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{


  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  Database ?database;


  void createData() async
  {

     return await openDatabase(
      'bank.db',
      version: 1,
      onCreate: (database,version){
        database.execute(
          'CREATE TABLE bank (id INTEGER PRIMARY KEY , name TEXT, email TEXT , currentBalance TEXT)'
        ).then((value) {
          print('Table Bank Create');
          emit(CreateTableSuccessState());
        }).catchError((error){
          print('Error in Create Table is ${error.toString()}');
          emit(CreateTableErrorState());
        });
      },

      onOpen: (database){
        print('Database Bank Opened');
        emit(OpenDatabaseSuccessState());
      }
    ).then((value) {
      database=value;
      if(checkBool==false){
        checkBool=true;
        insertDate().then((value) {
          CashHelper.setBool(key: 'check', check: checkBool);
        });
        print('Database Bank Created');
        emit(CreateDatabaseSuccessState());
      }
      else{
        getData(database);
        print('Database Bank Created');
        emit(CreateDatabaseSuccessState());
      }
    }).catchError((error){

      print('Error in Create Database is ${error.toString()}');
      emit(CreateDatabaseErrorState());
    });

  }

  List <Map> Customers=[];

  Future insertDate()async{

     return await database?.transaction((txn) async {

       txn.rawInsert(
        'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 1","customer1@gmail.com","${60000}")',

      ).then((value) {
        print('Customer 1 Is Inserted');
        emit(InsertDatabaseSuccessState());
      }).catchError((error){
        print('Error in Insert Customer 1 is ${error.toString()}');
        emit(InsertDatabaseErrorState());
      });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 2","customer2@gmail.com","${40000}")',

       ).then((value) {
         print('Customer 2 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 2 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 3","customer3@gmail.com","${80000}")',

       ).then((value) {
         print('Customer 3 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 3 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 4","customer4@gmail.com","${36000}")',

       ).then((value) {
         print('Customer 4 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 4 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 5","customer5@gmail.com","${22000}")',

       ).then((value) {
         print('Customer 5 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 5 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 6","customer6@gmail.com","${94000}")',

       ).then((value) {
         print('Customer 6 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 6 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 7","customer7@gmail.com","${21000}")',

       ).then((value) {
         print('Customer 7 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 7 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 8","customer8@gmail.com","${65000}")',

       ).then((value) {
         print('Customer 8 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 8 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 9","customer9@gmail.com","${12000}")',

       ).then((value) {
         print('Customer 9 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 9 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

       txn.rawInsert(
         'INSERT INTO bank (name,email,currentBalance) VALUES ("Customer 10","customer10@gmail.com","${71000}")',

       ).then((value) {
         print('Customer 10 Is Inserted');
         emit(InsertDatabaseSuccessState());
       }).catchError((error){
         print('Error in Insert Customer 10 is ${error.toString()}');
         emit(InsertDatabaseErrorState());
       });

    }).then((value) {
      print('Inserted Is Done');
      getData(database);
      emit(InsertDatabaseSuccessState());

    });


  }

  Future <List<Map>?> getData(datebase) async
  {

    Customers=[];
    return await database?.rawQuery(
      'SELECT * FROM bank'
    ).then((value) {
      print('Get Is Done');
      Customers=value;
      print(value[0]['name']);
      emit(GetDatabaseSuccessState());
    }).catchError((error){
      print('Error in Get is ${error.toString()}');
      emit(GetDatabaseErrorState());
    });

  }

   void transferFunction(){

     transferValue=!transferValue;
     emit(ChangeTransferValueState());

   }

   var moneyController=TextEditingController();

  Future updateSender(
  {
  required value,
  required int id,
  })async{

   await database?.rawUpdate(
      'UPDATE bank SET currentBalance = ? WHERE id = ? ',
      ['${value}','${id}']).then((value) {
        emit(UpdateSenderSuccessState());
    }).catchError((error){
      print('Error in Update Sender Is ${error.toString()}');
      emit(UpdateSenderErrorState());
    });

  }

  Future updateReceiver(
      {
        required value,
        required int id,
      })async{

    await database?.rawUpdate(
        'UPDATE bank SET currentBalance = ? WHERE id = ? ',
        ['${value}','${id}']).then((value) {
      getData(database);
      emit(UpdateReceiverSuccessState());
    }).catchError((error){
      print('Error in Update Receiver Is ${error.toString()}');
      emit(UpdateReceiverErrorState());
    });

  }

  Database ?databaseTransfer;


  void createTransferData() async
  {

    return await openDatabase(
        'transfer.db',
        version: 1,
        onCreate: (databaseTransfer,version){
          databaseTransfer.execute(
              'CREATE TABLE transfer (id INTEGER PRIMARY KEY , sender TEXT, receiver TEXT , money TEXT)'
          ).then((value) {
            print('Table Transfer Create');
            emit(CreateTableTransferSuccessState());

          }).catchError((error){
            print('Error in Create Transfer Table is ${error.toString()}');
            emit(CreateTableTransferErrorState());
          });
        },

        onOpen: (databaseTransfer){
          print('Database Transfer Opened');
          emit(OpenTransferSuccessState());
        }
    ).then((value) {
      databaseTransfer=value;
      emit(CreateTransferSuccessState());


    }).catchError((error){

      print('Error in Create Transfer Database is ${error.toString()}');
      emit(CreateTransferErrorState());
    });

  }

  List <Map> moneyTransfer=[];

  Future insertTransferDate(
      {
        required String sender,
        required String receiver,
        required String money,


      }
      )async{

    return await databaseTransfer?.transaction((txn) async {

      txn.rawInsert(
        'INSERT INTO transfer (sender,receiver,money) VALUES ("${sender}","${receiver}","${money}")',

      ).then((value) {
        print('Transfer Is Inserted');
        emit(InsertDatabaseTransferSuccessState());
      }).catchError((error){
        print('Error in Insert Transfer is ${error.toString()}');
        emit(InsertDatabaseTransferErrorState());
      });
    }).then((value) {
      print('Inserted Is Done');
      getTransferData(databaseTransfer);
      emit(InsertDatabaseTransferSuccessState());

    });


  }

  Future <List<Map>?> getTransferData(datebaseTransfer) async
  {

    moneyTransfer=[];
    return await databaseTransfer?.rawQuery(
        'SELECT * FROM transfer'
    ).then((value) {
      print('Get Is Done');
      moneyTransfer=value;
      print(value[0]['money']);
      emit(GetDatabaseTransferSuccessState());
    }).catchError((error){
      print('Error in Get Transfer Database is ${error.toString()}');
      emit(GetDatabaseTransferErrorState());
    });

  }

}
