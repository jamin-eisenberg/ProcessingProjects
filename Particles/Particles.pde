
ArrayList<Particle> particles;

boolean mouseDown;

void setup() {

  size(600, 600);

  particles = new ArrayList<Particle>();
}

void draw(){
  
  background(255);
  
  if(mouseDown){
    PVector curr = new PVector(mouseX, mouseY);
    particles.add(new Particle(curr, PVector.sub(curr, new PVector(pmouseX, pmouseY)).setMag(5), color(50, 100, random(255)), random(10, 50)));
  }
  
  for(Particle p : particles){
    p.update();
    p.draw();
  }
}

void mousePressed(){
  mouseDown = true;
}

void mouseReleased(){
  mouseDown = false;
}
