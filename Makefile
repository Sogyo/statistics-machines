docker: r-hadoop

r-hadoop:
	cd r-hadoop && docker build -t sogyo/r-hadoop:latest .; cd ..

.PHONY: r-hadoop
