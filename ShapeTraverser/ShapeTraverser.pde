
ArrayList<Shape> shapes;

int count;
boolean connectors = true;
float speed;

color[] colors = {color(255, 0, 0), color(255, 127, 0), color(255, 255, 0), color(0, 255, 0), color(0, 0, 255), color(255, 0, 255)};

void setup() {
  size(800, 800);

  shapes = new ArrayList<Shape>();
  for (int i = 0; i < 20; i++) {
    shapes.add(new Shape(colors[i % 6], new PVector(width / 2, height / 2), 50 + 25*i, i + 2));
  }
}

void draw() {
  background(255);

  fill(0);
  textSize(30);
  text(count, 0, 30);


  PVector prev = shapes.get(0).dotPos();

  int updated = 0;
  for (int i = 0; i < shapes.size(); i++) {
    Shape s = shapes.get(i);
    int u = s.update();
    if (u != 0) {
      updated = u;
    }

    PVector curr = s.dotPos();

    s.draw();

    stroke(color(0, 100));

    if (connectors)
      line(curr.x, curr.y, prev.x, prev.y);

    prev = curr;
  }

  count += updated;
}


void keyPressed() {
  if (key == ' ') connectors = !connectors;
}

void mouseWheel(MouseEvent e) {
  speed += e.getCount() * 0.01;
}

class Line {
  PVector start;
  PVector end;
  float fraction;

  Line(PVector start, PVector end) {
    this.start = start.copy();
    this.end = end.copy();
  }

  PVector dotPos(float fraction) {
    return PVector.add(start, PVector.sub(end, start).mult(fraction));
  }

  void draw(boolean dot, float fraction) {
    line(start.x, start.y, end.x, end.y);

    push();

    if (dot) {
      fill(0);
      stroke(0);

      PVector pt = dotPos(fraction);
      circle(pt.x, pt.y, 10);
    }

    pop();
  }
}

class Shape {
  PVector pos;
  Line[] lines;
  color col;
  int active;
  float fraction;

  Shape(color col, PVector pos, float radius, int numSides) {
    this.col = col;
    this.pos = pos.copy();
    lines = new Line[numSides];

    PVector r = new PVector(0, -radius);
    PVector prev = PVector.add(pos, r);
    PVector end;
    for (int i = 0; i < numSides; i++) {
      r.rotate(TWO_PI / numSides);
      end = PVector.add(pos, r);
      lines[i] = new Line(prev, end);
      prev = end.copy();
    }

    active = 0;
  }

  PVector dotPos() {
    return lines[active].dotPos(fraction);
  }

  int update() {
    fraction += speed;
    if (fraction > 1) {
      fraction = 0;
      active = (active + 1) % lines.length;
      return 1;
    } else if (fraction < -1) {
      fraction = 0;
      active = (((active-1 % lines.length) + lines.length) % lines.length);// Math.floorMod((active - 1), lines.length);
      return -1;
    }
    return 0;
  }

  void draw() {
    stroke(col);

    for (Line line : lines) {
      line.draw(line == lines[active], fraction < 0 ? 1+ fraction : fraction);
    }
  }
}
