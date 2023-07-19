
ArrayList<Line> diamond = new ArrayList<Line>();
PVector mouse;
ArrayList<Line> origin = new ArrayList<Line>();
int dir;
final int TURN_SPEED = 2;
final int res = 60;
final int deg = 60;

void setup() {
  size(1600, 800);

  //diamond.add(new Line(new PVector(width / 2, height / 4), new PVector(width*3 / 4, height / 2)));
  //diamond.add(new Line(new PVector(width *3/ 4, height / 2), new PVector(width/2, height*3/4)));
  //diamond.add(new Line(new PVector(width/2, height*3 / 4), new PVector(width/ 4, height / 2)));
  //diamond.add(new Line(new PVector(width / 4, height / 2), new PVector(width/2, height / 4)));
  diamond.add(new Line(new PVector(width/2, 0), new PVector(width/2, height)));
  PVector cent = new PVector(width/4, height/2);
  for (int i = 0; i < 20; i++)
    diamond.add(new Line(PVector.add(cent, PVector.random2D().mult(random(0, width/4))), PVector.add(cent, PVector.random2D().mult(random(0, width/4)))));

}

void draw() {
  background(255);

  if (mouseX < width/2) {
    noCursor();
    origin.clear();
    mouse = new PVector(mouseX, mouseY);

    for (int i = dir - deg/2; i < dir+deg/2; i += deg / res) {
      Line l = new Line(mouse, PVector.add(mouse, PVector.fromAngle(radians(i)).mult(max(width, height)*3)));
      origin.add(l);

      float minL = MAX_INT;
      PVector minEnd = null;
      for (Line obs : diamond) {
        PVector inters = l.intersection(obs);
        if (inters != null)
          l.set_end(inters);
        if (l.lengthSq() < minL) {
          minL = l.lengthSq();
          minEnd = l.get_end();
        }
      }
      l.set_end(minEnd);
    }
    for (Line l : origin) {
      l.draw();
    }
  }
  else{
    cursor();
  }
  for (Line l : diamond) {
    l.draw();
  }
  
  int x = width / 2;
  float pixDist = width/2/res;
  float c = 100000;
  for(Line l : origin){
    //println(l.lengthSq());
    fill(0, 0, map(l.lengthSq(), 0, width*2, 255, 0));
    rect(x, height/2 - (c/2)/l.lengthSq(), pixDist, c/l.lengthSq());
    x += pixDist;
  }
}

void keyPressed() {
  if (keyCode == LEFT) dir -= TURN_SPEED;
  else if (keyCode == RIGHT) dir += TURN_SPEED;
}


class Line {
  PVector start, end;

  Line(PVector _start, PVector _end) {
    start = _start;
    end   = _end;
  }

  void set_start(PVector _start) {
    start = _start;
  }

  void set_end(PVector _end) {
    end = _end;
  }

  PVector get_start() {
    return start;
  }

  PVector get_end() {
    return end;
  }

  float lengthSq() {
    return pow(start.x-end.x, 2) + pow(start.y-end.y, 2);
  }

  void draw() {
    line(start.x, start.y, end.x, end.y);
  }

  PVector intersection(Line two) {
    Line one = this;
    float x1 = one.get_start().x;
    float y1 = one.get_start().y;
    float x2 = one.get_end().x;
    float y2 = one.get_end().y;

    float x3 = two.get_start().x;
    float y3 = two.get_start().y;
    float x4 = two.get_end().x;
    float y4 = two.get_end().y;

    float bx = x2 - x1;
    float by = y2 - y1;
    float dx = x4 - x3;
    float dy = y4 - y3;

    float b_dot_d_perp = bx * dy - by * dx;

    if (b_dot_d_perp == 0) return null;

    float cx = x3 - x1;
    float cy = y3 - y1;

    float t = (cx * dy - cy * dx) / b_dot_d_perp;
    if (t < 0 || t > 1) return null;

    float u = (cx * by - cy * bx) / b_dot_d_perp;
    if (u < 0 || u > 1) return null;

    return new PVector(x1+t*bx, y1+t*by);
  }
}
