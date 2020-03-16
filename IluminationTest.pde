int sphereDetail = 60;
PShape eye;
PShape rose;
PShape skull;

void setup() {
  size(1280, 720, P3D);
  sphereDetail(sphereDetail);
  lights();
  loadModels();
}


void draw() {
  drawSkull();
  drawEyes();
  drawRose();
    
}

void control() {
  if (mousePressed) {
    alternativeLights();
  } else {
    lights();
  }
}

void loadModels(){
  eye = loadShape("assets/eye/eyeball.obj");
  rose = loadShape("assets/rose_alt/rose.obj");
  rose.rotateX(radians(90));
  rose.rotate(radians(-90), 0, 0, 1);
  skull = loadShape("assets/skull/skull.obj");
  skull.rotateX(radians(90));
}

void drawEyes(){
  pushMatrix();
  translate(width/3+150, height/2);
  scale(20, 20, 20);
  shape(eye);
  popMatrix();

  pushMatrix();
  translate(2*width/3-150, height/2);
  scale(20, 20, 20);
  shape(eye);
  popMatrix();
}

void drawRose(){
  pushMatrix();
  translate(width/2+250, height/2);
  scale(8, 8, 8);  
  shape(rose);
  popMatrix();
}

void drawSkull(){
  pushMatrix();
  translate(width/2, height/2+250, -250);
  scale(8, 8, 8);  
  shape(skull);
  popMatrix();
}

void alternativeLights() {
}
