

// Variables globales
int slideActual = 0;
int totalSlides = 5;
boolean transicion = false;
float alpha = 0;
PFont font;
PImage[] imagenes = new PImage[3];
boolean botonPresionado = false;
int tiempoPresionado = 0;

void setup() {
  size(640, 480);
  font = createFont("Arial", 32);
  textFont(font);
  
  // Cargar imágenes (reemplaza con tus propias imágenes)
  imagenes[0] = loadImage("violetta1.jpg");
  imagenes[1] = loadImage("violetta2.jpg");
  imagenes[2] = loadImage("violetta3.jpg");
  
  // Si no hay imágenes, crear placeholders
  for (int i = 0; i < imagenes.length; i++) {
    if (imagenes[i] == null) {
      imagenes[i] = createImage(400, 300, RGB);
      imagenes[i].loadPixels();
      for (int j = 0; j < imagenes[i].pixels.length; j++) {
        imagenes[i].pixels[j] = color(random(255), random(255), random(255));
      }
      imagenes[i].updatePixels();
    }
  }
}

void draw() {
  // Fondo blanco
  background(255);
  
  // Mostrar slide actual
  mostrarSlide();
  
  // Mostrar botón de reinicio
  dibujarBotonReinicio();
  
  // Efecto de transición
  if (transicion) {
    alpha += 10;
    fill(255, alpha);
    noStroke();
    rect(0, 0, width, height);
    
    if (alpha >= 255) {
      transicion = false;
      alpha = 0;
      slideActual = (slideActual + 1) % totalSlides;
    }
  }
  
  // Efecto de botón presionado
  if (botonPresionado) {
    tiempoPresionado++;
    if (tiempoPresionado > 30) { // 0.5 segundos aprox (60fps)
      botonPresionado = false;
      tiempoPresionado = 0;
    }
  }
}

void mostrarSlide() {
  switch(slideActual) {
    case 0:
      // Portada
      fill(#FF66B2);
      textSize(48);
      textAlign(CENTER, CENTER);
      text("Violetta", width/2, height/2 - 50);
      
      fill(#333333);
      textSize(24);
      text("La estrella juvenil de Disney", width/2, height/2 + 30);
      break;
      
    case 1:
      // Biografía básica
      fill(#333333);
      textSize(18);
      textAlign(CENTER, TOP);
      text("Biografía", width/2, 50);
      
      textSize(16);
      textAlign(LEFT, TOP);
      text("Violetta es una serie de televisión argentina producida por Disney Channel.\n\n" +
           "Protagonizada por Martina Stoessel, la serie se centra en la vida de una\n" +
           "joven llamada Violetta y su pasión por la música.", 100, 120);
      
      image(imagenes[0], width/2 - 150, height/2 + 20, 300, 200);
      break;
      
    case 2:
      // Personaje principal
      fill(#333333);
      textSize(32);
      textAlign(CENTER, TOP);
      text("Violetta Castillo", width/2, 50);
      
      textSize(12);
      textAlign(LEFT, TOP);
      text("Características:\n" +
           "- Joven de 16 años\n" +
           "- Regresa a Buenos Aires después de vivir en Europa\n" +
           "- Descubre su talento para el canto\n" +
           "- Se enfrenta a desafíos personales y musicales", 100, 120);
      
      image(imagenes[1], width - 250, height/2 - 100, 200, 250);
      break;
      
    case 3:
      // Datos curiosos
      fill(#333333);
      textSize(32);
      textAlign(CENTER, TOP);
      text("Datos Curiosos", width/2, 50);
      
      textSize(18);
      textAlign(LEFT, TOP);
      text("- La serie se emitió en más de 130 países\n" +
           "- Martina Stoessel (Tini) dobló su propia voz en varios idiomas\n" +
           "- La música de la serie fue un éxito en ventas\n" +
           "- Se grabó en Buenos Aires y Barcelona\n" +
           "- Tuvo 3 temporadas (2012-2015)", 100, 120);
      
      // Gráfico simple
      fill(#FF66B2);
      rect(100, height/2 + 100, 150, -80);
      fill(#66B2FF);
      rect(300, height/2 + 100, 150, -120);
      fill(#66FFB2);
      rect(500, height/2 + 100, 150, -60);
      break;
      
    case 4:
      // Final
      fill(#FF66B2);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("¡Gracias por ver esta presentación!", width/2, height/2 - 50);
      
      fill(#333333);
      textSize(24);
      text("Presiona cualquier tecla o haz clic para reiniciar", width/2, height/2 + 50);
      
      image(imagenes[2], width/2 - 100, height/2 + 100, 200, 150);
      break;
  }
}

void dibujarBotonReinicio() {
  // Coordenadas y dimensiones del botón
  int botonX = width - 120;
  int botonY = height - 60;
  int botonAncho = 100;
  int botonAlto = 40;
  
  // Efecto visual cuando se presiona
  if (botonPresionado) {
    fill(#AAAAAA);
  } else {
    fill(#DDDDDD);
  }
  
  // Dibujar botón
  stroke(#333333);
  rect(botonX, botonY, botonAncho, botonAlto, 5);
  
  // Texto del botón
  fill(#333333);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Reiniciar", botonX + botonAncho/2, botonY + botonAlto/2);
}

void mousePressed() {
  // Verificar si se hizo clic en el botón de reinicio
  int botonX = width - 120;
  int botonY = height - 60;
  int botonAncho = 100;
  int botonAlto = 40;
  
  if (mouseX >= botonX && mouseX <= botonX + botonAncho &&
      mouseY >= botonY && mouseY <= botonY + botonAlto) {
    botonPresionado = true;
    slideActual = 0; // Reiniciar a la primera slide
    return;
  }
  
  // Avanzar a la siguiente slide con efecto de transición
  if (!transicion) {
    transicion = true;
    alpha = 0;
  }
}

void keyPressed() {
  // Reiniciar presentación con cualquier tecla en la última slide
  if (slideActual == totalSlides - 1) {
    slideActual = 0;
  } else if (!transicion) {
    transicion = true;
    alpha = 0;
  }
}
