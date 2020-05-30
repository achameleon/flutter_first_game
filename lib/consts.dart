
library consts;

import 'dart:io';

import 'package:flutter/material.dart';

final double ballDiameter = scrX / 24;

final double plankHeight = scrY / 20;
final double plankWidth = scrX / 7;
final double plankDistation = scrY / 6;

final double opponentPlankHeight = scrY / 20;
final double opponentPlankWidth = scrX / 7;
final double opponentPlankDistation = scrY / 10;

const double borT = 0;
const double borL = 0;

const String bounceSound = "bounce.m4a";
const String winSound = "win.m4a";
const String loseSound = "lose.m4a";

const double volumeBounce = 1;
const double volumeWin = 0.4;
const double volumeLose = 0.4;

const int portReceive = 4444;
const int portSend = 4444;

double ballSpeed = 1;

double scrX = 799;
double scrY = 392;

double borB = 392;
double borR = 799;

double accelerometerMax = 8;

Color backgroundColor = Colors.teal;

bool isClient = false;
InternetAddress ip;
InternetAddress ipOther;

double scrXOther = 0;
double scrYOther = 0;
