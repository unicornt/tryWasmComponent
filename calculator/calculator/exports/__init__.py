from typing import TypeVar, Generic, Union, Optional, Protocol, Tuple, List, Any, Self
from enum import Flag, Enum, auto
from dataclasses import dataclass
from abc import abstractmethod
import weakref

from ..types import Result, Ok, Err, Some
from ..exports import calculate

class Calculate(Protocol):

    @abstractmethod
    def eval_expression(self, op: calculate.Op, x: int, y: int) -> int:
        raise NotImplementedError


