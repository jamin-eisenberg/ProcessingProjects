PImage man;
PImage blinkingMan;
long timePressed;

void setup() {
  size(343, 460);
  man = loadImage(dataPath("man.jpg"));
  blinkingMan = loadImage(dataPath("blinkingMan.jpg"));
  fill(0);
  rectMode(CORNERS);
}

void draw() {
  background(0);
  image(man, 0, 0);
  if (mousePressed) {
    image(blinkingMan, 0, 0);
    timePressed = System.currentTimeMillis();
  }
  long elapsedTime = System.currentTimeMillis() - timePressed;
  if (abs(elapsedTime - 10000) < 50) {
    image(blinkingMan, 0, 0);
  }
}
