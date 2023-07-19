
ArrayList<Particle> particles;

//boolean mouseDown = false;

void setup() {
  size(800, 800);
  
  particles = new ArrayList<Particle>();
}

void draw() {
  background(0);
  
  if(mousePressed){
    particles.add(new Particle(new PVector(mouseX, mouseY), new PVector(), new PVector(0, 0.3), color(255), 20, 0.95, 255, 0.95, 100)); 
  }
    
  ArrayList<Particle> toRemove = new ArrayList<Particle>();
  for(Particle p : particles){
    if(p.pos.x < 0 || p.pos.x > width || p.pos.y < 0 || p.pos.y > height){
      toRemove.add(p);
    }
    p.update();
    p.draw();
  }
  
  for(int i = 0; i < toRemove.size(); i++)
    particles.remove(toRemove.get(i));
}
