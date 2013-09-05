// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// PBox2D example

// ContactListener to listen for collisions!


import org.jbox2d.callbacks.ContactImpulse;
import org.jbox2d.callbacks.ContactListener;
import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

 class CustomListener implements ContactListener {
  CustomListener() {
  }

  // This function is called when a new collision occurs
   void beginContact(Contact cp) {
    // Get both fixtures
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();
    // Get both bodies
    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
    // Get our objects that reference these bodies
    Object o1 = b1.getUserData();
    Object o2 = b2.getUserData();

    // If object 1 is a Gorilla, and object 2 is a Banana
    if ((o1.getClass() == Gorilla.class) && (o2.getClass() == Banana.class)) {
      Gorilla g = (Gorilla) o1;
      g.hitPoints--;
      
      
      Banana b = (Banana) o2;
      b.explode();
      
      println("Collision: o1 is gorilla");
    }
    else if ((o2.getClass() == Gorilla.class)&& (o1.getClass() == Banana.class)) {
      Gorilla g = (Gorilla) o2;
      g.hitPoints--;
      
      
      Banana b = (Banana) o1;
      b.explode();
      
      println("Collision: o2 is gorilla");
    }
    
    
    
    
    // If object 1 is a Banana, and object 2 is a Sun
    if ((o1.getClass() == Banana.class) && (o2.getClass() == Sun.class)) {
      println("The sun is hit!");
      Sun s = (Sun) o2;
      s.selectImage(2);
    }
    else if ((o2.getClass() == Banana.class)&& (o1.getClass() == Sun.class)) {
      println("The sun is hit!");
      Sun s = (Sun) o1;
      s.selectImage(2);
      
    }
    
    
    
  }

   void endContact(Contact contact) {
    // TODO Auto-generated method stub
  }

   void preSolve(Contact contact, Manifold oldManifold) {
    // TODO Auto-generated method stub
  }

   void postSolve(Contact contact, ContactImpulse impulse) {
    // TODO Auto-generated method stub
  }
}


