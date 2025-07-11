PImage baseImage;
int gridSize = 200;
float time = 0;
int cols, rows;
float[][] rotations;
PFont font;
boolean imageLoaded = false;

void setup() {
  size(800, 400);
  baseImage = loadImage("estructura.jpg");

  if (baseImage == null) {
    println("⚠️ Error: No se pudo cargar 'estructura.jpg'. Asegurate de ponerla en la carpeta 'data'.");
    noLoop();
    return;
  }

  baseImage.resize(gridSize, gridSize);
  font = createFont("Arial", 16);
  textFont(font);

  cols = width / gridSize;
  rows = height / gridSize;
  rotations = new float[cols][rows];
  generateRotations();

  imageLoaded = true;
}

void draw() {
  if (!imageLoaded) return;

  background(255);
  time += 0.02;

  float waveSpeed = map(mouseX, 0, width, 0.01, 0.2);
  float waveAmp = map(mouseY, 0, height, 5, 20);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      pushMatrix();
      translate(i * gridSize + gridSize/2, j * gridSize + gridSize/2);
      rotate(rotations[i][j]);
      translate(-gridSize/2, -gridSize/2);
      drawWarpedTile(time, waveSpeed, waveAmp);
      popMatrix();
    }
  }

  drawButton();
}

void drawWarpedTile(float t, float speed, float amplitude) {
  PGraphics pg = createGraphics(gridSize, gridSize);
  pg.beginDraw();
  pg.image(baseImage, 0, 0);
  pg.endDraw();

  for (int y = 0; y < gridSize; y += 5) {
    float offset = sin(y * 0.1 + t * speed) * amplitude;
    image(pg, offset, y, gridSize, 5, 0, y, gridSize, 5);
  }
}

void drawButton() {
  fill(0);
  rect(10, height - 40, 160, 30, 8);
  fill(255);
  textAlign(LEFT, CENTER);
  text("Reiniciar patrón", 20, height - 25);
}

void mousePressed() {
  if (mouseX > 10 && mouseX < 170 && mouseY > height - 40 && mouseY < height - 10) {
    generateRotations();
  }
}

void generateRotations() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      rotations[i][j] = int(random(4)) * HALF_PI;
    }
  }
}
