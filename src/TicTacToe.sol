// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TicTacToe {
    error PositionAlreadyUsed();
    error NotYourTurn();
    error AlreadyFinished();
    
    address public player1;
    address public player2;
    address public currentPlayer;
    address public winner;

    uint8[3][3] internal board;
    bool internal finished;

    constructor(address _player1, address _player2) {
        player1 = _player1;
        player2 = _player2;
        currentPlayer = _player1;
    }

    function play(uint8 i, uint8 j) external {
        // revert if a player tries to play in a position already used
        if (board[i][j] != 0) {
            revert PositionAlreadyUsed();
        } 

        // revert if the current player is not the msg sender
        if (currentPlayer != msg.sender) {
            revert NotYourTurn();
        }

        // revert if the game is already finished
        if (finished == true) {
            revert AlreadyFinished();
        }

        // used to identify the players in the game (player1 = 1) (player2 = 2) 
        if (msg.sender == player1) {
            board[i][j] = 1;
            // switch to player2
            currentPlayer = player2;
        } else {
            board[i][j] = 2;
            // switch to player1 
            currentPlayer = player1;
        }

        // check if someone has won, set the game to finished and who's the winner
        if (checkWin() == true) {
            finished = true;
            winner = msg.sender;
        }
    }

    function checkWin() private view returns (bool) {
        // used to check if some player has won in the horizontal lines
        for (uint8 i = 0; i < 3; i++) {
            if ((board[i][0] == board[i][1]) && (board[i][1] == board[i][2])) {
                if (board[i][0] != 0) {
                    return true;
                }
            }
        }

        // used to check if some player has won in the vertical columns
        for (uint8 j = 0; j < 3; j++) {
            if ((board[0][j] == board[1][j]) && (board[1][j] == board[2][j])) {
                if (board[0][j] != 0) {
                    return true;
                }
            }
        }

        // used to check if some player has won in the diagonal lines
        if ((board[0][0] == board[1][1]) && (board[1][1] == board[2][2]) ||
            (board[0][2] == board[1][1]) && (board[1][1] == board[2][0])) {     
            if (board[0][0] != 0) {
                return true;
            }
        }

        return false;
    }
}
