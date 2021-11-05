//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../libraries/KnightMove.sol";
import "../libraries/BishopMove.sol";
import "../libraries/QueenMove.sol";
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol"; 
import "hardhat/console.sol";
contract ComplexGame is IGame {
    mapping(uint => SystemTypes.Position) positions;

    function play(uint256 _moves) override external { 
         uint num = 3; // number of pieces
         uint possibles_length;
         KnightMove knight = new KnightMove();
         BishopMove bishop = new BishopMove();
         QueenMove queen = new QueenMove();
         SystemTypes.Position memory knightCurrentPosition = positions[0];
         SystemTypes.Position memory bishopCurrentPosition = positions[1];
         SystemTypes.Position memory queenCurrentPosition = positions[2];
         console.log("Knight's initial position is (%d, %d)", knightCurrentPosition.X, knightCurrentPosition.Y);
         console.log("Bishop's initial position is (%d, %d)", bishopCurrentPosition.X, bishopCurrentPosition.Y);
         console.log("Queen's initial position is (%d, %d)", queenCurrentPosition.X, queenCurrentPosition.Y);

         for (uint i = 0; i < _moves; i++) {
          uint rand = Randomizer.random(i) % num; 

          if(rand == 0){
              SystemTypes.Position[] memory possibles = knight.validMovesFor(knightCurrentPosition);
              possibles_length = possibles.length;
              while(true){
              uint r = Randomizer.random( possibles_length) % possibles.length; 
              knightCurrentPosition = possibles[r]; 

              if((knightCurrentPosition.X == bishopCurrentPosition.X && knightCurrentPosition.Y == bishopCurrentPosition.Y)
               || (knightCurrentPosition.X == queenCurrentPosition.X && knightCurrentPosition.Y == queenCurrentPosition.Y)){
                 possibles_length++ ;
                  continue;
              }
              console.log("%d : moving Knight to Position (%d,%d)", i, knightCurrentPosition.X, knightCurrentPosition.Y); 
              break;
          }
          }

         else if(rand == 1){
              SystemTypes.Position[] memory possibles = bishop.validMovesFor(bishopCurrentPosition);
              possibles_length = possibles.length;
              while(true){
              uint r = Randomizer.random(possibles_length) % possibles.length; 
              bishopCurrentPosition = possibles[r]; 

              if((bishopCurrentPosition.X == knightCurrentPosition.X && bishopCurrentPosition.Y == knightCurrentPosition.Y)||
               (bishopCurrentPosition.X == queenCurrentPosition.X && bishopCurrentPosition.Y == queenCurrentPosition.Y)){
                   possibles_length++ ;
                  continue;
              }
              console.log("%d : moving Bishop to Position (%d,%d)", i, bishopCurrentPosition.X, bishopCurrentPosition.Y); 
              break;
          }
       }

        else {
              SystemTypes.Position[] memory possibles = queen.validQueenMoves(queenCurrentPosition);
              possibles_length = possibles.length;
              while(true){
              uint r = Randomizer.random(possibles_length) % possibles.length; 
              queenCurrentPosition = possibles[r]; 

              if((queenCurrentPosition.X == knightCurrentPosition.X && queenCurrentPosition.Y == knightCurrentPosition.Y) ||
               (queenCurrentPosition.X == bishopCurrentPosition.X && queenCurrentPosition.Y == bishopCurrentPosition.Y)){
                 possibles_length++ ;
                  continue;
              }
              console.log("%d : moving Queen to Position (%d,%d)", i, queenCurrentPosition.X, queenCurrentPosition.Y); 
              break;
          }
       }
       
    }
    }
    
    function setup() external override {
         positions[0] = SystemTypes.Position(3,3); // Knight's position
         positions[1] = SystemTypes.Position(2,1); // Bishop's position
         positions[2] = SystemTypes.Position(4,5); // Queen's position
         
    }
} 