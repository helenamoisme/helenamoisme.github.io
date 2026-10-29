import processing.serial.*;
Serial myPort;
PImage well, ghost;
boolean scare = false;
int press = 1;
float lightX = 400, lightY = 400;
int lightsize = 150;
void setup() {
  size(800, 600);
  pixelDensity(1);
  well = loadImage("well.png");
  ghost = loadImage("ghost.png");
  well.resize(width, height);
  well.loadPixels();
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 9600);
}
void draw() {
  while (myPort.available() > 0) {
    String val = myPort.readStringUntil('\n');
    if (val != null) {
      int[] xyz = int(split(trim(val), ','));
      if (xyz.length == 5) {
        lightX = map(xyz[0], 0, 4095, 0, width);
        lightY = map(xyz[1], 0, 4095, 0, height);
        lightsize = int(map(constrain(xyz[3], 0, 4095), 0, 4095, 100, 400));
        int z = xyz[2], button = xyz[4];
        boolean onWell = lightX > 250 && lightX < 550 && lightY > 320 && lightY < 520;
        if (z == 0 && press == 1 && onWell) scare = true;
        if (button == 0) scare = false;
        press = z;
      }
    }
  }
  if (scare) {
    image(ghost, 0, 0, width, height);
  } else {
    loadPixels();
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int i = y * width + x;
        float d = dist(x, y, lightX, lightY);
        float radius = lightsize / 2.0;
        float fade = constrain(map(d, radius * 0.6, radius, 0, 1), 0, 1);
        pixels[i] = lerpColor(well.pixels[i], color(0), fade);
      }
    }
    updatePixels();
  }
  fill(70, 60, 0);
  rect(0, 0, width, 20);
  rect(0, height - 20, width, 20);
  rect(0, 0, 20, height);
  rect(width - 20, 0, 20, height);
}
