import os
import streams
import strutils
import sequtils

const invalidChars = AllChars - Letters

proc hasExactlyCount(str: string, c: char, count: int): bool = str.count(c) == count

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

    if any(iter, proc(c: char): bool = hasExactlyCount(input, c, 2)):
      inc doubleOccurrences

    if any(iter, proc(c: char): bool = hasExactlyCount(input, c, 3)):
      inc tripleOccurrences

  echo "Double occurrences: ", doubleOccurrences
  echo "Triple occurrences: ", tripleOccurrences

  var
    found = false
    commmonChars = newSeq[char]()

  for input in inputs:
    if found:
      break
    for str in inputs:
      if editDistance(str, input) == 1:
        found = true
        for i in 0..str.high:
          if str[i] == input[i]:
            commmonChars.add(str[i])

  echo "Common letters: ", cast[string](commmonChars)
