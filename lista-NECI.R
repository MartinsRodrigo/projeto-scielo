  links <- c("S1981-38212013000200004",
             "S1981-38212013000200003",
             "S1981-38212014000200048",
             "S0011-52582014000401169",
             "S0011-52582013000400008",
             "S0011-52582010000100006",
             "S0011-52582009000100007",
             "S0011-52582008000400002",
             "S0011-52582008000400003",
             "S0011-52582007000400002",
             "S0011-52582007000200002",
             "S0011-52582007000200001",
             "S0011-52582006000200006",
             "S0011-52582005000300004",
             "S0011-52582004000400005",
             "S0011-52582002000400005",
             "S0011-52582001000400004",
             "S0011-52582001000200002",
             "S0011-52581999000400003",
             "S0011-52581999000400004")
  
  
  setwd('~/projeto-scielo')
  
  link_xml <- "http://www.scielo.br/scieloOrg/php/articleXML.php?pid=XXX&lang=pt"
  
  
  source('codigo_guilherme.R')
  
  banco_neci <- data.frame(
    ref_sobrenome=c(), 
    ref_nome=c(), 
    ref_ano=c(), 
    ref_revista=c(), 
    ref_titulo=c(),
    autor_sobrenome=c(),
    autor_nome=c(),
    revista=c(),
    titulo =c(),
    ano =c(),
    resumo=c(),
    chave=c(),
    stringsAsFactors=FALSE)
  
  

  
  for (i in links) {
    url <- gsub('XXX', i , link_xml)
    print(url)
    banco_neci <- rbind(banco_neci, 
                        retorna_banco_scielo(url))
    
  }

  
  write.csv(banco_neci, 'banco-neci.csv', row.names=FALSE)
