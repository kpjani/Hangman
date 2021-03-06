# Hangman 



This is a Ruby program to play [Hangman game](https://en.wikipedia.org/wiki/Hangman_(game)), guessing words from [Strikingly](https://www.strikingly.com) server through a RESTful API.

Detailed description about the program is available [Here](https://github.com/joycehan/strikingly-interview-test-instructions/tree/new)

The Ruby program is written as per the instructions provided.

For guessing the words correctly, The program first uses the [character frequency information](http://www.datagenetics.com/blog/april12012/)

along with an [english dictionary](http://dreamsteep.com/projects/the-english-open-word-list.html)


Since for guessing each word, 10 guesses are allowed, the program first makes 3 guesses using the character frequency information.


Once one or more characters are correctly guess (that's the case most probably), the remaining characters are guessed by searching in the dictionary. 


For reducing the negative scoring,
 once it is determined that number of guesses left are  less than the number of attempts left, guessing that word is skipped.


To improve the search efficiency from dictionary, most common characters matching the required characters are identified and used as a guess.

The algorithm works very well for lengthy words as compared to shorter words, and scores more than 1000 most of the time. 

#Instructions

The file to be run is **"checking.rb"**