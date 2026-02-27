# Machine Learning for Mechanics - Supervised Exercises (M2 MMSCT)

MATLAB implementations for **Université Gustave Eiffel** course *Machine Learning for Mechanics* (Instructor: Julien Yvonnet). Complete solution to **TD1, TD2, TP3** with report generation.

## 📋 Course Exercises

### **TD1: Neural Network Regression**
- **Q1**: 3D→1D cubic function approximation (4 architectures tested)
  - Best: **2L-5N** (MSE $2.3×10^{-5}$)
- **Q2**: Euclidean norm $||x||_2$ regression (MSE $3.8×10^{-8}$)

### **TD2: High-Dimensional Clustering**
- **Q1-Q2**: K-means + silhouette + PCA on 50D data
  - **Optimal K=4** (silhouette ~0.75, perfect separation)
- Pre-generated datasets: `DataTP2.dat`, `DataTP3.dat`

### **TP3: POD + Clustering** *(Latest)*
- **Q1**: K-means K=3 baseline
- **Q2**: K-means K=10 clustering
- **Q3**: POD eigenvalues per cluster (5%/10% error modes)
- **Q4**: POD projection visualization (Mode1-Mode2 plane)

### **TD3: Image Classification**
- Shape detection (circle/square/band) with patternnet
- **Best accuracy**: 80% (single-layer net)

## 🚀 Quick Start

1. **Clone & navigate**
```bash
git clone https://github.com/YOUR_USERNAME/ml-mechanics-m2.git
cd ml-mechanics-m2
