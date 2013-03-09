% Inferring Phylogenies Using Evolutionary Algorithms
% Erlend Hamberg
% 12 March, 2013

# About Me

- Graduated from NTNU with an M.Sc. in Computer Science in 2011
  (Specialization: Artificial Intelligence methods)
- Previously at ARM writing GPU drivers
- *Not* a biologist (but played on in grad school)

# This talk

> - Research done for my Master's thesis
> - A mix of genetics and artificial intelligence methods

## Outline

> - Phylogenetics
> - Evolutionary algorithms
> - Estimating likelihood of a hypothesis
> - Using an evolutionary algorithm for phylogenetic inference
> - Conclusion

# Phylogenetics

Phylogenetics is the study of evolutionary relationships among groups of
organisms (e.g.  species, populations).

\begin{center}
\includegraphics[height=0.5\textheight]{figures/darwinsdrawing.pdf}
\end{center}

# Phylogenetic Trees

- Phylogenies are commonly visualized as trees.

- Phylogenetic trees are used to trace the evolution on the level of taxa,
  species or individual genes.
- These trees represent hypotheses for the evolutionary history and can help us
  understand the history of mutations and aid in the understanding of biological
  processes

<!--  In biology this is usually among different species or between groups of related species, but phylogenetic analysis is also used in other areas such as natural language studies in which case the entities looked at will be human languages -->

# Phylogenetics Trees Example

If we have three species, there are three possible possible rooted, bifurcating
trees describing the evolutionary relationship among them:

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/tree_examples.pdf}
\end{center}

# Phylogenetic Inference

- Phylogenetic inference is the problem of reconstructing a phylogeny from a set
  of data -- usually molecular data such as DNA sequences.
- The problem of reconstructing the optimal phylogeny from a data set is an
  NP-complete problem. <!-- given some optimality criterion -->
- Exact techniques for inferring the most likely tree exist, but are
  computationally infeasible even for trees of 30--40 species due to the
  enormous number of possible trees.
- Heuristic search algorithms are therefore often applied to find an
  approximation to the most likely phylogenetic tree.

# Methods for Doing Phylogenetic Inference

There are numerous methods for constructing phylogenetic trees from molecular
data.

- **Parsimony methods** assume that base changes are unlikely events and tries
  to find the trees that minimize changes.
- **Distance methods** pre-process the data and make a distance matrix with
  pairwise distances between sequences and then only use these distances to come
  up with a tree.
- **Likelihood methods** try to make use of the full sequence data by
  formulating a probabilistic model of evolution and using statistical methods
  such as maximum likelihood estimation.

# Maximum Likelihood

- Tries to use all of the available sequence data.
- Constructs a probabilistic model of evolution and then uses the statistical
  maximum likelihood to assign a likelihood to a tree.
- Requires more computation than parsimony and distance methods, but have
  several desirable properties.
- ML maximization will converge to the correct parameter values and the smallest
  possible variance around these values as the amount of data grows.

# Model of Evolution

In order to use a maximum likelihood approach, we need a model of DNA evolution:

> - A statistical description of the process of substitution in nucleotide
> sequences.
> - Tells us the expected frequency of the different bases at equilibrium and the
> probability of a specific base change over a branch of length t: $$P\left(j\mid
> i,t\right)$$
> - "The probability of seeing base $j$ at the end of a branch of length $t$ given
> that the start of the branch has base $i$."

# Branch Lengths

- Instead of measuring branch lengths in (millions of) years, they are defined
  to be the expected nucleotide substitutions per site.

- This means that if we have a branch of length 0.5 between an ancestor and a
  descendant, we expect --on average -- half the sites to have undergone
  changes.

# Branch Lengths Example

\begin{center}
\includegraphics[height=0.60\textheight]{figures/four-site_tree_with_branch_lenghts.pdf}
\end{center}

<!-- This is an idealized example -->

# Alignment

\begin{center}
\includegraphics[height=0.35\textheight]{figures/insertion.pdf}
\end{center}

## Aligned Sequences

           CTATCGC---TCATTGATCCAAAAATTT--GATCAAC
           ACATCAC---TTATTGATCCAATAATTTTTGATCAAC
           CTACCACATTTAATTGATCCAATGACTT--GACCAAC
           CTACCACATTTAATTGATCCAATGACTT--GACCAAC

# Calculating the Likelihood of a Tree

...

# Evolutionary Algorithms

- Evolutionary algorithms (EAs) is a class of heuristic search algorithms
  inspired by biological evolution.
- Candidate solutions are artificially "evolved" and features from the best
  solutions have higher probability of "surviving" from one generation to the
  next.
- Lend themselves easily to parallel computing.

# EA Cycle

\begin{center}
\includegraphics[height=0.7\textheight]{figures/ea_overview.pdf}
\end{center}

# Using EAs to search for candidate trees

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/systems_overview.pdf}
\end{center}
