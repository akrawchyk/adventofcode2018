import os
import streams
import strutils
import sequtils
import typetraits

const invalidChars = AllChars - Letters

proc exactlyCountLetter(str: string, c: char, count: int): bool = str.count(c) == count

when isMainModule:
  let
    filepath = paramStr(1)
    fs = newFileStream(filepath)

  var inputs = newSeq[string]()

  if not isNil(fs):
    var line: string

    while fs.readLine(line):
      doAssert line.find(invalidChars) == -1
      inputs.add(line.normalize())

  var
    doubleOccurrences = 0
    tripleOccurrences = 0

  for input in inputs:
    var iter = toSeq(input.items)

    if any(iter, proc(c: char): bool = exactlyCountLetter(input, c, 2)):
      doubleOccurrences = doubleOccurrences + 1

    if any(iter, proc(c: char): bool = exactlyCountLetter(input, c, 3)):
      tripleOccurrences = tripleOccurrences + 1

  echo doubleOccurrences, ' ', tripleOccurrences
