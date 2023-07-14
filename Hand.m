classdef Hand < handle
%A Hand is a 1-d array of at most 5 Cards.
    
    properties (Constant)
        MAX_SIZE= 5;  % Max number of cards in a hand
    end
    properties (Access=private)
        cards= Card.empty();  % Array of Cards, initialized to empty array
    end
    
    methods
        function h = Hand()
        %Construct Hand h.  h.cards is initialized as an empty array.
            h.cards= Card.empty();
        end
        
        function cardArray = getCards(self)
        %Return cards of self (this hand)
            cardArray= self.cards;
        end
        
        
        
        function tf = isFull(self)
            %tf is true if self is a full hand; otherwise tf is false.
            
            %Compares length of array to constant maxsize property of self       
            if length(self.getCards) < self.MAX_SIZE
                tf = false; %if length<5, tx is false
            else
                tf = true; %if length is not <5, tx is true
            end
        end

        
        function v = getHandValue(self)
        %v is the sum of the values of the Cards in self (this hand).
            
            %initialize sum to 0
            v=0;
            
            %loops through length of deck and adds card value to deck sum
            for i = 1:length(self.cards)
                v = v + self.cards(i).getCardValue;
            end
            
        end
        
        function tf = isBlackjack(self)
        %tf is true if self is a hand whose value is 21; otherwise tf is false.
            if self.getHandValue == 21
                tf = true;
            else
                tf = false;
            end
            
        end
        
        function tf = isCharlie(self)
        %tf is true if self is a 5-card Charlie; otherwise tf is false.
            if self.isFull == true && self.getHandValue <=21
                tf=true;
            else
                tf=false;
            end

        end
        
        function canAdd = addCard(self, c)
        %canAdd is true if self isn't already a full hand; in this case add
        %Card c to self.  Otherwise canAdd is false and do not add Card c.
        if nargin ==2
            if self.isFull == false
                temp = self.cards;
                for i = 1:length(self.cards)+1
                    if i ~= length(self.cards)+1
                        self.cards(i)= temp(i);
                    else
                        if isempty(c)==0
                            self.cards(i)= c;
                        else
                            fprintf('Unable to deal card\n')
                        end
                        
                    end
                end              
                canAdd= true;
            else                
                canAdd= false;
                %self.cards=self.cards;
            end
        end
        
        end
        
        function clearHand(self)
        %Clear out the cards in self (this hand), i.e., set to empty array.
            self.cards= Card.empty();
        end
        
        function disp(self)
            % Display all the Cards in self (this hand) and if appropriate, the
            % string 'Charlie!' or 'Blackjack!'.  If this hand is both 5-card
            % Charlie and blackjack, display 'Charlie!'.

            
            if isempty(self) || isempty(self.cards)
                disp('Empty hand')
            else
                %self.getCards() returns an array with a length > 0                
                %loops through array of cards displaying each in the deck
                for i = 1:length(self.getCards)
                    fprintf('%s ',self.cards(i).getCardName);
                end
                
                %if deck is charlie and blackjack, displays charlie only                             
                if self.isCharlie == true && self.isBlackjack == true
                   disp('''Charlie''')
                %if deck is charlie displays charlie
                elseif self.isCharlie == true && self.isBlackjack == false
                    disp('''Charlie!''')
                %if deck is blackjack (no charlie) displays blackjack
                elseif self.isCharlie == false && self.isBlackjack == true
                    disp('''Blackjack!''')
                else
                    fprintf('\n')                     
                end
                
                dea = Dealer();
                

            end
            
        end
            
    end % public methods
    
end % class Hand