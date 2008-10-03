ARTICLES = \
	afterword.th		\
	cathedral-bazaar.th	\
	hacker-history.th	\
	hacker-revenge.th	\
	homesteading.th		\
	magic-cauldron.th

PAGES = \
	afterword.th/index.html		\
	cathedral-bazaar.th/index.html	\
	hacker-history.th/index.html	\
	hacker-revenge.th/index.html	\
	homesteading.th/index.html	\
	magic-cauldron.th/index.html

all: $(PAGES)

clean:
	rm -rf $(ARTICLES)

%.th.po: %.xml
	if [ -f $@ ]; then	\
	  xml2po -e -u $@ $< ;	\
	else			\
	  xml2po -e -o $@ $< ;	\
	fi

%.th.xml: %.th.po %.xml
	xml2po -e -o $@ -l th -p $^

%/index.html: %.xml
	rm -rf `dirname $@`
	mkdir `dirname $@`
	xsltproc -o `dirname $@`/ /usr/share/xml/docbook/stylesheet/nwalsh/xhtml/chunkfast.xsl $<
	#jw -f docbook -b html -o `dirname $@` $<

