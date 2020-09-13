# mic11_hardware_image_decompressor
Hardware implementation of an image decompressor. The image compression specification we are using for this project is the .mic11.
It takes YUV data ans converts it into RGB data
The hardware implementation was done by taking a 320 x 240 pixel image and running it through the Altera DE2 board through the UART interface, from a personal computer and then storing it in the SRAM. The compressed data is read by the image decoding circuitry devised by us with the specifications in the project manual, and then store it back into the SRAM. From there, the VGA controller will read and display the image
