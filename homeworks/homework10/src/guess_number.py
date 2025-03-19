import random
def guess_number(min_value, max_value, tries):
    random_number = random.randint(min_value,max_value)
    print(f"Hi! This is game \"Guess the Number\"")
    print(f"You need to guess a number between {min_value} and {max_value}.")
    print(f"You have {tries} tries. Let's start!\n")
    while tries > 0:
        try:
            value_of_player = int(input("Enter the number: "))
        except ValueError:  
            print("Please enter a valid integer!")
            continue
        if random_number == value_of_player:
            print("Congratulations, you win!")
            break
        elif random_number > value_of_player:
            print(f"The number is greater than {value_of_player}.")
        else:
             print(f"The number is less than {value_of_player}.")   
        tries-=1
        print(f"You have {tries} tries.\n")
    if value_of_player != random_number:
        print(f"You lose, try again. The winnable number was {random_number}.")
guess_number(1,100,5)
