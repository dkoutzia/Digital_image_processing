import numpy as np
from scipy.spatial import distance
from countour_descriptor import contour_descriptor,compute_distance
from get_contour import getcontour
def createdataset(character_images,ascii_code):
    dataset = []
    labels = []
    contour_length=[]
    N1,N2,N3=100,200,300
    for character_image in character_images:

        # Preprocess the character image (e.g., resize, normalize, etc.)
        normalized_image = character_image / 255.0

        # Add the preprocessed image to the dataset
        dataset.append(normalized_image)
        contour = getcontour(np.array(character_image))
        contour_length.append(len(contour))
        descriptor = contour_descriptor(contour)
        if len(contour) == 1:
            int_desc= interpolate_descriptor(descriptor, N1)
        elif len(contour) == 2:
            int_desc=  interpolate_descriptor(descriptor, N2)
        else:
            int_desc=interpolate_descriptor(descriptor, N3)

        # Compare the contour of the character image with ASCII codes and find the closest match
        min_distance = float('inf')  # Initialize minimum distance to a large value
        closest_label = None

        for ascii_code in range(len(ascii_code)):
            ascii_contour = getcontour(ascii_code)
            descriptor_ascii = contour_descriptor(ascii_contour)
            # Calculate the distance between the contours
            if len(ascii_contour) == 1:
               int_desc_ascii= interpolate_descriptor(descriptor_ascii, N1)
            elif len(ascii_contour) == 2:
                int_desc_ascii= interpolate_descriptor(descriptor_ascii, N2)
            else:
                int_desc_ascii= interpolate_descriptor(descriptor_ascii, N3)

            if len(contour)==len(ascii_contour):
              dist=compute_distance(int_desc,int_desc_ascii)
            else:
                dist=float('inf')

            # Check if the current distance is smaller than the minimum distance
            if dist < min_distance:
                min_distance = dist
                closest_label = chr(ascii_code)  # Convert ASCII code to character

        # Add the closest label to the labels list
        labels.append(closest_label)

    # Convert the dataset and labels to NumPy arrays for further processing
    dataset = np.array(dataset)
    labels = np.array(labels)

    return dataset, labels,contour_length







from scipy.interpolate import interp1d

def interpolate_descriptor(sequence, desired_length):
    real_part = sequence.real
    imag_part = sequence.imag

    # Create interpolation functions for real and imaginary parts
    f_real = interp1d(range(len(real_part)), real_part, kind='linear')
    f_imag = interp1d(range(len(imag_part)), imag_part, kind='linear')

    # Interpolate the real and imaginary parts separately
    interpolated_real = f_real(np.linspace(0, len(real_part) - 1, desired_length))
    interpolated_imag = f_imag(np.linspace(0, len(imag_part) - 1, desired_length))

    # Combine the interpolated real and imaginary parts into a complex sequence
    interpolated_sequence = interpolated_real + 1j * interpolated_imag

    return interpolated_sequence


def map_contours(contour_type, character_class):
    if character_class == 2:
        # Map contours for class 2 characters
        if contour_type == "inside":
            mapped_contour = "outside"
        elif contour_type == "outside":
            mapped_contour = "inside"
        else:
            mapped_contour = contour_type

    elif character_class == 3:
        # Map contours for class 3 characters
        if contour_type == "outside":
            mapped_contour = "inside_up"
        elif contour_type == "inside_up":
            mapped_contour = "inside_down"
        elif contour_type == "inside_down":
            mapped_contour = "outside"
        else:
            mapped_contour = contour_type

    else:
        # For other character classes, no mapping is required
        mapped_contour = contour_type

    return mapped_contour