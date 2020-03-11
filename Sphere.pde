class Sphere{
  PShape sphere;
  
  Sphere(){
    beginShape();
    sphere = createShape(SPHERE, 150);
    sphere.setStroke(255);
    endShape(CLOSE);
  }
  
  Sphere(PImage texture){
    beginShape();
    sphere = createShape(SPHERE, 150);
    sphere.setStroke(255);
    sphere.setTexture(texture);
    endShape(CLOSE);
  }
  
  void draw(){
    shape(sphere);
  }
  
  void draw(PVector position){
    pushMatrix();
    translate(position.x, position.y, position.z);
    this.draw();
    popMatrix();
  }
  
  PShape get(){
    return sphere;
  }
  
}
