//
//  EasyIntArrayTasks.swift
//  Algorithms
//
//  Created by Igor Ratynski on 23.07.2022.
//

import Foundation

// MARK: Good pairs
extension Solution.Easy {
  func numIdenticalPairs(_ nums: [Int]) -> Int {
    var result = 0

    for indexI in 0..<(nums.count - 1) {
      for indexJ in (indexI + 1)..<nums.count {
        guard nums[indexI] == nums[indexJ] else { continue }
        result += 1
      }
    }
    
    return result
  }
}

// MARK: Single number
extension Solution.Easy {
  func singleNumber(_ nums: [Int]) -> Int {
    var result: [Int] = [], cache: [Int:Int] = [:]
    
    for value in nums {
      cache[value] = (cache[value] ?? 0) + 1
      if cache[value] == 1 {
        result.append(value)
      } else {
        guard let index = result.firstIndex(of: value) else { continue }
        result.remove(at: index)
      }
    }
    
    return result.first!
  }
}

// MARK: Contains duplicate
extension Solution.Easy {
  func containsDuplicate(_ nums: [Int]) -> Bool {
//    // I
//    Set(nums).count != nums.count
//    // II
    var cache = Set<Int>(), count: Int
    for num in nums {
      count = cache.count
      cache.insert(num)
      guard count == cache.count else { continue }
      return true
    }
    return false
  }
}

// MARK: Sorted squares
extension Solution.Easy {
  func sortedSquares(_ nums: [Int]) -> [Int] {
      nums.map { $0 * $0 }.sorted()
  }
}

// MARK: Missing number
extension Solution.Easy {
  func missingNumber(_ nums: [Int]) -> Int {
    // I
    /*
    let nums = nums.sorted()
        
    for index in 1..<nums.count {
      guard nums[index - 1] == nums[index] - 1 else { return nums[index - 1] + 1 }
    }
    
    return nums.first! == 0 ? nums.last! + 1 : 0
    */
    // II
    var commonCount = 0, mustCount = 0, minValue = nums.first!
    for (index, value) in nums.enumerated() {
      commonCount += value
      mustCount += index
      guard minValue > value else { continue }
      minValue = value
    }
    if minValue == 1 { return 0 }
    return minValue + nums.count - (commonCount - (minValue * nums.count + mustCount))
  }
}

// MARK: Move zeros
extension Solution.Easy {
  func moveZeroes(_ nums: inout [Int]) {
    for i in 0..<nums.count {
      guard nums[i] == 0 else { continue }
      for j in (i+1)..<nums.count {
        guard nums[j] != 0 else { continue }
        nums[i] = nums[j]
        nums[j] = 0
        break
      }
    }
  }
}

// MARK: 485. Find max consecutive ones
extension Solution.Easy {
  func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var count = 0, tempCount = 0
    
    for number in nums {
      if number == 1 {
        tempCount += 1
      } else {
        if count < tempCount {
          count = tempCount
        }
        tempCount = 0
      }
    }
    
    return max(count, tempCount)
  }
}

// MARK: 495. Find poisoned duration
extension Solution.Easy {
  func findPoisonedDuration(_ timeSeries: [Int], _ duration: Int) -> Int {
    var poison = 0, temp: Int
    for index in 1..<timeSeries.count {
      temp = timeSeries[index] - timeSeries[index-1]
      if temp >= duration {
        poison += duration
      } else {
        poison += temp
      }
    }
    
    return poison + duration
  }
}

// MARK: 605. Can place flowers
extension Solution.Easy {
  func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
    guard n > 0 else { return true }
    var flowerbed = flowerbed, n = n, temp: Int, index = 0
    
    while index < flowerbed.count {
      temp = flowerbed[index]
      if index - 1 >= 0 {
        temp += flowerbed[index-1]
      }
      if index + 1 < flowerbed.count {
        temp += flowerbed[index+1]
      }
      
      guard temp == 0 else {
        index += 1
        continue
      }
      
      flowerbed[index] = 1
      n -= 1
      index += 2
      guard n == 0 else { continue }
      return true
    }
    
