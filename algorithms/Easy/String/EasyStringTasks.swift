//
//  EasyStringTasks.swift
//  Easy
//
//  Created by Igor Ratynski on 22.07.2022.
//

import Foundation

// MARK: Most words found
extension Solution.Easy {
  func mostWordsFound(_ sentences: [String]) -> Int {
    var result = 1, tempResult: Int
    
    for sentence in sentences {
      tempResult = 1
      for letter in sentence {
        guard letter == " " else { continue }
        tempResult += 1
      }
      
      if result < tempResult {
        result = tempResult
      }
    }
    
    return result
  }
}

// MARK: Add strings
extension Solution.Easy {
  func addStrings(_ num1: String, _ num2: String) -> String {
    var result = "", addToNext = false, tempResult: Int, num1 = num1, num2 = num2, temp1: Int, temp2: Int
    
    while !num1.isEmpty || !num2.isEmpty || addToNext {
      temp1 = 0; temp2 = 0
      
      if !num1.isEmpty {
        temp1 = Int(String(num1.removeLast()))!
      }
      if !num2.isEmpty {
        temp2 = Int(String(num2.removeLast()))!
      }
      
      tempResult = temp1 + temp2 + (addToNext ? 1 : 0)
      
      if tempResult > 9 {
        tempResult -= 10
        addToNext = true
      } else {
        addToNext = false
      }
      result.append(String(tempResult))
    }
    
    return String(result.reversed())
  }
}

// MARK: Letter combinations
extension Solution.Easy {
  func restoreString(_ s: String, _ indices: [Int]) -> String {
    var result = Array<Character>(repeating: " ", count: s.count)
    for (index, item) in s.enumerated() {
      result[indices[index]] = item
    }
    return String(result)
  }
}

// MARK: Find the difference
extension Solution.Easy {
  func findTheDifference(_ s: String, _ t: String) -> Character {
    let last = t.last!, s = Array<Character>(s), t = Array<Character>(t)
    var sDictionary: [Character:Int] = [:], tDictionary: [Character:Int] = [:]
    
    for index in 0..<s.count {
      sDictionary[s[index]] = (sDictionary[s[index]] ?? 0) + 1
      tDictionary[t[index]] = (tDictionary[t[index]] ?? 0) + 1
    }
    tDictionary[last]  = (tDictionary[last] ?? 0) + 1
    
    for key in tDictionary.keys {
      guard sDictionary[key] != nil else { return key }
      guard sDictionary[key] != tDictionary[key] else { continue }
      return key
    }
    return last
  }
}

// MARK: Truncate sentence
extension Solution.Easy {
  func truncateSentence(_ s: String, _ k: Int) -> String {
    var wordsIndex = 0, resultIndex = s.count
    
    for (index, value) in s.enumerated() {
      guard value == " " else { continue }
      wordsIndex += 1
      guard k == wordsIndex else { continue }
      resultIndex = index
      break
    }
    
    let index = s.index(s.startIndex, offsetBy: resultIndex)
    return s.substring(to: index)
  }
}

// MARK: Unique morse representations
extension Solution.Easy {
  func uniqueMorseRepresentations(_ words: [String]) -> Int {
    let letters: [Character:String] = ["a":".-","b":"-...","c":"-.-.","d":"-..","e":".","f":"..-.","g":"--.","h":"....","i":"..","j":".---","k":"-.-","l":".-..","m":"--","n":"-.","o":"---","p":".--.","q":"--.-","r":".-.","s":"...","t":"-","u":"..-","v":"...-","w":".--","x":"-..-","y":"-.--","z":"--.."]
    var result = Set<String>(), tempString: String
    
    for word in words {
      tempString = ""
      for character in word {
        tempString.append(letters[character]!)
      }
      result.insert(tempString)
    }
    
    return result.count
  }
}

// MARK: Is isomorphic
extension Solution.Easy {
  func isIsomorphic(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    let s = Array<Character>(s), t = Array<Character>(t)
    var sMap: [Character:Int] = [:], tMap: [Character:Int] = [:]
    for index in 0..<s.count {
      if sMap[s[index]] == nil {
        sMap[s[index]] = index
      }
      if tMap[t[index]] == nil {
        tMap[t[index]] = index
      }
      if sMap[s[index]] != tMap[t[index]] {
        return false
      }
    }
    
    return true
  }
}

// MARK: Max score
extension Solution.Easy {
  func maxScore(_ s: String) -> Int {
    var result = 0, left: Substring, right: Substring, sIndex: String.Index
    // TODO: optimization: check is need to go further
    // string -> [Int] of 0 indexes and count how many before string devider and fullCount - devider - zeroCount after
    for index in 1..<s.count {
      sIndex = s.index(s.startIndex, offsetBy: index)
      left = s[s.startIndex..<sIndex]
      right = s[sIndex..<s.endIndex]
      
      result = max(result, left.filter { $0 == "0" }.count + right.filter { $0 == "1" }.count)
    }
    return result
  }
}

