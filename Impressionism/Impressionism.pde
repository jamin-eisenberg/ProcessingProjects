import java.util.*;
import processing.video.*;

List<Pixel> cachedPixels;

Capture cam;

void setup() {
  size(640, 480);
  
  cam = new Capture(this, Capture.list()[0]);
  cam.start();
  
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  
  loadPixels();

  List<PVector> picks = new ArrayList<>();
  for (int i = 0; i < 5000; i++) {
    picks.add(new PVector(random(width), random(height)));
  }
  
  cachedPixels = new ArrayList<>();
  for (int i = 0; i < pixels.length; i++) {
    PVector currPixel = new PVector(i % width, i / width);
    PVector closestPick = picks.stream().min((a, b) -> {
      PVector dist1 = PVector.sub(a, currPixel);
      PVector dist2 = PVector.sub(b, currPixel);
      dist1.y *= 3;
      dist2.y *= 3;

      return (int) (dist1.magSq() - dist2.magSq());
    }
    ).get();
    cachedPixels.add(new Pixel(currPixel, closestPick));
  }

  for (int i = 0; i < pixels.length; i++) {
    PVector closestPick = cachedPixels.get(i).closestPick;
    pixels[i] = pixels[(int) (closestPick.x + ((int) closestPick.y * width))];
  }

  updatePixels();
}

void draw() {
  background(0);
  
  if (cam.available()) {
    cam.read();
  }
  image(cam, 0, 0);
  
  loadPixels();
  
  for (int i = 0; i < pixels.length; i++) {
    PVector closestPick = cachedPixels.get(i).closestPick;
    pixels[i] = pixels[(int) (closestPick.x + ((int) closestPick.y * width))];
  }

  updatePixels();
}

class Pixel {
  PVector pos;
  PVector closestPick;
  
  Pixel(PVector pos, PVector closestPick) {
    this.pos = pos;
    this.closestPick = closestPick;
  }
}

//void windowResized() {
//  image(img, 0, 0);
//}
