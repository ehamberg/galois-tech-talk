% Inferring Phylogenies Using Evolutionary Algorithms
% Erlend Hamberg
% 12 March, 2013

# About Me

> - Graduated from NTNU with an M.Sc. in Computer Science in 2011
>   (Specialization: Artificial Intelligence methods)
> - Previously at ARM writing GPU drivers
> - *Not* a biologist (but played on in grad school)

# This talk

- Research done for my Master's thesis
- A mix of genetics and artificial intelligence methods

## Outline

- Phylogenetics
- Evolutionary algorithms
- Estimating likelihood of a hypothesis
- Using an evolutionary algorithm for phylogenetic inference
- Conclusion

# Phylogenetics

Phylogenetics is the study of evolutionary relationships among groups of
organisms (e.g.  species, populations).

\begin{center}
\includegraphics[height=0.5\textheight]{figures/darwinsdrawing.pdf}
\end{center}

# Phylogenetic Trees

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/tree_examples.pdf}
\end{center}

# Alignment

\begin{center}
\includegraphics[height=0.35\textheight]{figures/insertion.pdf}
\end{center}

## Aligned Sequences

           CTATCGC---TCATTGATCCAAAAATTT--GATCAAC
           ACATCAC---TTATTGATCCAATAATTTTTGATCAAC
           CTACCACATTTAATTGATCCAATGACTT--GACCAAC
           CTACCACATTTAATTGATCCAATGACTT--GACCAAC

# Using EAs to search for candidate trees

\begin{center}
\includegraphics[width=0.9\textwidth]{figures/systems_overview.pdf}
\end{center}
