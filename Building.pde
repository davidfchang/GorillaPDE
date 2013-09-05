// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// PBox2D example

// A rectangular box
class Building {

  // We need to keep track of a Body and a width and height
  Body b;
  PImage bodyImage;
  float w;
  float h;
  float x;
  float y;
  
  // Constructor
  Building(float x_,float y_, float w_, float h_, float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    float buildingImage = random(1,10);
    
    switch ((int)buildingImage){
    case 1:
        bodyImage = loadImage("building1.png");
        break;
    case 2:
        bodyImage = loadImage("building2.png");
        break;
    case 3:
        bodyImage = loadImage("building3.png");
        break;
    case 4:
        bodyImage = loadImage("building4.png");
        break;
    case 5:
        bodyImage = loadImage("building5.png");
        break;
    case 6:
        bodyImage = loadImage("building6.png");
        break;
    case 7:
        bodyImage = loadImage("building7.png");
        break;
    case 8:
        bodyImage = loadImage("building8.png");
        break;
    case 9:
        bodyImage = loadImage("building9.png");
        break;
    case 10:
        bodyImage = loadImage("building10.png");
        break;
    default:
        bodyImage = loadImage("marioblock.png");
        break;
    }
   // bodyImage = loadImage("marioblock.png");
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
    b.setUserData(this);

  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(b);
  }

  
  void display() {
    fill(120,120,120,120);
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    float a = b.getAngle();
    pushMatrix();
    translate(x,y);
    rotate(-a);
    //rect(0,0,w,h);
    image(bodyImage,-w/2,-h/2,w ,h);
    popMatrix();
    

    
  }
  
  
  
}

