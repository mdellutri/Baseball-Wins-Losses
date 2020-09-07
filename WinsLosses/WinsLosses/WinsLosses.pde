//Mason Dellutri
//2/18/2020
//Assignment #3
//Sources to site: Processing Online Documentation
//                 
    
    //Setup variables used in multiple methods
    Table winsTable;
    Table lossesTable;
    String[] teamNames = new String[30];
    int[][] winsArray;
    int[][] lossesArray;
    int columnCount;
    int rowCount;
    int highlightedRow = 0;
    int difference = 1;
    
    //setup creates the window, loads the data from files into 2d arrays,
    // and gets useful information
    void setup(){
      size(600,600);
      background(85,120, 250);
      
      winsTable = loadTable("wins.csv");
      lossesTable = loadTable("losses.csv");
      columnCount = winsTable.getColumnCount();
      rowCount = winsTable.getRowCount();
      winsArray = new int[columnCount-1][rowCount];
      lossesArray = new int [columnCount-1][rowCount];
      int count = 0;
      for (TableRow row : winsTable.rows()){
        for ( int j = 0; j < columnCount-1; j++){
          winsArray[j][count]= row.getInt(j+1); 
        }
        teamNames[count]=row.getString(0);
        count++;
      }
      count = 0;
      for (TableRow row : lossesTable.rows()){
        for ( int j = 0; j < columnCount-1; j++){
          lossesArray[j][count]= row.getInt(j+1); 
        }
        count++;
      }
      
    }
  
    
    void draw(){
      background(85,120, 250);
      float heightY = height - 20;
      float widthX = width - 20;
      stroke(30,30,80); 
      line(0,300, 600, 300);
      float oldX, oldY, newX, newY;
      oldX= 10;
      oldY=height/2;
      float spacing = widthX/(columnCount);
      float winLossAverage = 0;
      for(int team = 0; team < rowCount; team++) {
          stroke(30+difference,30+difference,80+difference); 
          winLossAverage = 0;
          if(highlightedRow != team){
            for(int games = 0; games < columnCount-1; games++){
           
                winLossAverage = ((winsArray[games][team])*1.0)/((winsArray[games][team] + lossesArray[games][team])*1.0);
                newY = (winLossAverage * heightY)+ 10;
                newX = oldX+spacing;
                
                line(oldX,oldY, newX, newY);
                oldX = newX;
                oldY = newY;
                println(winLossAverage);
                println(newY);
            }
          }
  
          difference += 5;
          oldX= 10;
          oldY=height/2;
      }
       for(int games = 0; games < columnCount-1; games++){
              winLossAverage = ((winsArray[games][highlightedRow])*1.0)/((winsArray[games][highlightedRow] + lossesArray[games][highlightedRow])*1.0);
              newY = (winLossAverage * heightY)+ 10;
              newX = oldX+spacing;
              stroke(255,255,255);
              text(""+teamNames[highlightedRow], 50, 60);
              line(oldX,oldY, newX, newY);
              oldX = newX;
              oldY = newY;
              println(winLossAverage);
              println(newY);
            }
      difference = 1;
    }
    
    void keyPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
         highlightedRow++;
         if (highlightedRow > rowCount-1){
            highlightedRow = 0; 
         }
      } else if (keyCode == DOWN) {
        highlightedRow--;
        if (highlightedRow < 0){
            highlightedRow = rowCount-1; 
         }
      } 
    } 
  }
