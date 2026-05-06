# Digital Image Processing – RAW to RGB Conversion

This repository contains the implementation of the first assignment for the Digital Image Processing course. The project focuses on converting RAW `.DNG` images captured from Bayer-pattern RGB sensors into standard RGB images through a complete image processing pipeline.

## Project Overview

Modern digital cameras store sensor measurements in RAW format, where each pixel records only one color channel (R, G, or B) according to a Bayer filter arrangement.

The goal of this project is to reconstruct a full RGB image from RAW sensor measurements by implementing the core stages of the RAW image development pipeline.

The implemented pipeline includes:
- Reading and preprocessing RAW `.DNG` images
- White balance correction
- Bayer demosaicing and interpolation
- Camera-to-XYZ color space conversion
- XYZ-to-sRGB conversion
- Gamma correction

The implementation was developed entirely in MATLAB without relying on built-in interpolation utilities.

---

## Implemented Components

### RAW Image Reading

The function `readdng.m` reads a `.DNG` image and extracts:
- RAW sensor measurements
- White balance coefficients
- Camera color transformation matrix (`XYZ2Cam`)

The preprocessing stage also:
- Crops the useful sensor region
- Normalizes pixel intensities
- Maps black level values to `0`
- Maps white level values to `1`
- Clips out-of-range values

---

### RAW to RGB Conversion

The function `dng2rgb.m` converts the RAW Bayer image into RGB format.

Supported Bayer patterns:
- BGGR
- GBRG
- GRBG
- RGGB

Implemented interpolation methods:
- Nearest Neighbor
- Bilinear Interpolation

The function produces:
- Camera color space image
- XYZ image
- Linear RGB image
- Final sRGB image

The processing pipeline also applies:
- White balance correction
- Color space transformations
- Gamma correction

---

## Demonstration

The script `demo.m` demonstrates the complete RAW-to-RGB reconstruction pipeline by:
- Loading a RAW `.DNG` image
- Reconstructing the RGB image
- Visualizing intermediate and final outputs
- Generating histograms for each color channel

---

## Technologies Used

- MATLAB
- LibTIFF Interface for MATLAB
- RAW/DNG Image Processing

---

## Topics Covered

- RAW Image Processing
- Bayer Sensor Interpolation
- Demosaicing
- White Balance
- Color Science
- XYZ and sRGB Color Spaces
- Image Normalization
- Histogram Analysis

---

## Notes

This project focuses on implementing the fundamental stages of a digital camera RAW image processing pipeline and demonstrates the conversion of Bayer-pattern sensor data into visually correct RGB images.
