ArrayList<Hexagon> grid;

void setup() {
  size(800, 800);

  grid = new ArrayList<Hexagon>();
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      grid.add(new Hexagon(j % 2 == 0, i, j, 100));
    }
  }
}

void draw() {
  background(255);
  for (Hexagon h : grid) {
    h.draw();
  }
}
