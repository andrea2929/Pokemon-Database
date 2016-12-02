shinyUI(fluidPage(
  uiOutput("header"),
  titlePanel(
    h1("Pokémon",class="jumbotron")
  ),
  sidebarLayout(position = "right",
                sidebarPanel(
                  selectInput("type1", label = h3("Select Types"), 
                              choices = list(
                                "Normal", 
                                "Fighting",
                                "Flying",
                                "Poison",
                                "Ground",
                                "Rock",
                                "Bug",
                                "Ghost",
                                "Steel",
                                "Fire",
                                "Water",
                                "Grass",
                                "Electric",
                                "Psychic",
                                "Ice",
                                "Dragon",
                                "Dark",
                                "Fairy"), selected = "Normal"),
                  selectInput("type2", label = NULL, 
                              choices = list(
                                "None",
                                "Normal", 
                                "Fighting",
                                "Flying",
                                "Poison",
                                "Ground",
                                "Rock",
                                "Bug",
                                "Ghost",
                                "Steel",
                                "Fire",
                                "Water",
                                "Grass",
                                "Electric",
                                "Psychic",
                                "Ice",
                                "Dragon",
                                "Dark",
                                "Fairy"), selected = "None"),
                  uiOutput("statistics")
                ),
                mainPanel(
                  uiOutput("pokemans"),
                  h4("Damage Taken"),
                  uiOutput("graph2")
                )
  ),
  mainPanel(
    div(
      #tableOutput("graph1"), 
      style="font-size:97%; margin: 0 auto;"
    )
  )
))