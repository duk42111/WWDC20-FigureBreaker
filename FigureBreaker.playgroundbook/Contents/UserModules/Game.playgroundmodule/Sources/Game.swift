import Combine

/// Class responsible for having the state of the game and the progress of a player
public class Game {
    private var cancellables = Set<AnyCancellable>()
    private let gameLevel: GameLevel
    
    @Published public var state = CurrentGameState.readyToStart
    @Published public var remainingHp: Int = 3
    @Published public var currentScore: Int = 0
    @Published public var goalScore: Int
    
    /// Initialize the Game with a provided GameLevel
    public init(gameLevel: GameLevel) {
        self.gameLevel = gameLevel
        self.goalScore = gameLevel == .feasible ? 5 : 10
        
        observeRemainingHp()
        observeScore()
        observeState()
    }
    
    /// Observe for changes in the remainingHp property and change the state of the game to .gameOver when hp is lower than 1
    private func observeRemainingHp() {
        self.$remainingHp
            .sink { [weak self] (remainingHp) in
                guard let self = self else { return }
                
                if remainingHp < 1 {
                    self.state = .gameOver
                }
        }.store(in: &cancellables)
    }
    
    /// Observe for changes in the currentScore property and change the state of the game to .win when the current score is equal to the goal score
    private func observeScore() {
        self.$currentScore
            .sink { [weak self] (currentScore) in
                guard let self = self else { return }
                if currentScore == self.goalScore {
                    self.state = .win
                }
        }.store(in: &cancellables)
    }
    
    /// Observe for changes in the state property and assign the remainingHp, currentScore, and goalScore their initial values when the state is .inProgress
    private func observeState() {
        self.$state
            .sink { [weak self] (state) in
                guard let self = self else { return }
                
                if state == .inProgress {
                    self.remainingHp = 3
                    self.currentScore = 0
                    self.goalScore 
                        = self.gameLevel == .feasible ? 5 : 10
                }
        }.store(in: &cancellables)
    }
}
