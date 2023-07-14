function simBlackjack(playerNames)
% Simulate a game of Blackjack.  playerNames is a 1-d cell array of char
% vectors; each char vector is the name of one player. playerNames is not empty.

clc
fprintf('Welcome to Blackjack\n\n')

numPlayers= length(playerNames);

% Instantiate the dealer and players
dea= Dealer();
for k= numPlayers:-1:1
   players(k)= Player(playerNames{k}); 
end

% Game loop
playing= 1;
while playing
    % Deal a new round
    dealNewRound(dea, players); 
    
    % One at a time, the players complete their hands
    completePlayersHands(players, dea);
    
    % Dealer finishes its hand
    dea.finishHand()
    
    % Evaluate this round, display results, and update player statistics
    fprintf('\n----------------------------------------\n')
    outputResults(dea, players);
    fprintf('----------------------------------------\n')
    
    % Start another round? 
    playing= promptNextRound(players);
end

% Display final statistics (#games won and lost) of all players
printStats(players)

% The End
disp('Goodbye')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dealNewRound(dea, players)
% Deal a new round:  Clear the hand of the dealer and each active player.
% Reset each active player's status to HIT.  The dealer and each active
% player gets 2 cards; display their hands.
% dea: the Dealer
% players: 1-d array of the Players in the game
dea.getHand().clearHand()
yesno= dea.deal(2, dea.getHand());
dea.disp()
for k= 1:length(players)
  if players(k).getStatus()~=Player.QUIT_GAME
      players(k).getHand().clearHand()
      players(k).setStatus(Player.HIT)
      yesno= dea.deal(2, players(k).getHand());
      players(k).disp()
  end
end

   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function completePlayersHands(players, dea)
% For each active player, repeatedly obtain user input and perform the 
% action until each the player is at stay/21/bust/fullhand
% players: 1-d array of the Players in the game
% dea: the Dealer
for k= 1:length(players)
   while players(k).getStatus()~=Player.QUIT_GAME ...
         && players(k).getStatus()~=Player.STAY ...
         && players(k).getHand().getHandValue() < 21 ...
         && ~(players(k).getHand().isFull()) 
       fprintf('\nWhat would %s like to do? ', players(k).getName())

       action= input('(1:HIT  2:STAY  0:QUIT GAME) ');      
       players(k).setStatus(action)
       if action==Player.HIT
           yesno= dea.deal(1, players(k).getHand());
           players(k).disp()
       end
   end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function outputResults(dea, players)
% Evaluate this round and for each active player display the result and 
% update its statistics.  Rules of the game:
% A player with 5-Card Charlie automatically wins against dealer. Otherwise
% - If both player and dealer bust, the player loses
% - If dealer busts and the player does not, the player wins
% - If player does not bust and has a hand with a value higher than 
%   dealer's, the player wins
% - If player's hand and dealer's hand both have the same value (including 
%   blackjack), dealer wins
% See example output on course website for the display format.
% dea: the Dealer
% players: 1-d array of the Players in the game


%dealer inherits person's disp method, so hand and possible bust displayed
dea.disp()


%was unsure how to get rid of charlie, however I felt I was close
%dealer inherits person's disp method, so hand and possible bust displayed
% if dea.getHand().isCharlie~=true
%     dea.disp()    
% else
%     if dea.getHand().isBlackjack == true
%         for i = 1:length(dea.getHand().getCards)
%             fprintf('%s',dea.getName())
%             disp(dea.getHand().getCards)
%             %fprintf('%s %s',dea.getName(),dea.getHand().getCards(i).getCardName);
%             disp('''Blackjack!''')
%             fprintf('\n')
%         end
%     else
%         for i = 1:length(dea.getHand().getCards)
%             %fprintf('%s %s',dea.getName(),dea.getHand().getCards(i).getCardName);
%             fprintf('%s',dea.getName())
%             disp(dea.getHand().getCards)
%             fprintf('\n')
%         end
%     end
% end

%loops through all the current players
for n = 1:length(players)
    
    %if a player left, this "if" will prevent players hand from displaying
    if players(n).getStatus ~= 0
        
        %players who are active have their hands displayed
        players(n).disp()
        
        
        %if dealer busts and player does not, player wins
        
        if players(n).getHand().getHandValue() <= 21 && dea.getHand().getHandValue() > 21
            
            %adds 1 win to gamesWon property of player
            players(n).win()
            
            %prints player won
            fprintf('%s won\n', players(n).getName())
            
          
        % if neither player/dealer bust, need more information to determine
            
        elseif players(n).getHand().getHandValue() <= 21 && dea.getHand().getHandValue() <= 21
            
            %if player's hand is < or = to dealers, need more info
            if players(n).getHand().getHandValue() <= dea.getHand().getHandValue()
                
                %if player's hand is not charlie, player loses
                if players(n).getHand().isCharlie == false
                   players(n).lose()
                   fprintf('%s lost\n', players(n).getName())
                                        
                %if player's hand is charlie, player automatically wins    
                else
                    if n~= length(players)
                        players(n).win()
                        fprintf('%s won', players(n).getName())
                    else
                        players(n).win()
                        fprintf('%s won\n', players(n).getName())
                    end
                end
                           
            %if player's hand is larger than dealer's, player wins
            else
                if players(n).getHand().isBlackjack == true && n~= length(players)
                    players(n).win()
                    fprintf('%s won', players(n).getName())     
                else
                    players(n).win()
                    fprintf('%s won\n', players(n).getName())
                    
                end
            end
        
        %if player and dealer bust, player loses    
        elseif players(n).getHand().getHandValue() > 21 && dea.getHand().getHandValue() > 21
            players(n).lose()
            fprintf('%s lost\n', players(n).getName())
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function yesno = promptNextRound(players)
% Start another round?  NO if there're no active players; otherwise
% prompt user for inp1ut.
% players: 1-d array of the Players in the game
% yesno: 1 if there should be a next round; otherwise 0.
numActivePlayers= 0;
for k= 1:length(players)
    if players(k).getStatus()~=Player.QUIT_GAME
        numActivePlayers= numActivePlayers + 1;
    end
end
if numActivePlayers==0
    yesno= 0;
else
    yesno= input('Start another round? (1:YES  0:NO) ');
    fprintf('\n')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function printStats(players)
% Display final statistics (#games won and lost) of all players
% players: 1-d array of the Players in the game

   for n = 1:length(players)
       players(n).showStatistics()   
   end

