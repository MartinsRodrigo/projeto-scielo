`%p%` <- function(e1, e2) {
  return(paste(e1, e2, sep=''))
}

library(xml2)



# Recebe uma url XML da Scielo 
#e torna banco
retorna_banco_scielo <- function(url) {
  page <- read_xml(url)
  autor_sobrenome <- paste(xml_text(
    xml_find_all(page, '//article-meta/contrib-group/contrib/name/surname')),
    collapse='|')

  autor_nome <- paste(xml_text(
    xml_find_all(page, '//article-meta/contrib-group/contrib/name/given-names')),
    collapse='|')
  
  revista <- xml_text(
    xml_find_all(page, '//journal-title'))
  
  titulo <- xml_text(
    xml_find_all(page, '//article-meta/title-group/article-title'))
  
  ano <- xml_text(
    xml_find_all(page, '//article-meta/pub-date/year'))
  
  resumo <- xml_text(
    xml_find_all(page, '//article-meta/abstract/p'))
  
  chave <- xml_text(
    xml_find_all(page, '//article-meta/kwd-group/kwd'))
  
  
  refs <- xml_attr(xml_find_all(page, '//ref'), "id")
  refs_ <- xml_find_all(page, '//ref')
  
  banco <- data.frame(ref_sobrenome=c(), 
                      ref_nome=c(), 
                      ref_ano=c(), 
                      ref_revista=c(), 
                      ref_titulo=c())
  for (i in 1:length(refs)) {
    print(i)
    ref_sobrenome <- paste0(
      xml_text(xml_find_all(refs_, "//ref[@id='" %p% refs[i] %p% "']//surname")),
      collapse="|"
    )
    
    ref_nome <- paste0(
      xml_text(xml_find_all(refs_, "//ref[@id='" %p% refs[i] %p% "']//given-names")),
      collapse="|"
    )
    
    ref_ano <- xml_text(xml_find_all(refs_, "//ref[@id='" %p% refs[i] %p% "']//year"))
    ref_revista <- xml_text(xml_find_all(refs_, "//ref[@id='" %p% refs[i] %p% "']//source"))
    ref_titulo <- xml_text(xml_find_all(refs_, "//ref[@id='" %p% refs[i] %p% "']//article-title"))
    if ( length(ref_titulo) == 0 )
      ref_titulo <- NA
    temp_referencia_db <- data.frame(ref_sobrenome, ref_nome, ref_ano, ref_revista, ref_titulo, stringsAsFactors=FALSE)
    banco <- rbind(banco, temp_referencia_db)  
  }
  
  banco$autor_sobrenome <- autor_sobrenome
  banco$autor_nome <- autor_nome
  banco$revista <- revista
  banco$titulo <- titulo[1]
  banco$ano <- ano[1]
  banco$resumo <- resumo[1]
  banco$chave <- paste(chave, collapse=",")
  return(banco)
}


