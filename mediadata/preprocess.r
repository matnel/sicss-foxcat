library('stm')

load('collected.rdata')

metadata <- data.frame( data$publish_date , data$media_name )

## for initial version only like this, change to the fancier one later on
processed <- textProcessor( data$full_text_bow, metadata )
out <- prepDocuments(processed$documents, processed$vocab, processed$meta)

docs <- out$documents
vocab <- out$vocab
meta <-out$meta

save( out, docs, vocab, meta, file = 'processed.rdata' )
