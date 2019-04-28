public class Body {
  PVector pos;
  int size;
  float G = 0.4;
  int mass;
  int radius;

  public Body (int posx, int posy, int size) {
    this.pos = new PVector(posx, posy);
    this.size = size;
    this.mass = 300 * size;
    this.radius = size/3;
  }

  boolean sucked(Particle p) {
    if (p.pos.x >= (this.pos.x - radius) && p.pos.x <= (this.pos.x + radius) && p.pos.y >= (this.pos.y - radius) && p.pos.y <= (this.pos.y + radius)) {
      return true;
    }

    return false;
  }

  PVector attract(Particle p) {
    PVector force = PVector.sub(pos, p.pos);
    float strength = (G * size * p.mass) / (force.mag() * force.mag());
    force.setMag(strength);
    return force;
  }

  public void show() {
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, size, size);
  }
}
