ARTICLES = \
	afterword		\
	cathedral-bazaar	\
	hacker-history		\
	hacker-revenge		\
	homesteading		\
	magic-cauldron

PAGES = \
	afterword/index.html		\
	cathedral-bazaar/index.html	\
	hacker-history/index.html	\
	hacker-revenge/index.html	\
	homesteading/index.html		\
	magic-cauldron/index.html

all: $(PAGES)

clean:
	rm -rf $(ARTICLES)

%/index.html: %.xml
	rm -rf `dirname $@`
	mkdir `dirname $@`
	jw -f docbook -b html -o `dirname $@` $<

