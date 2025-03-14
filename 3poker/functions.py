import deck
import random


# evaluates the value of a 3 card hand
def evaluate_hand(hand):
    if straight_flush(hand):
        result = 6
        return result
    if three_of_kind(hand):
        result = 5
        return result
    if straight(hand):
        result = 4
        return result
    if flush(hand):
        result = 3
        return result
    if pair(hand):
        result = 2
        return result
    else:
        result = 0
        return result

#if there are no other combination besides high card returns value of highest card
def high_card(hand):
    winner = 0
    values = [deck.value_rank[card[0]] for card in hand]
    sort = sorted(values, reverse = True)
    return sort[0]

#checks for straight flush
def straight_flush(hand):
    if straight(hand) and flush(hand):
        return True
    return False

#checks for 3 of a kind
def three_of_kind(hand):
    values = [[card[0]] for card in hand]
    if values[0] == values[1] and values[0] == values[2]:
        return True
    return False

#checks for straight
def straight(hand):
    values = [deck.value_rank[card[0]] for card in hand]
    sort = sorted(values)
    if sort[0] == sort[1]-1 and sort[1] == sort[2]-1:
        return True
    return False 

#checks for flush
def flush(hand):
    values = [[card[1]] for card in hand]
    if values[0] == values[1] and values[0] == values[2]:
        return True
    return False

#cheks for pair
def pair(hand):
    values = [[card[0]] for card in hand]
    if values[0] == values[1] or values[0] == values[2] or values[1] == values[2]:
        return True
    return False

#if both hands have just a pair
#checks for which pair has higher value
def both_pair(hand, hand1):
    values = [[card[0]] for card in hand]
    values1 = [[card[0]] for card in hand1]
    if values[0] == values[1] or values[1] == values[2]:
        dealerHand = values[1]
    if values[0] == values[2]:
        dealerHand = values[0]
    if values1[0] == values1[1] or values1[1] == values1[2]:
        playerHand = values1[1]
    if values1[0] == values1[2]:
        playerHand = values1[0]
    if dealerHand > playerHand:
        result = 2
        return result
    if dealerHand < playerHand:
        result = 1
        return result
    else:
        result = 0
        return result

#checks best card for dealer compared to best possible hand player can have
def dealer_evaluation(deck, hand, player_points):
    best_card = []
    random.shuffle(deck)
    dealer_pointer_possible = most_player_points(deck, hand)
    for card in deck:
        hypothetical_hand = hand + [card]
        posible_points = evaluate_hand(hypothetical_hand)
        if posible_points >= player_points:
            best_card.append([card])
            return best_card
        if posible_points == dealer_pointer_possible:
            best_card.append([card])
            return best_card

#checks best hand player can have
def most_player_points(deck, hand):
    posible_points = 0
    most_points = 0
    random.shuffle(deck)
    for card in deck:
        hypothetical_hand = hand + [card]
        posible_points = evaluate_hand(hypothetical_hand)
        if posible_points > 0 and posible_points > most_points:
            most_points = posible_points
    return most_points

#handles all beting
def wagering(wager, dealer_money, player_money, dealer_hand, player_hand, remaining_deck, exit, pot):
    player_money = player_money - wager

    dealer_wager_points = most_player_points(remaining_deck, dealer_hand)
    player_wager_points = most_player_points(remaining_deck, player_hand[:2])

    if dealer_wager_points >= 3 and player_wager_points <= 3:
        if random.random() < 0.8:
            print("Dealer Calls")
            dealer_money = dealer_money - wager
            pot = wager*2
        else:
            print("Dealer Doubles Your Bet. A Raise")
            dealer_money = dealer_money - (wager + (wager/2))
            pot = wager + wager*2
            print("Pot: ", pot)
            final_decision = int(input("Enter 1: to call\nEnter 2: to fold\n->"))
            if final_decision == 1:
                player_money = player_money - wager
                pot = pot + wager
                print("Pot: ", pot)
            if final_decision == 2:
                dealer_money = dealer_money + pot
                exit = 1
    else:
        if player_wager_points >= 4:
            if random.random() < 0.8:
                print("Dealer Calls")
                dealer_money = dealer_money - wager
                pot = wager*2
                print("Pot: ", pot)
            else:
                print("Dealer Folds")
                player_money = player_money + wager
                exit = 1
        elif player_wager_points >= 3:
            if random.random() < 0.9:
                print("Dealer Calls")
                dealer_money = dealer_money - wager
                pot = wager*2
                print("Pot: ", pot)
            else:
                print("Dealer Folds")
                player_money = player_money + wager
                exit = 1
        elif player_wager_points <= 2:
            print("Dealer Calls")
            dealer_money = dealer_money - wager
            pot = wager*2
            print("Pot", pot)
    

    return dealer_money, player_money, pot, exit

#checks for winning hand
def final_evaluation(dealer_hand, player_hand, dealer_money, player_money, pot):
    dealer_evaluation = evaluate_hand(dealer_hand)
    player_evaluation = evaluate_hand(player_hand)
    dealer_highCard = high_card(dealer_hand)
    player_highCard = high_card(player_hand)

    if dealer_evaluation == 2 and player_evaluation == 2:
        winner = both_pair(dealer_hand, player_hand)
        if winner == 2:
            print("Dealer Wins")
            dealer_money = dealer_money + pot
        elif winner == 1:
            print("Player Wins")
            player_money = player_money + pot
        elif winner == 0:
            print("Push")
            player_money = player_money + pot/2
            dealer_money = dealer_money + pot/2

    if dealer_evaluation == player_evaluation:
        if dealer_highCard > player_highCard:
            print("Dealer wins")
            dealer_money = dealer_money + pot
        elif dealer_highCard < player_highCard:
            print("Player wins")
            player_money = player_money + pot
        elif dealer_highCard == player_highCard:
            print("Push")
            player_money = player_money + pot/2
            dealer_money = dealer_money + pot/2

    else:
        if dealer_evaluation > player_evaluation:
            print("Dealer wins")
            dealer_money = dealer_money + pot
        else:
            print("Player Wins")
            player_money = player_money + pot
    return dealer_money, player_money

#percentage of AI being activated 
def percent_ran(AI, percentage, player_hand, dealer_hand, remaining_deck):
    if random.random() < percentage:
        dealer_hand = AI(player_hand, dealer_hand, remaining_deck) 
    else:
        hand = random.sample(remaining_deck, 1)
        dealer_hand.append(hand[0])

#AI
def AI(player_hand, dealer_hand, remaining_deck):
    player_hand = player_hand[:2] 

    points = most_player_points(remaining_deck, player_hand)
    winning_card = dealer_evaluation(remaining_deck, dealer_hand, points)
    if winning_card is None:
        winning_card = random.sample(deck.deck,1)
    dealer_hand.append(winning_card[0][0])

    return dealer_hand