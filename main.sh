#!/usr/bin/env bash

#now=`date +"%Y-%m-%d" -d "02/01/2019"`
now=`date +"%Y-%m-%d"`
end=`date +"%Y-%m-%d" -d $1`

cat 'header.html' > test.html
while [ "$now" != "$end" ] ;
do
    now=`date +"%Y-%m-%d" -d "$now + 1 day"`;
    echo "\n\n$now\n\n"
    echo "<h3>$now</h3>" >> test.html
    for hour in invitatorium lectionis laudes media vesperae completorium; do
        echo "<h4>$hour</h4>" >> test.html
        curl -d "hora=$hour&input_date=$now&psalm_numbering=greek" \
            -X POST http://www.liturgia-horarum.ru/phpordinarium.php \
            | sed -e 's/style="display:none;">/style="display:block;"><div class="h_title">или<\/div>/g' \
            >> test.html

    done
done
cat 'footer.html' >> test.html


cd tmp
mv ../test.html Text/main.xhtml
zip -r ../test.epub *