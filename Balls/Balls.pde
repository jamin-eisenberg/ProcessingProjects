ArrayList<Ball> balls;

void setup(){
  size(800, 800);
  
  balls = new ArrayList<Ball>();
  
  for(int i =0; i < 8; i++){
    balls.add(new Ball(color(255, 255, map(i, 0, 10, 0, 255)), new PVector(width/2, 2*height/3), -i*width/20-50, (i/12.0+1)));
  }
}


void draw(){
  background(255);
  
  for(Ball ball : balls){
    ball.draw();
  }
}

class Ball{
  color col;
  PVector center;
  float len;
  float t;
  float period;
  
  Ball(color c, PVector ce, float l, float p){
    col = c;
    center = ce;
    len = l;
    period = p;
    t = 0;
  }
  
  //void update(){
  //  t += speed;
  //}
  
  void draw(){
    pushMatrix();
    
    println(period);
        
    float angle = 2*abs(t/period - floor(t/period+0.5)) * HALF_PI + QUARTER_PI; //(TWO_PI / period / 60) * t;
    
    t+=1/60f;
    
    
    //println(angle % period<1);
    //if(abs(angle % period)>1){
    //  period = -period;
    //}
        
    //if(arm.heading()>-QUARTER_PI || arm.heading() < -3*QUARTER_PI){
    //  speed = -speed;
    //}
    
    PVector pos = PVector.add(center, PVector.fromAngle(angle).mult(len));
    
    translate(pos.x, pos.y);
    stroke(0);
    fill(col);
    circle(0, 0, 20);
    
    popMatrix();
  }
}
