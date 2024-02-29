#ifndef SRC_CLOCK_SPI_INTERFACE_
#define SRC_CLOCK_SPI_INTERFACE_

#include <linux/types.h>
#include <stdbool.h>

#define SPI_LMK "/dev/spidev2.0"
#define SPI_PLL_A "/dev/spidev1.0"
#define SPI_PLL_B "/dev/spidev1.1"
#define SPI_PLL_C "/dev/spidev1.2"

int lmk04208_config(char * spidev, __u32 lmk_freq);
int lmk04208_read(char * spidev, __u8 addr);
int lmk04208_write( char *spidev, __u32 *buf, __u32 size);
int lmk04208_status( char *spidev, bool verbose);
int lmx2594_config(char * spidev, __u32 lmx_freq);
int lmx2594_write( char *spidev, __u32 *buf, __u32 size);
int lmx2594_read(char * spidev, __u8 addr);
int lmx2594_status(char * spidev, bool verbose);
int clk_init(__u32 lmk_freq, __u32 lmx0_freq, __u32 lmx1_freq, __u32 lmx2_freq);

#endif /* SRC_CLOCK_SPI_INTERFACE_ */
