#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdbool.h>
#include "clock_spi_interface.h"
#include "clock_interface.h"


int main(int argc, char **argv) {
	int ret = EXIT_FAILURE;
	__u32 data[1];

	if (argc<2) {
		printf("Missing arguments\n");
		exit(EXIT_FAILURE);
	} else {
		if ( strcmp(argv[1],"-i")== 0 ) {
			switch (argc) {
			case 2:
				ret = clk_init(LMK04208_KRM_ZURF_REVA, DAC_409_6_MHZ, DAC_409_6_MHZ, ADC_409_6_MHZ);
				break;
			case 6:
				ret = clk_init(atoi(argv[2]), atoi(argv[3]), atoi(argv[4]), atoi(argv[5]));
				break;
			default:
				printf("Invalid number of arguments (%d): -i [INT INT INT INT]\n", argc);
				ret = EXIT_FAILURE;
			}
		} else if (strcmp(argv[1],"-c")== 0) {
			switch (argc) {
			case 4:
				if (strcmp(argv[2],SPI_LMK)==0) {
					ret = lmk04208_config(argv[2], atoi(argv[3]));
				} else {
					ret = lmx2594_config(argv[2], atoi(argv[3]));
				}
				break;
			default:
				printf("Invalid number of arguments (%d): -c DEV INT\n", argc);
				ret = EXIT_FAILURE;
			}
		} else if (strcmp(argv[1],"-w")== 0) {
			switch (argc) {
			case 4:
			  data[0] = strtoul(argv[3], NULL, 0);
			  if(errno==EINVAL || errno==ERANGE) {
			    printf("Invalid integer value %s \n", argv[3]);
			  } else {
	        if (strcmp(argv[2],SPI_LMK)==0) {
	          ret = lmk04208_write(argv[2], data, 1);
	        } else {
	          ret = lmx2594_write(argv[2], data, 1);
	        }
			  }
				break;
			default:
				printf("Invalid number of arguments (%d): -w DEV DATA \n", argc);
				ret = EXIT_FAILURE;
			}
		} else if (strcmp(argv[1],"-r")== 0) {
			switch (argc) {
			case 4:
				if (strcmp(argv[2],SPI_LMK)==0) {
					ret = lmk04208_read(argv[2], atoi(argv[3]));
				} else {
					ret = lmx2594_read(argv[2], atoi(argv[3]));
				}
				printf("%s, addr %02d = 0x%08x\n", argv[2], atoi(argv[3]), ret);
				break;
			default:
				printf("Invalid number of arguments (%d): -r DEV INT\n", argc);
				ret = EXIT_FAILURE;
			}
		} else if ( strcmp(argv[1],"-s")== 0 ) {
			switch (argc) {
			case 2:
  			ret = 0;
			  lmk04208_status(SPI_LMK, false);
			  lmx2594_status(SPI_PLL_A, false);
			  lmx2594_status(SPI_PLL_B, false);
			  lmx2594_status(SPI_PLL_C, false);
				break;
			case 3:
  			ret = 0;
			  lmk04208_status(SPI_LMK, true);
			  lmx2594_status(SPI_PLL_A, true);
			  lmx2594_status(SPI_PLL_B, true);
			  lmx2594_status(SPI_PLL_C, true);
				break;
			default:
				printf("Invalid number of arguments (%d): -s \n", argc);
				ret = EXIT_FAILURE;
			}
		} else {
			printf("Unknown option %s\n", argv[1] );
			ret = EXIT_FAILURE;
		}
	}

	return ret;
}
