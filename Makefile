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

STATS_FILE = STATS
REPORT_HTML = index.html

all: $(PAGES)

clean:
	rm -rf $(ARTICLES)

stats:
	rm -f $(STATS_FILE)
	for p in $(ARTICLES); do				\
	  $(MAKE) $$p.po ;					\
	  st=`LC_MESSAGES=C msgfmt --statistics $$p.po -o /dev/null 2>&1` ;	\
	  t=0; f=0; u=0;					\
	  for n in 1 2 3; do					\
	    fld=`echo $$st | cut -d, -f$$n` ;			\
	    v=`echo $$fld | grep ' translated' | sed 's/ *\([0-9]*\) trans.*/\1/'` ;	\
	    if [ ! -z "$$v" ]; then t=$$v; fi ;			\
	    v=`echo $$fld | grep ' fuzzy' | sed 's/ *\([0-9]*\) fuzzy.*/\1/'` ;	\
	    if [ ! -z "$$v" ]; then f=$$v; fi ;			\
	    v=`echo $$fld | grep ' untrans' | sed 's/ *\([0-9]*\) untra.*/\1/'` ;	\
	    if [ ! -z "$$v" ]; then u=$$v; fi ;			\
	  done ;						\
	  printf "$$p.po\\t%s\\t%s\\t%s\\n" $$t $$f $$u  >> $(STATS_FILE) ;		\
	done
	./gen-report < $(STATS_FILE) > $(REPORT_HTML)

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

.PHONY: all clean stats
