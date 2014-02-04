CXXFLAGS	= -g -Wall
OBJS		= lexer.o parser.o Type.o Symbol.o Scope.o
PROG		= scc
SRCS		= lexer.cpp


all:		$(PROG)

$(PROG):	$(SRCS) $(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) $(SRCS) core *.o

lexer.cpp:	lexer.l
		$(LEX) $(LFLAGS) -t lexer.l > lexer.cpp
