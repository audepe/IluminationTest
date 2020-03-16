import processing.sound.*;  
import processing.serial.*;
import queasycam.*;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

TimerTask timerTask = new TimerTask()
     {
         public void run() 
         {
             rollLights();
         }
};


SoundFile spotlight;
SoundFile music;
QueasyCam cam;
Timer timer = new Timer();
int sphereDetail = 60;
int lightRoll;
ArrayList <PVector> lightRolls;
PShape eye;
PShape rose;
PShape skull;
PFont def;
PImage rotateSign;
float musicVol;
float eyeScaleMax;
float eyeScaleMin;
float eyeScaleCurrent = eyeScaleMax;
int textOffset = 0;
boolean increasing = false;
boolean rollEnded = false;
boolean cameraMode = false;
boolean splashMode = true;
boolean imageShow = true;
PVector currentLR;

void setup() {
  size(1280, 720, P3D);
  
  
  eyeScaleMax = 20;
  eyeScaleMin = 10;
  
  PVector light0 = new PVector(-1, 0, 0);
  PVector light45 = new PVector(-1, 1, 0);
  PVector light90 = new PVector(0, 1, 0);
  PVector light135 = new PVector(1, 1, 0);
  PVector light180 = new PVector(1, 0, 0);
  PVector light225 = new PVector(1, -1, 0);
  PVector light270 = new PVector(0, -1, 0);
  PVector light315 = new PVector(-1, -1, 0);
  
  lightRolls = new ArrayList<PVector>();
  
  lightRolls.add(light0);
  lightRolls.add(light45);
  lightRolls.add(light90);
  lightRolls.add(light135);
  lightRolls.add(light180);
  lightRolls.add(light225);
  lightRolls.add(light270);
  lightRolls.add(light315);
  
  
  lightRoll = 0;
  
  currentLR = lightRolls.get(lightRoll);
  
  sphereDetail(sphereDetail);
  
  loadModels();
  
  spotlight = new SoundFile(this, "assets/sounds/spotlight.wav");
  music = new SoundFile(this, "assets/sounds/cyborgchase.mp3");
  musicVol = 0.15;
  music.amp(musicVol);
  rotateSign = loadImage("assets/images/sign.png");
  def = createFont("assets/fonts/def.ttf",128);
}


void draw() {
  background(0);
  if (splashMode){
    splashScreen();
  } else {
    control();
    animateEyes();  
    drawSkull();
    drawEyes();
    drawRose();
    if (cameraMode && imageShow){
      drawText();
      textOffset += 10;
    }
  }
}

void control() {
  if (mousePressed && rollEnded) {
    pointLight(255, 102, 126, mouseX, mouseY, 20);
    ambientLight(51, 102, 126);
  } else {
    alternativeLights();
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

void drawText(){
  imageMode(CENTER);
  pushMatrix();
  translate(width/2 +750, height/2, 700+textOffset);
  rotateY(radians(180 + 90));
  image(rotateSign,0,0);
  popMatrix();
}

void splashScreen(){
    pushMatrix();
    translate(width/2, height/2);
    fill(255, 0, 0);
    textFont(def);
    textAlign(CENTER);
    textSize(128);
    text("IluminationTest",0,-100);
    textSize(32);
    text("Tiene sonido, espere a que acabe el show de luces",0,+25);
    text("Pulse espacio para iniciar la animación",0,+75);   
    text("Click dch. para activar la cámara",0,+125);
    text("Click izq. para iluminar",0,+175);    
    text("Mueve el ratón para mover la cámara",0,+225);
    text("WASD para moverte",0,+275);
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

void musicTransition(float target){
  while(musicVol < target){
    musicVol += 0.005;
    music.amp(musicVol);
  }
}

void rollLights(){
  spotlight.play();
  ambientLight(139, 178, 216);
  directionalLight(51, 102, 126, 0, 0, -10);
  if(lightRoll >= 7){
   timer.cancel();
   currentLR = new PVector(0, 0, -10);
   rollEnded = true;
   delay(3000);
   musicTransition(0.3);
  } else {
    lightRoll++;
    currentLR = lightRolls.get(lightRoll);
  }
}

void initCamera(){
  cam = new QueasyCam(this);
  cam.position = new PVector(width/2, height/2, 500);
  cameraMode = true;
}

void mousePressed(){
  if(mouseButton == RIGHT && rollEnded){
    initCamera();
  }
}

void keyPressed(){
  if (key == ' ' && splashMode){
    splashMode = false;
    timer.scheduleAtFixedRate(timerTask, 1500, 2*1000);
    music.play();
  }
}

void alternativeLights() {
  directionalLight(51, 102, 126, currentLR.x, currentLR.y, currentLR.z);
  if (rollEnded){
    directionalLight(166,92,229, lightRolls.get(1).x, lightRolls.get(1).y, lightRolls.get(1).z);
    directionalLight(166,92,229, lightRolls.get(3).x, lightRolls.get(3).y, lightRolls.get(3).z);
    directionalLight(166,92,229, lightRolls.get(5).x, lightRolls.get(5).y, lightRolls.get(5).z);
    directionalLight(166,92,229, lightRolls.get(7).x, lightRolls.get(7).y, lightRolls.get(7).z);
  }
}
