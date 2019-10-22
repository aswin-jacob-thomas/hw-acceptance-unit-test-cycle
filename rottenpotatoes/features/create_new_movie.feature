Feature: search for movies by director

  As a movie buff
  So that I can get information about the movie whenever I need
  I want to add a new movie information

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

  And I am on the RottenPotatoes home page

Scenario: add a new movie to rottenpotatoes
  When I follow "Add new movie"
  And I fill in "Title" with "Chicken Run"
  And  I press "Save Changes"
  Then I should see "Chicken Run"