# Genetic Algorithms in Elixir 

- [Chapter 1 - Writing Your First Genetic Algorithm](#chapter-1---writing-your-first-genetic-algorithm)
- [Chapter 2 - Breaking Down Genetic Algorithms](#chapter-2---breaking-down-genetic-algorithms)
- [Chapter 3 - Encoding Problems and Solutions](#chapter-3---encoding-problems-and-solutions)
- [Chapter 4 - Evaluating Solutions and Populations](#chapter-4---evaluating-solutions-and-populations)
- [Chapter 5 - Selecting the Best](#chapter-5---selecting-the-best)
- [Chapter 6 - Generating New Solutions](#chapter-6---generating-new-solutions)
- [Chapter 7 - Preventing Premature Convergence](#chapter-7---preventing-premature-convergence)
- [Chapter 8 - Replacing and Transitioning](#chapter-8---replacing-and-transitioning)
- [Chapter 9 - Tracking Genetic Algorithms](#chapter-9---tracking-genetic-algorithms)
- [Chapter 10 - Visualizing the Results](#chapter-10---visualizing-the-results)
- [Chapter 11 - Optimizing Your Algorithms](#chapter-11---optimizing-your-algorithms)

## General Notes:
- A lot of times the code in the book is "wrong" -> missing capture operators which are present in code available to download.
- `codebreaker.exs` as written in Chapter 7 will not run, not exactly in the mood to debug why it returns invalid character binaries.
- This codebase is riddled with errors - the `Genetic.run` call in `schedule.exs` for Chapter 8 calls `reinsertion_strategy` - changing this to `reinsertion_strategy` (correctly spelling reinsertion) results in an argument error - looks like the `old` list contains a mix of `%Types.Chromosome{}`s and tuples of `%Types.Chromosome{}` -> the private `unzip/2` function was added to fix this (easier to fix here than find the root of the problem unfortunately...).
- I took out the display in `Genetic.evolve` in Chapter 11, having the printout is distracting during the benchmarking process, and `:erlang.float_to_binary(best.fitness)` doesn't play nice with integers.
- I don't seem to be able to benchmark `Genetic.crossover` out of the box, might need to go back and tweak some `Benchee` settings.
- Chapter 11 is an absolute nightmare in terms of bugs - I don't think this was tested at all. For example `genetic.initialize` returns a list of tuples for the population, whereas `evaluate` expects population to be a list of pids. Furthermore the pipeline in `evaluate` is not going to work as written because the results of the first `Enum.map` are incompatible with sort... I _really_ don't feel like debugging even more of this code for the sake of seeing it run, I get it...

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

### What You Learned
- What informed search is, and why it's superior to brute-force search for finding solutions to difficult problems.
- What are genetic algorithms, and implemented a basic version to solve the One-Max problem.

## [Chapter 2 - Breaking Down Genetic Algorithms](Chapter02/)
The purpose of this chapter is to use the One-Max problem to help design and build a _framework_ which can be used to create genetic algorithms, which can later be applied to other problems.

### Chromosomes and Populations
For the most part, how you encode a population (a collection of chromosomes) won't change - as long as the population remains a set of chromosomes. Some rules to help define the rules of the framework:
- To use polymorphism, encode chromosomes using a data structure that implements the `Enumerable` protocol.
- Because populations are stored as lists, you can use any function in the `Enum` or `List` library to implement transformations.
- Your algorithm should work on any population size. 
    - Bigger populations will take longer to transform but may converge on a solution faster.
    - Smaller populations are easier to transform, but may take longer to converge.

### Initializing the Population
We've determined that the population is a list, and the first step must return a list of chromosomes so we need to ensure that our initialization function can apply to all types of problems and is not hindered by the specifics of _how_ chromosomes are encoded. For this we can pass a function as an argument into the initializer, so long as this function produces chromosomes.
- The initialization step must produce an initial population - a list of possible solutions.
- The function which initializes the population should be agnostic to how the chromosomes are encoded. This can be achieved by accepting a function which returns a chromosome. 

### Evaluating the Population
The evaluation step is responsible for evaluating each chromosome based on some fitness function and sorting the population based on the fitness. This makes it easy to extract the best members of the population. Just like encoding chromosome schemes varies from problem to problem, so does the evaluation. 
- The evaluation step must take a population as an input.
- The evaluation step must produce a population sorted by fitness.
- The function which evaluates the population should take a parameter that is a function that returns the fitness of each chromosome.
- The fitness function can return anything, as long as the fitness can be sorted.

### Selecting Parents
- The selection step must take a population as an input.
- THe selection step must produce a transformed population that's easy to work with during crossover - say by returning a list of tuples which are pairs of parents.

### Creating Children
The goal of crossover is to exploit the strengths of current solutions to find new, better solutions. Crossover is the last step before starting a new generation and should produce a population that feels identical to the starting population, but with new solutions.
- Take a list of 2-tuples as input.
- Combine the 2-tuples, which represent the parent pairs. 
- Return a population identical in size to the initial population.

### Creating Mutants 
Mutation is the last step before the next generation - with the goal of preventing premature convergence by transforming (at random) some of the chromosomes of the current population.
- The mutation step should accept a population as input.
- The mutation step should mutate _only some_ of the chromosomes in the population - the percentage should be relatively small (~5%).
- The mutation strategy should be identical to the mutation function from the previous chapter.

### Termination Criteria
- Termination criteria must be defined by the problem - the framework must accept some problem-defined condition which stops the algorithm when satisfied.
- Termination criteria (for now) must be an integer - the maximum value needed to stop the evolution.

### What You Learned
- Created a framework for genetic algorithms
    - Defined criteria that's consistent and different between problems
    - Defined rules for the framework to enforce so it can be generalized
- Re-solved the One-Max problem with this framework

## [Chapter 3 - Encoding Problems and Solutions](Chapter03/)
Chromosome - At the most basic level, a chromosome is a single solution to a genetic problem. It is a series of genes consisting of values called _alleles_.

### Using Behaviours to Model Problems
Elixir doesn't feature abstract classes, interfaces, or traits like traditional object-oriented languages. Instead, abstraction can be implemented using _behaviours_. We will define 3 callbacks to help with our framework:
- Genotype: `@callback genotype :: Chromosome.t`
    - Chromosome.t is the custom type build in the previous section.
    - This means `genotype/0` must return a `%Chromosome{}` struct.
- Fitness: `@callback fitness_function(Chromosome.t) :: number()`
    - Fitness functions assess the fitness of a single chromosome.
    - In this book, fitness functions will only return numeric values. 
- Termination: `@callback terminate?(Enum.t) :: boolean()`
    - Even though the termination criteria is not always known, this behaviour should take an enumerable representation of the population and return a boolean indicating whether evolution should stop or continue

### Understanding and Choosing Genotypes
One of the most important decisions when using a genetic algorithm is the type of _encoding_ (the representation of a solution) used. The type of encoding scheme you use is called a _genotype_, and the genotype of a chromosome indicates what the chromosome should look like.

While genotype is the internal representation of solutions, the _phenotype_ is the expressed representation of the solution - what it looks like "in the real world".

- Binary Genotypes (bitstrings): genes consisting of only 1s and 0s. 
- Permutation Genotypes: especially effective for scheduling or path-finding problems. The problems which Permutation Genotypes best lend themselves to are generally referred to as _combinatorial optimization_ problems - problems which look for an ordered solution. 
- Real Value Genotypes: these represent solutions using real values - string, float, character, etc.
- Tree/Graph Genotypes: the most common application for these genotypes is _genetic programming_. 

## [Chapter 4 - Evaluating Solutions and Populations](Chapter04/)

### Introducing Penalty Functions
Some solutions will not be considered valid, for example they may violate the constraints of the problem like the weight constraint in the [Cargo](Chapter04/genetic/scripts/cargo.exs) example. A Penalty Function is a function applied to constraint satisfaction problems for the purpose of reducing the constraint satisfaction problem into an unconstrained one. Rather than putting constraints on possible solutions, penalty functions incur a penalty on solutions which violate the constraint of the original problem.

### Defining Termination Criteria
If you don't know when to stop and return a solution, you'll never get a solution and the recursion will continue indefinitely. The goal of termination criteria is to stop the algorithm when it has reached the maximum fitness. There are three basic techniques for defining reasonable termination criteria:
1. Stopping Evolution at a Fitness Threshold
2. Stopping Evolution after n Generations 
3. Stopping Evolution with No Improvements 
    - The simplest way to stop based on changes in fitness is to use _temperature_. A "hot" algorithm continues to make improvements while a "cold" one has not made improvements in awhile.

### Exploring Different Types of Optimization
1. Optimizing Multiple Objectives
2. Interactive Optimization - to handle as assess _perceptual data_, you can write interactive fitness functions. This is handy when you're working with solutions which are impossible to assess mathematically, instead you ask the user to assess fitness. This however usually takes a lot of time and is subject to user bias.

## [Chapter 5 - Selecting the Best](Chapter05/)
Selection is about balancing genetic diversity and fitness. If you can't maintain genetic diversity of your population, the algorithm will likely end up converging without finding the best solution. 
1. Fitness-based Selection
2. Rewards-based Selection - based on the cumulative reward obtained by an individual. Rewards are calculated with a reward function, and can be very useful in multi-objective optimization.

### Implementing Common Selection Strategies 
1. Elitism Selection: choose the best `n` chromosomes to reproduce.
2. Random Selection: select `n` chromosomes at random. Can be useful if your problem absolutely requires genetic diversity.
3. Tournament  Selection: pits chromosomes together to favour those that are both diverse and strong. One drawback of tournament selection is that it might not be appropriate for smaller populations. You can implement tournament selection with or without duplicates - if you allow duplicate parents to be selected you run the risk of allowing your population to becomes less genetically diverse. If you do not allow duplicates, you increase genetic diversity at the cost of algorithm speed 
    - Choose a pool of `n` chromosomes where `n` is the "tournament size".
    - Choose the fittest chromosome from the tournament.
    - Repeat
4. Roulette Selection (fitness-proportionate selection): choose parents with a probability proportional to their fitness. Roulette selection attempts to balance genetic diversity and fitness based on probability - individuals with higher fitness have a higher probability of being chosen, but it is still possible that less fit individuals are selected as well.

## [Chapter 6 - Generating New Solutions](Chapter06/)

### Implementing Common Crossover Strategies 
1. Order-One Crossover
    - Select a random slice of genes from Parent 1
    - Remove the values from teh slice of Parent 1 from Parent 2
    - Insert the slice from Parent 1 into the same position in Parent 2
    - Repeat with a random slice from Parent 2
2. Single-point Crossover
3. Uniform Crossover
4. Whole Arithmetic Recombination

### Chromosome Repairment 
This is the process by which you ensure solutions remain valid _after_ crossover or mutation. This is only necessary if you choose a crossover strategy which does not impact the validity of your solutions.

## [Chapter 7 - Preventing Premature Convergence](Chapter07/)
Premature convergence refers to the stalling progress of an algorithm as a result of a lack of genetic diversity in the population.

### Implementing Common Mutation Strategies
1. Flip Mutation (bit flip mutation) - this will "flip" some or all of the bits in a chromosome.
2. Scramble Mutation - "shuffles" all the genes in a given chromosome to give a new one.
3. Gaussian Mutation - this method is meant specifically for real-value representations of chromosomes. In Gaussian Mutation, you calculate the mean and standard deviation of the genes in the chromosome, and then use them to generate numbers in the distribution. This allows you to slightly adjust a chromosome without changing it too much as the random numbers that replace the genes in the chromosome belong to the same distribution.
4. Swap - swap a pair of genes.
5. Uniform - replace genes with uniform random numbers.
6. Invert - invert the order of the chromosome.

## [Chapter 8 - Replacing and Transitioning](Chapter08/)
The process of combining the byproducts of selection, crossover, and mutation, into a new population is called _reinsertion_ or _replacement_.

### Reinsertion
The process of taking chromosomes produced from selection, crossover, and mutation, and inserting them back into a population to move on to the next generation.
1. Pure Reinsertion and Generational Replacement - _Pure Reinsertion_ is the tpe we used in the first few chapters of this book, where every chromosome in the old population is replaced with an offspring of the new population.
2. Elitist Reinsertion - a top-portion of the old population survives into the next generation. You introduce a concept of _survival rate_, which dictates what percentage of the parent chromosomes survive into the next generation.
3. Uniform Reinsertion or Random Replacement - selects random chromosomes from the old population to survive into the next generation. The purpose of this strategy is to maintain as much genetic diversity as possible in the new population. This strategy, however, is not very common.

If you need your algorithms to converge quickly and efficiently, stick to elitist or pure insertion. 

### Growing and Shrinking Populations
There is a slight distinction between _replacement_ and _reinsertion_, although the two terms are often used interchangeably. _Replacement_ strategies focus specifically on maintaining a fixed population size - old chromosomes are replaced with new ones. _Reinsertion_ strategies integrate old chromosomes with new ones.

Unchecked selection and survival rates will make your population either grow or decay _exponentially_, so they must be balanced or else your algorithm will stall or run out of populations.

## [Chapter 9 - Tracking Genetic Algorithms](Chapter09/)

### Logging Statistics using ETS
During an evolution, you may want to track statistics about age, fitness, or variation in population. In this chapter, we set up a GenServer to supervise an ETS table which will store per-generation statistics.

### Tracking Genealogy in a Genealogy Tree
In the context of genetic algorithms, _genealogy_ is the history of a chromosome's lineage. It allows the tracking of the ancestry of a specific chromosome back to the initial population. We'll use `libgraph` to construct a _genealogy tree_, represented as a directed graph pointing from parent chromosome to child.

## [Chapter 10 - Visualizing the Results](Chapter10/)
- Software like [Graphviz](http://www.webgraphviz.com/) can be used to visualize genealogy graphs.
- Elixir has a Gnuplot package which can be used to plot results.
- There is an ALE (Arcade Learning Environment) library for Elixir. It's very easy to put a wrapper around `ALEx` callbacks and integrate a sequence of commands into a game interface to try and find the optimal way to get the highest score!

## [Chapter 11 - Optimizing Your Algorithms](Chapter11/)
When working through algorithm optimizations, the general progression of successive optimization methods is:

1. Creating benchmarks and profiling the algorithms.
2. Optimizing the performance of the Elixir code.
3. Parallelizing the algorithms.
4. Writing NIFs

Generally, you want to progress down this list only when necessary.

### Tools
- `Benchee` can be used for benchmarking
- `ExProf` can be used for profiling

### Quick and Easy Optimizations
- If order of lists is not important, `Enum.map/2` can be replaced with `Enum.reduce/3`
- Using negative numbers in `Enum.take` and `Enum.drop` is mad slow
- Lazy Evaluation - `Stream` can be used in place of `Enum` in some places to reduce memory usage

### Parallelization  
- Reach for parallelization when dealing with larger amounts of data that take awhile to process
- Easiest way to parallelize is with the `Task` module
- Keep in mind that creating a new process comes with significant overhead (stack, heap, message area, etc.) 

