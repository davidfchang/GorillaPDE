

// A rectangular box
class Gorilla  {
  
  PImage bodyImage;
  Body body;
  float x,y;
  float w,h;
  int elapsedFrames;
  boolean isitplayer1;
  BodyDef bd;
  int hitPoints;

  // Constructor
  Gorilla(float x_, float y_, float w_, boolean isplayer1) {
    x = x_;
    y = y_;
    w = w_;
    h = w;
    isitplayer1 = isplayer1;
    hitPoints = 3;
    
    // Build Body
    bd = new BodyDef();      
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    if (isplayer1)
      bodyImage = loadImage("gright.png");
    else //player2
      bodyImage = loadImage("gleft.png");

   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    sd.setAsBox(box2dW, box2dH);
    
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.0;

    // Attach Fixture to Body               
    body.createFixture(fd);
    body.setUserData(this);
    
  }

  // Drawing the box
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);    // Using the Vec2 position and float angle to
    rotate(-a);              // translate and rotate the rectangle
    fill(175);
    stroke(0);
    //rectMode(CENTER);
    //rect(0,0,w,h);
    image(bodyImage,-w/2,-h/2,w ,h);
    popMatrix();
  }
  
  void selectImage(int imageIndex){
          switch(imageIndex){
          case 1:  //Facing left
              bodyImage = loadImage("gright.png");
              break;
          case 2:  //Facing right
              bodyImage = loadImage("gleft.png");
              break;
          case 3:  //Left Arm up
              bodyImage = loadImage("gleftup.png");
              break;  
          case 4: //Right Arm up
              bodyImage = loadImage("grightup.png");
              break;
          default: //reset
              if (isitplayer1)
                bodyImage = loadImage("gright.png");
              else //player2
                bodyImage = loadImage("gleft.png");
              break;
          
        
  }
  
    
  }
}
