/*
 * File:	checker.h
 *
 * Description:	This file contains the public function declarations for the
 *		semantic checker for Simple C.
 */

# ifndef CHECKER_H
# define CHECKER_H
# include "Scope.h"
# include <string>

Scope *openScope();
Scope *closeScope();

Symbol *defineFunction(const std::string &name, const Type &type);
Symbol *declareFunction(const std::string &name, const Type &type);
Symbol *declareVariable(const std::string &name, const Type &type);
Symbol *checkIdentifier(const std::string &name);
Symbol *checkFunction(const std::string &name);
const Type *checkLogicalOr(const Type *left, const Type *right);
const Type *checkLogicalAnd(const Type *left, const Type *right);
const Type *checkMultiplicative(const Type *left, const Type *right, const std::string &op);
const Type *checkAdditive(const Type *left, const Type *right, const std::string &op);
const Type *checkRelational(const Type *left, const Type *right, const std::string &op);
const Type *checkEquality(const Type *left, const Type *right, const std::string &op);
const Type *checkPostfix(const Type *left, const Type *right);
void checkReturn(const Type *returnType, const Type *funcType);
void checkStatementExpression(const Type *type);
void checkAssignment(const Type *left, const Type *right, const bool &lvalue);
const Type *checkDeref(const Type *type);
const Type *checkAddress(const Type *type, const bool &lvalue);
const Type *checkNot(const Type *type);
const Type *checkNegation(const Type *type);
const Type *checkSizeOf(const Type *type);
const Type *checkFunction(const Type *type, std::vector<const Type *> &params);
bool areCompatible(const Type *left, const Type *right);

# endif /* CHECKER_H */
