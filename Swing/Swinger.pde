// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Swinger {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  
  color col;
  
  DistanceJoint dj;
  
  Swinger(float x, float y) {
    r = 8;
    
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;
    
    // Attach fixture to body
    body.createFixture(fd);
    //body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));

    col = color(175);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,r*2,r*2);
    // Let's add a line so we can see the rotation
    line(0,0,r,0);
    popMatrix();
  }

  void grab(Body b){
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = body;
    djd.bodyB = b;
    Vec2 v = box2d.getBodyPixelCoord(body).sub(box2d.getBodyPixelCoord(b));
    //djd.length = sqrt(v.x*v.x + v.y*v.y);
    djd.length = 10;
    djd.frequencyHz = 0;
    
    dj = (DistanceJoint) box2d.world.createJoint(djd);
  }
  
  void release(){
    box2d.world.destroyJoint(dj);
  }
}
