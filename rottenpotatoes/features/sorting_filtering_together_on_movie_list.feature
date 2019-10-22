Feature: display list of movies after adding some filtering criteria in a sorted order
 
  As an avide moviegoer
  So that I can browse movies based on my preferences after filtering movies based on MPAA ratings
  I want to see the filtered movies sorted by title or release date

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And  I am on the RottenPotatoes home page
  
Scenario: restrict to movies with 'G' or 'R' ratings followed by sorting in alphabetical order
  When I check the following ratings: G, R
  And I uncheck the following ratings: PG, PG-13, NC-17
  And I press "ratings_submit"
  When I follow "Movie Title"
  Then I should see "2001: A Space Odyssey"
  And I should see "Aladdin"
  And I should see "Amelie"
  And I should see "Chicken Run"
  And I should not see "Chocolat"
  And I should see "The Terminator"
  And I should see "When Harry Met Sally"
  And I should not see "Raiders of the Lost Ark"
  And I should not see "The Help"
  And I should see "2001: A Space Odyssey" before "Aladdin"
  And I should see "Aladdin" before "Amelie"

Scenario: sort movies in increasing order of release date followed by restricting movies with MPAA ratings 'G' or 'R'
  When I follow "Release Date"
  When I check the following ratings: G, R
  And I uncheck the following ratings: PG, PG-13, NC-17
  And I press "ratings_submit"
  Then I should see "2001: A Space Odyssey"
  And I should see "Aladdin"
  And I should see "Amelie"
  And I should see "Chicken Run"
  And I should not see "Chocolat"
  And I should see "The Terminator"
  And I should see "When Harry Met Sally"
  And I should not see "Raiders of the Lost Ark"
  And I should not see "The Help"
  Then I should see "2001: A Space Odyssey" before "The Terminator"
  Then I should see "When Harry Met Sally" before "Aladdin"
  