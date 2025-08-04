#import "@preview/ilm:1.4.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/thmbox:0.2.0": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes

#show: thmbox-init(counter-level: 2)
#set text(lang: "en")
#set figure(numbering: none)

#let definition-counter = counter("definition")
#show: sectioned-counter(definition-counter, level: 2)
#let definition = definition.with(counter: definition-counter)

#show: ilm.with(
  title: [Soft Computing],
  author: "Shubhra Goyal",
  abstract: [],
)

= Introduction to Soft Computing

Soft computing#footnote[Hard computing on the other hand uses precise, deterministic and logical algorithms to produce exact solutions. It works on binary logic and requires structured input] is an approach to computing that deals with imprecision, uncertainty, partial truth and approximate reasoning inspired by the way humans solve problems. It has high tolerance for imprecision and noise, ability to learn and adapt and is inspired by biological systems and nature. It is used to solve problems where hard rules can't be defined, it reduces computation costs by approximating results, enables real-time adaptive systems and deals well with non-linear and dynamic systems.

#table(
  columns: 3,
  align: center,
  table.header([*Feature*], [*Hard Computing*], [*Soft Computing*]),
  [*Logic*], [Binary], [Fuzzy],
  [*Input Data*], [Precise], [Inexact],
  [*Problem Type*], [Structured], [Complex],
  [*Tolerance to \ 
  Uncertainty*], [Low], [High],
  [*Adaptability*], [Rigid Algorithms], [Adaptive],
)

The main components of soft computing are:
#columns(2)[
  - Fuzzy Logic
  - Neural Networks
  - Genetic Algorithms
  #colbreak()
  - Rough Sets
  - Optimization Techniques
]

== Fuzzy Logic

#definition[Fuzzy Logic][
  It is a form of logic that deals with reasoning that is approximate rather than fixed and exact. Unlike traditional binary (or "crisp") logic where variables must be either 0 or 1 (false or true), fuzzy logic allows for values between 0 and 1, representing degrees of truth.
]
#definition[Membership Function][
  These are mathematical functions used in fuzzy logic to map input values to their degree of membership in a fuzzy set — that is, how strongly an element belongs to a fuzzy category.
]

A *Fuzzy Inference System (FIS)* is the core framework in fuzzy logic that uses fuzzy set theory to map inputs to outputs using fuzzy rules. The components of a FIS are:
#columns(3)[
  - Fuzzification 
  #colbreak() 
  - Rule Evaluation 
  #colbreak() 
  - Defuzzification
]

#diagram(
  node-defocus: 0,
  spacing: (1cm, 2cm),
  edge-stroke: 1pt,
  crossing-thickness: 5,
	mark-scale: 70%,
  node-fill: luma(97%),

  node((0, 0), "Crisp Input"),
  edge((0, 0), "r", "-|>"),
  node((1, 0), "Fuzzifier"),
  edge((1, 0), "r", "-|>"),
  node((2, 0), "Rule Base
  &
  Inference Engine"),
  edge((2, 0), "r", "-|>"),
  node((3, 0), "Defuzzifier"),
  edge((3, 0), "r", "-|>"),
  node((4, 0), "Crisp Output")
)

#definition[Fuzzification][
  It is the process of converting crisp input to fuzzy values.
]
#definition[Rule Evaluation][
  This is the set of `IF-THEN` rules that define the system.
]
#definition[Defuzzification][
  This is the process of converting fuzzy outputs to crisp values.
]
These fuzzy systems can be used in air conditioners to control the temperature using fuzzy inputs and a lot more.

== Rough Sets

#definition[Rough Sets][
  These are a mathematical for handling imprecise, uncertain, or incomplete information, especially useful in data analysis, machine learning, and knowledge discovery. These were introduced by Zdzisław Pawlak in the early 1980s. It helps us work with approximations of sets based on indiscernibility.
]
#definition[Universe][
  It is the set of all objects under consideration. It is denoted by $U$.
]
#definition[Indiscernibility Relation][
  Two objects are indiscernible if they have the same attribute values. Formally, this is an equivalence relation over the universe. It is denoted by $tilde$.
]
#definition[Target Set][
  The set we want to classify or analyze — but we may not know exactly which elements are in it due to indistinguishability. It is denoted by $X$ and $X subset.eq U$.
]
#definition[Lower Approximation][
  This contains the objects that definitely belong to $X$. It is denoted by $underline(R)(X)$.
]
#definition[Upper Approximation][
  This contains the objects that possibly belong to $X$. It is denoted by $overline(R)(X)$.
]
The rough set boundary region is $overline(R)(X) - underline(R)(X)$ which contains the objects we cannot classify with certainty. If the boundary is empty, then $X$ is a crisp set otherwise if the boundary is non-empty, then $X$ is a rough set.

#table(
  columns: 3,
  align: center,
  table.header([*Feature*], [*Rough Sets*], [*Fuzzy Sets*]),
  [*Uncertainty Type*], [Vagueness from _indiscernibility_], [Vagueness via _partial truth_],
  [*Membership*], [Only set boundaries], [Degree of membership $in [0, 1]$],
  [*Data Dependency*], [Based on _data relations_], [Based on _membership functions_],
)

Rough sets are used in data mining for feature selection and rule generation. #footnote[We also use optimization techniques like PSO, GA in soft computing but since I am not a bitch I won't write this here]

== Neural Networks

A neural network is a computational model inspired by the brain, capable of learning patterns from data.#footnote[Semester 4 ML notes discuss these] The basic unit of a NN is a perceptron (neuron). It can learn from supervised or unsupervised data, can model non-linear functions and adapt through training. Some common NNs are:
- *Feedforward Neural Network* has a simple architecture and has no loops. It is used for classification and regression
- *Convolution Neural Network* is specialized for image recognition
- *Recurrent Neural Network* handles sequential data and has a feedback loop. It is used in time series and speech recognition
The most popular concept in NNs is the backpropagation algorithm. The steps are:
- *Forward Pass* where the output is computed
- *Compute Error* which is the difference between the calculated and expected
- *Backward Pass* which propagates the error backwards
- *Update Weights*

NNs are used in healthcare, finance and much more#footnote[Literally every fucking shit now].

Due to all these great strategies, the best thing to do is to combine them, thus, giving rise to neuro-fuzzy systems and genetic-fuzzy systems.

Some emerging trends are:
- *Edge Computing + Soft Computing:* Real time intelligent systems
- *Explainable AI (XAI):* Making neural models interpretable
- *Federated Learning:* Privacy-preserving distributed learning
