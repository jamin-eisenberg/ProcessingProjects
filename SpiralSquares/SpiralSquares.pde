float s = 0.99;

void setup() {
  size(1000, 1000);

  noFill();
}

void draw() {
  background(255);

  translate(width/2, height/2);

  for (float i = 1; i > 0.001; i *= s) {
    scale(s);
    rotate(asin(sqrt(2)/(2*s))-QUARTER_PI);
    drawSquare();
  }
}

void drawSquare() {
  rectMode(CENTER);
  rect(0, 0, width, height);
}

void mouseWheel(MouseEvent e) {
  s = constrain(s + e.getCount()*0.001, 0, 0.999);
}
