# robust-ssd-metric

Code for the robust sample specific distance described in Learning Robust Multi-label Sample Specific Distances for Identifying HIV-1 Drug Resistance.

The main MATLAB file is `LearnMultiLabel.m`

## Abstract

Acquired immunodeficiency syndrome (AIDS) is a syndrome caused by the human
immunodeficiency virus (HIV). During the progression of AIDS, a patient’s the
immune system is weakened, which increases the patient’s susceptibility to
infections and diseases. Although antiretroviral drugs can effectively suppress
HIV, the virus mutates very quickly and can become resistant to treatment. In
addition, the virus can also become resistant to other treatments not currently
being used through mutations, which is known in the clinical research community
as cross-resistance. Since a single HIV strain can be resistant to multiple
drugs, this problem is naturally represented as a multi-label classifica- tion
problem. Given this multi-class relationship, traditional single-label
classification methods usually fail to effectively identify the drug
resistances that may develop after a particular virus mutation. In this paper,
we propose a novel multi-label Robust Sample Specific Distance (RSSD) method to
identify multi-class HIV drug resistance. Our method is novel in that it can
illustrate the relative strength of the drug resistance of a reverse
transcriptase sequence against a given drug nucleoside analogue and learn the
distance metrics for all the drug resistances. To learn the proposed RSSDs, we
formulate a learning objective that maximizes the ratio of the summations of a
number of L1-norm distances, which is difficult to solve in general. To solve
this optimization problem, we derive an efficient, non-greedy, iterative
algorithm with rigorously proved convergence. Our new method has been verified
on a public HIV-1 drug resistance data set with over 600 RT sequences and five
nucleoside analogues.  We compared our method against other state-of-the-art
multi-label classification methods and the experimental results have
demonstrated the effectiveness of our proposed method.

## Bibtex

```
@inproceedings{brand2019learning,
  title={Learning Robust Multi-label Sample Specific Distances for Identifying HIV-1 Drug Resistance},
  author={Brand, Lodewijk and Yang, Xue and Liu, Kai and Elbeleidy, Saad and Wang, Hua and Zhang, Hao},
  booktitle={International Conference on Research in Computational Molecular Biology},
  pages={51--67},
  year={2019},
  organization={Springer}
}
```
