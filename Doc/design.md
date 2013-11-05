Design document of Hangman
=============

- a list of database tables and fields (and their types) that you’ve decided to implement;

- a list of classes and methods (and their return types and/or arguments) that you’ve decided to implement;

- photos of whiteboard drawings;

- more advanced sketches of UIs.

# Section 1 – Purpose of project/sub-system
The app has to implement all the features that one could encounter during playing a typical hangman game.
<br>Please find Readme.md for more information on purpose/functionality.

# Section 2 – List of database tables and fields

Table that stores the data from eords.plist, for this table and id and word row is sufficient.
    
# Section 3 – A list of models and actions

For the gameplay display:
<ul>Answer lable that stores the word that the player have to guess for<i>
<li>Some representation for the already guessed letters</li>
<li>Label for remaining guesses</li>
<li>New Game button</li>
<li>Highscores button</li>
<li>Options button</li>
</ul>

A model has to be implemented to habdle the words, connection between database and view
Perhaps a model for highlights?

# Style guide

Commenting & Documentation

    Preferebly comment on each function, short descreption about it's purpose (I'm not going to comment out
    code that is generated with scaffolds though)

Indentation

    Preferred identation style:

    - (IBAction)lengthIncrement:(id)sender
    {
      // updates textField to match stepper
      self.length.text = [NSString stringWithFormat: @"%.0f", self.lengthStepper.value];
    
      // save value
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      [defaults setObject:self.length.text forKey:@"length"];
      [defaults synchronize];    
    }

Code Grouping

    Code lines that are that are suppose to serve the same task are going to be arringed in blocks and these
    blocks will be separated with spaces.

Naming Scheme
    
    Prefer usage of camelCase, such as: NewObjec, PriceIndex etc..
    
DRY Principle

    The same piece of code should not be repeated over and over again.

No Deep Nesting

    Preferablu reduce level of nesting, 

Limited Line Length

    Avoid writing horizontally long lines of code.

Capitalize SQL Special Words

    Capitalize SQL special words and function names to to distinguish them from your table and column names.
    
Source for style document:
<a href='http://net.tutsplus.com/tutorials/html-css-techniques/top-15-best-practices-for-writing-super-readable-code/'>
Top 15+ Best Practices for Writing Super Readable Code</a>
