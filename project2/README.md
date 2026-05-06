# Digital Image Processing – OCR using Fourier Descriptors

This repository contains my implementation for the second assignment of the Digital Image Processing course. The project focuses on Optical Character Recognition (OCR) using classical image processing techniques, contour extraction, Fourier descriptors, and character classification.

## Project Overview

The goal of the project is to automatically detect and recognize characters from rotated text images. The implemented pipeline includes:

- Rotation angle estimation using Fourier analysis
- Image deskewing
- Line and character segmentation
- Contour extraction
- Fourier Descriptor computation
- Character representation and comparison
- Basic OCR dataset generation

The implementation was developed in Python using OpenCV, NumPy, and SciPy.

---

## Implemented Components

### Rotation Angle Estimation

The function `findRotationAngle()` estimates the skew angle of a text image using:

- image blurring,
- 2D Discrete Fourier Transform (DFT),
- frequency spectrum analysis,
- serial search refinement based on brightness projections.

---

### Image Rotation

The function `rotateImage()` rotates and pads the image so the text can be aligned correctly before segmentation.

---

### Line Segmentation

The script `separate_lines.py` separates text lines using vertical projection histograms.

---

### Character Segmentation

The function `separate_characters()` separates characters using horizontal projections on binary text images.

---

### Contour Extraction

The function `getcontour()` extracts character contours using:

- Gaussian blur,
- adaptive thresholding,
- morphological dilation,
- thinning,
- contour detection.

The extracted contours are returned as coordinate arrays.

---

### Fourier Descriptors

The script `countour_descriptor.py` computes Fourier Descriptors from contour coordinates by:

- converting contour points into complex sequences,
- applying the Discrete Fourier Transform (DFT),
- using the magnitude spectrum as the descriptor.

Contour similarity is measured using Euclidean distance between descriptors.

---

### Dataset Creation

The script `create_dataset.py` generates datasets for OCR classification by:

- extracting contours,
- interpolating descriptors to fixed lengths,
- grouping characters according to contour count,
- comparing descriptors between samples.

---

### Main Pipeline

The `main.py` script demonstrates the complete workflow:

- text image rotation correction,
- contour extraction for sample characters,
- line separation,
- character segmentation,
- OCR preprocessing pipeline visualization.

---

## Technologies Used

- Python
- OpenCV
- NumPy
- SciPy
- scikit-learn

---

## Topics Covered

- Optical Character Recognition (OCR)
- Fourier Transform
- Fourier Descriptors
- Image Rotation Correction
- Contour Analysis
- Morphological Operations
- Character Segmentation
- Pattern Recognition

---

## Notes

This project is an experimental implementation of a contour-based OCR system and focuses mainly on the image preprocessing and descriptor extraction stages of the pipeline.
