import java.util.Stack;

final int BOX_SIZE = 74;
final boolean follow = true; 

Box[] boxes = new Box[100];
int pointer = 0;

boolean inputting;

Stack<Integer> open;

String code = "++++++++++ [->+++>+++++++>++++++++++>+++++++++++>++++++++++++ <<<<<]>> +++ .< ++ .>>> ++ .< +++++  .> ++++ .> + .<<<< .>>> .< - .--- .<< .>> + .> ----- ..--- .<<< + .";
//String code;

int codeI = 0;

void setup() {
  
  //code = loadStrings(dataPath("triangle.txt")).join("");
  
  size(1295, 200);

  open = new Stack<Integer>();

  for (int i = 0; i < boxes.length; i++) {
    boxes[i] = new Box(i);
  }
  
  //frameRate(10);
}

void draw() {

  if (codeI < code.length() && !inputting)
    handleChar(code.charAt(codeI++));

  background(255);

  translate(0, height / 2);

  pushMatrix();

  if (follow)
    translate(-boxes[pointer].pos*3*BOX_SIZE + width / 2, 0);
  else
    translate(1.5*BOX_SIZE, 0);

  for (Box box : boxes) {
    box.draw(false);
  }

  boxes[pointer].draw(true);

  popMatrix();
}

void handleChar(char ch) {
  switch(ch) {
  case '<':
    pointer = constrain(pointer - 1, 0, boxes.length - 1);
    break;
  case '>':
    pointer = constrain(pointer + 1, 0, boxes.length - 1);
    break;
  case '+':
    boxes[pointer].inc();
    break;
  case '-':
    boxes[pointer].dec();
    break;
  case '.':
    print(boxes[pointer].getOut());
    break;
  case ',':
    inputting = true;
    boxes[pointer].contents = 0;
    break;
  case '[':
    if (boxes[pointer].contents == 0) {
      int currOpen = 1;
      codeI++;
      while (currOpen > 0) {
        if (code.charAt(codeI) == '[') { 
          currOpen++;
        } else if (code.charAt(codeI) == ']') {
          currOpen--;
        }
        codeI++;
      }
    } else {
      open.push(codeI);
    }
    break;
  case ']':
    codeI = open.pop() - 1;
    break;
  }
}

void keyPressed() {
  if (inputting) {
    if (key >= '0' && key <= '9') {
      boxes[pointer].contents = boxes[pointer].contents*10 + (key - '0');
    } else if (keyCode == ENTER) {
      inputting = false;
    }
  } else {
    if (key == CODED) {
      if (keyCode == LEFT) handleChar('<');
      else if (keyCode == RIGHT) handleChar('>');
      else if (keyCode == UP) handleChar('+');
      else if (keyCode == DOWN) handleChar('-');
    } else if ("[],.".contains(key + "")) {
      handleChar(key);
    }
  }
}
