#!/usr/bin/env Rscript
maker_key = commandArgs(trailingOnly = TRUE)
if (length(maker_key) != 1) {
  stop("key must be provided", call. = FALSE)
}

if (!requireNamespace("xml2")) {
  install.packages("xml2")
}
if (!requireNamespace("httr")) {
  install.packages("httr")
}

my_event <- 'nukeproof_news'

nkp_url <- "http://nukeproof.com/wp-sitemap-posts-post-1.xml"
nkp_xml <- xml2::read_xml(nkp_url)
nkp <- xml2::xml_contents(nkp_xml)
nkp_news <- xml2::xml_text(nkp)
latest_news <- rev(basename(tail(nkp_news, 3)))

maker_url <- 
  paste(
    'https://maker.ifttt.com/trigger', 
    my_event, 
    'with/key',
    maker_key, 
    sep = '/'
  )
maker_body <- 
  list(
    value1 = latest_news[1],
    value2 = latest_news[2], 
    value3 = latest_news[3]
  )
httr::POST(maker_url, body = maker_body)
