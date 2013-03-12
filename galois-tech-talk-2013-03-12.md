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

> - Phylogenetics and phylogenetic inference
> - Estimating likelihood of a hypothesis
> - Evolutionary algorithms
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

<!--  In biology this is usually among different species or between groups of
related species, but phylogenetic analysis is also used in other areas such as
natural language studies in which case the entities looked at will be human
languages -->

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

# A Short Note on Alignment

Sequences are *aligned* before being used for phylogenetic inference.

\begin{center}
\includegraphics[height=0.25\textheight]{figures/insertion.pdf}
\end{center}

## Aligned Sequences

           CTATCGC---TCATTGATCCAAAAATTT--GATCAAC
           ACATCAC---TTATTGATCCAATAATTTTTGATCAAC
           CTACCACATTTAATTGATCCAATGACTT--GACCAAC

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

# Maximum Likelihood Method

- Tries to use all of the available sequence data.
- Constructs a probabilistic model of evolution and then uses maximum
  likelihood to assign a likelihood to a tree.
- Requires more computation than parsimony and distance methods, but have
  several desirable properties.
- ML maximization will converge to the correct parameter values and the
  smallest possible variance around these values as the amount of data grows.

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

# Calculating the Likelihood of a Tree -- Example

In this simple example tree we only look at one site. We have observed the
states *A*, *C*, *C*, and *G* for our operational taxonomical units. The
hypothetical states of the hypothetical taxonomical unites are *x*, *y*, and
*z*.

\begin{center}
\includegraphics[height=0.50\textheight]{figures/tree_for_calculation_example.pdf}
\end{center}

# Calculating the Likelihood of a Tree

When calculating the likelihood of a whole phylogenetic tree we have to
make some assumptions to make the calculation feasible.

## Assumption one

> Evolution in different sites is independent.

This assumption lets us decompose the likelihood of a tree given the data,
$P\left(D\mid\mathbb{T}\right)$, into a product of $n$ terms -- one for each
site:$$L=P\left(D\mid\mathbb{T}\right)=\prod_{i=1}^{n}P\left(D_{i}\mid\mathbb{T}\right)$$

where $D_{i}$ is the data at site $i$.

# Calculating the Likelihood of a Tree

The likelihood of a tree with observations of one state is then the sum of the
probabilities of all possible combinations of states which might have
existed at the m interior nodes $n_{1}\ldots n_{m}$:


\begin{eqnarray*}
P\left(D_{i}\mid\mathbb{T}\right) & = & \sum_{n_{1}}\sum_{n_{2}}\ldots\sum_{n_{m}}P\left(s_{1},s_{2},\ldots,s_{n},n_{1},n_{2},\ldots n_{m}\mid\mathbb{T}\right)\\
 & = & \phantom{+}P\left(A,C,C,G,\; A,A,A\mid\mathbb{T}\right)\nonumber \\
 &  & +P\left(A,C,C,G,\; A,A,C\mid\mathbb{T}\right)\nonumber \\
 &  & +\ldots\nonumber \\
 &  & +P\left(A,C,C,G,\; T,T,T\mid\mathbb{T}\right)\nonumber
\end{eqnarray*}

where $s_{1},s_{2},\ldots,s_{n}$ are the leaf nodes' states at that one ($A$,
$C$, $C$, $G$ in our case). Each summation runs over the four possible states
$A$, $C$, $G$, and $T$.

# Calculating the Likelihood of a Tree

\begin{center}
\includegraphics[height=0.50\textheight]{figures/tree_for_calculation_example.pdf}
\end{center}

# Calculating the Likelihood of a Tree

## Assumption two

> Evolution in different lineages is independent.

The second assumption allows us to decompose the probability on the right
side of the previous expression into a product of terms:

\begin{eqnarray*}
P\left(A,C,C,G,x,y,z\mid\mathbb{T}\right) & = & \phantom{\times}P\left(x\right)\times P\left(y\mid x,t_{5}\right)\nonumber \\
 &  & \times P\left(A\mid y,t_{1}\right)\times P\left(C\mid y,t_{2}\right)\nonumber \\
 &  & \times P\left(z\mid x,t_{6}\right)\times P\left(C\mid z,t_{3}\right)\nonumber \\
 &  & \times P\left(G\mid z,t_{4}\right)
\end{eqnarray*}

<!-- The probabilities above are given by the transition probability of our model of evolution. -->

# Calculating the Likelihood of a Tree

\begin{center}
\includegraphics[height=0.50\textheight]{figures/tree_for_calculation_example.pdf}
\end{center}

