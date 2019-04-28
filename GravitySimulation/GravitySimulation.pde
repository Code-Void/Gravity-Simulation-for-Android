Body bod;

ArrayList<Particle> particles = new ArrayList<Particle>();
int maxPartSize = 2000;
int minPartSize = 200;

int mode = 0; // 0 - single particle, 1 - mouse dragged, 2 - change position

PVector init = null;

boolean changingmode = false;

void setup() {
  orientation(LANDSCAPE);
  bod = new Body(width/2, height/2 + 50, 150);
}

void draw() {
  background(255);

  if (mode == 0 && init != null) {
    stroke(100, 100);
    strokeWeight(3);
    line(init.x, init.y, mouseX, mouseY);
  }

  ArrayList<Particle> partToRemove = new ArrayList<Particle>();
  for (Particle p : particles) {
    if (bod.sucked(p)) partToRemove.add(p);

    p.update();
    p.show();
  }

  for (Particle n : partToRemove) {
    if (particles.contains(n)) particles.remove(n);
  }

  if (mode == 2 && mousePressed && !changingmode) {
    bod.pos = new PVector(mouseX, mouseY);
  }
  bod.show();

  fill(150);
  rectMode(CORNERS);
  rect(0, 0, width, 100);

  fill(255);
  strokeWeight(1);
  textAlign(CENTER, CENTER);
  textSize(50);
  switch (mode) {
  case 0:
    text("Single Particle Mode", 0, 0, width, 100);
    break;
  case 1:
    text("Mouse Dragged Mode", 0, 0, width, 100);
    break;
  default:
    text("Move Attraction Source Mode", 0, 0, width, 100);
  }
}

void mousePressed() {
  if (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= 100) {
    if (mode == 1) changingmode = true;
    mode++;
    if (mode > 2) mode = 0;
  } else if (mouseY > 100 && mode == 0 && init == null) {
    init = new PVector((int) mouseX, (int) mouseY);
  }
}

void mouseReleased() {
  if (changingmode) changingmode = false;

  if (mouseY > 100 && mode == 0 && init != null) {
    PVector curr = new PVector((int) mouseX, (int) mouseY);

    PVector dist = PVector.sub(curr, init);
    dist.div(35);

    particles.add(new Particle(init, (int) random(minPartSize, maxPartSize), dist));

    init = null;
  }
}

void mouseDragged() {
  if (mouseY > 100 && mode == 1) {
    PVector curr = new PVector((int) mouseX, (int) mouseY);
    PVector prev = new PVector((int) pmouseX, (int) pmouseY);
    particles.add(new Particle(prev, (int) random(minPartSize, maxPartSize), PVector.sub(curr, prev).div(5)));
  }
}
