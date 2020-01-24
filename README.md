# HashTable
Example for HashTable with LinkedList.
This examples shows how hashtable calculates the index for key value pairing,
also object with same hashing index stored at custom linked list.

```
enum LinkedList<T> {
    case end
    indirect case node(T, LinkedList<T>)
}
```
