classdef Card < handle
% A Card has a suit and a rank
    properties (Constant)
        % Numeric constants representing the suits:
        HEART=1;
        SPADE=2;
        DIAMOND=3;
        CLUB=4;
    end
    properties (Access=private)
        suit  % an integer in [1..4] representing the suit
        rank  % an integer in [1..13] representing the rank
    end
    
    methods
        function c = Card(su, num)
        % Construct Card c:
        %   c.suit is su, an integer in [1..4]
        %   c.rank is num, an integer in [1..13]
            if nargin==2
                c.suit= su;  
                c.rank= num;
            end
        end
        
        function s = getSuit(self)
        % Return the suit (integer) of self (this Card).
            s= self.suit;
        end
        
        function r = getRank(self)
        % Return the rank (integer) of self (this Card).
            r= self.rank;
        end
        
        
        
        function v = getCardValue(self)
            % Return the value (integer) of self (this Card).  Ace has the
            % value 1 and each face card has the value 10; the remaining cards
            % each has a value that matches its rank.           

            %Checking rank of card as value depends on rank
            if self.getRank > 9 %cards >=10 have value of 10
                v = 10;
            else %ever other card gets value equal to its own rank
                v = self.getRank;
            end
                        
        end
       
        
        function n = getCardName(self)
            % Return the string representation of self (this Card). For example,
            % 'ACE-C' is the ace of clubs, '3-H' is the 3 of hearts, 'JACK-D'
            % is the Jack of diamonds, 'KING-S' is the King of spades, ..., etc.
            % n is a char row vector.
            
            %create bank of string representations for suit and rank
            cho = {'H','S','D','C'};
            choose = {'ACE','2','3','4','5','6','7','8','9','10','JACK','QUEEN','KING'};
            
            %suit & rank inputs serve as idx to choose from bank
            n = [choose{self.getRank} '-' cho{self.getSuit}];
           
        end
        
        function disp(self)
            if isempty(self)
                disp('No card')
            elseif length(self)>1
                disp@handle(self)
            else
                fprintf('%s', self.getCardName())
            end
        end
        
    end % public methods
    
end % class Card