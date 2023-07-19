
PVector goal;
ArrayList<PVector> population;
final int POP_SIZE = 100;

void setup(){
   size(800, 800);
   
   goal = new PVector(width/2, height / 5);
   
   population = new ArrayList();
   for(int i = 0; i < POP_SIZE; i++){
     population.add(new PVector(width / 4, 4*height / 5));
   }
}

void draw(){
  background(255);
  
  stroke(0);
  fill(255, 0, 0);
  circle(goal.x, goal.y, 20);
  
  stroke(0, 0, 255);
  for(PVector p : population){
    point(p.x, p.y);
  }
}

class Individual{
  ArrayList<PVector> genes;
  
  Individual mate(Individual other){
    
  }
}
  
