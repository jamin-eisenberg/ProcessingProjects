int res = 10;
boolean all; 

void setup() {
  size(800, 800);
}

void draw() {
  background(255);

  for (float i = 0; i < TWO_PI; i += (all ? HALF_PI : PI)) {
    pushMatrix();
    translate(width/2, height/2);
    rotate(i);
    translate(-width/2, -height/2);
    for (int x = 0; x <= width/res; x++) {
      line(x*res, 0, 0, height-x*res);
    }
    popMatrix();
  }
}

void mouseClicked() {
  all = !all;
}

void mouseWheel(MouseEvent event) {
  res -= event.getCount();
}
