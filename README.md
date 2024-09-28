 I have designed a Caption Editor App using Flutter! This app allows users to effortlessly upload images from their gallery, add captions or sentences, and customize them with various text properties before saving the final image back to the gallery.

Key Features:
Image Upload: Users can select images directly from their gallery.
Text Customization: The app offers options to:
Adjust font size (increase or decrease in increments of 2)
Change text alignment (left, right, center)
Modify font style (bold or italic)
Select from seven primary text colors
Saving Option: Once editing is complete, users can save their customized image directly to their gallery with a simple click of a save icon.

User Experience:
Upon launching the app, users are greeted with an upload button that redirects them to their gallery for image selection. The selected image is displayed on the screen with various editing options. A floating action button opens a text box for caption entry, and upon clicking "Add Text," the caption appears on the image. Users can save their edited images with a simple click of a save icon, and long-pressing on the text allows for easy deletion.

Technical Details:
To enhance functionality, I utilized the following plugins:
image_picker: ^0.8.7+3 (for selecting images from the gallery)
screenshot: ^3.0.0 (for capturing the final edited image)
image_gallery_saver: ^2.0.3 (for saving images back to the gallery)
permission_handler: ^11.3.1 (to request gallery access permissions)
