 // Sandroni Rios Celene
// nro de legajo 122891/4
PImage[] creditImages;
PFont creditFont;
float scrollY;
boolean isScrolling = true;
Button restartButton;
int currentImage = 0;
float imageAlpha = 0;
float fadeSpeed = 2;
int imageDisplayTime = 180; // frames to display each image
int imageTimer = 0;

void setup() {
  size(640, 480);
  smooth();
  
  // Cargar imágenes de créditos (reemplaza con tus propias imágenes)
  creditImages = new PImage[3];
  for (int i = 0; i < creditImages.length; i++) {
    creditImages[i] = loadImage("cap" + (i+1) + ".jpg");
    if (creditImages[i] == null) {
      // Si no hay imágenes, crear placeholders
      creditImages[i] = createImage(width, height, RGB);
      creditImages[i].loadPixels();
      for (int j = 0; j < creditImages[i].pixels.length; j++) {
        creditImages[i].pixels[j] = color(random(50, 200), random(50, 200), random(50, 200));
      }
      creditImages[i].updatePixels();
    }
  }
  
  // Cargar fuente (asegúrate de tener una fuente en la carpeta data)
  creditFont = createFont("Arial Bold", 24);
  textFont(creditFont);
  
  // Crear botón de reinicio
  restartButton = new Button(width/2 - 75, height - 80, 150, 50, "Reiniciar Créditos");
  
  scrollY = height;
}

void draw() {
  background(0);
  
  // Mostrar imagen actual con efecto de fade
  if (currentImage < creditImages.length) {
    tint(255, imageAlpha);
    image(creditImages[currentImage], 0, 0, width, height);
    noTint();
    
    // Controlar fade in/out
    if (imageTimer < imageDisplayTime/2) {
      imageAlpha += fadeSpeed;
      if (imageAlpha > 255) imageAlpha = 255;
    } else {
      imageAlpha -= fadeSpeed;
      if (imageAlpha < 0) imageAlpha = 0;
    }
    
    imageTimer++;
    if (imageTimer >= imageDisplayTime) {
      currentImage++;
      imageTimer = 0;
      imageAlpha = 0;
    }
  } else {
    // Mostrar créditos después de las imágenes
    drawCredits();
  }
  
  // Mostrar botón de reinicio (si no está en modo de imágenes)
  if (currentImage >= creditImages.length) {
    restartButton.display();
  }
  
  // Efecto de escudo de Capitán América en el fondo
  drawShieldEffect();
}

void drawCredits() {
  // Fondo semitransparente para mejor legibilidad
  fill(0, 150);
  rect(0, 0, width, height);
  
  // Texto de créditos que sube
  if (isScrolling) {
    scrollY -= 0.8;
    if (scrollY < -2000) {
      scrollY = height;
      isScrolling = false;
    }
  }
  
  pushMatrix();
  translate(0, scrollY);
  
  // Título
  fill(200, 50, 50);
  textSize(48);
  textAlign(CENTER);
  text("CAPITÁN AMÉRICA", width/2, 100);
  
  // Créditos
  fill(255);
  textSize(32);
  text("El soldado del invierno", width/2, 180);
  
  textSize(24);
  text("Dirigido por", width/2, 250);
  text("Joe Russo & Anthony Russo", width/2, 290);
  
  text("Protagonizado por", width/2, 350);
  text("Chris Evans como Steve Rogers", width/2, 390);
  text("Scarlett Johansson como Natasha Romanoff", width/2, 430);
  text("Sebastian Stan como Bucky Barnes", width/2, 470);
  
  text("Música compuesta por", width/2, 530);
  text("Alan Silvestri", width/2, 570);
  
  text("Producción", width/2, 630);
  text("Marvel Studios", width/2, 670);
  
  text("Basado en los cómics de", width/2, 730);
  text("Marvel Comics", width/2, 770);
  
  textSize(18);
  text("© 2025 Marvel Studios. Todos los derechos reservados.", width/2, 850);
  
  popMatrix();
}

void drawShieldEffect() {
  // Efecto de escudo circular en el fondo
  noFill();
  stroke(200, 50, 50, 50);
  strokeWeight(2);
  ellipse(width/2, height/2, 400 + sin(frameCount*0.05)*20, 400 + sin(frameCount*0.05)*20);
  ellipse(width/2, height/2, 300 + cos(frameCount*0.03)*15, 300 + cos(frameCount*0.03)*15);
  ellipse(width/2, height/2, 200 + sin(frameCount*0.07)*10, 200 + sin(frameCount*0.07)*10);
  
  // Estrella centelleante
  fill(255, 200);
  noStroke();
  drawStar(width/2, height/2, 30 + sin(frameCount*0.1)*5, 60 + sin(frameCount*0.1)*5, 5);
}

void drawStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void mousePressed() {
  if (restartButton.isOver() && currentImage >= creditImages.length) {
    restartCredits();
  }
}

void restartCredits() {
  scrollY = height;
  isScrolling = true;
  currentImage = 0;
  imageAlpha = 0;
  imageTimer = 0;
}

class Button {
  float x, y, w, h;
  String label;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    // Efecto hover
    if (isOver()) {
      fill(200, 50, 50);
    } else {
      fill(50, 50, 200);
    }
    
    stroke(255);
    strokeWeight(2);
    rect(x, y, w, h, 10);
    
    fill(255);
    textSize(18);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
  
  boolean isOver() {
    return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
  }
}
