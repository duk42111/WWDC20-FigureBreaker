import PlaygroundSupport

/*:
 # Welcome to the FigureBreaker!
 Put your **reaction** and **attention to detail** to test in this game!
 
 # Instructions
 
 * Three types of colored figures are randomly created and launched into the scene: **Box**, **Sphere**, and **Pyramid**:
 
 ![Figures](figures.png)
 * To win the game, you need to hit target figures and ignore others. Remember that not only do you need to take into account the type of the figure, but also its **color**. We have the following colors in the game:
 
 ![Colors](colors.png)
 * Depending on the **GameLevel**, you will have to successfully hit either 5 (for **.feasible**) or 10 (for **.challenging**) target figures to win the game (the rate of figure launching will also be different):
 
 */

let gameScene = GameScene(gameLevel: .feasible)

/*:
 * Move your cursor or finger around the screen and "slice" figures. Be careful not to hit wrong figures, you have only **3** lives!
 * The target figure randomly changes and is displayed on the top of the scene:
 
 ![Target Figure](targetFigure.png)
 
 - Note:
 Before running the game, do not forget to **turn the "Enable Results" off** so that the game runs smoothly:
 
 ![Disable Results](disableResults.png)
 
 # Enjoy!
 */


let gameView = GameView(gameScene: gameScene)
let gameController = GameController(gameView: gameView)

PlaygroundPage.current.wantsFullScreenLiveView = true
PlaygroundPage.current.liveView = gameView
