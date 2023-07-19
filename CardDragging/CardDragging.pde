ArrayList<Image> cards;
char[] suits = {'C', 'D', 'H', 'S'};

void setup(){
  size(800, 800);
  
  cards = new ArrayList<Image>();
  
  for(char suit : suits){
    for(int i = 1; i < 13; i++){
      String n;
      
      if(i == 1) n = "A";
      else if(i == 11) n = "J";
      else if(i == 12) n = "Q";
      else if(i == 13) n = "K";
      else n = Integer.toString(i);
      
      cards.add(new Image(loadImage(dataPath(n + suit + ".png")))); 
    }
  }
  
  cards.get(0).img.resize(100, 100);
  
}

void draw(){
  background(255);
  
  image(cards.get(0).img, cards.get(0).pos.x, cards.get(0).pos.y);
  
  cards.get(0).update();
}

void mouseDragged(){
  cards.get(0).vel.set(new PVector(mouseX - pmouseX, mouseY - pmouseY));
}

class Image{
  PVector pos;
  PVector vel;
  PImage img;
  
  Image(PImage img){
    pos = new PVector();
    vel = new PVector();
    this.img = img;
  }
  
  void update(){
    pos.add(vel);
    vel.mult(0.95);
  }
}
