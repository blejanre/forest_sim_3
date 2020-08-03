class Tree {
  
  PVector position;
  Node tree;
  
  Tree() {
    position = new PVector(random(100, 1300), random(500, 700));
    tree = new Node(position);
  }
  
  void update() {
    tree.update();
  }
  
  void display() {
    tree.display();
  }
}
