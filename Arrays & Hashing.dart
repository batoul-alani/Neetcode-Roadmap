void main() {
  /// First issue
  // print(containsDuplicate([1,2,3]));
  /// Second issue
  // print(isAnagram("anagram", "nagaram"));
  /// Third issue
  // print(groupAnagrams(["eat","tea","tan","ate","nat","bat"]));
  /// Forth issue
  // print(topKFrequent([4,1,-1,2,-1,2,3], 2));
  /// Fifth issue
  // print(productExceptSelf([4,3,2,1,2]));
  /// Sixth issue
  // print(isValidSudoku([
  //   [".", ".", ".", ".", "5", ".", ".", "1", "."],
  //   [".", "4", ".", "3", ".", ".", ".", ".", "."],
  //   [".", ".", ".", ".", ".", "3", ".", ".", "1"],
  //   ["8", ".", ".", ".", ".", ".", ".", "2", "."],
  //   [".", ".", "2", ".", "7", ".", ".", ".", "."],
  //   [".", "1", "5", ".", ".", ".", ".", ".", "."],
  //   [".", ".", ".", ".", ".", "2", ".", ".", "."],
  //   [".", "2", ".", "9", ".", ".", ".", ".", "."],
  //   [".", ".", "4", ".", ".", ".", ".", ".", "."]
  // ]));
  /// Eighth issue
  print(longestConsecutive([1,2,0,1]));
}

int longestConsecutive(List<int> nums) {
  Set<int> numsAsSet = nums.toSet();

  int longest = 0;
  for(int index in numsAsSet){
    if(!numsAsSet.contains( index -1 )){
      int length = 0;
      while(numsAsSet.contains( index + length)){
        length ++ ;
      }
      longest = longest > length ? longest : length;
    }
  }
  return longest;
}

bool isValidSudoku(List<List<String>> board) {
  bool isValidRows = checkingFromRows(board);
  if (isValidRows) {
    bool isValidColumns = checkingFromColumns(board);
    if (isValidColumns) {
      bool isValidSquare = checkingFromSquare(board);
      return isValidSquare;
    }
  }
  return false;
}

bool checkingFromRows(List<List<String>> board) {
  for (int row = 0; row < board.length; row++) {
    for (int column = 0; column < board[row].length; column++) {
      String item = board[row][column];

      if (item != "." && board[row].lastIndexOf(item) != column) {
        return false;
      }
    }
  }
  return true;
}

bool checkingFromColumns(List<List<String>> board) {
  for (int row = 0; row < board.length; row++) {
    for (int column = 0; column < board[row].length; column++) {
      String item = board[row][column];

      for (int subRow = 0; subRow < board.length; subRow++) {
        if (item != "." && board[subRow][column] == item && subRow != row) {
          return false;
        }
      }
    }
  }
  return true;
}

bool checkingFromSquare(List<List<String>> board) {
  for (int row = 1; row < board.length; row += 3) {
    for (int column = 1; column < board[row].length; column += 3) {
      List<String> items = [];
      board[row - 1][column - 1] != "."
          ? items.add(board[row - 1][column - 1])
          : null;
      board[row - 1][column] != "." ? items.add(board[row - 1][column]) : null;
      board[row - 1][column + 1] != "."
          ? items.add(board[row - 1][column + 1])
          : null;
      board[row][column - 1] != "." ? items.add(board[row][column - 1]) : null;
      board[row][column] != "." ? items.add(board[row][column]) : null;
      board[row][column + 1] != "." ? items.add(board[row][column + 1]) : null;
      board[row + 1][column - 1] != "."
          ? items.add(board[row + 1][column - 1])
          : null;
      board[row + 1][column] != "." ? items.add(board[row + 1][column]) : null;
      board[row + 1][column + 1] != "."
          ? items.add(board[row + 1][column + 1])
          : null;
      print(items);
      for (int index = 0; index < items.length; index++) {
        for (int subIndex = 1; subIndex < items.length; subIndex++) {
          if (index != subIndex) {
            if (items[index] == items[subIndex]) {
              return false;
            }
          }
        }
      }
    }
  }
  return true;
}

bool containsDuplicate(List<int> nums) =>
    nums.length == nums.toSet().length ? false : true;

bool isAnagram(String s, String t) {
  List<String> sToList = s.split("");
  List<String> tToList = t.split("");

  Map<String, int> sresult = {};
  Map<dynamic, dynamic> tresult = {};

  for (String char in sToList) {
    if (sresult.containsKey(char)) {
      sresult.addAll({char: sresult[char]! + 1});
    } else {
      sresult.addAll({char: 0});
    }
  }

  for (String char in tToList) {
    if (tresult.containsKey(char)) {
      tresult.addAll({char: tresult[char]! + 1});
    } else {
      tresult.addAll({char: 0});
    }
  }

  Set<String> result = {};

  sresult.forEach((key, value) {
    result.addAll({"$key $value"});
  });

  tresult.forEach((key, value) {
    result.addAll({"$key $value"});
  });

  return result.length == sresult.length && sresult.length == tresult.length;
}

List<List<String>> groupAnagrams(List<String> strs) {
  Map<String, List<String>> map = {};

  for (String str in strs) {
    final List<String> s = str.split('');
    s.sort();
    final String key = s.join();
    if (map.containsKey(key)) {
      map[key]!.add(str);
    } else {
      map[key] = [str];
    }
  }
  return map.values.toList();
}

List<int> topKFrequent(List<int> nums, int k) {
  List<int> finalResult = [];

  Map<int, int> result = {};

  /// return Map with num and how many found this num in nums
  for (int num in nums) {
    if (result.containsKey(num)) {
      result.addAll({num: result[num]! + 1});
    } else {
      result.addAll({num: 1});
    }
  }

  result = result.orderByValues(compareTo: (a, b) => a.compareTo(b));

  if (result.length >= k) {
    for (int i = 0; i < k; i++) {
      finalResult.add(result.keys.last);
      result.remove(result.keys.last);
    }
    return finalResult;
  } else if (result.length == 1) {
    finalResult.add(result.keys.last);
    return finalResult;
  } else {
    return nums;
  }
}

/// Extensions on [Map] of <[K], [V]>
extension ExtendsionsOnMapDynamicDynamic<K, V> on Map<K, V> {
  /// Order by keys
  Map<K, V> orderByKeys({required int Function(K a, K b) compareTo}) {
    return Map.fromEntries(
        entries.toList()..sort((a, b) => compareTo(a.key, b.key)));
  }

  /// Order by values
  Map<K, V> orderByValues({required int Function(V a, V b) compareTo}) {
    return Map.fromEntries(
        entries.toList()..sort((a, b) => compareTo(a.value, b.value)));
  }
}

List<int> productExceptSelf(List<int> nums) {
  List<int> result = List.generate(nums.length, (index) => 1);

  int prefix = 1;
  for (int i = 0; i < nums.length; i++) {
    if (i != 0) {
      prefix = prefix * nums[i - 1];
      result[i] = prefix;
    }
  }

  int postFix = 1;
  for (int i = nums.length - 1; i >= 0; i--) {
    if (i == nums.length - 1) {
      result[i] = result[i] * postFix;
    } else {
      postFix = postFix * nums[i + 1];
      result[i] = postFix * result[i];
    }
  }

  return result;
}
