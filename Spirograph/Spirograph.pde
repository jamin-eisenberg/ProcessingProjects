float R = width*4;
float l = 0.5;
float k = 0.3;
float t = 0;
float x, y;
int iterations = 10000;
float res = 0.1;

ArrayList<PVector> points;

void setup() {
  size(800, 800);
  points = new ArrayList<PVector>();
}

void draw() {
  background(255);

  if (pmouseX != mouseX || pmouseY != mouseY) {
    k = map(mouseX, 0, width, 0, 1);
    l = map(mouseY, 0, height, 0, 1);
    
    points.clear();
    PVector first = new PVector(1-k + l*k, 0).mult(R);
    int i;
    for (i = 1; i < iterations; i++) {
      t = i * res;
      x = R*((1-k)*cos(t) + l*k*cos((t-t*k)/k));
      y = R*((1-k)*sin(t) - l*k*sin((t-t*k)/k));
      if (abs(first.x - x) < 1 && abs(first.y - y) < 1)
        break;
      points.add(new PVector(x, y));
    }
  }

  translate(width/2, height/2);

  PVector prev = null;
  for (PVector p : points) {
    if (prev != null) line(prev.x, prev.y, p.x, p.y);
    prev = p.copy();
  }
}


//void keyPressed(){
//  if(keyCode == LEFT) l -= 0.01;
//  else if (keyCode == RIGHT) l += 0.01;
//  else if (keyCode == DOWN) k -= 0.01;
//  else if (keyCode == UP) k += 0.01;

//  l = constrain(l, 0, 1);
//  k = constrain(k, 0, 1);
//}
