class AlphaBet:
    def __init__(self, lang, letters):
        self.lang = lang      
        self.letters = letters

    def print_letters(self):   # print letters of alphabet
        for i in self.letters:
            print(i)
    
    @property  #  getter count of letters in alphabet
    def letters_num(self):
        return len(self.letters)
    
class EngAlphabet(AlphaBet):
    _letters_num = 21
    example_text = "I love electronic music"
    def __init__(self):
        super().__init__("eng","abcdefghijklmnopqrstuvwxyz")
    
    def is_en_letter(self, letter):
        if letter.lower() in self.letters:
            print(f"The letter '{letter}' is in the English alphabet")
        else:
            print(f"The letter '{letter}' is not in the English alphabet")

    @property
    def abc_letters_num(self):
        return EngAlphabet._letters_num 
    
    @property
    def example(self):
        return self.example_text


object = EngAlphabet()
object.print_letters()
print(object.letters_num)
object.is_en_letter("F")
object.is_en_letter("Щ")
print(object.example)