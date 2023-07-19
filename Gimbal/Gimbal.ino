#include <AccelStepper.h>

#define HALFSTEP 8

#define xPin1  2
#define xPin2  3
#define xPin3  4
#define xPin4  5

#define yPin1  8
#define yPin2  9
#define yPin3  10
#define yPin4  11

AccelStepper xStepper(HALFSTEP, xPin1, xPin3, xPin2, xPin4);
AccelStepper yStepper(HALFSTEP, yPin1, yPin3, yPin2, yPin4);

String val;

int yIndex;
String xStr, yStr;

bool charsAlphaNumeric(String s) {
  for (int i = 0; i < s.length(); i++) {
    if ((s[i] < '0' || s[i] > '9') && s[i] != 'X' && s[i] != 'Y' && s[i] != '\n' && s[i] != '\r' && s[i] != '-') {
      Serial.println(s[i]);
      return false;
    }
  }
  return true;
}

void setup() {
  xStepper.setMaxSpeed(1000);
  xStepper.setAcceleration(1000);
  xStepper.setSpeed(1000);

  yStepper.setMaxSpeed(1000);
  yStepper.setAcceleration(1000);
  yStepper.setSpeed(1000);

  Serial.begin(57600);
}

void loop() {
  if (Serial.available())
  { // If data is available to read,
    val = Serial.readStringUntil('\n');

    yIndex = val.indexOf('Y');
    if (val[0] == 'X' && yIndex > -1 && charsAlphaNumeric(val)) {
      xStr = val.substring(1, yIndex);
      yStr = val.substring(yIndex + 1);
      xStepper.moveTo(xStr.toInt());
      yStepper.moveTo(yStr.toInt());
    }
    else {
      Serial.println("invalid");
    }

    Serial.print(val);
    Serial.print("\t\t");
    Serial.print(xStepper.targetPosition());
    Serial.print("\t");
    Serial.println(yStepper.targetPosition());
  }



  //  delay(10); // Wait 10 milliseconds for next reading

  xStepper.run();
  yStepper.run();
}
