import peasy.*;

PeasyCam cam;

ArrayList<Particle> particles;


void setup() {
  size(800, 800, P3D);

  cam = new PeasyCam(this, 200);

  particles = new ArrayList<Particle>();

  float startOffset = 0.01;

  StaticVariableSet<Double> constants = new StaticVariableSet<Double>();
  //constants.set("a", new Double(1.8));
  //constants.set("b", new Double(-0.07));
  //constants.set("d", new Double(1.5));
  //constants.set("m", new Double(0.02));
  
  //constants.set("b", new Double(0.19));
  
  //constants.set("p", new Double(3));
  //constants.set("q", new Double(2.7));
  //constants.set("r", new Double(1.7));
  //constants.set("s", new Double(2));
  //constants.set("e", new Double(9));
  
  constants.set("a", new Double(5));
  constants.set("b", new Double(-10));
  constants.set("c", new Double(-0.38));

  for (int i = 0; i < 50; i++) {
    PVector start = PVector.random3D().mult(startOffset);
    //particles.add(new Particle(start, "a*(x-y)", "-4*a*y+x*z+m*x^3", "-d*a*z+x*y+b*z^2", constants));
    //particles.add(new Particle(start, "-b*x+sin(y)", "-b*y+sin(z)", "-b*z+sin(x)", constants));
    //particles.add(new Particle(start, "y-p*x+q*y*z", "r*y-x*z+z", "s*x*y-e*z", constants));
    particles.add(new Particle(start, "a*x-y*z", "b*y+x*z", "c*z+x*y/3", constants));
  }

  stroke(255);
  //fill(255);
  noFill();

}

void draw() {  
  background(0);

  for (Particle p : particles) {
    p.update();
    p.draw();
  }
}

void keyPressed() {
  for (Particle p : particles) {
    p.update();
  }
}

class Particle {
  final static float RADIUS = 0.5;
  final static float DT = 0.01;
  final static int TRAIL_LEN = 100;

  PVector pos;
  PVector vel;
  ArrayList<PVector> pastPos;
  
  String xExpr, yExpr, zExpr;
  StaticVariableSet<Double> constants;

  Particle(PVector pos, String xExpr, String yExpr, String zExpr, StaticVariableSet<Double> constants) {
    this.pos = pos.copy();
    this.vel = new PVector();
    this.pastPos = new ArrayList<PVector>();
    
    this.xExpr = xExpr;
    this.yExpr = yExpr;
    this.zExpr = zExpr;
    this.constants = constants;
  }

  void update() {
    DoubleEvaluator eval = new DoubleEvaluator();
    
    constants.set("x", new Double(pos.x));
    constants.set("y", new Double(pos.y));
    constants.set("z", new Double(pos.z));
    
    vel.x = (float) (double) eval.evaluate(xExpr, constants);
    vel.y = (float) (double) eval.evaluate(yExpr, constants);
    vel.z = (float) (double) eval.evaluate(zExpr, constants);
    
    vel.mult(DT);

    pos.add(vel);

    pastPos.add(pos.copy());

    if (pastPos.size() >= TRAIL_LEN) {
      pastPos.remove(0);
    }
  }

  void draw() {

    beginShape();
    for (PVector p : pastPos) {
      vertex(p.x, p.y, p.z);
    }
    endShape();

    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    sphere(RADIUS);

    popMatrix();
  }
}
