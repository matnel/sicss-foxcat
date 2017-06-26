import mediacloud, json, datetime

key = open('key.txt').read().strip()

mc = mediacloud.api.MediaCloud( key )

collected = []

keyword = "muslim OR islam"
solr_filter = [ "language:en" ]

all_count = mc.storyCount( keyword, solr_filter )['count']

data = mc.storyWordMatrix( keyword , solr_filter= solr_filter, rows= 100 )

all_words = data['word_list']

for document_id, words in data['word_matrix'].items():

    full_text = ''
    for wid, wcount in words.items():

        word = all_words[ int( wid ) ][0] + ' '
        word = wcount * word
        full_text += word

    d = mc.story( document_id )

    d['full_text_bow'] = full_text

    collected.append( d )


print json.dump( collected, open('collected.json', 'w') )
