import java.util.Stack;
import java.util.Scanner;

class Interpreter{
  String code;
  byte[] mem;
  int pointer;
  Stack<Integer> codeLoopStartIndices;

  Interpreter(String code){
      this(code, 100);
  }

  Interpreter(String code, int size){
    this.code = code;
    this.mem = new byte[size];
    this.pointer = 0;
    this.codeLoopStartIndices = new Stack<Integer>();
  }

  String run(){
    String output = "";

    for(int i = 0; i < code.length(); i++){
      switch(code.charAt(i)){
        case '+':
          mem[pointer]++;
          break;
        case '-':
          mem[pointer]--;
          break;
        case '>':
          pointer++;
          break;
        case '<':
          pointer--;
          break;
        case '[':
            System.out.println(mem[pointer]);
          if(mem[pointer] != 0){
            System.out.println("pushing");
            codeLoopStartIndices.push(i);
          }
          else{
            while(code.charAt(i) != ']'){
                System.out.println(i);
              i++;
            }
            i++;
          }
          break;
        case ']':
          i = codeLoopStartIndices.pop();
          System.out.println(i);
          break;
        case '.':
          System.out.print((char) mem[pointer]);
          //output += (char) (mem[pointer]);
          break;
        case ',':
          mem[pointer] = new Scanner("97").nextByte();
          break;
      }
    }

    return output;
  }
}
