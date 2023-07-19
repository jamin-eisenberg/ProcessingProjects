class Hexagon {
  boolean a;
  int r, c, size;
  
  Hexagon(boolean a, int r, int c, int size) {
    this.a = a;
    this.r = r;
    this.c = c;
    this.size = size;
  }
  
  void draw() {
    pushMatrix();
    
    float halfA = (a ? 1.0 : 0.0) / 2; 
    translate(halfA + c, sqrt(3) * (halfA + r));
    line(0, 0, size, size);
    
    popMatrix();
  }
}
