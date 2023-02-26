# Genetic Algorithms in Elixir 

## [Chapter 1 - Writing Your First Genetic Algorithm](Chapter01/)
Genetic Algorithms are a class of optimization algorithms based on evolution and natural selection. They use strategies inspired by genetics and biology to produce near-optimal solutions to complicated problems. Genetic Algorithms word via _transformations_ on _populations_ of _chromosomes_ over some number of _generations_. 

- Crossover - how genetic algorithms exploit in search, this is the process of creating new _child_ solutions from _parent_ solutions. The idea is that the strongest solutions have characteristics which make them strong.
- Schemas - the characteristics which make a solution strong. These are the building blocks of fit solutions.
- Mutation - how genetic algorithms explore. Mutation introduces randomness in the algorithm, which slightly alter some aspect of the previous solution to create new solutions which may in turn lead to a better path.

### The One-Max Problem
This is a trivial problem often used to introduce the concept of genetic algorithms. **What is the maximum sum of a bitstring of length _N_**. 

#### Initializing the Population
In a traditional search method like depth-first or breadth-first, you examine one solution at a time and determine where to go next. Genetic algorithms examine many solutions at once, ruling out large areas of the search space after each generation. The population size dictates the size of the area of the search space you're looking at. 

#### Understanding the Flow of Genetic Algorithms
After children are mutated, the process repeats itself. Genetic algorithms are recursive by nature. 

#### What You Learned
- What informed search is, and why it's superior to brute-force search for finding solutions to difficult problems.
- What are genetic algorithms, and implemented a basic version to solve the One-Max problem.