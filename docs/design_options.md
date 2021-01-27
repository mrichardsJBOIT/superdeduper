# Design Options

---
## Requirements:
* In your implementation, only use the standard libraries of your chosen language. No shelling out, or using external services or libraries.
* You are free to use external libraries for the purposes of testing.
* The code should be readable, reusable, easy to modify and well tested. We're looking for production-quality code that is test driven.

**Consider the the following points in formulating your solution:**
* What if this same solution was used on a really large set of photos? What if it was a thousand photos? Or tens of thousands?
* What if this was a three-way merge, with triplicates? Does your solution account for this?
* Some of these files may have had their filename changed.
* Some of these may have only their extension changed.


    Your code should be of production quality, and demonstrate the idioms of your chosen language.
## Considerations
* Language 
    * Java 
    * Ruby 
* Packaging
    * Shell script calling class of chosen language
    * Executable Java .jar file
    * Ruby gem with executable
* Design Patterns
  *  Limit to Gang of four
* Algorithm
  * Content comparison
    * Iterating over each file checking byte by byte, moving or marking duplicates for single consideration
      * Fortunately we can get this type of behaviour by using a 'group by' function on an enumerable collection...  
    * Crashed Digests
      * As each file is read, create a hashed signature of the file and store in a collection using signature as the key
      * Duplicates (potential at least) will crash on insert
      * Mark or store as crashed files as duplicates
      * May have to compare byte by byte as well, duplicate digests do not guarantee identical files.
  * Folder traversal
* Performance and scalability
  * How efficient are the algorithms?
  * Can processing be done in parallel?
* Scope
  * ...where to stop....

## Choices
| Component | Option(s) | Comments |  
| --------  | -----     | --------- |
| Language  | Ruby      | Use the challenge as an opportunity to upskill and learn. |
| Packaging | Gem       | Mature and well supported package management.  Simpler than Maven for Java.  |
| Patterns  | <ul><li>Command</li><li>Facade or Singleton</li><li>Iterator</li></ul> | <ul><li>Asynchronous processing of large collections</li><li>Simple interface to complex operations.  Singleton likely to impact multi-instance processing for </li><li>Encapsulate traversing file and internal collections</li></ul>  |
| Content comparison | Byte by byte  | Go for the simple solution first...  |

## Classes and Structures
* Application 
* Command Line Parser
* Image, Photo or File
* Collections
  * All files
    * What properties are collected or 
  * Duplicates
    * How are these named or grouped?

## Processing Logic
> * Receive and validate arguments
> * Collect all files for consideration
>    *  How to identify or group potential duplicates at this stage? e.g. reading first 'n' bytes or file size 
> * Iterate over collection 
>   * Compare each member
>   * When an identical member is found
>     * Move or mark that found member as a duplicate  
> * Display duplicates