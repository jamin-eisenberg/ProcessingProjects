class Particle{
  PVector pos;
  PVector vel;
  float radius;
  color col;
  
  Particle(PVector p, PVector v, color c, float r){
    pos = p;
    vel = v;
    col = c;
    radius = r;
  }
  
  void update(){
    radius = Math.max(0, radius - 1);
    pos.add(vel);
  }
  
  void draw(){
    noStroke();
    fill(col);
    circle(pos.x, pos.y, radius);
  }
}
