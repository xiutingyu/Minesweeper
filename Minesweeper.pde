import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons;
public final static int NUM_BOMBS=50; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton> (); //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r=0; r<NUM_ROWS;r++)
    {
        for (int c=0; c<NUM_COLS; c++)
            buttons[r][c]=new MSButton(r,c);
    }
    setBombs();
    
}
public void setBombs()
{
    for (int i=0; i<20; i++)
    {
        int row=((int)(Math.random()*20));
        int col=((int)(Math.random()*20));
        if(!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);//your code
            
        }
    }
}

public void draw ()
{
    background( 0 );
    if(!gameOver&&isWon()){
        displayWinningMessage();
    }
}
public boolean isWon()
{
   for (int r=0; r<NUM_ROWS; r++){
       for (int c=0; c<NUM_COLS;c++){
          if (!bombs.contains(buttons[r][c])&&!buttons[r][c].isMarked()){
            return false; 
          }
      }
   } 
    return true;//your code here
}
public void displayLosingMessage()
{
    buttons[10][5].setLabel("Y");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("U");
    buttons[10][8].setLabel(" ");
    buttons[10][9].setLabel("L");
    buttons[10][10].setLabel("O");
    buttons[10][11].setLabel("S");
    buttons[10][12].setLabel("E");
    buttons[10][13].setLabel("!");
 //your code here
}
public void displayWinningMessage()
{
    buttons[10][1].setLabel("Y");
    buttons[10][2].setLabel("O");
    buttons[10][3].setLabel("U");
    buttons[10][4].setLabel(" ");
    buttons[10][5].setLabel("A");
    buttons[10][6].setLabel("R");
    buttons[10][7].setLabel("E");
    buttons[10][8].setLabel(" ");
    buttons[10][9].setLabel("T");
    buttons[10][10].setLabel("H");
    buttons[10][11].setLabel("E");
    buttons[10][12].setLabel("");
    buttons[10][13].setLabel("W");
    buttons[10][14].setLabel("I");
    buttons[10][15].setLabel("N");
    buttons[10][16].setLabel("N");
    buttons[10][17].setLabel("E");
    buttons[10][18].setLabel("R");
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed==true)
            marked=!marked;
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(""+countBombs(r,c));
        else 
        {
             if(isValid(r+1,c)&&buttons[r+1][c].isClicked()==false) // 8 if loops
                 buttons[r+1][c].mousePressed();

             if(isValid(r-1,c)&&buttons[r-1][c].isClicked()==false)
                 buttons[r-1][c].mousePressed();

             if(isValid(r,c+1)&&buttons[r][c+1].isClicked()==false)
                 buttons[r][c+1].mousePressed();

             if(isValid(r,c-1)&&buttons[r][c-1].isClicked()==false)
                 buttons[r][c-1].mousePressed();

             if(isValid(r-1,c-1)&&buttons[r-1][c-1].isClicked()==false)
                buttons[r-1][c-1].mousePressed();
            
             if(isValid(r-1,c+1)&&buttons[r-1][c+1].isClicked()==false)
                buttons[r-1][c+1].mousePressed();
            
             if(isValid(r+1,c+1)&&buttons[r+1][c+1].isClicked()==false)
                buttons[r+1][c+1].mousePressed();
            
             if(isValid(r+1,c-1)&&buttons[r+1][c-1].isClicked()==false)
             buttons[r+1][c-1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
            rect(x, y, width, height);
            fill(0);
            text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if (r<20 && r>=0 && c<20 && c>=0)
           return true;//your code here
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if (isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
        {
           numBombs++;
        }
        if (isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
        {
           numBombs++;
        }
        if (isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
        {
           numBombs++;
        }
        if (isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
        {
           numBombs++;
        }
        if (isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
        {
           numBombs++;
        }
        if (isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
        {
           numBombs++;
        }
        if (isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
        {
           numBombs++;
        }
        if (isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
        {
           numBombs++;
        }
//your code here
        return numBombs;
    }
}



