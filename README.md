CS394
=====

CS394 - iOS

**Programming Languages Used:** Swift

**Assignment 1 README:**

  * Everything else works as expected, dealer AI, score, hit, stand, etc.
  * The betting win/loss score is static for now

**Assignment 2 README:**

  * Uses 3 decks of cards
  * Multiple players (3 players) + Dealer
  * Ace is counted as both 1 and 11
  * Multiple Swift Classes: Card, Hand, Deck, Model
  * Built using interface builder, buttons for hit and stand and displaying score
  * Cards shuffled after 5 games
  
  * **Not done yet:** Although there are multiple players, only player 1 can be controlled at this time
   - The framework for other players is set up. (Array of players, var with currentPlayer)
   - Have to edit to switch players (increase currentPlayer by 1) when standing or hitting, instead of going straight to dealer's turn.

  * Extra credit: Calculate and recommend a player if they should hit based on Blackjack Basic Strategy.
