class Arete {
    
    Point debut;
    Point fin;

    Point getMilieu() {
        float x = (debut.getX() + fin.getX()) / 2;
        float y = (debut.getY() + fin.getY()) / 2;
        float z = (debut.getZ() + fin.getZ()) / 2;
        return new Point(x, y, z);
    }

    
    Point getDebut() {
        return debut;
    }

    void setDebut(Point debut) {
        this.debut = debut;
    }

    Arete(Point debut, Point fin) {
        this.debut = debut;
        this.fin = fin;
    }
    
    Point getFin() {
        return fin;
    }
    void setFin(Point fin) {
        this.fin = fin;
    }
    public void dessiner() {
        line(debut.getX(), debut.getY(), debut.getZ(), fin.getX(), fin.getY(), fin.getZ());
    }
    
    @Override
    String toString(){
       return "Debut : "+ debut.toString() + "Fin : " +fin.toString() + "\n"; 
    }
    

}
