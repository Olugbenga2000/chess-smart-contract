 //SPDX-License-Identifier: Unlicense
 pragma solidity ^0.8.0;

 import {SystemTypes} from "./SystemTypes.sol";

contract BishopMove{
    
    uint count;
    SystemTypes.Position initialPosition;

    function validMovesFor(SystemTypes.Position memory _position) 
     public returns (SystemTypes.Position[] memory) {
        SystemTypes.Position[] memory validPositions = new SystemTypes.Position[](calculateNumberOfPossibleMoves(_position));
        initialPosition = SystemTypes.Position(_position.X, _position.Y);
        allBottomRightMoves(initialPosition, validPositions);
        allBottomLeftMoves(initialPosition, validPositions);
        allTopRightMoves(initialPosition, validPositions);
        allTopLeftMoves(initialPosition, validPositions);
        count = 0;

        return validPositions;   
    }

    function allBottomRightMoves(
        SystemTypes.Position memory currentPosition, SystemTypes.Position[] memory _validPositions  ) 
        private {
         while (true){

             if ( currentPosition.X == 8 || currentPosition.Y == 8 ){
                break;
            }
            currentPosition.X += 1;
            currentPosition.Y += 1;
            _validPositions[count] = SystemTypes.Position(currentPosition.X, currentPosition.Y);
            count++ ;

         }
    }

    function allBottomLeftMoves(
        SystemTypes.Position memory currentPosition, 
        SystemTypes.Position[] memory _validPositions  ) 
        private{
         while (true){

             if ( currentPosition.X == 8 || currentPosition.Y == 1){
                break;
            }
            currentPosition.X += 1;
            currentPosition.Y -= 1;
            _validPositions[count] = SystemTypes.Position(currentPosition.X, currentPosition.Y);
            count++ ;

         }
    }

    function allTopRightMoves(
        SystemTypes.Position memory currentPosition, 
        SystemTypes.Position[] memory _validPositions  ) 
        private{
         while (true){

             if ( currentPosition.X == 1 || currentPosition.Y == 8){
                break;
            }
            currentPosition.X -= 1;
            currentPosition.Y += 1;
            _validPositions[count] = SystemTypes.Position(currentPosition.X, currentPosition.Y);
            count++ ;

         }
    }

    function allTopLeftMoves(
        SystemTypes.Position memory currentPosition, SystemTypes.Position[] memory _validPositions  ) 
        private{
         
         while (true){
             if ( currentPosition.X == 1 || currentPosition.Y == 1){
                break;
            }
            currentPosition.X -= 1;
            currentPosition.Y -= 1;
            _validPositions[count] = SystemTypes.Position(currentPosition.X, currentPosition.Y);
            count++ ;

         }
    }
    
    
    function calculateNumberOfPossibleMoves(SystemTypes.Position memory _position) private pure returns (uint){
        uint topLeft = min(_position.X, _position.Y) - 1;
        uint topRight = min(_position.X, 9 - _position.Y) - 1;
        uint bottomLeft = 8 - max(_position.X, 9 - _position.Y);
        uint bottomRight = 8 - max(_position.X, _position.Y);
        return( topLeft + topRight + bottomLeft + bottomRight);
    }

    function min(uint x, uint y) private pure returns(uint){
        return(x >= y ? y : x);
    }

    function max(uint x, uint y) private pure returns(uint){
        return(x >= y ? x : y);
    }
}
