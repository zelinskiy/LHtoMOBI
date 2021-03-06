#!/usr/bin/env bash

#usage: $ sh main.sh 10/01/2019 11/01/2019

now=`date +"%Y-%m-%d" -d $1`
end=`date +"%Y-%m-%d" -d $2`

cat 'header.html' > test.html
while [ "$now" != "$end" ] ;
do    
    echo "\n\n$now\n\n"
    echo "<h3>$now</h3>" >> test.html
    for hour in invitatorium lectionis laudes media vesperae completorium; do
        echo "<h4>$hour</h4>" >> test.html
        curl -d "hora=$hour&input_date=$now&psalm_numbering=greek" \
            -X POST http://www.liturgia-horarum.ru/phpordinarium.php \
            | sed -e 's/style="display:none;">/style="display:block;"><div class="h_title">или<\/div>/g' \
            >> test.html    
    done
    now=`date +"%Y-%m-%d" -d "$now + 1 day"`;
done
cat 'footer.html' >> test.html


cd tmp
# rm ../test.epub
mv ../test.html Text/main.xhtml
zip -r ../test.epub *
