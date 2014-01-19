CXXFLAGS	= -g -Wall
OBJS		= lexer.o parser.o
PROG		= scc


all:		$(PROG)

$(PROG):	$(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) core *.o

lexer.cpp:	lexer.l tokens.h
		$(LEX) $(LFLAGS) -t lexer.l > lexer.cpp

parser.cpp:	tokens.h outputs.h

