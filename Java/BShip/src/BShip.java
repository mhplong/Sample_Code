import java.util.Random;



public class BShip {

	/**
	 * @param args
	 */
	static char shipBoard1[][] = new char[10][10];
	static char fireBoard1[][] = new char[10][10];
	static char shipBoard2[][] = new char[10][10];
	static char fireBoard2[][] = new char[10][10];
	
	public static void main(String[] args) {
		init();
		placePieces(1);
		placePieces(2);
		showBoard(1);
		showBoard(2);
		AIFire(2);
		if (gameFinished() == 1) {
			System.out.println("Player 1 Won");
		} else if (gameFinished() == 2) {
			System.out.println("Player 2 Won");
		} else {
			System.out.println("Shouldn't Happen");
		}
	}
	
	public static void init() {
		for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 10 ; j++) {
				shipBoard1[i][j] = ' ';
				fireBoard1[i][j] = 'B';
				shipBoard2[i][j] = ' ';
				fireBoard2[i][j] = 'B';
			}
		}
	}

	
	// places six ships with various sizes on the board
	public static void placePieces(int player) {
		Random rndX = new Random();
		Random rndY = new Random();
		int x, y;
		
		char curBoard[][] = new char[10][10];
		
		if (player == 1) {
			curBoard = shipBoard1;
		}  else if (player == 2) {
			curBoard = shipBoard2;
		} else {
			System.out.println("Bad player number : " + player);
			System.exit(1);
		}
		
		int shipCount = 0;
		while (shipCount < 6) {
			x = Math.abs(rndX.nextInt() % 10);
			y = Math.abs(rndY.nextInt() % 10);
			
			if (curBoard[x][y] != ' ') {
				System.out.println("Dup");
				continue;
			}
			
			if (shipCount < 2 && (x + 1) < 10) {
				if (curBoard[x+1][y] != ' ') {
					System.out.println("Dup");
					continue;
				}
				curBoard[x][y] = 'T';
				curBoard[x+1][y] = 'T';
				shipCount++;
			} else if (shipCount < 4 && (x + 2) < 10) {
				if (curBoard[x+2][y] != ' ') {
					System.out.println("Dup");
					continue;
				}
				curBoard[x][y] = 'S';
				curBoard[x+1][y] = 'S';
				curBoard[x+2][y] = 'S';
				shipCount++;
			} else if (shipCount < 5 && (x + 3) < 10) {
				if (curBoard[x+3][y] != ' ') {
					System.out.println("Dup");
					continue;
				}
				curBoard[x][y] = 'B';
				curBoard[x+1][y] = 'B';
				curBoard[x+2][y] = 'B';
				curBoard[x+3][y] = 'B';
				shipCount++;
			} else {
				if ((x + 4) < 10) {
					if (curBoard[x+4][y] != ' ') {
						System.out.println("Dup");
						continue;
					}
					curBoard[x][y] = 'C';
					curBoard[x+1][y] = 'C';
					curBoard[x+2][y] = 'C';
					curBoard[x+3][y] = 'C';
					curBoard[x+4][y] = 'C';
					shipCount++;
				}
			}
			
			
			System.out.println("X: " + x + " and Y: " + y);
		}
		
	}
	
	public static void AIFire(int player) {
		char curFireBoard[][] = new char[10][10];
		char curBoard[][] = new char[10][10];
		int otherPlayer = 0;
		
		if (player == 1) {
			curBoard = shipBoard2;
			curFireBoard = fireBoard1;
			otherPlayer = 2;
		} else if(player == 2) {
			curBoard = shipBoard1;
			curFireBoard = fireBoard2;
			otherPlayer = 1;
		} else {
			System.out.println("Bad Player Number");
			System.exit(1);
		}
		
		for(int i = 0; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				if (curBoard[i][j] == ' ') {
					curFireBoard[i][j] = 'M';
				} else {
					curFireBoard[i][j] = curBoard[i][j];
					curBoard[i][j] = 'X';
				}
				showBoard(player);
			}
		}
		showBoard(otherPlayer);
	}
	
	public static int gameFinished() {
		
		int count1 = 0;
		int count2 = 0;
		for (int i = 0; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				if (shipBoard2[i][j] == ' ' || shipBoard2[i][j] == 'X') {
					count1++;
				}
				if (shipBoard1[i][j] == ' ' || shipBoard1[i][j] == 'X') {
					count2++;
				}
			}
		}
		
		if (count1 == 100) {
			return 1;
		} else if (count2 == 100) {
			return 2;
		}
		
		return 0;
	}
	
	public static void showBoard(int player) {
		char curBoard[][] = new char[10][10];
		char curFireBoard[][] = new char [10][10];
		String playerName = "";
		
		
		if (player == 1) {
			curBoard = shipBoard1;
			curFireBoard = fireBoard1;
			playerName = "Player 1";
		} else if (player == 2) {
			curBoard = shipBoard2;
			curFireBoard = fireBoard2;
			playerName = "Player 2";
		} else {
			System.out.println("Bad Player Number");
			System.exit(1);
		}
		
		System.out.println(playerName + "'s Ships Board and Hits Board\n");
		System.out.println("_______Ships_______     _______Shots_______");
		
		for(int i = 0; i < 10; i++) {
			for (int j = 0; j < 10; j++) {
				System.out.print(curBoard[i][j] + " ");
			}
			System.out.print("\t");
			for (int j = 0; j < 10; j++) {
				System.out.print(curFireBoard[i][j] + " ");
			}
			System.out.println();
		}
		
		System.out.println();
	}

}
