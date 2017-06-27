import mediacloud, json, datetime
import calendar

key = open('key.txt').read().strip()

print key

mc = mediacloud.api.MediaCloud( key )

collected = []

keyword = "muslim OR islam"

solr_core_filter = "tags_id_media:8875027"

for year in range(2005,2018):

    for month in range(1,13):

        last_day = calendar.monthrange( year, month )[1]

        solr_filter_date = " AND publish_date:[{0}-{1}-01T00:00:00.000Z TO {0}-{1}-{2}T23:59:59.999Z]".format( year, month, last_day )

        solr_filter = solr_core_filter + solr_filter_date

        all_count = mc.storyCount( keyword, solr_filter )['count']

        print year, month, all_count

        ## bag of words

        data = mc.storyWordMatrix( keyword , solr_filter= solr_filter, rows= all_count )

        json.dump( data , open( 'wordmatrix_{0}_{1}.json'.format( year, month ), 'w' ) )

        ## metadata

        data = mc.storyList(  keyword , solr_filter= solr_filter, rows= all_count )

        json.dump( data, open( 'metadata_{0}_{1}.json'.format( year, month ), 'w' ) )
