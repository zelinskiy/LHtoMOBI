#!/usr/bin/env bash

# curl -d "hora=laudes&date=2019-02-01&psalm_numbering=hebrew" -X POST http://www.liturgia-horarum.ru/phpordinarium.php > test.html
# invitatorium lectionis laudes media vesperae completorium;

now=`date +"%Y-%m-%d" -d "02/01/2019"`
end=`date +"%Y-%m-%d" -d "02/10/2019"`

cat 'header.html' > test.html
while [ "$now" != "$end" ] ;
do
    now=`date +"%Y-%m-%d" -d "$now + 1 day"`;
    echo "\n\n$now\n\n"
    echo "<h3>$now</h3>" >> test.html
    for hour in invitatorium laudes vesperae completorium; do
        echo "<h4>$hour</h4>" >> test.html
        curl -d "hora=$hour&hour&date=$now&psalm_numbering=hebrew" \
            -X POST http://www.liturgia-horarum.ru/phpordinarium.php \
            | sed -e 's/style="display:none;">/style="display:block;"><div class="h_title">или<\/div>/g' \
            >> test.html

    done
done
cat 'footer.html' >> test.html