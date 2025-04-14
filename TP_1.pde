void setup() {
  size(600, 600);
  smooth();
  noStroke();
}

void draw() {
  background(255);
  
  // Dibujar el cuerpo azul
  fill(0, 120, 190);
  ellipse(300, 400, 250, 200);
  
  // Cabeza
  fill(0, 120, 190);
  ellipse(300, 250, 200, 180);
  
  // Orejas
  // Oreja izquierda
  fill(0, 120, 190);
  triangle(220, 180, 200, 120, 250, 160);
  // Oreja derecha
  triangle(380, 180, 400, 120, 350, 160);
  
  // Ojos
  fill(255);
  ellipse(270, 240, 60, 70);
  ellipse(330, 240, 60, 70);
  
  // Pupilas
  fill(0);
  ellipse(270, 250, 25, 30);
  ellipse(330, 250, 25, 30);
  
  // Nariz
  fill(50);
  ellipse(300, 280, 30, 20);
  
  // Boca
  noFill();
  stroke(0);
  strokeWeight(2);
  arc(300, 310, 80, 40, 0, PI);
  noStroke();
  
  // Bigotes
  stroke(0);
  strokeWeight(2);
  // Izquierdos
  line(280, 300, 230, 290);
  line(280, 310, 230, 310);
  // Derechos
  line(320, 300, 370, 290);
  line(320, 310, 370, 310);
  noStroke();
  
  // Brazos
  fill(0, 120, 190);
  // Brazo izquierdo
  ellipse(220, 380, 50, 80);
  // Brazo derecho
  ellipse(380, 380, 50, 80);
  
  // Dedos (simplificados)
  fill(0, 120, 190);
  // Mano izquierda
  ellipse(210, 420, 30, 30);
  ellipse(230, 420, 30, 30);
  // Mano derecha
  ellipse(370, 420, 30, 30);
  ellipse(390, 420, 30, 30);
}
