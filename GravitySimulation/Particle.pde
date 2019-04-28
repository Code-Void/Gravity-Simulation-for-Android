public class Particle {
  PVector pos;
  PVector velocity;
  PVector acceleration;
  int mass, strW;

  public Particle(PVector pos, int mass, PVector initialVel) {
    this.pos = pos;
    this.velocity = initialVel;
    this.acceleration = new PVector(0, 0);
    this.mass = mass;
    this.strW = (int) map(mass, minPartSize, maxPartSize, 10, 40);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    applyForce(bod.attract(this));

    velocity.add(acceleration);
    pos.add(velocity);
    acceleration.mult(0);
  }

  void show() {
    strokeWeight(strW);
    stroke(255, 0, 0);
    point(pos.x, pos.y);
  }
}
