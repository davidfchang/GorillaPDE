

class Banana {

  // We need to keep track of a Body and a width and height
  Body body;
  PImage bodyImage;
  color col;
  int w, h;
  
  Vec2 shootVector;

  // Constructor
  Banana(float x, float y) {
    // Add the box to the box2d world
    makeBody(new Vec2(x, y));
    body.setUserData(this);
    col=color(255);
    bodyImage = loadImage("banana-hd.png");
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }
  
  
  
  void launchBanana(float velocity,float angle){
    
    shootVector = new Vec2 ( velocity * cos(angle), velocity * sin(angle) );
    body.setLinearVelocity(shootVector);
    body.setAngularVelocity(random(-5, 5));
  }
  
  void explode() {
    col = color(255, 0, 0);   
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height) {
      killBody();
      return true;
    }
    return false;
  }
  
  
  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();


    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    /*
    fill(col);
    stroke(0);
        beginShape();
    //println(vertices.length);
    // For every vertex, convert to pixel vector
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    */
    tint(col); 
    image(bodyImage,0,0,w ,h);
    tint(255);
    popMatrix();
  }
  
  
  
  
  
  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();

    Vec2[] vertices = new Vec2[8];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(5, 10));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(16, 6));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(32, 6));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(49, 13));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(61, 33));
    vertices[5] = box2d.vectorPixelsToWorld(new Vec2(54, 59));
    vertices[6] = box2d.vectorPixelsToWorld(new Vec2(48, 59));
    vertices[7] = box2d.vectorPixelsToWorld(new Vec2(5, 20));

    sd.set(vertices, vertices.length);

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    body.createFixture(sd, 1.0);
    w = 70;
    h = 70;


    
    
  }


}

