
library consts;

import 'dart:io';

import 'package:flutter/material.dart';

final double ballDiameter = scrX / 24;

final double plankHeight = scrY / 20;
final double plankWidth = scrX / 7;
final double plankDistation = scrY / 6;

final double opponentPlankHeight = scrY / 20;
final double opponentPlankWidth = scrX / 7;
final double opponentPlankDistation = plankDistation - plankHeight;

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

const double plankConst = 75; ////server: 75, client: -75
const double ballXConst = -72;
const double ballYConst = -39;

const double bRange = 10;

double ballSpeed = 1;

double scrX = 799; ////server: 799, client: 732
double scrY = 392; ////server: 392, client: 360

double borB = scrY;
double borR = scrX;

double accelerometerMax = 8;

Color backgroundColor = Colors.teal;

bool isClient = true; ////
InternetAddress ip;
InternetAddress ipOther;

double scrXOther = 0;
double scrYOther = 0;
