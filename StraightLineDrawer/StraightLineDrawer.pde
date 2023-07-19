
ArrayList<PVector> currPoints;
boolean mouseDown;

ArrayList<PVector> lineStarts;
ArrayList<PVector> lineEnds;


void setup() {
  size(500, 500);

  currPoints = new ArrayList<PVector>();
  lineStarts = new ArrayList<PVector>();
  lineEnds = new ArrayList<PVector>();
}

void draw() {
  background(255);

  PVector point, lastPoint;
  for (int i = 1; i < currPoints.size(); i++) {
    point = currPoints.get(i);
    lastPoint = currPoints.get(i-1);
    line(lastPoint.x, lastPoint.y, point.x, point.y);
  }

  for (int i = 0; i < lineStarts.size(); i++) {
    line(lineStarts.get(i).x, lineStarts.get(i).y, lineEnds.get(i).x, lineEnds.get(i).y);
  }
}

void mouseDragged() {
  currPoints.add(new PVector(mouseX, mouseY));
}


void mouseReleased() {
  PVector avg = avg(currPoints);

  ArrayList<PVector> slopes = new ArrayList<PVector>();

  for (int i = 0; i < currPoints.size() - 1; i++) {
    slopes.add(PVector.sub(currPoints.get(i), currPoints.get(i + 1)));
  }

  PVector avgSlope = avg(slopes).mult(100);

  lineStarts.add(PVector.sub(avg, avgSlope));
  lineEnds.add(PVector.add(avg, avgSlope));

  currPoints.clear();
}

PVector avg(ArrayList<PVector> arr) {
  PVector total = new PVector();

  for (PVector p : arr) {
    total.add(p);
  }

  return total.mult(1.0/arr.size());
}

void keyPressed() {
  if (key == 'c') {
    lineStarts.clear();
    lineEnds.clear();
  }
}
