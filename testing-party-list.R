
# This gets authorized investigators, but only the first page of names
r <- GET(url = "https://nyu.databrary.org/api/search?volume=false&f.party_authorization=4&f.party_is_institution=false")

# This gets affliates? f.party_authorization=3
r <- GET(url = "https://nyu.databrary.org/api/search?volume=false&f.party_authorization=3&f.party_is_institution=false")

# Staff are f.party_authorization=5

# f.party_authorization=2, 6, 7 returns no one

# f.party_authorization=1 returns
# $response$docs
# id sortname    prename                  affiliation institution
# 1 162  de Jong Marjanneke           Utrecht University       FALSE
# 2 155 Libertus      Klaus     University of Pittsburgh       FALSE
# 3 280 Richards    John E. University of South Carolina       FALSE

# f.party_authorization=0 returns
# $response$docs
# id     sortname       prename                                            affiliation institution
# 1   606    Lederberg           Amy                               Georgia State University       FALSE
# 2   827       Kohler         Peter                                    Stanford University       FALSE
# 3   877          Ahn           Soo                                George Mason University       FALSE
# 4   829       Monroy        Claire   Donders Institute for Brain, Cognition and Behaviour       FALSE
# 5   783         Holt      Nicholas                               University of Louisville       FALSE
# 6   819      Spencer        Hannah                                     Utrecht University       FALSE
# 7   830 Stubblefield        Edward                                         michigan state       FALSE
# 8   847       Murphy      P. Karen                      The Pennsylvania State University       FALSE
# 9   600         West Kelsey Louise                               University of Pittsburgh       FALSE
# 10  831       Miller Kevin Francis                                 University of Michigan       FALSE
# 11  906        Hajal     Nastassia UCLA Semel Institute for Neuroscience & Human Behavior       FALSE
# 12  848         Wong         Sissy                                  University of Houston       FALSE
# 13  862      Escobar         Kelly                                    New York University       FALSE
# 14  898        Smith Craig Elliott                                 University of Michigan       FALSE
# 15  861     Kuchirko          Yana                                    New York University       FALSE
# 16 1041       JARLAN        Pierre                                                   umps       FALSE
# 17  790          Kim         Kaeun                    University of Massachusetts Amherst       FALSE
# 18 1023    Fernandes          Sara                                    New York University       FALSE
# 19 1032      Dodkins    Cindy Kaye  Swinburne BabyLab, Swinburne University of Technology       FALSE
# 20  109   Zimmermann         Laura                                  Georgetown University       FALSE
# 21  132         Flom          Ross                               Brigham Young University       FALSE
# 22  151        Balas      Benjamin                          North Dakota State University       FALSE
# 23  283       Ulrich       Beverly                                 University of Michigan       FALSE
# 24  267       Fivush         Robyn                                       Emory University       FALSE
# 25  270     Margulis     Katherine                                      Temple University       FALSE