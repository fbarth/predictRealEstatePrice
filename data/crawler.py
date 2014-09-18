import urllib2
import HTMLParser
import json
import time

class ImoveisParser(HTMLParser.HTMLParser):
        
        def __init__(self, bairro):
                HTMLParser.HTMLParser.__init__(self)
                self.bairro = bairro

        def feed(self, html):
                self.prec = False
                self.area = False
                self.suit = False
                self.dorm = False
                self.toil = False
                self.gara = False
                self.desc = False
                self.codi = False
                self.prox = False
                # Diverse data
                self.imovel = {}
                self.imoveis = []
                self.proximo = ''
                HTMLParser.HTMLParser.feed(self, html)
                
        def handle_starttag(self, tag, attr):
                self.tag = tag
                attr = dict(attr)
                if 'price' in attr.get('class', ''):
                        self.prec = True
                elif 'icon-area' in attr.get('class', ''):
                        self.area = True
                elif 'icon-suites' in attr.get('class', ''):
                        self.suit = True
                elif 'icon-dorm' in attr.get('class', ''):
                        self.dorm = True
                elif 'icon-toilet' in attr.get('class', ''):
                        self.toil = True
                elif 'icon-garage' in attr.get('class', ''):
                        self.gara = True
                elif 'offer-desc-min' in attr.get('class', ''):
                        self.desc = True
                elif 'offer-id' in attr.get('class', ''):
                        self.codi = True
                        self.codi2 = attr.get('value', '')
                elif ('data-page' in attr and 'data-url' in attr) or (attr.get('class') == 'disabled' and tag == 'span'):
                        self.prox = True
                        self.prox2 = attr.get('data-page', None)
                        
        def handle_data(self, data):
                if self.prec and self.tag == 'span':
                        self.imovel['preco'] = data.strip() or '-'
                        self.prec = False
                elif self.area and self.tag == 'span':
                        self.imovel['area'] = data.strip() or '-'
                        self.area = False
                elif self.suit and self.tag == 'span':
                        self.imovel['suites'] = data.strip() or '-'
                        self.suit = False
                elif self.dorm and self.tag == 'span':
                        self.imovel['dormitorios'] = data.strip() or '-'
                        self.dorm = False
                elif self.toil and self.tag == 'span':
                        self.imovel['banheiros'] = data.strip() or '-'
                        self.toil = False
                elif self.gara and self.tag == 'span':
                        self.imovel['garagem'] = data.strip() or '-'
                        self.gara = False
                elif self.desc and self.tag == 'p':
                        if not 'descricao' in self.imovel.keys():
                                self.imovel['descricao'] = data.strip()
                        self.imovel['descricao'] += data.strip()
                elif self.codi and self.tag == 'input':
                        self.imovel['id'] = self.codi2
                        self.codi = False
                elif self.prox and data.startswith('Pr'):
                        self.proximo = self.prox2
                        self.prox = False

        def handle_endtag(self, tag):
                if self.desc and tag == 'div':
                        self.imovel['bairro'] = self.bairro
                        self.imoveis.append(self.imovel)
                        self.imovel = {}
                        self.desc = False

def get_urldata(url):
        http = urllib2.urlopen(url)
        html = http.read()
        http.close()
        return html

def try_urldata(url, tentativas_max=3):
        tentativas = 0
        while tentativas < tentativas_max:
                try:
                        return get_urldata(url)
                except:
                        time.sleep(3)
                        tentativas += 1
                        continue
        return None

def get_imoveis(zona, bairro):
        html = get_urldata('http://www.123i.com.br/comprar/apartamento/sp/sao-paulo-capital/%s/%s' % (zona, bairro,))
        if html is None:
                print 'FALHA ao baixar', bairro
                return []
        parser = ImoveisParser(bairro)
        parser.feed(parser.unescape(unicode(html, errors='ignore')))
        save_on_file(parser.imoveis)
        print 'sucesso ao baixar', bairro
        while parser.proximo:
                html = get_urldata('http://www.123i.com.br/comprar/apartamento/sp/sao-paulo-capital/%s/%s?p=%s' % (zona, bairro, parser.proximo,))
                if html is None:
                        print 'FALHA ao baixar', bairro, 'pagina', parser.proximo
                        continue
                parser.feed(parser.unescape(unicode(html, errors='ignore')))
                save_on_file(parser.imoveis)
                print 'sucesso ao baixar', bairro, 'pagina', parser.proximo
        return imoveis
        

def get_bairros_sao_paulo(callback):
        html = get_urldata('http://www.123i.com.br/geographicmap/offer/sp/sao-paulo?count&srtr=sale&ut=flat')
        zona_bairros = json.loads(html)['data']
        for zona in zona_bairros:
                zona2 = '-'.join(zona.lower().split(' '))
                for bairro in zona_bairros[zona].keys():
                        callback(zona2, bairro)
                        

def get_paginas_imoveis(zona, bairro):
        imoveis.extend(get_imoveis(zona, bairro))

def save_on_file(imoveis):
        for imovel in imoveis:
                tmp = ';'.join([
                        imovel.get('bairro'),
                        #imovel.get('id'),
                        imovel.get('preco'),
                        imovel.get('area'),
                        imovel.get('suites', '-'),
                        imovel.get('dormitorios', '-'),
                        imovel.get('banheiros', '-'),
                        imovel.get('garagem', '-'),
                        imovel.get('descricao', '').replace(';', ',').replace('\r\n', ' ').replace('\r', ' ').replace('\n', ' '),
                ])
                fp.write(tmp.encode('ascii', 'ignore')+'\n')
        
with open('imoveis.csv', 'w') as fp:
        imoveis = []
        fp.write('bairro;preco;area;suites;dormitorios;banheiros;garagem;descricao\n')
        get_bairros_sao_paulo(get_paginas_imoveis)
        

print 'finalizado com sucesso'
