# Genetic Algorithms in Elixir 

- [Chapter 1 - Writing Your First Genetic Algorithm](#chapter-1---writing-your-first-genetic-algorithm)
- [Chapter 2 - Breaking Down Genetic Algorithms](#chapter-2---breaking-down-genetic-algorithms)
- [Chapter 3 - Encoding Problems and Solutions](#chapter-3---encoding-problems-and-solutions)

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
Elixir doesn't feature abstract classses, interfaces, or traits like traditional object-oriented languages. Instead, abstraciton can be implemented using _behaviours_. We will define 3 callbacks to help with our framework:
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
