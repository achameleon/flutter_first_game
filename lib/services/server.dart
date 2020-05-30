
import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'package:flutterflamegame/consts.dart';

class Server {

  static StreamSubscription subscriptionData;
  static RawDatagramSocket socketData;
  Function processData;

  Server(Function processData) {
    initData(portReceive);
    this.processData = processData;
  }

  void initData(int port) {
    Datagram datagram;
    String dataReceived = '';
    RawDatagramSocket.bind(InternetAddress.anyIPv4, port)
      .then((RawDatagramSocket socket) {
        socketData = socket;
        subscriptionData = socketData.listen((RawSocketEvent event) {
          datagram = socketData.receive();
          if (datagram == null) return;
          dataReceived = String.fromCharCodes(datagram.data);
          processData(dataReceived);
        });
    });
  }

  static void sendData(String data, InternetAddress ipO, int port) {
    if (ipO == null) return;
    socketData?.send(data.codeUnits, ipO, port);
  }

}