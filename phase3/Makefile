CXXFLAGS	= -g -Wall
OBJS		= lexer.o parser.o 
PROG		= scc
SRCS		= lexer.cpp


all:		$(PROG)

$(PROG):	$(SRCS) $(OBJS) Type.h Symbol.h Scope.h checker.cpp
		$(CXX) -o $(PROG) $(OBJS)

clean:;		$(RM) -f $(PROG) $(SRCS) core *.o

lexer.cpp:	lexer.l
		$(LEX) $(LFLAGS) -t lexer.l > lexer.cpp
