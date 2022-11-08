import java.util.Iterator;
import java.lang.Math;
import java.util.Random;

final int PARTICLES_COUNT = 1000;
final int SCREEN_X = 800;
final int SCREEN_Y = 600;
final int MINIMUM_LIFE = 50;
final int MAXIMUM_LIFE = 100;
final int MINIMUM_DIAMETER = 5;
final int MAXIMUM_DIAMETER = 15;
final int AMPLITUDE = 50;

ArrayList<Particle> objects;
Iterator<Particle> objIterator;  
Random rnd = new Random();

class Particle { 
  float xMovement;
  float yCenter;
  float xCenter;
  float diameter;
  float radius;
  float speed;
  float mass;
  int life;
  boolean sin;
    
  Particle(){  
    setNewFireObject();
  }    
  
  void setNewFireObject(){
    sin = rnd.nextBoolean();
    yCenter = SCREEN_Y + 100 - rnd.nextInt(50);
    diameter = MAXIMUM_DIAMETER;
    radius = diameter / 2;  
    speed = 5;
    life = rnd.nextInt(MAXIMUM_LIFE) + MINIMUM_LIFE;
    xCenter = rnd.nextInt(SCREEN_X);
  }
  
  color getColor(){
    int alpha = life * 255 / MAXIMUM_LIFE;
    int green = (life / 2) * 255 / MAXIMUM_LIFE;
    color col = color(255,green,0, alpha);    
    return col;
  }
  
  float getDiameter(){
    return life * MAXIMUM_DIAMETER / MAXIMUM_LIFE;
  }
  
  void update() {   
    yCenter -= speed;    
    
    if (sin)
      xMovement = (float)(AMPLITUDE * (Math.sin(Math.toRadians(yCenter)))) + xCenter;
    else
      xMovement = (float)(AMPLITUDE * (Math.cos(Math.toRadians(yCenter)))) + xCenter;
    
    if (life > 0)
      life--;
    else{
      setNewFireObject();
    }
  } 
} 

void addFire(){
  Particle obj = new Particle();
  obj.setNewFireObject();
  obj.xCenter = mouseX;
  obj.yCenter = mouseY;
  objects.add(obj); 
}

void setup() { 
  size(800,600);
  
  objects = new ArrayList<Particle>();   
  
  for (int i = 0; i < PARTICLES_COUNT ; i++){  
     Particle obj = new Particle();          
     objects.add(obj); 
  }
}

void draw() {   
  background(0);       
   
  objIterator = objects.iterator();
  
  while(objIterator.hasNext()){ 
    
     Particle obj = objIterator.next();
     
     obj.update();

     noStroke();          
     
     fill(obj.getColor());
     
     circle(obj.xMovement, obj.yCenter,  obj.getDiameter());   
     
  } 
  
  if (mousePressed && (mouseButton == LEFT)) {
    addFire();
  }
   
}
