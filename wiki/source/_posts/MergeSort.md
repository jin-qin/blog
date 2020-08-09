---
title: MergeSort
date: 2020-08-07 20:37:17
categories: Algorithms
tags:
---


# MergeSort
Like QuickSort, Merge Sort is a Divide and Conquer algorithm. It divides input array in two halves, calls itself for the two halves and then merges the two sorted halves. The merge() function is used for merging two halves.

![MergeSort](https://upload.wikimedia.org/wikipedia/commons/c/cc/Merge-sort-example-300px.gif)

> My implementation for MergeSort in C++:
```cpp
#include <algorithm>
template<class InputIterator>
void mergesort(InputIterator first, InputIterator last) {
  if (last - first <= 1) return;
  
  auto mid = first + (last - first) / 2;

  mergesort(first, mid);
  mergesort(mid, last);

  // merge [first, mid) and [mid, last)
  std::inplace_merge(first, mid, last);
}
```

> To test out
```cpp
#include <iostream>
#include <iterator>

int main() {
  std::vector<int> arr {9,8,7,5,6,1,3,2,4};
  mergesort(arr.begin(), arr.end());

  std::copy(arr.begin(), arr.end()
  std::ostream_iterator<int>(std::cout, " "));
}
```