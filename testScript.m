% Some tests for the classes in Project 6 Blackjack simulation
clear all
clc

%this document uses randomly created tests and should pass every test
%every time the script is run

format compact

disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------- CLASS CARD -----------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')

%instantiating cards
c1= Card(2, 6);                             
c2= Card(Card.SPADE, 9);                
c3= Card(Card.CLUB, 11);
c4= Card(2, 1);
c5= Card(2, 13);
c6= Card(2, 10);

test = [c1 c2 c3 c4 c5 c6];

disp('---- getSuit ----')
for i = 1:length(test)
    disp(test(i).getSuit)
end

disp('---- getRank ----')
for i = 1:length(test)
    disp(test(i).getRank)
end

disp('---- getCardValue ----')
for i = 1:length(test)
    disp(test(i).getCardValue)
end

disp('---- getCardName ----')
for i = 1:length(test)
    disp(test(i).getCardName)
end


disp('---- Check if Card Constructor Creates Every Card----')
for s = 1:4
    for r = 1:13
        ind = (s-1)*13+r;
        c = Card(s,r);
        fprintf('%s \n', c.getCardName)
    end
end

disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------- CLASS HAND -----------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')


disp('---- Test class Hand ----')
h=Hand()        %should return empty hand

disp('---- Test class Hand ----')
b = [];
for n = 1:5
    c = Card(floor(4*rand()+1),floor(13*rand()+1));
    b = [b c];
    h.addCard(c);
    disp(h)         
end


disp('---- Test isFull ----')

f=Hand();
for i = 1:length(b)
    f.addCard(b(i));
    yesno = f.isFull  %should output 0,0,0,0,1
end



disp('---- Test getHandValue ----')
fprintf('\n')
fprintf('Is ---  %d  --- equal to the sum of above cards?\n\n', h.getHandValue)


disp('---- Test isBlackjack ----')
clear

h=Hand();
while h.getHandValue~=21
    h=Hand();
    for n = 1:(floor(5*rand()+1))
        c = Card(floor(4*rand()+1),floor(13*rand()+1));
        h.addCard(c);
    end
end





disp(h)

yesno = h.isBlackjack     %should display 1



disp('------test isCharlie------')


h=Hand();
condition = false;
while h.isFull==false || h.getHandValue>21
    h=Hand();
    for n = 1:(floor(5*rand()+1))
        c = Card(floor(4*rand()+1),floor(13*rand()+1));
        h.addCard(c);
    end
end

disp(h)
yesno = h.isCharlie             %should show 1


disp('------test addCard------')

h=Hand();
a=(floor(10*rand()+1));
fprintf('original amount of cards to be added %d\n',a)
for n = 1:a
    c = Card(floor(4*rand()+1),floor(13*rand()+1));    
    h.addCard(c)    %should at most 5 logical 1 outputs
end
fprintf('Hand:   ')
disp(h)



disp('------test disp------')
fprintf('\n\n')

d = Hand();
disp(d) % should disp 'Empty Hand'
fprintf('\n\n')
clear
h=Hand();
condition = false;
while h.isFull==false || h.getHandValue~=21
    h=Hand();
    for n = 1:(floor(5*rand()+1))
        c = Card(floor(4*rand()+1),floor(13*rand()+1));
        h.addCard(c);
    end
end
disp(h)     %should display 'Charlie' not 'BlackJack'
fprintf('\n\n')
clear
h=Hand();
condition = false;
while h.isFull==false || h.getHandValue>20
    h=Hand();
    for n = 1:(floor(5*rand()+1))
        c = Card(floor(4*rand()+1),floor(13*rand()+1));
        h.addCard(c);
    end
end
disp(h)     %should display 'Charlie'
fprintf('\n\n')
clear
h=Hand();
condition = false;
while h.getHandValue~=21
    h=Hand();
    for n = 1:(floor(5*rand()+1))
        c = Card(floor(4*rand()+1),floor(13*rand()+1));
        h.addCard(c);
    end
end
disp(h)     %should display'BlackJack'
fprintf('\n\n')


disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------- CLASS DECK -----------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
fprintf('\n\n')

disp('---Test Deck Constructor---')

d = Deck(); 
disp(d)         %should instantiate a deck with no cards missing

disp('---Test Shuffle---')

%none of the shuffled decks should be the same
for i=1:10
    a = Deck();
    a.shuffle()
    disp(a)
end


disp('---Take a Card---')
fprintf('\n')
disp('Original shuffled Deck')
clear
a = Deck();
a.shuffle();
disp(a)
for i=1:59
    b = a;
    c = b.takeACard();
    fprintf('card taken:')
    disp(c)
    fprintf('\n\n')
    fprintf('remaining deck:')
    fprintf('\n')
    disp(a)
    fprintf('\n')
end
%should expect to a shuffled deck that has its last card removed every
%iteration. when no cards are left, should display No card

clear 




disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------- Test class Player ----------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')

%expect 30 randomly created player names
bank={'chad','braddddy','erfdsf42s','elon musk', 'yeah boii12'};
for i = 1:50
    timeswon = ceil(25*rand());
    timeslost = ceil(25*rand());
    
    y = rem(ceil(25*rand()),2)
    if y ==0
        a(i) = Player();
    else
        t = bank{ceil(floor(5*rand()+1))};
        a(i) = Player(t);
    end
    disp(a(i))             %random name followed by: empty hand
    set1 = floor(3*rand());
    set = floor(3*rand());   
      
    
    fprintf('randomly generated vallues to compare:\n')
    fprintf(' wins:    %d\n losses: %d\n status1: %d\n status2: %d\n\n', timeswon, timeslost,set1,set) 
    for w = 1:timeswon
        a(i).win()
    end
       
    for w = 1:timeslost
        a(i).lose()
    end
    
    a(i).setStatus(set1)
    disp(a(i).getStatus())
    
    a(i).setStatus(set)
    disp(a(i).getStatus)    %status should be same as randomly set value
    
    
    a(i).showStatistics()
    fprintf('\n\n')
    
end


    

disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------- Test class Dealer ----------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
clear
fprintf('\n\n\n')



for i = 1:20
    dealer= Dealer()
    yesno= dealer.deal(floor(5*rand()+1), dealer.getHand())
    dealer.getHand().disp() % should see  % should see 2 cards
    yesno= dealer.deal(5*rand()+1, dealer.getHand())
    dealer.getHand().disp()
    dealer.getHand().clearHand()
    dealer.getHand().disp()
    dealer.finishHand()
    dealer.getHand().disp()
    disp(dealer.getHand().getHandValue())
end
clear



disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')
disp('----------------------------------------------------------')




