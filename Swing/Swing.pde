import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

Boundary ceiling;

Swinger swinger;

boolean pressed;

void setup() {
  size(500, 500);

  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  ceiling = new Boundary(width / 2, 10, width, 20);

  swinger = new Swinger(width / 2 - 50, height / 2);
}

void draw() {
  background(255);

  box2d.step();

  ceiling.display();
  swinger.display();
}

void keyPressed() {
  if (key == ' ') {
    if (!pressed)
      swinger.grab(ceiling.b);
    pressed = true;
  }
}

void keyReleased() {
  if (key == ' ') {
    swinger.release();
    pressed = false;
  }
}