// MARK: Can construct
extension Solution.Easy {
  func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
    guard ransomNote.count <= magazine.count else { return false }
    var ransomNoteDict: [Character:Int] = [:], magazineDict: [Character:Int] = [:]
    
    for letter in ransomNote {
      ransomNoteDict[letter] = (ransomNoteDict[letter] ?? 0) + 1
    }
    for letter in magazine {
      magazineDict[letter] = (magazineDict[letter] ?? 0) + 1
    }
    
    for (key, value) in ransomNoteDict {
      guard (magazineDict[key] ?? -1) >= value else { return false }
    }
    
    return true
  }
}

// MARK: Is anagram
extension Solution.Easy {
  func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }
    // I
//    var sDict: [Character:Int] = [:], tDict = sDict
//
//    for char in s {
//      sDict[char] = (sDict[char] ?? 0) + 1
//    }
//    for char in t {
//      tDict[char] = (tDict[char] ?? 0) + 1
//    }
//
//    return sDict == tDict
    
    // II
    var sDict: [Character:Int] = [:]
    
    for char in s {
      sDict[char] = (sDict[char] ?? 0) + 1
    }
    for char in t {
      sDict[char] = (sDict[char] ?? 0) - 1
      guard sDict[char]! > -1 else { return false }
    }
    
    return sDict.values.first { $0 > 0 } == nil
  }
}

// MARK: Longest common prefix
extension Solution.Easy {
  func longestCommonPrefix(_ strs: [String]) -> String {
    guard strs.count > 1 else { return strs.first! }
    var result: String = strs.first!, goNext: Bool
    
    for index in 1..<strs.count {
      guard !strs[index].hasPrefix(result) else { continue }
      goNext = false
      while !goNext && !result.isEmpty {
        result.removeLast()
        guard strs[index].hasPrefix(result) else { continue }
        goNext = true
      }
      guard !result.isEmpty else { return "" }
    }
    
    return result
  }
}

// MARK: Is subsequence
extension Solution.Easy {
  func isSubsequence(_ s: String, _ t: String) -> Bool {
    guard !s.isEmpty else { return true }
    var s = s, current = s.removeFirst()
    
    for character in t {
      guard character == current else { continue }
      guard !s.isEmpty else { return true }
      current = s.removeFirst()
    }
    return false
  }
}

// MARK: Check zero ones
extension Solution.Easy {
  func checkZeroOnes(_ s: String) -> Bool {
    var s = s, previous = s.removeFirst(), count: [Character:Int] = [:], tempCount: Int = 1
    
    for character in s {
      if character == previous {
        tempCount += 1
      } else {
        if count[previous] ?? 0 < tempCount {
          count[previous] = tempCount
        }
        tempCount = 1
        previous = character
      }
    }
    
    if count[previous] ?? 0 < tempCount {
      count[previous] = tempCount
    }
    
    return (count["1"] ?? 0) > (count["0"] ?? 0)
  }
}

// MARK: 557. Reverse words
extension Solution.Easy {
  func reverseWords(_ s: String) -> String {
    // I
//    s.components(separatedBy: " ")
//      .map { String($0.reversed()) }
//      .joined(separator: " ")
    
    // II
    var word: [Character] = [], result = ""
    for character in s {
      guard character == " " else {
        word.append(character)
        continue
      }
      for index in stride(from: word.count - 1, through: 0, by: -1) {
        result.append(word[index])
      }
      word.removeAll()
      result.append(" ")
    }
    
    for index in stride(from: word.count - 1, through: 0, by: -1) {
      result.append(word[index])
    }
    
    return result
  }
}

// MARK: 819. Most common word
private extension Bool {
  var negation: Bool { !self }
}
extension Solution.Easy {
  func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
    var dictionary: [String:Int] = [:], count = 0, word = ""
    paragraph
      .split(whereSeparator: \.isLetter.negation)
      .map { String($0.lowercased()) }
      .forEach {
        guard !banned.contains($0) else { return }
        dictionary[$0] = (dictionary[$0] ?? 0) + 1
        if dictionary[$0]! > count {
          count = dictionary[$0]!
          word = $0
        }
      }
    return word
  }
}

// MARK: 821. Shortest distance to a character
extension Solution.Easy {
  func shortestToChar(_ s: String, _ c: Character) -> [Int] {
    var count = s.count, result: [Int] = [], s = s.enumerated().compactMap { $0.element == c ? $0.offset : nil }
    var firstIndex = s.removeFirst(), secondIndex: Int?, firstIndexValue: Int, secondIndexValue: Int
    if !s.isEmpty {
      secondIndex = s.removeFirst()
    }
    
    for index in 0..<count {
      firstIndexValue = abs(firstIndex - index)
      secondIndexValue = abs((secondIndex ?? firstIndex) - index)
      result.append(min(firstIndexValue, secondIndexValue))
      
      guard firstIndexValue > secondIndexValue else { continue }
      firstIndex = secondIndex!
      
      guard !s.isEmpty else { continue }
      secondIndex = s.removeFirst()
    }
    
    return result
  }
}

