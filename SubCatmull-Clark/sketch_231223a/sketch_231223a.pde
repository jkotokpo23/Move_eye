import controlP5.*;

ControlP5 cp5;
ColorPicker cp;
int subdivisionLevel = 0;
int maxsub = 5;
Maillage maillage;
float zoom = 1;
float angleX = 0;
float angleY = 0;
static int PAGE = 0;
int typeMaillage = 0;
int longueur = 1000;
int largeur = 750;
PGraphics scene3D;

void setup() {
    size(1000, 750, P3D);
    textSize(25);
    cp5 = new ControlP5(this);
    
    cp5 = new ControlP5(this);
    cp = cp5.addColorPicker("picker")
            .setPosition(700, 100)
            .setSize(100, 50)
            .setColorValue(color(255, 255, 255, 255))
            ;

    cp5.addButton("Plus")
     .setPosition(20,140)
     .setSize(50, 20)
     .updateSize();
     
   cp5.addButton("Moins")
     .setPosition(80,140)
     .setSize(50, 20)
     .updateSize();
       

    DropdownList dl = cp5.addDropdownList("TypeMaillage")
       .setPosition(20, 170)
       .setSize(110, 80)
       .addItem("Cube", 0)
       .addItem("Tore", 1);
    dl.addListener(new ControlListener() {
        public void controlEvent(ControlEvent event) {
            handleDropdownEvent(event);
        }
    });

    cp5.addSlider("angleX")
       .setPosition(20, 240)
       .setSize(110, 20)
       .setRange(-PI, PI);

    cp5.addSlider("angleY")
       .setPosition(20, 270)
       .setSize(110, 20)
       .setRange(-PI, PI);

    cp5.addSlider("zoom")
       .setPosition(20, 300)
       .setSize(110, 20)
       .setRange(0.5, 3)
       .setValue(1);

    maillage = creerMaillage();
}

void draw() {
    background(10);
    draw3DScene();
}

void Moins(){
  decrementSubdivisionLevel(); 
}

void Plus(){
  incrementSubdivisionLevel();
}

void TypeMaillage(){
  
}

void handleDropdownEvent(ControlEvent event) {
    int selectedIndex = (int)event.getController().getValue();
    switch (selectedIndex) {
        case 0:
            typeMaillage = 0;
            maillage = creerMaillage();
            resetMaillage();
            break;
        case 1:
            typeMaillage = 1;
            maillage = creerMaillage();
            resetMaillage();
            break;
        default :
            typeMaillage = 2;
            maillage = creerMaillage();
            resetMaillage();
            break;
    }
}

void draw3DScene() {
    background(135);
    lights();
    pushMatrix();
    translate(width / 2, height / 2);
    scale(zoom);
    text("Niveau : " + subdivisionLevel, -55, -260, 150, 350);
    rotateY(angleY);
    rotateX(angleX);
    fill(cp.getColorValue());
    for (Face face : maillage.getListe()) {
        face.dessiner();
    }
    popMatrix();
}

void subdivisionLevel(int newLevel) {
    if (newLevel != subdivisionLevel) {
        subdivisionLevel = newLevel;
        resetMaillage();
        for (int i = 0; i < subdivisionLevel; i++) {
            maillage = maillage.Catmull_Clark(); 
        }
    }
}

void mouseDragged() {
    angleY += (mouseX - pmouseX) * 0.01;
    angleX += (mouseY - pmouseY) * 0.01;
}

void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    zoom += e * 0.05;
    zoom = constrain(zoom, 0.5, 3);
}

void resetMaillage() {
    maillage = creerMaillage();
    subdivisionLevel = 0;
}

void keyPressed() {
    if (key == ENTER || key == RETURN) {
        incrementSubdivisionLevel();
        println("Bouton");
        println(subdivisionLevel);
    }
    if (key == ' ') {
        maillage.reset();
        resetMaillage();
        
    }
    if (key == 'R' || key == 'r') {
        decrementSubdivisionLevel();
    }
}


void incrementSubdivisionLevel() {
    if(subdivisionLevel < maxsub){
      subdivisionLevel++;
      applySubdivision();
    }
}

void decrementSubdivisionLevel() {
    if(subdivisionLevel > 0){
      subdivisionLevel--;
      applySubdivision();
    }
}

void applySubdivision() {
    maillage = creerMaillage();
    for (int i = 0; i < subdivisionLevel; i++) {
        maillage = maillage.Catmull_Clark();
    }
}


Arete creerArete(Point debut, Point fin) {
    return new Arete(debut, fin);
}

Face creerFace(Arete a1, Arete a2, Arete a3, Arete a4) {
    ArrayList<Arete> aretes = new ArrayList<Arete>();
    aretes.add(a1);
    aretes.add(a2);
    aretes.add(a3);
    aretes.add(a4);
    return new Face(aretes);
}

Face creerFace(Arete a1, Arete a2, Arete a3) {
    ArrayList<Arete> aretes = new ArrayList<Arete>();
    aretes.add(a1);
    aretes.add(a2);
    aretes.add(a3);
    return new Face(aretes);
}

Maillage creerMaillage(){
  switch(typeMaillage){
    case 0 :
      return creerMaillageCubique();
    default :
      return creerMaillageTore();
  }
}

