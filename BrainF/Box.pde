class Box {
  int contents;
  private int pos;

  public Box(int pos) {
    contents = 0;
    this.pos = pos;
  }

  public void inc() {
    contents = (contents + 1) % 256;
  }

  public void dec() {
    contents--;
    if(contents < 0) contents = 256;
  }

  public char getOut() {
    return (char) contents;
  }

  public void draw(boolean selected) {
    rectMode(CENTER);
    
    if (selected) {
      strokeWeight(5);
      fill(225, 245, 127);
    } else {
      strokeWeight(1);
      fill(240);
    }
    
    rect(3*pos*BOX_SIZE, 0, 3*BOX_SIZE, BOX_SIZE);
    
    strokeWeight(1);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(BOX_SIZE);
    text(contents, 3*pos*BOX_SIZE, -BOX_SIZE/9.0);
    
    textSize(BOX_SIZE/5.0);
    text(pos, 3*pos*BOX_SIZE, BOX_SIZE*2/3);
  }
}
