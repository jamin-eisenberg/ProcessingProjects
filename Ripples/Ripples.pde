import java.util.*;
import java.util.stream.*;


ArrayList<Ripple> ripples;

void setup() {
  size(800, 800);

  ripples = new ArrayList<>();
}

void draw() {
  background(255);
  noFill();
  List<Ripple> toDelete = new ArrayList<>();
  for (Ripple r : ripples) {
    if(!r.update()) {
      toDelete.add(r);
    }
    r.draw();
  }
  for (Ripple r : toDelete) {
    ripples.remove(r);
  }
}

void mouseClicked() {
  ripples.add(new Ripple(new PVector(mouseX, mouseY)));
}

void mouseDragged() {
  ripples.add(new Ripple(new PVector(mouseX, mouseY)));
}

class Ripple {
  PVector origin;
  List<Integer> radii;
  int liveCounter;
  double waveMag;

  Ripple(PVector origin) {
    this.origin = origin;
    this.radii = new ArrayList(List.of(1));
  }

  boolean update() {
    this.radii = this.radii.stream().map(r -> r + 1).filter(r -> r < 255).collect(Collectors.toList());
    liveCounter++;
    if (waveMag > 1 && liveCounter < 255) {
      this.radii.add(1);
      waveMag = 0;
    }
    if (liveCounter % 2 == 0) {
      waveMag += Math.pow(sin(liveCounter), 2);
    }
    
    return liveCounter < 255 * 2;
  }

  void draw() {
    for (Integer radius : radii) {
      stroke(0, 0, 0, 255 - radius);
      circle(origin.x, origin.y, radius);
    }
  }
}
