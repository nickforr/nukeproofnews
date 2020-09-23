
if (!requireNamespace("xml2")) {
  install.packages("xml2")
}

nkp_url <- "http://nukeproof.com/wp-sitemap-posts-post-1.xml"
nkp_xml <- xml2::read_xml(nkp_url)
nkp <- xml2::xml_contents(nkp_xml)
nkp_news <- xml2::xml_text(nkp)
tail(nkp_news)