# Calculating the Likelihood of a Tree

It is still too inefficient to use this directly because the number of terms we
need to sum rises exponentially with the number of species.

<!--For a tree with n species, there are n-1 interior nodes each of which has one of four states, meaning that we need to sum 4^{n-1} terms. -->

A pruning method can be used to make the computation feasible: By moving the
summation signs as far to the right as possible we get

\begin{align*}
P\left(D_{i}\mid\mathbb{T}\right)= & \phantom{\times}\sum_{x}P\left(x\right)\\
 & \times\left(\sum_{y}P\left(y\mid x,t_{5}\right)P\left(A\mid y,t_{1}\right)P\left(C\mid y,t_{2}\right)\right)\\
 & \times\left(\sum_{z}P\left(z\mid x,t_{0}\right)P\left(C\mid z,t_{3}\right)P\left(G\mid z,t_{4}\right)\right)\text{.}
\end{align*}

# Calculating the Likelihood of a Tree

\begin{align*}
P\left(D_{i}\mid\mathbb{T}\right)= & \phantom{\times}\sum_{x}P\left(x\right)\\
 & \times\left(\sum_{y}P\left(y\mid x,t_{5}\right)P\left(A\mid y,t_{1}\right)P\left(C\mid y,t_{2}\right)\right)\\
 & \times\left(\sum_{z}P\left(z\mid x,t_{0}\right)P\left(C\mid z,t_{3}\right)P\left(G\mid z,t_{4}\right)\right)\text{.}
\end{align*}

To compute this we work our way up the tree by calculating the conditional
likelihoods of subtrees: the probability of what is observed at a node $k$ and
down given that $k$ has the state $s$ -- denoted
$L_{k}^{\left(i\right)}\left(s\right)$. This computation is done for each site
$i$.

# Calculating the Likelihood of a Tree

We can use an algorithm that "pushes" information up the tree to compute this.
We make use of the subtree likelihoods $L_{k}^{\left(i\right)}\left(s\right)$.
The term $P\left(C\mid z,t_{3}\right)P\left(G|z,t_{4}\right)$ is such a quantity
for the left subtree  of the example tree.:

\begin{center}
\includegraphics[height=0.25\textheight]{figures/right_subtree_for_calculation_example.pdf}
\end{center}

This can be read as "the probability of everything seen at and below a node with
state $z$". There will be four such quantities -- one for each possible value
$z$ can take ($A$ , $C$ , $G$ or $T$).


# Calculating the Likelihood of a Tree

Once these four values have been computed they need not be computed again if we
find the same states in the nodes below z for a different site. This dynamic
programming approach greatly reduces the number of calculations that needs to be
done.

The algorithm is recursive and computes $L_{k}^{\left(i\right)}\left(s\right)$
at each node from the same values from the nodes immediately below it:

$$L_{k}^{\left(i\right)}\left(s\right)=\left(\sum_{x}P\left(x\mid s,t_{\ell}\right)L_{\ell}^{(i)}\left(x\right)\right)\left(\sum_{y}P\left(y\mid s,t_{m}\right)L_{m}^{\left(i\right)}\left(y\right)\right)$$

where $\ell$ and $m$ are the two nodes directly below $k$.

<!-- This can be read as "the probability of everything at or below a node --
given that this node k has state s -- is the product of the probability of the
events of both the descendant lineages".
-->

# Calculating the Likelihood of a Tree

At the leaf nodes we have an observation $v$ of the actual state (A, C, G, or T
in the sequence data), so we get

$$L_{\text{leaf}}^{\left(i\right)}\left(s\right)=\begin{cases} 1 & \text{ if
}s=v\\ 0 & \text{otherwise} \end{cases}\text{.}$$

These values will act as the base cases of the recursive algorithm.

# Calculating the Likelihood of a Tree

The end result of the algorithm for a site $i$ is the average of
$\pi_{s}L_{root}^{\left(i\right)}\left(s\right)$ -- the values at the topmost
node in the tree weighted by their prior probabilities:

$$L^{\left(i\right)}=\sum_{s}\left(\pi_{s}L_{root}^{\left(i\right)}\left(s\right)\right)$$

The probability of the entire tree is then the product of the probabilities for
each site:

$$P(tree)=\prod_{i}L^{\left(i\right)}$$

In practice, the likelihoods will be very low, so  is usually implemented as
summation of logarithms instead of multiplying the likelihoods directly.

