import random
import time
import deck
import functions
import sys

def main():
    # how much money a person is starting out with 
    cash_in = int(input("How much money are you sitting down with: "))
    while(True):
        dealer_money = 0
        player_money = 0
        exit = 0
        pot = 0

        #increases the amount of AI if player doubled their money
        cheating = 0.15
        if player_money > cash_in*1.25:
            cheating = 0.3

        #first bet for player and creation of hands 
        wager = int(input("How much would you like to wage?: "))
        dealer_hand = random.sample(deck.deck, 2)
        remaining_deck = [card for card in deck.deck if card not in dealer_hand]
        player_hand = random.sample(deck.deck, 3)
        remaining_deck = [card for card in deck.deck if card not in dealer_hand]

        #showing hands and handling betting 
        print("Player's Cards", player_hand[:2], "[Face Down Card]")
        time.sleep(0.5)
        print("Dealer's Cards", dealer_hand, "[Face Down Card]")
        time.sleep(4)

        #the amount of money dealer and player wagered and pot size
        dealer_money, player_money, pot, exit = functions.wagering(wager, dealer_money, player_money, dealer_hand, player_hand[:2], remaining_deck, exit, pot)

        #if player or dealer doesn't fold
        if exit != 1:
            time.sleep(2)

            #30% of the time the AI will kick in
            functions.percent_ran(functions.AI, cheating, player_hand, dealer_hand, remaining_deck)

            print("Player's Hand ", player_hand)
            time.sleep(1)
            print("Dealer's Hand ", dealer_hand, "\n")
            
            #find out who wins
            dealer_money, player_money = functions.final_evaluation(dealer_hand, player_hand, dealer_money, player_money, pot)
            cash_in = cash_in + player_money

        #looped to play again
        print("You have: ", cash_in)
        again = input("Play Again?\nY or N\n->")
        if again == "N" or again == "n":
            sys.exit()
        print("\n")
main()

