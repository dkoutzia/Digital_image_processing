import cv2
import numpy as np


def getcontour(image):
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

    # Apply Gaussian blur to remove noise
    blur = cv2.GaussianBlur(image, (35, 35), 0)

    # Convert input image to binary
    thresh = cv2.adaptiveThreshold(blur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY_INV, 11, 2)

    # Dilate image to thicken the edges
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
    dilated = cv2.dilate(thresh, kernel, iterations=1)

    # Thin the edges using morphological thinning algorithm
    thinned = cv2.ximgproc.thinning(dilated)

    # Find contours in the thinned image
    contours, hierarchy = cv2.findContours(thinned, cv2.RETR_TREE, cv2.CHAIN_APPROX_NONE)

    # Create a copy of the original image
    img_copy = image.copy()
    

    # Draw the contours on the copy of the image
    cv2.drawContours(img_copy, contours, -1, (255, 255, 255), 2,lineType=cv2.LINE_AA)

    # Display the image with contours
    cv2.imshow('Image with Contours', cv2.resize(img_copy,(300,300)))
    cv2.waitKey(0)


    # Convert contours to cell array
    contour_array = []
    for contour in contours:
        contour_points = []
        for point in contour:
            contour_points.append([point[0][1], point[0][0]])
        contour_array.append(np.array(contour_points))

    return contour_array

