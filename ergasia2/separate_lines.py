import cv2
import numpy as np



def separate_lines(image):
    _, binary_image = cv2.threshold(image, 127, 255, cv2.THRESH_BINARY_INV)

    # Compute vertical projection
    vertical_projection = np.sum(binary_image, axis=1) // 255
    line_indices = np.where(vertical_projection == 0)[0]
    line_images=[]

    prev_index = 0
    for index in line_indices:
        # Extract a line of text based on the indices
        line_image = image[prev_index:index, :]
        prev_index = index + 1

        # Check if the line contains letters (non-zero pixels)
        if np.count_nonzero(line_image) > 0:
            line_images.append(line_image)



    return line_images

