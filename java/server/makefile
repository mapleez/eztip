JC = javac
MAIN = server.java

all: config utils server

config: config.java
	$(JC) $^

utils: ezutils.java
	$(JC) $^

depth: conn.java
	$(JC) $^
	
model: user.java
	$(JC) $^
	
server: model depth $(MAIN)
	$(JC) $(MAIN)
	
clean:
	rm -f *.class

