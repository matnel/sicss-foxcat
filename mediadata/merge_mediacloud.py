import json
import os

megadata = []

files = filter( lambda x: 'metadata_' in x, os.listdir( '.' ) )

for f in files:

    metadata = json.load( open( f ) )
    wordmatrix = json.load( open( f.replace('metadata', 'wordmatrix') ) )

    data = {}

    for m in metadata:
        data[ m['stories_id'] ] = m

    all_words = wordmatrix['word_list']

    for stories_id, words in wordmatrix['word_matrix'].items():

        full_text = ''
        for wid, wcount in words.items():

            word = all_words[ int( wid ) ][0] + ' '
            word = wcount * word
            full_text += word

        try:
            data[ int( stories_id ) ]['full_text_bow'] = full_text
        except:
            print 'Can not find document', stories_id, 'in', f

    megadata += data.values()

print 'Total of', len( megadata )

json.dump( megadata, open('collected.json', 'w') )
