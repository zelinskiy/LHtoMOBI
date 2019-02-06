from lxml import html
import urllib.request

def load_url(url, encoding='cp1251'):
    f = urllib.request.urlopen(url)
    f.read().decode(encoding)


test = '''
    <html>
        <body>
            <div class="first_level">
                <h2 align='center'>one</h2>
                <h2 align='left'>two</h2>
            </div>
            <h2>another tag</h2>
        </body>
    </html>
'''
tree = html.fromstring(test)

div_node = tree.xpath('//div')[0]
div_node.xpath('.//h2')
