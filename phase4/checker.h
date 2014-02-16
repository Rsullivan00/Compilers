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
const Type *checkReturn(const Type *type);

# endif /* CHECKER_H */