    return false
  }
}

// MARK: 566. Matrix reshape
extension Solution.Easy {
  func matrixReshape(_ mat: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
    var mat = mat, matCompact: [Int] = [], tempArray: [Int]
    // TODO: optimization - from end to start
    for array in mat {
      matCompact.append(contentsOf: array)
    }
    guard matCompact.count == r * c else { return mat }
    mat = []
    for _ in 0..<r {
      tempArray = []
      for _ in 0..<c {
        tempArray.append(matCompact.removeFirst())
      }
      mat.append(tempArray)
    }
    return mat
  }
}

// MARK: 2022. Construct 2d array
extension Solution.Easy {
  func construct2DArray(_ original: [Int], _ m: Int, _ n: Int) -> [[Int]] {
    guard original.count == m * n else { return [] }
    var tempArray: [Int], result: [[Int]] = [], original = original
    
    for _ in 0..<m {
      tempArray = []
      for _ in 0..<n {
        tempArray.append(original.removeFirst())
      }
      result.append(tempArray)
    }
    return result
  }
}

// MARK: 905. Sort array by parity
extension Solution.Easy {
  func sortArrayByParity(_ nums: [Int]) -> [Int] {
//    // I
//    var even: [Int] = [], odd: [Int] = []
//    for num in nums {
//      num % 2 == 0 ? even.append(num) : odd.append(num)
//    }
//
//    return even + odd
    // II
    var nums = nums, temp: Int, leftPtr = 0, rightPth = nums.count - 1, leftValid = false, rightValid = false
    
    while leftPtr < rightPth {
      if !leftValid {
        leftValid = nums[leftPtr] % 2 == 1
      }
      if !rightValid {
        rightValid = nums[rightPth] % 2 == 0
      }
      
      if leftValid && rightValid {
        temp = nums[leftPtr]
        nums[leftPtr] = nums[rightPth]
        nums[rightPth] = temp
        leftPtr += 1
        rightPth -= 1
        leftValid = false
        rightValid = false
      } else {
        if leftValid {
          rightPth -= 1
        } else {
          leftPtr += 1
        }
      }
    }
    
    return nums
  }
}

// MARK: 724. Find Pivot Index
// MARK: 1991. Find the Middle Index in Array
extension Solution.Easy {
  func pivotIndex(_ nums: [Int]) -> Int {
//  func findMiddleIndex(_ nums: [Int]) -> Int {
    var left: Int, right: Int
    
    for index in 0..<nums.count {
      left = 0
      right = 0
      
      for leftIndex in 0..<index {
        left += nums[leftIndex]
      }
      
      for rightIndex in (index + 1)..<nums.count {
        right += nums[rightIndex]
      }
      
      guard left == right else { continue }
      return index
    }
    
    return -1
  }
}

// MARK: 989. Add to Array-Form of Integer
extension Solution.Easy {
  func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
    
    // I
//    var result: [Int] = []
//    let k = String( Int(num.map { String($0) }.joined() )! + k )
//    for char in k {
//      result.append(Int(String(char))!)
//    }
//    return result
    
    // II
    var result: [Int] = [], num = num, k = k, kArray: [Int] = [], plusNext = 0, indexA = num.count - 1, indexB = 0, tempResult: Int

    while k > 0 {
      kArray.append(k % 10)
      k = k / 10
    }

    while indexA > -1 || indexB < kArray.count || plusNext > 0 {
      tempResult = (indexA > -1 ? num[indexA] : 0) + (indexB < kArray.count ? kArray[indexB] : 0) + plusNext
      plusNext = tempResult / 10
      if plusNext > 0 {
        tempResult = tempResult % 10
      }
      result.insert(tempResult, at: 0)

      indexA -= 1
      indexB += 1
    }

    return result
  }
}

// MARK: 169. Majority Element
extension Solution.Easy {
  func majorityElement(_ nums: [Int]) -> Int {
    var result: Int!, count = 0
    
    for num in nums {
      if count == 0 {
        result = num
      }
      
      if result == num {
        count += 1
      } else {
        count -= 1
      }
      
    }
    
    return result
  }
}

