classdef Deck < handle
    % A Deck is a 1-d array of 52 Cards.
    
    properties (Constant)
        NUM_SUITS=4;   % Number of suits
        NUM_RANKS=13;  % Number of ranks
    end
    
    
    properties (Access=private)
        cards= Card.empty();  % Array of Cards, initialized to empty array
    end
    
    
    
    methods
        function d = Deck()
            % Construct a a deck d which has pro is an array constructed of
            % 52 cards that contains cards of 4 suits and 13 ranks
            
            %outer loop:loops through number of suits
            for s = 1:Deck.NUM_SUITS
                
                %inner loop: loops through number of ranks
                for r = 1:Deck.NUM_RANKS
                    
                    %ind is ordered card in [1,52] by rank and suit
                    ind = (s-1)*13+r;
                    
                    %each constructed card object gets handle with index
                    d.cards(ind)= Card(s,r);
                end
            end
        end
        
    
        function shuffle(self)
            %takes constructed deck as an input, and shuffles it randomly
            %assigning shuffled deck back to itself
            
             if nargin ==1
                %initializing reference 1-D fill arrays
                bank = zeros(1,length(self.cards));
                fill = zeros(1,length(self.cards));
                
                %assigning deck array to temp variable for later assignment
                tempobjar = self.cards;
                
                %loops through length of deck
                for k = 1:length(self.cards)
                    
                    %initializing break condition
                    condition = true;
                    
                    %runs until condition is reassigned to false
                    while condition ~= false
                        
                        %i is a random index in interval [1,52]
                        i = floor(length(self.cards)*rand()+1); %r will be int in interval (1,52)
                        
                        %if the random index has not appeared in bank yet,
                        %condition will turn false and bank(index) will store 1
                        %indicating that index has been used
                        if bank(i) == 0
                            bank(i) = 1;
                            condition = false;
                        end
                    end
                    
                    %after a unique index is found, it is added to fill
                    %vector which stores all indexes in random progression
                    fill(k)=i;
                end

             end
             
             %handles from original obj array are reassigned to new object
             %array 
             for j = 1:length(fill)
                 self.cards(j) = tempobjar(fill(j));
             end
                                      
        end

        function c = takeACard(self)
            % Take a card from self (this deck).  If self is not empty, then
            % assign to c is the LAST card in self and make self.cards one
            % component shorter.  If self is empty then assign to c is an
            % empty array of class Card.
 
            if isempty(self.cards)==0
                c = self.cards(end);    %c gets the last card in deck array
                a= self.cards(1:end-1); %a gets handles of input deck, but 1 less
                self.cards = a;         %a assigned back to self
            else
                c = Card.empty();   %0x0 array of class card assigned to c
            end

        end

        function disp(self)
        % Display self, this deck of cards        
        if isempty(self)
            disp('Empty deck')
        else
            for k= 1:length(self.cards)
                fprintf('%s ', self.cards(k).getCardName())
                if rem(k,13)==0
                    fprintf('\n')
                end
            end
            fprintf('\n')
        end
        end
    end
    
end
