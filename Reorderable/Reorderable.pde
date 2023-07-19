
class Orderable {
  ArrayList<Item> items;
  PVector itemSize;
  PVector pos;
  int selected;

  Orderable(ArrayList<String> items, PVector pos, PVector itemSize) {
    this.items = new ArrayList<Item>();
    this.pos = pos.copy();
    PVector itemPos = pos.copy();
    for (String i : items) {
      this.items.add(new Item(itemPos, i));
    }
    this.itemSize = itemSize.copy();
    selected = -1;
  }

  void draw() {
    pushMatrix();
    stroke(0);
    for (Item i : items) {
      i.draw();
      translate(0, itemSize.y);
    }
    popMatrix();
    if (selected >= 0) {
      pushMatrix();
      translate(0, itemSize.y * selected);
      stroke(255, 0, 0);
      items.get(selected).draw();
      popMatrix();
    }
  }

  void swap(int i1) {
    int i2 = selected;
    Item temp = items.get(i1);
    items.set(i1, items.get(i2));
    items.set(i2, temp);
    selected = i1;
  }

  void move(int newI) {
    items.add(newI, items.remove(selected));
    selected = newI;
  }
  
  int getIndexFromPos(PVector p){
    if (p.x > pos.x && p.x < pos.x + itemSize.x && p.y > pos.y && p.y < pos.y + itemSize.y*items.size()) {
      return ((int) (p.y - pos.y)) / ((int) itemSize.y);
    }
    return -1;
  }

  void selectAtPos(PVector p) {
    selected = getIndexFromPos(p);
  }

  void selectRel(int shiftAmount) {
    selected += shiftAmount;
    selected = constrain(selected, 0, items.size() - 1);
  }

  class Item {
    PVector pos;
    String text;

    Item(PVector pos, String text) {
      this.pos = pos.copy();
      this.text = text;
    }

    void draw() {
      strokeWeight(2);
      fill(210);
      rect(pos.x, pos.y, itemSize.x, itemSize.y);
      fill(0);
      text(text, pos.x + itemSize.x/2, pos.y + itemSize.y/2);
    }
  }
}

Orderable o;

void setup() {
  size(500, 500);
  ArrayList<String> items = new ArrayList<String>();
  items.add("hi");
  items.add("bye");
  items.add("peace");
  o = new Orderable(items, new PVector(), new PVector(width, height / 3));
}

void draw() {
  background(255);
  o.draw();
}

void mousePressed() {
  o.selectAtPos(new PVector(mouseX, mouseY));
}

void mouseReleased(){
  o.move(o.getIndexFromPos(new PVector(mouseX, mouseY)));
}

void keyPressed() {
  if (key == CODED && (keyCode == UP || keyCode == DOWN)) {
    o.selectRel(keyCode == UP ? -1 : 1);
  }
}
