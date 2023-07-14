classdef Player < Person
% A Player is a Person.  A Player is not the dealer and keeps track of the
% number of games won and lost.  A Player has three states:  0 indicating
% it has quit the game, 1 indicating HIT for the current round, and 2
% indicating STAY for the current round.
    
    properties (Constant)
        % Integers representing a Player's action status in one round:
        HIT=1;  
        STAY=2; 
        
        % An integer indicating that the Player quits the entire game:
        QUIT_GAME=0;
    end
    properties (Access=private)
        status     % the player's state: Player.QUIT_GAME, Player.HIT, or 
                   %   PLAYER.STAY
        gamesWon   % number of games the player has won
        gamesLost  % number of games the player has lost
    end
    
    methods
    
        function p = Player(nam)
        % Construct a Player p whose name is the string in nam.  If No
        % argument is passed, generate a random name for the player.
        % Initialize p.status to HIT and p.gamesWon and p.gamesLost to 0. 
            if nargin==0
                randInt= ceil(rand*1000);
                nam= sprintf('Player%d', randInt);
            end
            p= p@Person(nam);
            p.status= Player.HIT;
            p.gamesWon= 0;
            p.gamesLost= 0;
        end
        
        function s = getStatus(self)
        % Return self's status
            s= self.status;
        end
        
        function setStatus(self, s)
        % Set self's status to s.  Halt program execution if s is not a
        % valid Player status.
        
            %Checks for two inputs
            if nargin == 2                
                %if s ~= to a constant player property, error occurs
                if s ~= self.STAY && s ~= self.HIT && s ~= self.QUIT_GAME                    
                    error('Error status is invalid')%displays error
                else
                    self.status = s;
                end
            end
        end
        
        function win(self)
            % Increment self.gamesWon
            % if player wins, their gamesWon property increases by 1
            self.gamesWon= self.gamesWon+1;

        end
        
        function lose(self)
        % Increment self.gamesLost
        % if player loses, their gamesLost property increases by 1
        self.gamesLost= self.gamesLost+1;

        end
        
        function showStatistics(self)
        % Display self's name and game statistics (number of games won and
        % lost)
        
        %prints player's name, wins, and loses in one line
        fprintf('%s won %d and lost %d games\n', self.getName(),self.gamesWon(),self.gamesLost())
                     
        end
        
    end % public methods
end
