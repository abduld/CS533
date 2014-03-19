% Map Reduce on Hetrogenous Systems
% Carl Pearson, Abdul Dakkak, Liwen Chang

## Project Summary

* State that we are not doing distributed computing anymore.

## Language Details

Our language/library will be inspired by array and data flow programming languages such as Fortran[@Fortran], APL[@APL], and LINQ[@LINQ] where
  one expresses computation based on operations on vectors and arrays.
This defines two vectors of size `100`

      n :: Integer = 1000;
      as :: []Real = rand.Real(n);
      bs :: []Real = rand.Real(n); 

We can then add the two vectors using an overloaded plus operator

      res :: []Real = as + bs;

To give you a taste of the language, in this program we approximate `pi` using Monte Carlo integration

      def f(a :: Real, b :: Real) :: Bool {
        return a*a + b*b < 1;
      }
      res :: Integer = zip(as, bs).count(f) / n;

this would be translated into the map/reduce operations of 

      t1 = map(f, zip(as, bs));
      count = 0;
      reduce((x) => count += x, t1);
      res = count / n;

We plan on expressing all commonly used analytics operations such as sort, mean, max, min, histogram, variance, etc...
  in this framework.


`TODO: cite nova and copper head`

## Progress Summary

We have 

* Parser
* Instruction lowerer
* Backend to generate CUDA code
* Backend to generate Javascript code (this is used for debugging)


## Implementation Details

To facilitate rapid prototyping in this project, we chose the Dart
  programming language.
The Dart language developed by google is a modern interperetation of
  Javascript --- a cross between C++/Java and Javascript.
It adds classes, types, and polymorphic instances (via a templating mechanism)
  and is able to compile down to Javascript or can be run in the Dart VM.
The language also has good documentation, extensive standard library,
  and an active library development community
  (the parser generator, for example, is a library we are using).



## Backend Details

* Javascript
* CUDA

## Compiler Pass

The most important factor in distributed computing is how to manage
  memory transfer.
If a node computes a chunk of data and it is used in subsequent instructions, then it should reuse the output rather than send and request the data again.
There are two approaches to facilitate this.
The first is a runtime approach: Hadoop, for example, dispatches
  tasks to maximize reuse of local data.
This done via the Hadoop scheduler which has a mapping between nodes and data 
  state.

The second is a compiler transformation.
This is mainly done via loop fusion.
If for example, one writes a program `map(f, map(g, lst))` then a compiler pass
  can transform this into `map(f.g, lst)`.
A simple peephole optimizer can scan for this instruction pattern and
  perform this transofmration.
A generalization of this technique for other list primitives is found in the 
  the Haskell vector library.
Using a concept called Stream Fusion[@StreamFusion], Haskell
  fuses most function loops to remove unecessary
  temporaries and list traversals.
In this project, we will look at how Haskell performs this transformation and
  how applicable it is in a non-shared memory model.

## Revised Schedule

## References