// MARK: 2404. Most Frequent Even Element
extension Solution.Easy {
  func mostFrequentEven(_ nums: [Int]) -> Int {
    var result: [Int:Int] = [:], maxCount = 0
    
    for num in nums {
      guard num % 2 == 0 else { continue }
      result[num] = (result[num] ?? 0) + 1
      
      if result[num]! > maxCount {
        maxCount = result[num]!
      }
    }
    
    return result
      .filter { $0.value == maxCount }
      .keys
      .sorted { $0 < $1 }
      .first ?? -1
  }
}

// MARK: 463. Island Perimeter
extension Solution.Easy {
  func islandPerimeter(_ grid: [[Int]]) -> Int {
    var result = 0
    
    for i in 0..<grid.count {
      for j in 0..<grid[i].count {
        guard grid[i][j] == 1 else { continue }
        result += i > 0 ? grid[i-1][j] == 1 ? 0 : 1 : 1
        result += i < (grid.count - 1) ? grid[i+1][j] == 1 ? 0 : 1 : 1
        
        result += j > 0 ? grid[i][j-1] == 1 ? 0 : 1 : 1
        result += j < (grid[i].count - 1) ? grid[i][j+1] == 1 ? 0 : 1 : 1
      }
    }
    
    return result
  }
}

// MARK: 747. Largest Number At Least Twice of Others
extension Solution.Easy {
  func dominantIndex(_ nums: [Int]) -> Int {
    
    // I
    var max = max(nums[0], nums[1]), maxIndex = max == nums[0] ? 0 : 1,
        beforeMax = min(nums[0], nums[1])
    
    for index in 2..<nums.count {
      if nums[index] > max {
        beforeMax = max
        max = nums[index]
        maxIndex = index
      } else if nums[index] > beforeMax {
        beforeMax = nums[index]
      }
    }
    
    guard beforeMax > 0 else { return maxIndex }
    return max / beforeMax > 1 ? maxIndex : -1
    
    // II
//    let sorted = nums.sorted { $0 > $1 }, max = sorted[0], beforeMax = sorted[1]
//    guard beforeMax > 0 else { return nums.firstIndex(of: max)! }
//    return max / beforeMax > 1 ? nums.firstIndex(of: max)! : -1
  }
}

// MARK: 1331. Rank Transform of an Array
extension Solution.Easy {
  func arrayRankTransform(_ arr: [Int]) -> [Int] {
    var positions: [Int:Int] = [:], count = 1
    
    for element in Set(arr).sorted() {
      positions[element] = count
      count += 1
    }
    
    return arr.map { positions[$0]! }
  }
}

// MARK: 2154. Keep Multiplying Found Values by Two
extension Solution.Easy {
  func findFinalValue(_ nums: [Int], _ original: Int) -> Int {
    let nums = Set(nums)
    var original = original
    
    while nums.contains(original) {
      original *= 2
    }
    
    return original
  }
}

// MARK: 1346. Check If N and Its Double Exist
extension Solution.Easy {
  func checkIfExist(_ arr: [Int]) -> Bool {
    let evensArray = arr.filter { $0 % 2 == 0 }, arr = Set(arr)
    guard evensArray.filter({ $0 == 0 }).count < 2 else { return true }
    
    for even in evensArray {
      guard even != 0, arr.contains(even / 2) else { continue }
      return true
    }
    return false
  }
}

// MARK: 832. Flipping an Image
extension Solution.Easy {
  func flipAndInvertImage(_ image: [[Int]]) -> [[Int]] {
    // I
    var result: [[Int]] = Array(repeating: [], count: image.count)
    
    for i in 0..<image.count {
      for j in stride(from: image[i].count - 1, through: 0, by: -1) {
        result[i].append(image[i][j] == 0 ? 1 : 0)
      }
    }
    
    return result
    // II
//    image.map { $0.reversed().map { $0 == 0 ? 1 : 0 } }
  }
}
