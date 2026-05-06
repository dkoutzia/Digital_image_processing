import cv2
import numpy as np

def separate_characters(line_image):
    _, binary_image = cv2.threshold(line_image, 127, 255, cv2.THRESH_BINARY_INV)

    # Compute horizontal projection
    horizontal_projection = np.sum(binary_image, axis=0) // 255
    word_indices = np.where(horizontal_projection == 0)[0]
    word_images = []

    prev_index = 0
    for index in word_indices:
        # Extract a word based on the indices
        word_image = line_image[:, prev_index:index]
        prev_index = index + 1

        # Check if the word contains letters (non-zero pixels)
        if np.count_nonzero(word_image) > 0:
            word_images.append(word_image)

    return word_images
