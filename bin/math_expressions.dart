void main() {
  String mathExpression = '20*5+6/3-4';
  print(calc(mathExpression));
}

double calc(String exp) {
  if (double.tryParse(exp) != null) {
    return double.parse(exp);
  }

  ({String left, String operator, String right}) splitExp = getOperands(exp);
  double leftOperand = calc(splitExp.left);
  double rightOperand = calc(splitExp.right);

  return switch (splitExp.operator) {
    '+' => leftOperand + rightOperand,
    '-' => leftOperand - rightOperand,
    '*' => leftOperand * rightOperand,
    '/' => leftOperand / rightOperand,
    _ => throw Exception(),
  };
}

({String left, String operator, String right}) getOperands(String exp) {
  late String leftOperand;
  late String operator;
  late String rightOperand;

  for (int i = 0; i < exp.length; i++) {
    if (isOperator(exp[i])) {
      leftOperand = exp.substring(0, i);
      operator = exp[i];
      rightOperand = exp.substring(i + 1);
      if (isLowPriorityOperator(exp[i])) {
        break;
      }
    }
  }
  return (left: leftOperand, operator: operator, right: rightOperand);
}

bool isOperator(String symbol) {
  return ['+', '-', '/', '*'].contains(symbol);
}

bool isLowPriorityOperator(String symbol) {
  return ['+', '-'].contains(symbol);
}
