import queasycam.*;

QueasyCam cam;

int sphereDetail = 60;
PShape eye;
PShape rose;
PShape skull;

float eyeScaleMax;
float eyeScaleMin;
float eyeScaleCurrent = eyeScaleMax;
boolean increasing = false;

void setup() {
  size(1280, 720, P3D);
  
  eyeScaleMax = 20;
  eyeScaleMin = 10;
  
  sphereDetail(sphereDetail);
  
  loadModels();
  
  //cam = new QueasyCam(this);
  //cam.position = new PVector(width/2, height/2, 500);
}


void draw() {
  background(0);
  control();
  animateEyes();
  drawSkull();
  drawEyes();
  drawRose();
}

void control() {
  if (mousePressed) {
    alternativeLights();
  } else {
    if(increasing){
      ambientLight(51, 102, 126);
    } else {
      alternativeLights();
    }
  }
}

void loadModels(){
  eye = loadShape("assets/eye/eyeball.obj");
  rose = loadShape("assets/rose_alt/rose.obj");
  rose.rotateX(radians(90));
  rose.rotate(radians(-90), 0, 0, 1);
  skull = loadShape("assets/skull/skull.obj");
  skull.rotateX(radians(90));
  skull.rotateY(radians(180));
}

void drawEyes(){
  pushMatrix();
  translate(width/3+150, height/2-25);
  scale(eyeScaleCurrent, eyeScaleCurrent, eyeScaleCurrent);
  shape(eye);
  popMatrix();

  pushMatrix();
  translate(2*width/3-150, height/2-25);
  scale(eyeScaleCurrent, eyeScaleCurrent, eyeScaleCurrent);
  shape(eye);
  popMatrix();
}

void drawRose(){
  pushMatrix();
  translate(width/2+250, height/2+100, 75);
  scale(8, 8, 8);  
  shape(rose);
  popMatrix();
}

void drawSkull(){
  pushMatrix();
  translate(width/2, height/2+250, -50);
  scale(8, 8, 8);  
  shape(skull);
  popMatrix();
}

void animateEyes(){
  if(eyeScaleCurrent >= eyeScaleMax){
    increasing = false;
  }
  
  if(eyeScaleCurrent <= eyeScaleMin){
    increasing = true;
  }
  
  if(increasing){
    eyeScaleCurrent += 0.75;
  } else {
    eyeScaleCurrent -= 0.75;
  }
}



void alternativeLights() {
  directionalLight(51, 102, 126, -1, 0, 0);
}
