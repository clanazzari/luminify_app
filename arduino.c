#include <SoftwareSerial.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
SoftwareSerial Bluetooth(0, 1); // RX, TX

String color;
const int YELLOW = 6;
const int WHITE = 5;
const int RED = 9;
const int GREEN = 10;
const int BLUE = 11;

void setup() {
  Serial.begin(9600);
  Serial.println("Lets get started");
  analogWrite(BLUE, 0);
  analogWrite(RED, 0);
  analogWrite(GREEN, 0);
  analogWrite(YELLOW, 0);
  analogWrite(WHITE, 255);
}

void loop() {

  if (Serial.available()) {
    color=Serial.readString();
    analogWrite(RED, strtol(color.substring(0,2).c_str(), NULL, 16));
    analogWrite(GREEN, strtol(color.substring(2,4).c_str(), NULL, 16));
    analogWrite(BLUE, strtol(color.substring(4,6).c_str(), NULL, 16));
    analogWrite(WHITE, strtol(color.substring(6,8).c_str(), NULL, 16));
    analogWrite(YELLOW, strtol(color.substring(8,10).c_str(), NULL, 16));
    Serial.println("Received Color:");
    Serial.println(color);
  }
}
