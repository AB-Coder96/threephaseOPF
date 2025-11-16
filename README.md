# Three-Phase OPF with Cross-Phase Inverter Operation

This repository contains the code and data accompanying the work on **three-phase optimal power flow (OPF)** for unbalanced distribution networks with **inverter-based distributed energy resources (DERs)**, especially **photovoltaic (PV) systems** and **electric vehicle charging stations (EVCSs)**.

The framework formulates a **convex (QP) three-phase OPF** in polar coordinates, explicitly models **cross-phase power flows** enabled by three-phase inverters, and incorporates a **data-driven polynomial approximation** of the Voltage Unbalance Factor (VUF). It is designed for both **radial** and **heavily meshed** distribution networks.

The repository includes all the elements needed to reproduce the test cases and numerical results presented in the associated paper.

---

## ✨ Key Features

- **Convex three-phase OPF**
  - Voltages modeled in **polar form** (magnitudes and angles).
  - Linearized three-phase power flow equations and line capacity constraints.
  - Single objective function combining **operational cost**, **losses**, and a **polynomial approximation of VUF**.

- **Explicit modeling of DERs**
  - Three-phase and single-phase **PVs**.
  - Three-phase and single-phase **EV charging stations**.
  - DERs participate actively in OPF to:
    - Limit harmful operating conditions.
    - Exploit full converter capability.
    - Improve voltage quality and reduce losses.

- **Cross-phase inverter operation**
  - Models the ability of three-phase inverters to **transfer power across phases**.
  - Uses unused phase capacity (active and reactive) to:
    - Reduce operating cost.
    - Improve system conditions.
    - Mitigate current and voltage imbalance.

- **Unbalanced distribution networks**
  - Fully three-phase unbalanced model including:
    - Self and mutual impedances.
    - Structural and random imbalance sources.
  - Applicable to:
    - IEEE 33-bus **radial** system.
    - 192-bus **heavily meshed** test system.

- **Reproducible experiments**
  - Multiple **scenarios** and **sub-methods**:
    - Different device mixes (various PV/EV configurations).
    - Different control/operation modes (with/without cross-phase capability).
  - Comparative results for:
    - Total cost.
    - Network losses.
    - VUF / power quality.

---

## 📁 Repository Structure

At a high level, the repository is organized as:

- `Libraries/`  
  Core routines and helper functions used across projects:
  - Data structures and parameter loading.
  - Power flow and OPF model assembly.
  - Linearization and convexification utilities.
  - VUF approximation and evaluation.

- `Projects/`  
  High-level entry points / project scripts to:
  - Build specific test systems (e.g., IEEE 33-bus, 192-bus).
  - Configure scenarios and sub-methods.
  - Call the OPF solver and post-process results (cost, losses, VUF).

- `Test Cases/`  
  Input data for the case studies:
  - Network topology and line parameters.
  - Load profiles and phases.
  - PV and EVCS locations, capacities, and operating constraints.
  - Scenario definitions for radial and meshed systems.

- `paper/`  
  Supporting material related to the paper:
  - Draft/LaTeX, figures, or additional derivations as needed.

- `Imbalance_paper.pdf`  
  PDF of the paper describing the full mathematical formulation, theoretical background, and numerical results.

- `README.md`  
  This file (project overview, usage, and citation information).

- `LICENSE`  
  License information (Apache-2.0).

- `*.bat`  
  Convenience scripts to initialize or push the project on Windows.

> If you add or rename core scripts (e.g., main OPF driver, plotting utilities), consider adding them explicitly in the sections below.

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/AB-Coder96/threephaseOPF.git
cd threephaseOPF
