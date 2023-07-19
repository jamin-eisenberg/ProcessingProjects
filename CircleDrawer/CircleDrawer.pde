
ArrayList<Point> currPoints;
ArrayList<Point> pointBuffer;

ArrayList<Circle> circles;
ArrayList<Circle> circleBuffer;

int circleTimer;

void setup() {
  size(800, 800);

  currPoints = new ArrayList<Point>();
  pointBuffer = new ArrayList<Point>();
  circles = new ArrayList<Circle>();
  circleBuffer = new ArrayList<Circle>();

  noFill();
}

void draw() {
  background(255);

  circleTimer--;

  if (circleTimer < 0 && circleBuffer.size() != 0) {
    pointBuffer.clear();
    circles.add(circleBuffer.remove(0));
  }

  Point point, lastPoint;
  for (int i = 1; i < pointBuffer.size(); i++) {
    point = pointBuffer.get(i);
    lastPoint = pointBuffer.get(i-1);
    line(lastPoint.pos.x, lastPoint.pos.y, point.pos.x, point.pos.y);
  }

  for (int i = 1; i < currPoints.size(); i++) {
    point = currPoints.get(i);
    lastPoint = currPoints.get(i-1);
    line(lastPoint.pos.x, lastPoint.pos.y, point.pos.x, point.pos.y);
  }

  for (Point p : pointBuffer) {
    p.update();
  }

  for (Circle c : circles) {
    c.draw();
  }
}

PVector avg(ArrayList<Point> arr) {
  PVector total = new PVector();

  for (Point p : arr) {
    total.add(p.pos);
  }

  return total.div(arr.size());
}

float avg(ArrayList<Point> arr, PVector center) {
  float total = 0;

  for (Point p : arr) {
    total += PVector.sub(p.pos, center).mag();
  }

  return total / arr.size();
}

void mouseReleased() {
  PVector avgPos = avg(currPoints);
  float avgRad = avg(currPoints, avgPos.copy());

  circleTimer = 90;

  for (Point p : currPoints) {
    p.target = PVector.add(avgPos, (PVector.sub(p.pos, avgPos).setMag(avgRad)));
  }

  pointBuffer = new ArrayList<Point>(currPoints);
  currPoints.clear();
  circleBuffer.add(new Circle(avgPos, (int) avgRad*2));
}

void mouseDragged() {
  currPoints.add(new Point(new PVector(mouseX, mouseY), new PVector(mouseX, mouseY)));
}

void keyPressed() {
  if (key == 'c')
    circles.clear();
}

class Point {
  PVector pos;
  PVector target;

  Point(PVector pos, PVector target) {
    this.pos = pos;
    this.target = target;
  }

  void update() {
    PVector error = PVector.sub(pos, target);
    pos.add(error.mult(-0.05));
  }
}

class Circle {
  PVector pos;
  int radius;

  Circle(PVector p, int r) {
    pos = p;
    radius = r;
  }

  void draw() {
    circle(pos.x, pos.y, radius);
  }
}
