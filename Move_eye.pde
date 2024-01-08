import java.util.Random;
float posX = 0, posY = 0, posZ = 0; // Position de la forme
boolean isCube = true; // Type de forme (true pour cube, false pour sphère)
int formColor = 255; // Couleur de la forme (blanc par défaut)
float angleX = 0;
float angleY = 0;
Random rand = new Random();
int r = 255;
int g = 255;
int b = 255;

void setup() {
  size(640, 360, P3D);
  println("La forme bouge en fonction du curseur, mais vous pouvez aussi maintenir le clic droit et le bouger"+
          "Appuyez sur entrer pour changer de forme\n" +
          "Espace pour changer de couleur");
}

void draw() {
  lights();
  background(100);
  
  camera(30.0, mouseY, 220.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
  rotateY(angleY);
  rotateX(angleX);
  translate(posX, posY, posZ); // Déplace la forme dans l'espace 3D
  fill(r, g, b); // Définit la couleur de la forme
  noStroke();
  
  if (isCube) {
    box(90); // Dessine un cube
  } else {
    sphere(45); // Dessine une sphère
  }

  stroke(255);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
}

void keyPressed() {
  if (key == ENTER) {
    isCube = !isCube; // Change la forme
  }

  if (key == ' ') {
    r = rand.nextInt(256);
    g = rand.nextInt(256);
    b = rand.nextInt(256);
  }

  // Contrôle du déplacement de la forme
  if (key == 'w') posY -= 10;
  if (key == 's') posY += 10;
  if (key == 'a') posX -= 10;
  if (key == 'd') posX += 10;
  if (key == 'q') posZ -= 10;
  if (key == 'e') posZ += 10;
}

void mouseDragged() {
    angleY += (mouseX - pmouseX) * 0.01;
    angleX += (mouseY - pmouseY) * 0.01;
}
