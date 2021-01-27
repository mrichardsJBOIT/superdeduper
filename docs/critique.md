# Critique

---
The following was asked
> Consider the the following points in formulating your solution:
>* What if this same solution was used on a really large set of photos? What if it was a thousand photos? Or tens of thousands?
>* What if this was a three-way merge, with triplicates? Does your solution account for this?
>* Some of these files may have had their filename changed.
>* Some of these may have only their extension changed.

## Thoughts

####Scalability

This solution reads the entire byte string of each file and stores them in an array.  Ruby's Enumerable module comes with a handy ['group_by'](https://ruby-doc.org/core-2.7.2/Enumerable.html#method-i-group_by) method that is built-in to the array class.  This allows us to group the collection by the byte string or content of the files. Bench marking will need to be done to capture how efficiently the library is able to sort and compare strings in the array.  
The larges file in the test collection was 7,700kb, a thousand of them would consume most users laptops. 

For a scalable solution to work on large collections the considerations would be:
* Can only a section of the images byte string be stored and where there are duplicate groups,
  * recursively read in more sections of the byte string until the images are identified as different or a full comparison os done. 
* Can the array be split into smaller arrays and each one processed for grouping in paralle?
  * While this may speed up processing it does not change the memory issues
  * This option adds a logic requirement to bring the collections back together and check for duplicate group
* Can file size be used as an indicator of potential image replication?
  * Can it be shown that images with different sizes are always different?
  * If so, then first grouping the collection by size then checking each group for duplicates would be a reasonable extension of this solution. 
    
#### Multiple Duplicates

Happily this solution does cater for multiple duplicates

#### Naming & Extensions

By focusing on the exact content the file names and extensions are not considered.  Duplicates with simple file name or extension changes are catered for. 