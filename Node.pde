class Node {
 
  Node parent; 
  PVector direction;
  float internode;
  PVector position;
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Node> children = new ArrayList<Node>();
  boolean tip;
  boolean alive;
  float thickness;
  color bark;
  
  Node(Node parent_node) {
    
    parent = parent_node; 
    
    //direction
    float up_weight = 0.3;
    float parent_direction = parent.direction.heading();
    float max_angle = radians(45);
    float angle = random(-max_angle, max_angle);
    PVector up = PVector.fromAngle(-HALF_PI);
    direction = PVector.fromAngle(parent_direction + angle);
    direction.add(up.mult(up_weight)).div(2);   
    
    internode = 20;
    
    // position
    PVector parentPosition = parent.position.copy();
    position = parentPosition.add(direction.setMag(internode));  
    direction.normalize();
    
    //leaves
    for (int i=0; i<2; i++) { //instead of int use float and have the starting value and addition be in the DNA
      leaves.add(new Leaf(this, i));
    }
    
    tip = true;
    alive = true;
    thickness = 3;
    bark = color(82, 43, 22);
    
  }
  Node(PVector pos) { //TREE NODE
    //direction
    direction = PVector.fromAngle(-HALF_PI);
    position = pos;
    //leaves
    tip = true;
    alive = true;
    thickness = 10;
  }
  
  void update() {
    thickness += .05;    // instead of calling update and display recusrively, and having to check for
    internode += .002;   // alive each time, have all the nodes in an array in Tree, and remove dead nodes
                         // frim the array
    
    //update position
    if (!(parent==null)) {    
      PVector parentPosition = parent.position.copy();
      position = parentPosition.add(direction.setMag(internode));  
      direction.normalize();
    }

    
    if (tip && (random(25)<2)) { //&& position.y > 20) { 
      if (position.y < 20) {
        alive = false;
      }
      children.add(new Node(this));
      tip = false;
    }
    
    if ((tip && random(150)<2) && position.y > 20) {
      children.add(new Node(this));        
    }
      
    
    for (Node child : children) {
      if (child.alive) {
        child.update();
      }
      child.display(); 
    }
    for (Leaf leaf : leaves) {
      leaf.update();
    }
  }
  
  void display() {
   if (!(parent==null)) {
     PVector[] coords = get_coords();
     stroke(bark);
     fill(bark);
     beginShape();
     
     
     vertex(coords[0].x, coords[0].y);
     vertex(coords[1].x, coords[1].y);
     vertex(coords[2].x, coords[2].y);
     vertex(coords[3].x, coords[3].y);
     
     endShape(CLOSE);
     
     for (Leaf leaf : leaves) {
       leaf.display();
     }
     

     //fill(255, 0, 0);
     //ellipse(coords[0].x, coords[0].y, 10, 10);
     //fill(0, 255, 0);
     //ellipse(coords[1].x, coords[1].y, 10, 10);
     //fill(0, 0, 255);
     //ellipse(coords[2].x, coords[2].y, 10, 10);
     //fill(0);
     //ellipse(coords[3].x, coords[3].y, 10, 10);       
       
   }
   
   //noStroke();
   //fill(82, 43, 22);
   //ellipse(int(position.x), int(position.y), 10, 10);
   

  }
  
  PVector[] get_coords() { 
  
    PVector[] result = new PVector[4];
    
    PVector parent_position = parent.position.copy();
    PVector parent_direction = parent.direction.copy();
    float parent_thickness = parent.thickness;
    
    PVector A = new PVector(-parent_direction.y, parent_direction.x);
    PVector B = new PVector(parent_direction.y, -parent_direction.x);    
    A.setMag(parent_thickness / 2);
    B.setMag(parent_thickness / 2);   
    
    PVector C = new PVector(-direction.y, direction.x);
    PVector D = new PVector(direction.y, -direction.x);
    C.setMag(thickness / 2);
    D.setMag(thickness / 2);
    
    result[0] = A.add(parent_position);
    result[1] = C.add(position);
    result[2] = D.add(position);
    result[3] = B.add(parent_position);
    
    return result;
  }

}
