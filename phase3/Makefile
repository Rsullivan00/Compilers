CXXFLAGS	= -g -Wall
OBJS		= lexer.o parser.o
PROG		= scc
SRCS		= lexer.cpp


all:		$(PROG)

$(PROG):	$(SRCS) $(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) $(SRCS) core *.o

lexer.cpp:	lexer.l
		$(LEX) $(LFLAGS) -t lexer.l > lexer.cpp

parser.cpp:	checker.cpp

checker.cpp:	Scope.h 

Scope.h:	Symbol.h

Symbol.h:	Type.h
