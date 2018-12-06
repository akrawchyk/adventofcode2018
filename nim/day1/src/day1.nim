import os
import streams
import strutils as str

when isMainModule:
  let
    opChars = {'+', '-'}
    invalidChars = AllChars - Digits - opChars
    fs = newFileStream(paramStr(1))

  var
    line = ""
    state = 0

  if not isNil(fs):
    while fs.readLine(line):
      doAssert line.find(invalidChars) == -1

      var rawNum = line.split(opChars)[1]
      if rawNum == "": continue

      case line[0]
      of '+':
        state = state + str.parseInt(rawNum)
      of '-':
        state = state - str.parseInt(rawNum)
      else: continue

    fs.close()

  echo state
