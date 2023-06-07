from bs4 import BeautifulSoup
from lxml import etree

class GetSecRes:
    def get_dependency_critical_num_with_lxml(self, filename):
       	with open(filename, encoding='utf-8') as f:
            data = f.read()
        doc = etree.HTML(data)
        trs = doc.xpath('//*[@id="summaryTable"]//tr[@class=" vulnerable"]')
        criticalres = []
        for tr in trs:
            tr_list = tr.xpath('./td/@data-sort-value')
            td_text = tr.xpath('./td/text()')
            tr_list.extend(td_text)
            [criticalres.append(tr_list) for td in tr_list if ("CRITICAL" == td or "CRITICAL*" == td)]
        convertList = ' '.join([str(e) for e in criticalres])
        if convertList:
            return convertList
        else:
            return "ok"
if __name__ == '__main__':
    import sys
    filename = sys.argv[1]
    criticalres = GetSecRes().get_dependency_critical_num_with_lxml(filename)
    sys.exit(criticalres)
