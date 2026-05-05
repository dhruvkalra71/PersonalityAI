# PersonalityAI

An AI-powered personality prediction built entirely in **Prolog** using rule-based inference, probabilistic reasoning, and greedy search.

---

# 🚀 Overview

This project implements an **adaptive personality test system** based on the **MBTI (Myers-Briggs Type Indicator)** model.

Instead of asking fixed questions, the system dynamically selects the **most informative next question** using AI search techniques.

---

# ✨ Key Features

* **Hybrid AI Model**

  * Score-based reasoning (deterministic)
  * Probability-based reasoning (uncertainty handling)

* **Greedy Best First Search**

  * Selects questions using **information gain approximation**
  * Mimics Akinator-style questioning

* **Confidence-Based Stopping**

  * Stops early when confidence ≥ 75%

* **Question Pruning**

  * Skips irrelevant questions once a trait is determined

* **Tie-Breaking System**

  * Asks additional adaptive questions when needed

* **Explainable AI Output**

  * Personality type
  * Description
  * Strengths & weaknesses
  * Top probability matches

---

# 🏗️ Project Structure

```
personalityAI/
│
├── main.pl
├── questions.pl
├── traits.pl
├── personality.pl
├── inference.pl
├── greedy.pl
```

---

# ⚙️ How It Works

## 1. Initialization

* All personality types assigned equal probability
* Trait scores initialized to zero

## 2. Adaptive Question Selection

* Uses **Greedy Best First Search**
* Selects question that maximizes **information gain**

## 3. User Input

Each question has 5 options:

1. Strongly Agree
2. Agree
3. Neutral
4. Disagree
5. Strongly Disagree

## 4. Inference Engine

* Updates:

  * Trait scores (E/I, S/N, T/F, J/P)
  * Probability distribution over 16 types

## 5. Pruning

* Stops asking questions for already determined traits

## 6. Stopping Condition

* Stops when:

  * Confidence ≥ 75%
  * OR no questions remain

## 7. Output

* Top personality matches
* Final MBTI type
* Description
* Strengths & Weaknesses

---

# ▶️ How to Run (GNU Prolog)

### Step 1: Open GNU Prolog

### Step 2: Load all files manually

```
| ?- consult('traits.pl').
| ?- consult('questions.pl').
| ?- consult('personality.pl').
| ?- consult('inference.pl').
| ?- consult('greedy.pl').
| ?- consult('main.pl').
```

### Step 3: Start the system

```
| ?- start.
```

---

# 🧠 AI Concepts Used

* Expert Systems (rule-based reasoning)
* Probabilistic Inference
* Greedy Best First Search
* Information Gain Approximation
* Decision Trees (implicit)
* Explainable AI (XAI)

---
