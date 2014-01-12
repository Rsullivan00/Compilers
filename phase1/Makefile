CXXFLAGS	= -g -Wall
OBJS		= lexer.o
PROG		= scc

$(PROG):	$(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

all:		$(PROG) 

clean:; $(RM) $(PROG) $(SRCS) core *.o

lexer.cpp:	lexer.l
		$(LEX) -t lexer.l > lexer.cpp	
