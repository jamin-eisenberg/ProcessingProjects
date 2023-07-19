
float scrollPos;
float scrollVel;


void setup(){
  size(800, 800);
  
  rectMode(CENTER);
  fill(0);
}

void draw(){
  background(255);
  
  translate(0, -scrollPos);
  
  for(int i = 0; i < 100; i++){
    fill(255 * abs(sin(radians(i * 10))));
    rect(width / 2, i * 50, 400, 20);
  }
  
  scrollPos += scrollVel;
  scrollVel *= 0.98;
}

void mouseDragged(){
  scrollVel = pmouseY - mouseY;
}
