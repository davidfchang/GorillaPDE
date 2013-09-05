// A rectangular box
class Sun  {
  
  PImage bodyImage;
  Body body;
  float x,y;
  float w,h;

  // Constructor
  Sun(float w_) {
    x = width/2;
    y = 60;
    w = w_;
    h = w;
    
    // Build Body
    BodyDef bd = new BodyDef();      
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    body = box2d.createBody(bd);
    bodyImage = loadImage("sunok.png");


   // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);  // Box2D considers the width and height of a
    sd.setAsBox(box2dW, box2dH);
    
    body.setUserData(this);
   /* 
    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.0;

    // Attach Fixture to Body               
    body.createFixture(fd);
    */
    
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
    rectMode(CENTER);
    //rect(0,0,w,h);
    image(bodyImage,-w/2,-h/2,w ,h);
    popMatrix();
  }
  
  
  void selectImage(int imageIndex){
          switch(imageIndex){
          case 1:  //Facing left
              bodyImage = loadImage("sunok.png");
              break;
          case 2:  //Facing right
              bodyImage = loadImage("sunhit.png");
              break;
          }
        
  }
  
  
  
}