Maillage creerMaillageCubique() {
    // Définir les sommets du cube
    int scale = 100;
    Point p1 = new Point(-1 * scale, -1 * scale, -1 * scale);
    Point p2 = new Point(1 * scale, -1 * scale, -1 * scale);
    Point p3 = new Point(1 * scale, 1 * scale, -1 * scale);
    Point p4 = new Point(-1 * scale, 1 * scale, -1 * scale);
    Point p5 = new Point(-1 * scale, -1 * scale, 1 * scale);
    Point p6 = new Point(1 * scale, -1 * scale, 1 * scale);
    Point p7 = new Point(1 * scale, 1 * scale, 1 * scale);
    Point p8 = new Point(-1 * scale, 1 * scale, 1 * scale);

    // Créer les faces du cube
    ArrayList<Face> faces = new ArrayList<Face>();
    faces.add(creerFace(new Arete(p1, p2), new Arete(p2, p6), new Arete(p6, p5), new Arete(p5, p1))); // Face avant
    faces.add(creerFace(new Arete(p2, p3), new Arete(p3, p7), new Arete(p7, p6), new Arete(p6, p2))); // Face droite
    faces.add(creerFace(new Arete(p3, p4), new Arete(p4, p8), new Arete(p8, p7), new Arete(p7, p3))); // Face arrière
    faces.add(creerFace(new Arete(p4, p1), new Arete(p1, p5), new Arete(p5, p8), new Arete(p8, p4))); // Face gauche
    faces.add(creerFace(new Arete(p4, p3), new Arete(p3, p2), new Arete(p2, p1), new Arete(p1, p4))); // Face supérieure
    faces.add(creerFace(new Arete(p5, p6), new Arete(p6, p7), new Arete(p7, p8), new Arete(p8, p5))); // Face inférieure

    return new Maillage(faces);
}

Maillage creerMaillageGrille() {
    int scale = 100;
    Point base1 = new Point(-1 * scale, -1 * scale, -1 * scale);
    Point base2 = new Point(1 * scale, -1 * scale, -1 * scale);
    Point base3 = new Point(1 * scale, -1 * scale, 1 * scale);
    Point base4 = new Point(-1 * scale, -1 * scale, 1 * scale);
    Point sommet = new Point(0, 1 * scale, 0); // Le sommet est au-dessus du centre de la base

    // Créer les faces de la pyramide
    ArrayList<Face> faces = new ArrayList<Face>();
    faces.add(creerFace(new Arete(base1, base2), new Arete(base2, sommet), new Arete(sommet, base1))); // Face avant
    faces.add(creerFace(new Arete(base2, base3), new Arete(base3, sommet), new Arete(sommet, base2))); // Face droite
    faces.add(creerFace(new Arete(base3, base4), new Arete(base4, sommet), new Arete(sommet, base3))); // Face arrière
    faces.add(creerFace(new Arete(base4, base1), new Arete(base1, sommet), new Arete(sommet, base4))); // Face gauche
    faces.add(creerFace(new Arete(base1, base2), new Arete(base2, base3), new Arete(base3, base4), new Arete(base4, base1))); // Base

    return new Maillage(faces);
}

Maillage creerMaillageTore() {
        int rayonPrincipal = 100;
        int rayonTube = 40;
        int nbSegments = 16;
        int nbCercles = 16;

        ArrayList<Point> points = new ArrayList<>();
        ArrayList<Face> faces = new ArrayList<>();

        // Générer les points du tore
        for (int i = 0; i < nbCercles; i++) {
            for (int j = 0; j < nbSegments; j++) {
                float angleCercle = (float) (2 * Math.PI * i / nbCercles);
                float angleSegment = (float) (2 * Math.PI * j / nbSegments);

                float x = (float) ((rayonPrincipal + rayonTube * Math.cos(angleSegment)) * Math.cos(angleCercle));
                float y = (float) ((rayonPrincipal + rayonTube * Math.cos(angleSegment)) * Math.sin(angleCercle));
                float z = (float) (rayonTube * Math.sin(angleSegment));

                points.add(new Point(x, y, z));
            }
        }

        // Créer les faces du tore
        for (int i = 0; i < nbCercles; i++) {
            for (int j = 0; j < nbSegments; j++) {
                int premier = i * nbSegments + j;
                int topRight = premier + 1;
                int bottomLeft = (i + 1) % nbCercles * nbSegments + j;
                int bottomRight = bottomLeft + 1;
        
                // Adjust for the last segment in each circle
                if (j == nbSegments - 1) {
                    topRight = i * nbSegments;
                    bottomRight = (i + 1) % nbCercles * nbSegments;
                }
        
                ArrayList<Arete> aretes = new ArrayList<>();
                aretes.add(new Arete(points.get(premier), points.get(topRight)));
                aretes.add(new Arete(points.get(topRight), points.get(bottomRight)));
                aretes.add(new Arete(points.get(bottomRight), points.get(bottomLeft)));
                aretes.add(new Arete(points.get(bottomLeft), points.get(premier)));
        
                faces.add(new Face(aretes));
            }
        }



        return new Maillage(faces);
    }
