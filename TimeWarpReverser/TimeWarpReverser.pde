final int SIZE = 300;
int x = 0;

color[] column;

void setup(){  
  PFont f = createFont("Monospaced", SIZE);
  
  fullScreen();
  //size(800, 800);
  textSize(SIZE);
  textFont(f);
  textAlign(CENTER, CENTER);
  fill(255);
  noStroke();
  noCursor();
  
  column = new color[height];
}

void draw(){
  background(0);
  x = constrain(x + 3, 0, width-1);
  
  text("Learn to Program!", 0, 0, width, height);
  
  loadPixels();
  
  for(int y = 0; y < height; y++){
    color init = pixels[y * width + x];
    for(int x = 0; x < width; x++){
      pixels[y * width + x] = init;
    }
  }
    
  updatePixels();
}

void keyPressed(){
  if(key == ' ') x = 0;
}
