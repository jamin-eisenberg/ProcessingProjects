
Springy s;
boolean pressed;

void setup() {
  size(600, 600);
  
  s = new Springy();
  
  fill(0);
}

void draw() {
  background(255);
  
  if(pressed){
    s.acc.set(PVector.sub(new PVector(mouseX, mouseY), s.pos)).mult(0.01);
    line(s.pos.x, s.pos.y, mouseX, mouseY);
  }
  
  s.update();
  s.draw();
}

void mousePressed(){
  pressed = true;
}

void mouseReleased(){
  pressed = false;
}

class Springy {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  void update(){
    
    pos.add(vel);
    
    vel.add(acc);
    vel.mult(0.95);
    
  }
  
  void draw(){
    circle(pos.x, pos.y, 20);
  }
}
