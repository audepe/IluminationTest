Sphere prueba;

PVector previousColor;

int sphereDetail = 60;

void setup(){
  size(1280, 720, P3D);
  previousColor = new PVector(random(255),random(255),random(255));
  sphereDetail(sphereDetail);
  
  prueba = new Sphere();
}


void draw(){
  if (mousePressed){
    alternativeLights();
  }
  else{
    lights();
  }
  
  prueba.draw(new PVector(width/2, height/2, 0));
  
}

void alternativeLights(){
  PVector colorVec = getRandomColor();
  float val=(float)mouseX/(float)width*(float)255;
  ambientLight((int)val*colorVec.x,(int)val*colorVec.y,(int)val*colorVec.z);
  //directionalLight(50, 200, 50, -1, 0, 0);
  //spotLight(204, 153, 0, mouseX, mouseY, 500, 0, 0, -1, PI/2, 600);
}

PVector getRandomColor(){
  previousColor.x *= random(0.9,1.1); 
  previousColor.y *= random(0.9,1.1); 
  previousColor.z *= random(0.9,1.1); 
  return  previousColor;
}
