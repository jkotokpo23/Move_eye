class Point {
    
    float x;
    float y;
    float z;
    
    Point(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    float getX() {
        return x;
    }

    void setX(float x) {
        this.x = x;
    }

    float getY() {
        return y;
    }

    void setY(float y) {
        this.y = y;
    }

    float getZ() {
        return z;
    }

    void setZ(float z) {
        this.z = z;
    }
    
    
    boolean equals(Point p){
      return ((p.getX() == getX()) && (p.getY() == getY()) && (p.getZ() == getZ()));  
    }
    
    Point moyenne(ArrayList<Point> points) {
        float sumX = 0, sumY = 0, sumZ = 0;
        int n = points.size();
        for (Point p : points) {
            sumX += p.getX();
            sumY += p.getY();
            sumZ += p.getZ();
        }
        sumX = sumX / n;
        sumY = sumY / n;
        sumZ = sumZ / n;
        return new Point(sumX, sumY, sumZ);
    }
     
    @Override
    String toString(){
      return "X : " + getX() + ", Y : " + getY() + ", Z : " + getZ(); 
    }

}
