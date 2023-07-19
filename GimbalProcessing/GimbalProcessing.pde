import processing.serial.*;

Serial serial;

void setup() {
  size(800, 800);
  serial = new Serial(this, Serial.list()[0], 115200);
}

void draw() {
  if (mousePressed) {
    serial.write("X" + mouseX + "Y" + mouseY + "\n");        
  }
}

void serialEvent(Serial s){
  String rcv = s.readStringUntil('\n');
  if(rcv != null)
    println(rcv);
}
