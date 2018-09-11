import 'src/pairing_graph.dart';

// Exercises 1 and 2

highlightPickySuits() {
  for (var suit in allSuits) {
    if (edgeCount(suit) == 1 || edgeCount(suit) == 2) {
      highlight(suit);
    }
  }
}

// Exercises 3 and 4

highlightPopularDresses() {
  for (var dress in allDresses) {
    if (edgeCount(dress) >= allDresses.length / 2) {
      highlight(dress);
    } else {
      dim(dress);
    }
  }
}

// Exercise 5

highlightRivalsOfFirstSuit() {
  for (var dress in dressesAvailableFor(firstSuit)) {
    for (var suit in suitsAvailableFor(dress)) {
      if (suit != firstSuit) {
        highlight(suit);
      }
    }
  }
}

highlightRivalsOfFirstDress() {
  for (var suit in suitsAvailableFor(firstDress)) {
    for (var dress in dressesAvailableFor(suit)) {
      if (dress != firstDress) {
        highlight(dress);
      }
    }
  }
}

// Exercise 6

highlightFirstDressAndFriends() {
  highlightDressAndFriends(firstDress);
}


/// Highlight the given dress and all friends, if not already done.
highlightDressAndFriends(dress) {
  if (isNotHighlighted(dress)) {
    highlight(dress);
    for (var suit in suitsAvailableFor(dress)) {
      highlightSuitAndFriends(suit);
    }
  }
}

/// Highlight the given suit and all friends, if not already done.
highlightSuitAndFriends(suit) {
  if (isNotHighlighted(suit)) {
    highlight(suit);
    for (var dress in dressesAvailableFor(suit)) {
      highlightDressAndFriends(dress);
    }
  }
}

// Exercises 7 and 8

maxPairing() {
  while (canFindChain()) {
    invertChain();
  }
}

/// Is there a path from an unpaired suit to an unpaired dress?
canFindChain() {
  for (var suit in allSuits) {
    if (isNotPaired(suit) && canFindUnpairedDressFrom(suit)) {
      return true;
    }
  }
  return false;
}

/// Is there a path to an unpaired dress from the given suit?
// canFindUnpairedDressFrom(suit) {
//   for (var dress in dressesAvailableFor(suit)) {
//     if (isNotPaired(dress) || canFindUnpairedDressFrom(suitPairedWith(dress))) {
//       return true;
//     }
//   }
//   return false;
// }

// Exercise 8
canFindUnpairedDressFrom(suit) {
  for (var dress in dressesAvailableFor(suit)) {
    if (isNotMarked(dress)) {
      mark(dress);
      if (isNotPaired(dress)) {
        chain(edge(suit, dress));
        return true;
      } else {
        if (canFindUnpairedDressFrom(suitPairedWith(dress))) {
          chain(edge(dress, suitPairedWith(dress)));
          chain(edge(suit, dress));
          return true;
        }
      }
    }
  }
  return false;
}

