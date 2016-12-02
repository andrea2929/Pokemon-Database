library("shiny")

table <- read.csv("~/PokemonDatabase/www/Pokechart.csv")
Pokemon <- read.csv("~/PokemonDatabase/www/Pokemon.csv")

types <- function(type1, type2) {
  if (type2=="None") {
    a <- ''
    for(i in names(table)) {
      if(i!='Types') {
        weak <- table[[type1]][table[1]==i]
        if (weak == 0)
          a <- paste(a,'<span class=\"label label-primary\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else if (weak < 1)
          a <- paste(a,'<span class=\"label label-success\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else if (weak == 1)
          a <- paste(a,'<span class=\"label label-default\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else
          a <- paste(a,'<span class=\"label label-danger\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
      }
    }
  }
  else {
    a <- ''
    for(i in names(table)) {
      if(i!='Types') {
        weak <- table[[type1]][table[1]==i]*table[[type2]][table[1]==i]
        if (weak == 0)
          a <- paste(a,'<span class=\"label label-danger\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else if (weak < 1)
          a <- paste(a,'<span class=\"label label-warning\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else if (weak == 1)
          a <- paste(a,'<span class=\"label label-default\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else if (weak == 4)
          a <- paste(a,'<span class=\"label label-primary\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
        else
          a <- paste(a,'<span class=\"label label-success\" style=\"margin-right: 5px\">',i,': ',weak,'</span> ')
      }
    }
  }
  return(a)
}

module <- function(name) {
  a <- paste('<div id=\"',
             name,
             '\" class=\"modal fade\" role=\"dialog\"><div class=\"modal-dialog\"><div class=\"modal-content\"><div class=\"modal-header\"><h1 style=\"text-transform:capitalize;\">',
             name,
             sep ='')
    a <- paste(a,'</h1></div>', sep = '')
    if (pokemon[pokemon$pokemon==name,2]<722) {
      a <- paste(a,'<img src=\"/sugimori/',
                 pokemon[pokemon$pokemon==name,2],
                 '.png\" style=\"width: 50%; height: auto; float: right; margin-right: 20px;\">', sep = '')
    }
    a <- paste(a,'<div class=\"modal-body\"><strong>HP</strong>: ',
               pokemon[pokemon$pokemon==name,5],
               '<br><strong>Attack</strong>: ',
               pokemon[pokemon$pokemon==name,6],
               '<br><strong>Defense</strong>: ',
               pokemon[pokemon$pokemon==name,7],
               '<br><strong>Special-Attack</strong>: ',
               pokemon[pokemon$pokemon==name,8],'<br>',
               '<strong>Special-Defense</strong>: ',
               pokemon[pokemon$pokemon==name,9],
               '<br><strong>Speed</strong>: ',
               pokemon[pokemon$pokemon==name,10],
               '<br><table class=\"table table-responsive\"><caption>Abilities</caption>
               <tr style=\"text-transform:capitalize; text-align:center;\">',
               sep = '')
  if (pokemon[pokemon$pokemon==name,11]!='')
    a <- paste(a,'<td>',gsub('-',' ',pokemon[pokemon$pokemon==name,11]),'</td>', sep = '')
  if (pokemon[pokemon$pokemon==name,12]!='')
    a <- paste(a,'<td>',gsub('-',' ',pokemon[pokemon$pokemon==name,12]),'</td>', sep = '')
  if (pokemon[pokemon$pokemon==name,13]!='')
    a <- paste(a,'<td>',gsub('-',' ',pokemon[pokemon$pokemon==name,13]),'</td>', sep = '')
  a <- paste(a,'</tr></table>', sep = '')
  if (pokemon[pokemon$pokemon==name,14]!='')
             a <- paste(a,'<h5>Description</h5>',pokemon[pokemon$pokemon==name,14])
  a <- paste(a, '</div><div class=\"modal-footer\"><button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">Close</button></div></div></div></div>', sep = '')
  return(a)
}

get_pokemon <- function(type1, type2) {
  a <- ''
  for(p in pokemon[,2]) {
    if((casefold(pokemon[pokemon$id==p,3], upper = FALSE) == casefold(type1,upper = FALSE) | casefold(pokemon[pokemon$id==p,3], upper = FALSE) == casefold(type2,upper = FALSE)) &
       (casefold(pokemon[pokemon$id==p,4], upper = FALSE) == casefold(type1,upper = FALSE) | casefold(pokemon[pokemon$id==p,4], upper = FALSE) == casefold(type2,upper = FALSE)))
      a <- paste(a,
                 module(pokemon[pokemon$id==p,1]),
                 '<img data-toggle=\"modal\" data-target=\"#', 
                 pokemon[pokemon$id==p,1],
                 '\" style=\"cursor:pointer;\" src=\"/icons/',
                 pokemon[pokemon$id==p,2],
                 '.png\"></img> ',
                 sep = '')
  }
  return(a)
}

shinyServer(function(input, output) {
  #output$graph1 <- renderTable({table})
  output$graph2 <- renderUI(HTML(types(input$type1,input$type2)))
  output$pokemans <- renderUI(HTML(get_pokemon(input$type1,input$type2)))
  output$header <- renderUI(HTML("<script>$('#myModal').on('shown.bs.modal', function () {
                                      $('#myInput').focus()
                                    })</script>"))
  output$statistics <- renderUI(HTML(paste('<h4>Statistics</h4><table class=\"table table-responsive\">
                                           <tr><th></th><th>Min</th><th>Max</th></tr>
                                           <tr><td><strong>HP</strong></td><td>',
                                           min(pokemon$base_HP),'</td><td>',max(pokemon$base_HP),
                                           '</td></tr><tr><td><strong>Attack</strong></td><td>',
                                           min(pokemon$base_Attack),'</td><td>',max(pokemon$base_Attack),
                                           '</td></tr><tr><td><strong>Defense</strong></td><td>',
                                           min(pokemon$base_Defense),'</td><td>',max(pokemon$base_Defense),
                                           '</td></tr><tr><td><strong>Special Attack</strong></td><td>',
                                           min(pokemon$base_SpecialAttack),'</td><td>',max(pokemon$base_SpecialAttack),
                                           '</td></tr><tr><td><strong>Special Defense</strong></td><td>',
                                           min(pokemon$base_SpecialDefense),'</td><td>',max(pokemon$base_SpecialDefense),
                                           '</td></tr><tr><td><strong>Speed</strong></td><td>',
                                           min(pokemon$base_Speed),'</td><td>',max(pokemon$base_Speed),
                                           '</td></tr></table>',
                                           sep = '')))
})