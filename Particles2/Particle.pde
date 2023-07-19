class Particle {
  PVector pos, vel, acc;
  ArrayList<PVector> oldPos;
  int historyCount;
  color col;

  float initSize;
  float sizeFactor;

  float initOpacity;
  float opacityFactor;

  Particle(PVector pos, PVector vel, PVector acc, color col, float initSize, float sizeFactor, float initOpacity, float opacityFactor, int historyCount) {
    this.pos = pos.copy();
    this.vel = vel.copy();
    this.acc = acc.copy();
    this.oldPos = new ArrayList<PVector>();
    this.col = col;
    this.initSize = initSize;
    this.sizeFactor = sizeFactor;
    this.initOpacity = initOpacity;
    this.opacityFactor = opacityFactor;
    this.historyCount = historyCount;
  }

  void update() {
    pos.add(vel);
    vel.add(acc);

    oldPos.add(pos.copy());
    if (oldPos.size() > historyCount)
      oldPos.remove(0);
  }

  void draw() {
    noStroke();
    
    float size = initSize;
    float opacity = initOpacity;

    for (int i = oldPos.size() - 1; i >= 0; i--) {
      PVector old = oldPos.get(i);
      fill(col, opacity);
      circle(old.x, old.y, size);
      
      size *= sizeFactor;
      opacity *= opacityFactor;
    }
  }
}
