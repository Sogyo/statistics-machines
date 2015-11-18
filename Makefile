docker: r-hadoop

push: r-hadoop-push

r-hadoop:
	cd r-hadoop && docker build -t sogyo/r-hadoop:latest .; cd ..

r-hadoop-push: r-hadoop
	cd r-hadoop && docker push sogyo/r-hadoop:latest; cd ..

.PHONY: r-hadoop
