CXXFLAGS	= -g #-Wall
OBJS		= checker.o lexer.o parser.o Scope.o Symbol.o Type.o
PROG		= scc
SRCS		= lexer.cpp


all:		$(PROG)

$(PROG):	$(SRCS) $(OBJS)
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) $(SRCS) core *.o

lexer.cpp:	lexer.l
		$(LEX) $(LFLAGS) -t lexer.l > lexer.cpp
