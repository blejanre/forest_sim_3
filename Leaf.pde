class Leaf {
  
  Node parent;
  int health;
  float radius;
  color young;
  color dead;
  color current;
  PVector direction;
  PVector position;
  float amount;
  float petiole;
  
  Leaf(Node parent_node, int number) {
    parent = parent_node;
    health = 1000;
    radius = 0;
    petiole = 0;
    young = color(95, 180, 110);
    dead = color(250, 250, 160);
    current = young;
    //direction
    int rotation = -90; //could be in the dna (or number could pass the correct value automatically (see comment in Node)
    float parent_direction = parent.direction.heading();
    float max_angle = radians(45);
    float angle = random(1.5*PI+max_angle, 1.5*PI-max_angle) - radians(rotation * number);
    direction = PVector.fromAngle(parent_direction + angle);

    //position
    PVector parent_position = parent.position.copy();
    position = parent_position.add(direction.setMag(20));  
    direction.normalize();
  }
  
  void update() {
    
    if (petiole < 21) {
      petiole += 0.1;
    }
    
    //position
    PVector parent_position = parent.position.copy();
    position = parent_position.add(direction.setMag(petiole + parent.thickness));  
    direction.normalize();
    
    if (health > 0) {
      health -= 1;
      if (radius < random(1, 5)) {
        radius += .08;
      }
    }

    
    
  }
  void display() {
    noStroke();
    current = lerpColor(current, dead, 0.004);
    fill(current);
    if (!(current == dead)) {
      //strokeWeight(2);
      //stroke(current);
      //line(int(parent.position.x), int(parent.position.y),int(position.x), int(position.y));
      
      ellipse(int(position.x), int(position.y), radius*2, radius*2);
    }

  }
}
