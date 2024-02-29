#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdbool.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#include <sys/ioctl.h>

#include "krm4zurf_presets.h"
#include "clock_spi_interface.h"

#define SPI_BITS_PER_WORD 8
#define SPI_SPEED_HZ 6250000


/*
 * endianess data format
 */
void format_data(__u8 *data, __u32 buf, __u32 len) {
  int j;
  for (j = 0; j < len; j++) {
    data[j] = (unsigned char) (buf>> 8*(len-(j+1))) & (0xFF);
  }
}


/*
 *  SPI device initialization
 */
int spi_init(int fd, char *spidev) {
	__u8 wr_mode=SPI_MODE_0;
	__u8 rd_mode=SPI_MODE_1;
	__u8 bits_per_word =SPI_BITS_PER_WORD;
	__u32 speed = SPI_SPEED_HZ;

	if ((ioctl(fd, SPI_IOC_WR_MODE, &wr_mode)) < 0) {
		printf("Error: %s set SPI_IOC_WR_MODE %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_RD_MODE, &rd_mode)) < 0) {
		printf("Error: %s set SPI_IOC_RD_MODE %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_RD_MODE32, &rd_mode)) < 0) {
		printf("Error: %s set SPI_IOC_RD_MODE %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bits_per_word)) < 0) {
		printf("Error: %s set SPI_IOC_WR_BITS_PER_WORD %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits_per_word)) < 0) {
		printf("Error: %s set SPI_IOC_RD_BITS_PER_WORD %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &speed)) < 0) {
		printf("Error: %s set SPI_IOC_WR_MAX_SPEED_HZ %s \n", strerror(errno), spidev);
		return errno;
	}

	if ((ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed)) < 0) {
		printf("Error: %s set SPI_IOC_RD_MAX_SPEED_HZ %s \n", strerror(errno), spidev);
		return errno;
	}

	return 0;
}


/*
 *
 */
int lmk04208_read(char *spidev, __u8 addr) {

	struct spi_ioc_transfer spi[2];
	memset(&spi, 0, sizeof(spi));
	int fd, j,  ret;
	__u32 buf;
	__u8 data[4];

	spi[0].tx_buf = (unsigned long) &data;
	spi[0].len = 4;
	//spi[0].speed_hz = SPI_SPEED_HZ;
	spi[0].bits_per_word = SPI_BITS_PER_WORD;
	spi[0].cs_change = 1;
	spi[1].rx_buf = (unsigned long) &data;
	spi[1].len = 4;
	//spi[1].rx_nbits=26;
	//spi[1].speed_hz = SPI_SPEED_HZ;
	spi[1].bits_per_word = SPI_BITS_PER_WORD;
	spi[1].cs_change = 0;

	if ((fd = open(spidev, O_RDWR)) < 0) {
		printf("Error: %s opening device %s \n", strerror(errno), spidev);
		return errno;
	}

	ret = spi_init(fd, spidev);
	if (ret < 0) {
		printf("Error: %s configuring %s \n", strerror(errno), spidev);
		close(fd);
		return ret;
	}
	buf = 0;
	buf |= 0 << 21;    // READBACK_LE
	buf |= addr << 16; // read addr
	//buf |= 1 << 5;    // lock writings
	buf |= 31 << 0;    // ctrl add

	format_data(data, buf, 4 );
	ret = ioctl(fd, SPI_IOC_MESSAGE(2), &spi);
	if (ret < 0) {
		printf("Error: %s reading from %s \n", strerror(errno), spidev);
		return errno;
	} else {
		buf = 0;
		for (j = 0; j < 4; j++) {
			buf |= (data[j] << (8*(4-(j+1))));
		}
		buf = (buf<< 1) | addr;
	}
	close(fd);
	return buf;
}


/*
 *
 */
int lmk04208_write(char *spidev, __u32 *buf, __u32 size) {

	struct spi_ioc_transfer spi[2];
	memset(&spi, 0, sizeof(spi));
	int fd, i, ret;
	__u8 data[4];
	spi[0].tx_buf = (unsigned long) &data;
	spi[0].len = 4;
	//spi[0].speed_hz = SPI_SPEED_HZ;
	spi[0].bits_per_word = SPI_BITS_PER_WORD;
	spi[0].cs_change = 1;
	spi[1].rx_buf = (unsigned long) &data;
	spi[1].len = 0;
	//spi[1].speed_hz = SPI_SPEED_HZ;
	spi[1].bits_per_word = SPI_BITS_PER_WORD;
	spi[1].cs_change = 1;

  if ((fd = open(spidev, O_RDWR)) < 0) {
    printf("Error: %s opening device %s \n", strerror(errno), spidev);
    close(fd);
    return errno;
  }

	ret = spi_init(fd, spidev);
	if (ret < 0) {
		printf("Error: %s configuring %s \n", strerror(errno), spidev);
		close(fd);
		return ret;
	}

	for (i = 0; i < size; i++) {
	  format_data(data, buf[i], spi[0].len );
		ret = ioctl(fd, SPI_IOC_MESSAGE(2), &spi);
		if (ret < 0) {
			break;
		}
	}
	close(fd);

	if (ret < 0) {
		printf("Error: %s transmitting word %d to %s \n", strerror(errno), i, spidev);
		return errno;
	}

	return 0;
}

/*
 *
 */
int lmk04208_status(char *spidev, bool verbose) {
  // TODO
}

/*
 *
 */
int lmk04208_config(char * spidev, __u32 lmk_freq) {

	int ret;

	if (lmk_freq >= LMK04208_MAX) {
		printf("Unsupported LMK04208 frequency\n");
		exit(EXIT_FAILURE);
	}

	ret = lmk04208_write(spidev, &LMK04208_CKin[lmk_freq][0], LMK04208_count);
  if (ret < 0) {
    printf("ERROR: configuring  %s (%d) \n", spidev, ret);
  } else {
    printf("lmk04208: set %s to  %d\n", spidev, lmk_freq);
  }

	return ret;
}


/*
 *
 */
int lmx2594_read(char * spidev, __u8 addr) {

  int fd, ret;
  unsigned char tx_buff[3];
  unsigned char rx_buff[3] = {0, 0, 0};
  struct spi_ioc_transfer spi[1];
  memset(&spi, 0, sizeof(spi));
  spi[0].tx_buf = (unsigned long) &tx_buff;
  spi[0].rx_buf = (unsigned long) &rx_buff;
  spi[0].len = 3;
  spi[0].tx_nbits = 8;
  spi[0].rx_nbits = 24;
  //spi[0].rx_nbits = 0;
  //spi[0].speed_hz = SPI_SPEED_HZ;
  spi[0].bits_per_word = SPI_BITS_PER_WORD;
  spi[0].cs_change = 0;           //0=Set CS high after a transfer, 1=leave CS set low

  tx_buff[0] = addr | 0x80;
  printf("addr %x, %x\n", addr, tx_buff[0]);
  if ((fd = open(spidev, O_RDWR)) < 0) {
    printf("Error: %s opening device %s \n", strerror(errno), spidev);
    return errno;
  }

  ret = spi_init(fd, spidev);
  if (ret < 0) {
    printf("Error: %s configuring %s \n", strerror(errno), spidev);
    close(fd);
    return ret;
  }

  ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
  if (ret < 0) {
    printf("Error: %s reading %s \n", strerror(errno), spidev);
  } else {
    ret = rx_buff[2] | (rx_buff[1]<<8) | (rx_buff[0]<<16) ;
  }

  //printf("%s, addr %d (%x) , data 0x%02x%02x\n", spidev, addr, tx_buff[0], rx_buff[1], rx_buff[0]);

  close(fd);
  return ret;
}

int lmx2594_status(char * spidev, bool verbose) {

  int fd,ret, i;
  unsigned char tx_buff[3];
  unsigned char rx_buff[3] = {0, 0, 0};
  struct spi_ioc_transfer spi[1];
  memset(&spi, 0, sizeof(spi));
  spi[0].tx_buf = (unsigned long) &tx_buff;
  spi[0].rx_buf = (unsigned long) &rx_buff;
  spi[0].len = 3;
  spi[0].tx_nbits = 8;
  spi[0].rx_nbits = 24;
  //spi[0].rx_nbits = 0;
  //spi[0].speed_hz = SPI_SPEED_HZ;
  spi[0].bits_per_word = SPI_BITS_PER_WORD;
  spi[0].cs_change = 0;           //0=Set CS high after a transfer, 1=leave CS set low

  if ((fd = open(spidev, O_RDWR)) < 0) {
    printf("Error: %s opening device %s \n", strerror(errno), spidev);
    return errno;
  }

  ret = spi_init(fd, spidev);
  if (ret < 0) {
    printf("Error: %s configuring %s \n", strerror(errno), spidev);
    close(fd);
    return ret;
  }

  ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
  if (ret < 0) {
    printf("Error: %s reading %s \n", strerror(errno), spidev);
  } else {
    ret = rx_buff[0] | (rx_buff[1]<<8) | (rx_buff[2]<<16) ;
  }

  if(verbose) {
    for(i=110; i<=112; i++) {
	    tx_buff[0] = i | 0x80;
	    ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
	    if (ret < 0) {
	      printf("Error: %s reading %s \n", strerror(errno), spidev);
	    } else {
	      ret = rx_buff[0] | (rx_buff[1]<<8) | (rx_buff[2]<<16) ;
	    }

	    ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
	    if (ret < 0) {
	      printf("Error: %s reading %s \n", strerror(errno), spidev);
	    } else {
	      ret = ((rx_buff[0]<<16) | (rx_buff[1]<<8) | rx_buff[2]) ;
	    }

	    switch(i){
	    	  case 110:
	    		  printf("status: %s, %16s : %d (0:Unlocked, 1:Invalid, 2:Locked, 3:Unlocked)\n", spidev, "LD VTUNE", (ret>>9) & 0x3 );
	    		  printf("status: %s, %16s : %d (0:Invalid, #:VCO#)\n", spidev, "VCO SEL", (ret>>5) & 0x7 );
	    		  break;
		    case 111:
	    		  printf("status: %s, %16s : %d\n", spidev, "VCO CAPCTRL", ret & 0x00FF );
	    		  break;
		    case 112:
	    		  printf("status: %s, %16s : %d\n", spidev, "VCO DACISET", ret & 0x01FF );
	    		  break;
		    default:
			    printf("Error: unknown status addr %d\n", i);
	    }

    }
  } else {  
	    tx_buff[0] = 110 | 0x80;
	    ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
	    if (ret < 0) {
	      printf("Error: %s reading %s \n", strerror(errno), spidev);
	    } else {
	      ret = rx_buff[0] | (rx_buff[1]<<8) | (rx_buff[2]<<16) ;
	    }

	    ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
	    if (ret < 0) {
	      printf("Error: %s reading %s \n", strerror(errno), spidev);
	    } else {
	      ret = ((rx_buff[0]<<16) | (rx_buff[1]<<8) | rx_buff[2]) ;
	    }
	    
	    printf("LMX2594: ");
	    if (strcmp(spidev,SPI_PLL_A)==0) {
	      printf("PLL A status :");
	    } else if (strcmp(spidev,SPI_PLL_B)==0) {
	      printf("PLL B status :");
	    } else if (strcmp(spidev,SPI_PLL_C)==0) {
	      printf("PLL C status :");
	    } else {
	      printf("%s status :", spidev);
	    }
	    switch((ret>>9) & 0x3){
	      case 0: printf("unlocked low\n"); break;
 	      case 1: printf("invalid\n"); break;
 	      case 2: printf("locked\n"); break;
	      default: printf("unlocked high\n"); break;
	    }
  }

  close(fd);
  return ret;
}

/*
 *
 */
int lmx2594_write( char *spidev, __u32 *buf, __u32 size) {

  struct spi_ioc_transfer spi;
  memset(&spi, 0, sizeof(spi));
  int fd, i, ret;
  int cnt = 0;
  __u8 data[3];
  spi.tx_buf = (unsigned long) &data;
  spi.len = 3;
  spi.speed_hz = SPI_SPEED_HZ;
  spi.bits_per_word = SPI_BITS_PER_WORD;
  spi.cs_change = 0;

  if ((fd = open(spidev, O_RDWR)) < 0) {
    printf("Error: %s opening device %s \n", strerror(errno), spidev);
    return errno;
  }

  ret = spi_init(fd, spidev);
  if (ret < 0) {
    printf("Error: %s configuring %s \n", strerror(errno), spidev);
    close(fd);
    return ret;
  }

  for (i = 0; i < size; i++) {
    format_data(data, buf[i], 3);
    ret = ioctl(fd, SPI_IOC_MESSAGE(1), &spi);
    if (ret < 0) {
      break;
    } else {
      cnt += ret;
    }
  }
  close(fd);
  if (ret < 0) {
    printf("Error: %s transmitting word %d to %s \n", strerror(errno), i, spidev);
    return errno;
  }

  return cnt;
}


/*
 *
 */
int lmx2594_config(char * spidev, __u32 lmx_freq) {

	int ret;

	if (lmx_freq >= DAC_MAX) {
		printf("Unsupported LMX2594 frequency\n");
		exit(EXIT_FAILURE);
	}

	/*
	 * 1. Apply power to device.
	 * 2. Program RESET = 1 to reset registers.
	 * 3. Program RESET = 0 to remove reset.
	 * 4. Program registers as shown in the register map in REVERSE order from
	 * highest to lowest.
	 * 5. Program register R0 one additional time with FCAL_EN = 1 to ensure that
	 * the VCO calibration runs from a
	 * stable state.
	 */
	__u32 pll_reset_cmd[2]= {0x00000002, 0x00000000 };
	ret = lmx2594_write(spidev, pll_reset_cmd, 2);
	if (ret > 0) {
	  usleep(10000);
		ret = lmx2594_write(spidev, &LMX2592_A[lmx_freq][0], LMX2594_A_count);
		if (ret > 0) {
		  usleep(10000);
			ret = lmx2594_write(spidev, &LMX2592_A[lmx_freq][LMX2594_A_count - 1], 1);
			if (ret > 0) {
				ret = EXIT_SUCCESS;
			}
		}
	}

	if (ret < 0) {
	  printf("ERROR: configuring  %s (%d) \n", spidev, ret);
	} else {
	  printf("LMX2594: set %s to  %s\n", spidev, DACFREQ_STRING[lmx_freq]);
	}

	return ret;
}


/*
 *
 */
int clk_init(__u32 lmk_freq, __u32 lmx0_freq, __u32 lmx1_freq, __u32 lmx2_freq) {

	unsigned int ret;

	/* Check LMK clock */
	if (lmk_freq != LMK04208_KRM_ZURF_REVA) {
		printf("Unsupported LMK04208 frequency\n");
		exit(EXIT_FAILURE);
	}

	if ((lmx0_freq >= ADC_MAX) || (lmx1_freq >= ADC_MAX) || (lmx2_freq >= DAC_MAX)) {
		printf("Unsupported LMX2594 frequency\n");
		exit(EXIT_FAILURE);
	}

	/* configure LMK clock */
	ret = lmk04208_config(SPI_LMK, lmk_freq);
	if (ret != EXIT_SUCCESS) {
		printf("Unable to set LMK clock with %d offset\n", lmk_freq);
		exit(EXIT_FAILURE);
	}
	usleep(1000000);
	

	/* configure LMX 0 clock */
	ret = lmx2594_config(SPI_PLL_A, lmx0_freq);
	if (ret != EXIT_SUCCESS) {
		printf("Unable to set LMX 0 clock with %d offset\n", lmx0_freq);
		exit(EXIT_FAILURE);
	}

	/* configure LMX 1 clock */
	ret = lmx2594_config(SPI_PLL_B, lmx1_freq);
	if (ret != EXIT_SUCCESS) {
		printf("Unable to set LMX 1 clock with %d offset\n", lmx1_freq);
		exit(EXIT_FAILURE);
	}

	/* configure LMX 2 clock */
	ret = lmx2594_config(SPI_PLL_C, lmx2_freq);
	if (ret != EXIT_SUCCESS) {
		printf("Unable to set LMX 2 clock with %d offset\n", lmx2_freq);
		exit(EXIT_FAILURE);
	}

	usleep(100000);
	lmk04208_status(SPI_LMK, false);
	lmx2594_status(SPI_PLL_A, false);
	lmx2594_status(SPI_PLL_B, false);
	lmx2594_status(SPI_PLL_C, false);

	return 0;
}

