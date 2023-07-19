Ball ball;
Paddle player;
Paddle bot;

void setup() {
  size(800, 800);
  
  ball = new Ball(new PVector(width / 2, height / 2), 5);
  player = new Paddle(new PVector(width - 10, height / 2 - 50));
  bot = new Paddle(new PVector(0, height / 2 - 50));
}

void draw() {
  background(0);
  fill(255);
  
  ball.update(player);
  ball.draw();
  player.move(new PVector(mouseX, mouseY));
  player.draw();
  bot.move(PVector.sub(ball.pos, new PVector(0, 50)));
  bot.draw();
}

class Ball {
  PVector pos;
  PVector vel;
  
  Ball(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }
  
  Ball(PVector pos, int speed) {
    this(pos, PVector.random2D().mult(speed));
  }
  
  void update(Paddle playerPaddle) {
    if(pos.y < 0 || pos.y > height) {
      vel.y = -vel.y;
    } 
    if (pos.x > width - 10) {
      println(playerPaddle.pos.y, pos.y);
      if(playerPaddle.pos.y < pos.y && playerPaddle.pos.y > pos.y + 100) {
        vel.x = -vel.x;
      } else {
        stop();
      }
    }
    if (pos.x < 10) {
      vel.x = -vel.x;
    }
    pos.add(vel);
  }
  
  void draw() {
    circle(pos.x, pos.y, 10);
  }
}

class Paddle {
  PVector pos;
  
  Paddle(PVector pos) {
    this.pos = pos;
  }
  
  void move(int speed) {
    pos.add(0, speed);
  }
  
  void move(PVector pos) {
    this.pos.y = pos.y;
  }
  
  void draw() {
    rect(pos.x, pos.y, 10, 100);
  }
}
