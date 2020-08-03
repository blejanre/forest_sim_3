// Version 3 of the forest simulation. Starting simpler for debugging purposes
// build it up from there. 2D. 


Tree ben = new Tree();
Tree zoe = new Tree();
  


void setup() {
  size(1400, 700);
  



}

void draw() {
  
  //sky
  background(212, 223, 217);
  
  //ground
  noStroke();
  fill(52, 32, 29);
  int a = 2;  // a/b is the fraction of the screen the ground occupies
  int b = 3;
  rect(0, a*height/b, width, (b-a)*height/b +1);
  
  ben.update();
  zoe.update();
  ben.display();
  zoe.display();

}
