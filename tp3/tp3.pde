//Celene Sandroni Rios
//Comision 1 
PImage referencia; // Para cargar la imagen de referencia
boolean mostrarReferencia = false;
Button reinicioBtn;

void setup() {
  size(800, 400);
  smooth();
  
  // Cargar imagen de referencia (asegúrate de tener un archivo "patrones.jpg" en la carpeta data)
  referencia = loadImage("patrones.jpg");
  if (referencia != null) {
    referencia.resize(200, 0); // Redimensionar manteniendo proporción
  }
  
  // Crear botón de reinicio
  reinicioBtn = new Button(width - 110, 10, 100, 40, "Reiniciar");
}

void draw() {
  background(240);
  
  // Dibujar patrones repetitivos
  dibujarPatrones();
  
  // Mostrar referencia si está activado
  if (mostrarReferencia && referencia != null) {
    image(referencia, 10, 10);
    fill(0, 150);
    rect(10, 10, referencia.width, 20);
    fill(255);
    text("Referencia", 15, 25);
  }
  
  // Dibujar botón
  reinicioBtn.display();
  
  // Mostrar instrucciones
  fill(0);
  text("Click para mostrar/ocultar referencia", 10, height - 20);
}

void dibujarPatrones() {
  // Configuración basada en mouse
  int columnas = int(map(mouseX, 0, width, 5, 30));
  int filas = int(map(mouseY, 0, height, 5, 20));
  float tamBase = min(width/columnas, height/filas);
  
  // Dibujar patrón modular
  for (int i = 0; i < columnas; i++) {
    for (int j = 0; j < filas; j++) {
      float x = i * (width/columnas) + (width/columnas)/2;
      float y = j * (height/filas) + (height/filas)/2;
      
      // Tamaño modulado por posición y mouse
      float tam = tamBase * 0.8 * (0.5 + 0.5 * sin(frameCount * 0.05 + i * 0.3 + j * 0.2));
      
      // Color basado en índices y tiempo
      fill(
        (i * 10 + frameCount) % 255, 
        (j * 15 + frameCount * 2) % 255, 
        (i * j + frameCount * 3) % 255
      );
      
      // Forma que cambia con el tiempo
      if (frameCount % 120 < 60) {
        ellipse(x, y, tam, tam);
      } else {
        rectMode(CENTER);
        rect(x, y, tam, tam, tam/4);
      }
    }
  }
}

void mousePressed() {
  // Toggle para mostrar referencia
  if (mouseX > 10 && mouseX < 210 && mouseY > 10 && mouseY < 30 && referencia != null) {
    mostrarReferencia = !mostrarReferencia;
  }
  
  // Verificar clic en botón
  if (reinicioBtn.mouseOver()) {
    // Reiniciar posición de los elementos (aquí podrías resetear variables)
    frameCount = 0; // Esto reinicia las animaciones basadas en frameCount
  }
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
    fill(mouseOver() ? color(200, 50, 50) : color(150));
    rect(x, y, w, h, 5);
    fill(255);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }
  
  boolean mouseOver() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
}
