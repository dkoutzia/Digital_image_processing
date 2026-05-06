from find_Rotation_Angle import findRotationAngle
import cv2
import numpy as np

def rotateImage(image, angle):
    if isinstance(image, str):
        # Image path provided, read the image
        image = cv2.imread(image)

    if image is None:
        print("Failed to read the image.")
        return

        # Check the shape of the image array
    if len(image.shape) == 2:
        print("Grayscale image")
    elif len(image.shape) == 3:
        print("RGB image")
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    else:
        print("Unknown image type")

    new_image = cv2.resize(image, (1000, 900))


    # Rotate the image by the specified angle
    rows, cols = new_image.shape[:2]
    M = cv2.getRotationMatrix2D((cols / 2, rows / 2), angle, 1)
    rotated = cv2.warpAffine(new_image, M, (cols, rows))

    # Find the maximum dimensions after rotation
    cos = np.abs(M[0, 0])
    sin = np.abs(M[0, 1])
    new_width = int(rows * sin + cols * cos)
    new_height = int(rows * cos + cols * sin)

    # Calculate the translation matrix for padding
    M[0, 2] += (new_width - cols) / 2
    M[1, 2] += (new_height - rows) / 2

    # Apply padding to the rotated image
    padded = cv2.warpAffine(rotated, M, (new_width, new_height), borderValue=255)

    return padded
