Feature: update existing movie

  As a movie buff
  So that I can find and store more information about a particular movie
  I want to include and serach on movie information

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: update rating to existing movie
  When I go to the edit page for "Alien"
  And  I select "PG" from "Rating"
  And  I press "Update Movie Info"
  Then the rating of "Alien" should be "PG"