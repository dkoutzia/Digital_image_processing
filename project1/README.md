**Digital Image Processing – RAW to RGB Conversion**

This repository contains the implementation of the first assignment for the course Digital Image Processing at Aristotle University of Thessaloniki. The project focuses on converting RAW .DNG images captured from Bayer-pattern RGB sensors into standard RGB images through a complete image processing pipeline.

**Project Overview**
Modern digital cameras store sensor measurements in RAW format, where each pixel records only one color channel (R, G, or B) according to a Bayer filter arrangement. The goal of this project is to reconstruct a full RGB image from these RAW sensor measurements by implementing the core stages of the RAW development pipeline:

Reading and preprocessing .DNG RAW files
White balance correction
Bayer demosaicing / interpolation
Camera-to-XYZ color space conversion
XYZ-to-sRGB conversion and gamma correction

The implementation is written entirely in MATLAB without relying on built-in interpolation utilities.


**Implemented Functions**

readdng.m

Reads a .DNG image and extracts:

RAW sensor measurements
White balance coefficients
Camera color transformation matrix (XYZ2Cam)

The function also:

crops the useful sensor region,
normalizes pixel intensities,
maps black level → 0,
maps white level → 1,
clips out-of-range values.

dng2rgb.m

Converts the RAW Bayer image into RGB.

Supported features:

Bayer patterns:
BGGR
GBRG
GRBG
RGGB
Interpolation methods:
nearest neighbor
bilinear interpolation

The function produces:

Camera color space image
XYZ image
Linear RGB image
Final sRGB image

It also applies:

white balance correction,
color space transformations,
gamma correction.

**Demo**

The script demo.m demonstrates the full pipeline using the provided RAW image:

loads the .DNG,
reconstructs the RGB image,
visualizes outputs,
generates histograms for each color channel.

**Topics Covered**
RAW image processing
Bayer sensor interpolation
Demosaicing
White balance
Color science
XYZ and sRGB color spaces
Image normalization
Histogram analysis

**Technologies**
MATLAB
LibTIFF interface for MATLAB
RAW/DNG image processing
