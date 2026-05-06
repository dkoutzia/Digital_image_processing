import cv2
import numpy as np

def findRotationAngle(x):
    # Load image
    img = cv2.imread(x)

    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    # Blur the image
    blurred = cv2.blur(gray, (15, 15), cv2.BORDER_DEFAULT)

    dft = cv2.dft(np.float32(blurred), flags=cv2.DFT_COMPLEX_OUTPUT)

    # shift zero-frequency component to the center of the spectrum
    dft_shift = np.fft.fftshift(dft)
    magnitude_spectrum = 20 * np.log(cv2.magnitude(dft_shift[:, :, 0],dft_shift[:, :, 1]))
    # normalize values between 0-255
    magnitude_spectrum = cv2.normalize(magnitude_spectrum, None, 0, 255, cv2.NORM_MINMAX, dtype=cv2.CV_8U)
    # delete the dc component
    M, N = magnitude_spectrum.shape
    cx = M // 2
    cy = N // 2
    magnitude_spectrum[cx, cy] = 0
    cv2.imshow('magnitude', cv2.resize(magnitude_spectrum, (1000, 1000)))
    cv2.waitKey()
    cv2.destroyAllWindows()

    # Find the frequency coordinates of maximum magnitude
    max_freq = np.argmax(magnitude_spectrum)
    max_coords = np.unravel_index(max_freq, magnitude_spectrum.shape)

    # Convert coordinates to frequency values
    freq_x = max_coords[0] - int(magnitude_spectrum.shape[0] / 2)
    freq_y = max_coords[1] - int(magnitude_spectrum.shape[1] / 2)


    # Calculate the angle of rotation using arctan2
    angle = -np.arctan(freq_y/freq_x) * 180 / np.pi
    print(angle)

    # Serial search for the exact rotation angle
    best_angle = angle
    max_brightness = -np.inf
    for i in np.arange(angle - 3, angle + 3, 0.05):
        # Rotate the image
        rotated = cv2.warpAffine(gray, cv2.getRotationMatrix2D((gray.shape[1] // 2, gray.shape[0] // 2), i, 1), (gray.shape[1], gray.shape[0]))

        # Calculate brightness projection on the vertical axis
        projection = np.sum(rotated, axis=1)
        brightness_changes = np.max(projection) - np.min(projection)

        # Choose angle with the highest brightness variation
        if brightness_changes > max_brightness:
            best_angle = i
            max_brightness = brightness_changes
    print(best_angle)
    return best_angle



