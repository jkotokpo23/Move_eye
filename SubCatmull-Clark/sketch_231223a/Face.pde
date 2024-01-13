class Face {
    ArrayList<Arete> liste;

    ArrayList<Arete> getListe() {
        return liste;
    }

    void ajouterArete(Arete arete){
        liste.add(arete);
    }

    Face(ArrayList<Arete> liste) {
        this.liste = liste;
    }
    
    void setListe(ArrayList<Arete> liste) {
        this.liste = liste;
    }
    
    Boolean isAdjacente(Arete arete){
      int is = 0;
      Point d = arete.getDebut();
      Point f = arete.getFin();
      for(Arete a : liste){
        Point d1 = a.getDebut();
        Point f1 = a.getFin();
        if(d.equals(d1)) is++;
        if(d.equals(f1)) is++;
        if(f.equals(d1)) is++;
        if(f.equals(f1)) is++;
      }
      is /=2;
      //println(is);
      return is == 2;
    }
    
    ArrayList<Point> obtenirPointsUniques() {
        ArrayList<Point> pointUnique = new ArrayList<Point>();
        for (Arete arete : liste) {
            if(!pointUnique.contains(arete.getDebut())){
              pointUnique.add(arete.getDebut());
            }
            if(!pointUnique.contains(arete.getFin())){
              pointUnique.add(arete.getFin());
            }
        }
        return pointUnique;
    }
    
    Point getCentre() {
        float sumX = 0;
        float sumY = 0;
        float sumZ = 0;
        int count = 0;

        // Supposons que la liste contient une séquence fermée d'aretes formant un polygone
        for (Arete arete : liste) {
            sumX += arete.getDebut().getX();
            sumY += arete.getDebut().getY();
            sumZ += arete.getDebut().getZ();
            count++;
        }

        // Si les aretes forment un polygone fermé, le dernier point est le meme que le premier
        // et ne devrait pas etre compté deux fois. Sinon, ajoutez le point final de la dernière arete.
        if (!liste.get(0).getDebut().equals(liste.get(liste.size() - 1).getFin())) {
            sumX += liste.get(liste.size() - 1).getFin().getX();
            sumY += liste.get(liste.size() - 1).getFin().getY();
            sumZ += liste.get(liste.size() - 1).getFin().getZ();
            count++;
        }

        return new Point(sumX / count, sumY / count, sumZ / count);
    }
    
    public void dessiner() {
      beginShape();
        for (Arete arete : liste) {
            vertex(arete.getDebut().getX(), arete.getDebut().getY(), arete.getDebut().getZ());
            vertex(arete.getFin().getX(), arete.getFin().getY(), arete.getFin().getZ());
        }
        
      endShape(CLOSE);
    }
    
    @Override
    String toString(){
       String pattern = "";
       for(int i = 0; i < liste.size(); i++){
         pattern = pattern + liste.get(i).toString();
       }
       return pattern + "\n"; 
    }

}