# Calculating the Likelihood of a Tree

    function L(node):
        if node.likelihoods:
            # we already have likelihoods for the node
            return node.likelihoods
    
        for s in ['A', 'C', 'G', 'T']:
            xs = ys = 0.0
            for x in ['A', 'C', 'G', 'T']:
                xs += P(s, x, t)*L(node.l_child)[x]
                ys += P(s, x, t)*L(node.r_child)[x]
    
            node.likelihoods[s] = xs*ys
    
        return node.likelihoods

# Where Are We?

We can calculate the likelihood of a hypothesis tree given

> - Molecular data
> - A probabilistic model of evolution

So, how do we come up with good hypotheses?

# Evolutionary Algorithms

- Evolutionary algorithms (EAs) is a class of heuristic search algorithms
  inspired by biological evolution.
- Candidate solutions are artificially "evolved" and features from the best
  solutions have higher probability of "surviving" from one generation to the
  next.
- Lend themselves easily to parallel computing.

<!-- An example of an evolved solution to a technology problem is the X-band
antenna evolved for a 2006 NASA mission called Space Technology 5 (ST5) -->

# EA Cycle

\begin{center}
\includegraphics[height=0.7\textheight]{figures/ea_overview.pdf}
\end{center}

# Using EAs to search for candidate trees

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/systems_overview.pdf}
\end{center}

# EA Operators for Phylogenetic Trees

- The field of genetic programming (GP) has produced mutation and recombination
  operators suitable for evolving trees.
- Trees in GP usually represent computer programs and not all of the operators
  suitable for these trees work for phylogenetic trees due to the strict
  restrictions on their form.

# Mutation

> - *SWAP*: two random leaf nodes swap positions
> - *Nearest Neighbour Interchange*: switch two branches that share a neighbour branch
> - *SCRAMBLE*: a random subtree is chosen and its topology is rearranged at random

# Prune-Delete-Graft

- PDG works by selecting a random node from one of the parent trees.
- This node is the root of a subtree and the leaf nodes that appear in this
  subtree is then pruned from the other parent.
- Last, a random branch in the pruned tree is selected and the subtree we
  randomly selected from the other parent is attached.

<!-- This method is quite simple and will always produce a valid tree. -->

# PDG Example

\begin{center}
\includegraphics[height=0.75\textheight]{figures/prune_graft_delete_example.pdf}
\end{center}

# PDG Example -- Lost Branch Lengths

\begin{center}
\includegraphics[height=0.75\textheight]{figures/prune_graft_delete_lost_branch_lengths.pdf}
\end{center}

# Results

The following results are from a data set consists of the mitochondrial genomes
of 20 mammals. After alignment and the removal of gap sites, the DNA sequences
were 14659 base pairs.

<!--
The runs were quite consistent and produce trees with similar fitness
($\sigma_{\text{avg. fitness}}=1560.14$, $\sigma_{\text{max fitness}}=1498.39)$.
-->

# Results

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/mamm20_max_fitness_plot.pdf}
\end{center}

# Results

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/max_avg_min_fitness_plot.pdf}
\end{center}

# Results

\begin{center}
\includegraphics[height=0.8\textheight]{figures/mamm20_best_tree.pdf}
\end{center}

# Sources of Error

Inferring a phylogeny from sequence data is a probabilistic process and there
are many sources of errors. The most important are:

- That evolution in different sites is independent, as assumed by the maximum
  likelihood method is quite unrealistic. It is know that the substitution
  processes at different sites in a sequence often are not independent].
- There can be errors in the DNA sequence data used. Misidentification during
  sequencing happens -- currently with a probability of the order of $10^{-2}$
  per base.
- The alignment process is a probabilistic process and the most probable
  alignment need not reflect the true mutations that has happened.
- The models of evolution used in the maximum likelihood approach are
  probabilistic models and will never be completely accurate.

# Fin

\begin{center}
\includegraphics[height=0.6\textheight]{figures/interrobang.pdf}
\end{center}

# References

> - Cotta, Carlos, and Pablo Moscato. "Inferring phylogenetic trees using
>   evolutionary algorithms." *Parallel Problem Solving from Nature—PPSN VII*
>   (2002): 720-729.
> - Felsenstein, J. "Inferring phylogenies. 2004." *Sinauer*, Sunderland, MA.
> - Felsenstein, Joseph. "Evolutionary trees from DNA sequences: a maximum
>   likelihood approach." *Journal of molecular evolution* 17.6 (1981): 368-376.
> - Floreano, Dario, and Claudio Mattiussi. *Bio-inspired artificial intelligence:
>   theories, methods, and technologies.* The MIT Press, 2008.
