classdef Dealer < Person
% A Dealer is a Person who has a Deck (of Cards) and deals out cards in the
% game of black jack.  When the Dealer runs out of Cards in its deck it 
% gets a new Deck.  No statistics is kept for the Dealer.

    properties (Access=private)
        deck= Deck.empty();  % the deck of cards that Dealer holds
    end
    
    methods
        function dea = Dealer()
        % Construct Dealer dea:  a Dealer is given the name 'Dealer' and
        % a new Deck of Cards.  dea shuffles the deck.
            name= 'Dealer';
            dea= dea@Person(name);
            dea.prepareNewDeck()
        end
        
        function prepareNewDeck(self)
            % The dealer (self) gets a new deck of cards and shuffle it.
            
            %dealer gets new Deck
            self.deck = Deck();
            
            %dealer's new deck is shuffle immediatly
            self.deck.shuffle();
                          
        end


        
        function status = deal(self, n, hdt)
        % The dealer (self) deals n cards from its deck to Hand hdt. status
        % is true (1) if the n cards are dealt successfully; otherwise 
        % status is false (0) and display warning/diagnostic message(s).
            for k= 1:n
                c= self.deck.takeACard();
                if isempty(c)
                    self.prepareNewDeck()
                    c= self.deck.takeACard();
                end
                status= hdt.addCard(c);
                if status==false
                    fprintf('Unable to deal %dth card to the hand\n', k)
                end
            end
        end
        
        function finishHand(self)
            % The dealer (self) deals card from its deck to its hand until its
            % hand's value is >16 or until its hand is full.
            
            %if its hand is already > 16, will not add more cards,
            %otherwise:
            if self.getHand().getHandValue()<17
                                
                %initializing "break" condition
                condition = true;
                
                %loop runs until hands condition is false
                while condition ~= false
                    
                    %dealers hand gets a cards
                    self.getHand.addCard(self.deck.takeACard());
                    
                    
                    %if hand is not full and <16, condition remains true
                    if self.getHand().getHandValue()<17 && self.getHand().isFull == 0
                        condition = true;
                    else %if either criteria is broken, condition turns false
                        condition = false;
                    end

                end
            end
        end
        
    end % public methods
end