
int max_iteration = 100;
float xMin = -2.5;
float xMax = 1;
float yMin = -1;
float yMax = 1;

PVector origin = new PVector(1, 1);
PVector scale = new PVector(1, 1);

void setup() {
  size(1200, 800);
  
  colorMode(HSB);
}

void draw() {
  background(0);
  
  mandelbrot();
    
}

void mouseWheel(MouseEvent e){
  float scaledMX = map(mouseX, 0, width, xMin, xMax);
  float scaledMY = map(mouseY, 0, height, yMin, yMax);
  
  int count = e.getCount();
  xMin *= 1 + (count * 0.1);
  xMax *= 1 + (count * 0.1);
  
  yMin *= 1 + (count * 0.1);
  yMax *= 1 + (count * 0.1);
}

void mouseDragged(){
  xMin += (pmouseX - mouseX) * 0.01;
  xMax += (pmouseX - mouseX) * 0.01;
  
  yMin += (pmouseY - mouseY) * 0.01;
  yMax += (pmouseY - mouseY) * 0.01;
  
  //xMin += map(pmouseX - mouseX, 0, width, xMin, xMax);
  //println(map(pmouseX, 0, width, xMin, xMax) - map(mouseX, 0, width, xMin, xMax));
  //xMax += map(pmouseX - mouseX, 0, width, xMin, xMax);
  //yMin += map(pmouseY - mouseY, 0, height, yMin, yMax);
  //yMax += map(pmouseY - mouseY, 0, height, yMin, yMax);
}

void mandelbrot(){
  loadPixels();
  
  for(int i = 0; i < pixels.length; i++){
    float x0 = map(i % width, 0, width, xMin, xMax);
    float y0 = map(i / width, 0, height, yMin, yMax);
    float x = 0;
    float y = 0;
    float iteration = 0;
    while(x*x + y*y <= 4 && iteration < max_iteration){
      float xtemp = x*x - y*y + x0;
      y = 2*x*y + y0;
      x = xtemp;
      iteration++;
    }
    iteration = iteration + 1 - log(log(abs(x*x+y*y)) / log(2));
    
    pixels[i] = color((int) (255 * iteration / max_iteration), 255, iteration < max_iteration ? 255 : 0);
  }
  
  updatePixels();
}
