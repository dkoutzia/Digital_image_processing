# Digital Image Processing – Image Registration and Feature Matching

This repository contains my implementation for the third assignment of the Digital Image Processing course. The project focuses on image registration, feature detection, local descriptors, and image matching using classical computer vision techniques.

## Project Overview

The goal of the project is to detect and match feature points between different images in order to estimate image transformations and perform image alignment (image registration).

The implemented components include:

- Rotation invariant local descriptors
- Harris Corner Detection
- Image rotation
- Feature matching preparation
- Basic image registration utilities

The implementation was developed in MATLAB.

---

## Implemented Components

### Local Descriptor

The function `myLocalDescriptor.m` implements a custom local descriptor for grayscale images.

The descriptor:
- samples concentric circles around a point,
- interpolates image intensities,
- computes rotation-invariant feature representations.

The descriptor is designed to capture local image structure around feature points.

---

### Upgraded Local Descriptor

The function `myLocalDescriptorUpgrade.m` contains an improved version of the local descriptor with richer feature information while maintaining rotation invariance.

---

### Harris Corner Detection

The function `isCorner.m` implements the Harris Corner Detector response calculation in order to identify corner points in grayscale images.

The implementation is based on:
- image gradients,
- structure tensor computation,
- Harris response metric.

---

### Image Rotation

The script `myImgRotation.m` performs image rotation operations used during testing and descriptor validation.

---

### Main Pipeline

The script `main.m` demonstrates the workflow of:
- feature extraction,
- descriptor computation,
- corner analysis,
- image transformation experiments.

---

## Topics Covered

- Image Registration
- Harris Corner Detection
- Local Feature Descriptors
- Rotation Invariant Features
- Feature Matching
- Computer Vision
- Image Transformations

---

## Technologies Used

- MATLAB
- Image Processing Toolbox

---

## Notes

This project focuses mainly on the implementation of custom feature descriptors and corner detection techniques for image registration applications.
