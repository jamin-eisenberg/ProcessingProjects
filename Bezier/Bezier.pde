PVector p1, p2, p3, p4;
int R = 20;
float t;
ArrayList<PVector> li;

void setup() {
  size(800, 800);
  p1 = new PVector(100, 200);
  p2 = new PVector(150, 100);
  p3 = new PVector(250, 100);
  p4 = new PVector(300, 200);
  
  noFill();
  
  t = 0;
  
  li = new ArrayList<PVector>();
}

void draw() {
  noFill();
  stroke(0);
  strokeWeight(1);
  t = (sin(frameCount / 100.0) + 1) / 2;
  if(t < 0.001) li.clear();
  
  background(255);
  circle(p1.x, p1.y, R);
  circle(p2.x, p2.y, R);
  circle(p3.x, p3.y, R);
  circle(p4.x, p4.y, R);
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);
  line(p3.x, p3.y, p4.x ,p4.y); 
  PVector p12 = PVector.lerp(p1, p2, t);
  PVector p23 = PVector.lerp(p2, p3, t);
  PVector p34 = PVector.lerp(p3, p4, t);
  circle(p12.x, p12.y, R/2);
  circle(p23.x, p23.y, R/2);
  circle(p34.x, p34.y, R/2);
  line(p12.x, p12.y, p23.x, p23.y);
  line(p23.x, p23.y, p34.x, p34.y);
  
  PVector p123 = PVector.lerp(p12, p23, t);
  PVector p234 = PVector.lerp(p23, p34, t);
  circle(p123.x, p123.y, R/4);
  circle(p234.x, p234.y, R/4);
  line(p123.x, p123.y, p234.x, p234.y);
  
  PVector pf = PVector.lerp(p123, p234, t);
  fill(0);
  circle(pf.x, pf.y, R/2);
  
  li.add(pf);
  
  stroke(0, 0, 255);
  strokeWeight(3);
  for(int i = 0; i < li.size() - 1; i++){
    line(li.get(i).x, li.get(i).y, li.get(i+1).x, li.get(i+1).y);
  }
  
}

void keyPressed(){
  if(key == '1') p1.set(mouseX, mouseY);
  if(key == '2') p2.set(mouseX, mouseY);
  if(key == '3') p3.set(mouseX, mouseY);
  if(key == '4') p4.set(mouseX, mouseY);
  li.clear();
}