// MARK: 824. Goat Latin
extension Solution.Easy {
  func toGoatLatin(_ sentence: String) -> String {
    let vowels: Set<Character> = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
    return sentence
      .components(separatedBy: " ")
      .enumerated().map {
        var element = $0.element
        return (vowels.contains($0.element.first!) ? $0.element : String(element.dropFirst()) + String(element.removeFirst()))
        + "ma" + String(repeating: "a", count: $0.offset + 1)
      }
      .joined(separator: " ")
  }
}

// MARK: 844. Backspace string compare
extension Solution.Easy {
  func backspaceCompare(_ s: String, _ t: String) -> Bool {
//    // I
//    func cleaned(string: String) -> String {
//      var result = ""
//      for value in string {
//        if value == "#" {
//          guard !result.isEmpty else { continue }
//          result.removeLast()
//        } else {
//          result.append(value)
//        }
//      }
//      return result
//    }
//
//    return cleaned(string: s) == cleaned(string: t)
    // II
    var s = s, t = t, index: String.Index?
    
    func clean(string: inout String) {
      while true {
        index = string.firstIndex(where: { $0 == "#" })
        guard index != nil else { break }
        string.remove(at: index!)
        guard index != string.startIndex else { continue }
        index = string.index(before: index!)
        string.remove(at: index!)
      }
    }
    
    clean(string: &s)
    clean(string: &t)
    
    return s == t
  }
}

// MARK: 796. Rotate String
extension Solution.Easy {
  func rotateString(_ s: String, _ goal: String) -> Bool {
    guard s.count == goal.count else { return false }
    guard s != goal else { return true }
    var s = s
    
    for _ in 0..<s.count - 2 {
      s = String(s.removeLast()) + s
      guard s == goal else { continue }
      return true
    }
    
    return false
  }
}

// MARK: 2129. Capitalize the Title
extension Solution.Easy {
  func capitalizeTitle(_ title: String) -> String {
    title
      .components(separatedBy: " ")
      .map { $0.count > 2 ? $0.prefix(1).uppercased() + $0.dropFirst().lowercased() : $0.lowercased() }
      .joined(separator: " ")
  }
}

// MARK: 709. To Lower Case
extension Solution.Easy {
  func toLowerCase(_ s: String) -> String {
    // I
//    return s.lowercased()
    // II
    let alphabet: [Character:Character] = ["A":"a", "B":"b", "C":"c", "D":"d", "E":"e", "F":"f", "G":"g", "H":"h", "I":"i", "J":"j", "K":"k", "L":"l", "M":"m", "N":"n", "O":"o", "P":"p", "Q":"q", "R":"r", "S":"s", "T":"t", "U":"u", "V":"v", "W":"w", "X":"x", "Y":"y", "Z":"z"]
    return String(s.map { alphabet[$0] != nil ? alphabet[$0]! : $0 })
  }
}

// TODO: 125. Valid Palindrome
extension Solution.Easy {
  func isPalindrome(_ s: String) -> Bool {
//    // I
//    let a = Array(s.lowercased().replacingOccurrences(of:"[^0-9a-z]", with: "", options: .regularExpression))
//
//    var last = a.count - 1
//    for first in 0..<a.count / 2 {
//      guard a[first] == a[last] else { return false }
//      last -= 1
//    }
//    return true
    
    // II
    let validCharacters: [Character:Character] = ["A":"a", "B":"b", "C":"c", "D":"d", "E":"e", "F":"f", "G":"g", "H":"h", "I":"i", "J":"j", "K":"k", "L":"l", "M":"m", "N":"n", "O":"o", "P":"p", "Q":"q", "R":"r", "S":"s", "T":"t", "U":"u", "V":"v", "W":"w", "X":"x", "Y":"y", "Z":"z", "0":"0", "1":"1", "2":"2", "3":"3", "4":"4", "5":"5", "6":"6", "7":"7", "8":"8", "9":"9"]
    let s = s.compactMap { validCharacters[$0] != nil ? validCharacters[$0] : validCharacters.values.contains($0) ? $0 : nil }
    var right = s.count - 1
    for left in 0..<s.count / 2 {
      guard s[left] == s[right] else { return false }
      right -= 1
    }
    
    return true
  }
}

// MARK: 2108. Find First Palindromic String in the Array
extension Solution.Easy {
  func tee() {
    let words = ["racecar","cool"]
    print(firstPalindrome(words))
  }
  func firstPalindrome(_ words: [String]) -> String {
    var isPalindrome: Bool, left: String.Index, right: String.Index
    for word in words {
      isPalindrome = true
      left = word.startIndex
      right = word.index(before: word.endIndex)
      
      for _ in 0..<word.count / 2 {
        guard word[left] == word[right] else {
          isPalindrome = false
          break
        }
        left = word.index(after: left)
        right = word.index(before: right)
      }
      
      guard isPalindrome else { continue }
      return word
    }
    
    return ""
  }
}
