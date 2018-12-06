import os
import streams
import strutils as str
import tables

const
  opChars = {'+', '-'}
  invalidChars = AllChars - Digits - opChars

when isMainModule:
  let
    fs = newFileStream(paramStr(1))

  var
    line = ""
    state = 0
    inputs = newSeq[tuple[op: char, value: int]]()
    frequencyCounts = newCountTable[int]()
    repeats = newSeq[int]()

  frequencyCounts.inc(state)

  if not isNil(fs):
    while fs.readLine(line):
      doAssert line.find(invalidChars) == -1

      var
        cmd: tuple[op: char, value: int]
        rawNum = line.split(opChars)[1]
      if rawNum == "": continue

      cmd = (op: line[0], value: str.parseInt(rawNum))
      inputs.add(cmd)

    fs.close()

  for cmd in inputs:
    # lol: https://nim-lang.org/docs/manual.html#types-object-variants
    if cmd.op == '+':
      state = state + cmd.value
    if cmd.op == '-':
      state = state - cmd.value

    frequencyCounts.inc(state)

    if frequencyCounts[state] >= 2:
      repeats.add(state)


  echo "Resulting frequency: ", state

  while repeats.len == 0:
    for cmd in inputs:
      if cmd.op == '+':
        state = state + cmd.value
      if cmd.op == '-':
        state = state - cmd.value

      frequencyCounts.inc(state)

      if frequencyCounts[state] >= 2:
        repeats.add(state)
        break

  echo "First repeated frequency: ", repeats[0]
