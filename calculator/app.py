import calculator
from calculator.imports.add import add
from calculator.exports.calculate import Op

class Calculate(calculator.Calculator):
    def eval_expression(self, op: Op, x: int, y: int) -> int:
        if op == Op.ADD:
            return add(x, y)
        return -1