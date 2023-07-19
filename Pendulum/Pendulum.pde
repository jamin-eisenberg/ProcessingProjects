
final float G = 0.5;

Pend p;
ArrayList<AfterImage> ais;

void setup() {
  size(800, 800);

  p = new Pend(new PVector(width / 2, height / 2), degrees(140), 350);
  ais = new ArrayList<AfterImage>();
}

void draw() {
  background(0, 200);

  for (AfterImage ai : ais) {
    ai.update();
    ai.draw();
  }

  for (int i = 0; i < ais.size(); i++) {
    if (ais.get(i).radius == 0) ais.remove(i);
  }

  p.update();
  p.draw();
}

void mouseReleased() {
  PVector curr = new PVector(mouseX, mouseY);
  p.ang = PVector.sub(p.pos, curr).heading() + HALF_PI;
  p.angVel = radians(PVector.sub( new PVector(pmouseX, pmouseY), curr).mag());

  ais.clear();
}

class Pend {
  PVector pos;
  int len;
  float ang;
  float angVel;
  float angAcc;

  Pend(PVector pos, float ang, int len) {
    this.pos = pos;
    this.ang = ang;
    this.len = len;
  }

  void update() {
    angAcc = -G/len*sin(ang);
    angVel += angAcc;
    ang += angVel;
  }

  void draw() {
    stroke(255);
    PVector end = PVector.add(pos, PVector.fromAngle(ang).rotate(HALF_PI).mult(len));
    line(pos.x, pos.y, end.x, end.y);
    circle(end.x, end.y, 20);

    ais.add(new AfterImage(end));
  }
}

class AfterImage {
  PVector pos;
  float radius = 20;

  AfterImage(PVector p) {
    pos = p.copy();
  }

  void update() {
    radius = Math.max(radius - 0.2, 0);
  }

  void draw() {
    fill(255);
    circle(pos.x, pos.y, radius);
  }
}
