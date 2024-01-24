99,                     /* application device ID */
256,                    /* page size */
4096,                  /* num pages */
3,                      /* address size */
8,                      /* log2 clock divider */
0x9F,                   /* SPI_RDID */
0,                      /* id dummy bytes */
3,                      /* id size in bytes */
0xC22314,               /* device id */
0x20,                   /* SPI_SE */
0,                      /* erase is full sector */
0x06,                   /* SPI_WREN */
0x04,                   /* SPI_WRDI */
PROT_TYPE_SR,           /* no protection */
{{0x3C,0x02},{0,0}},    /* SR values for protection */
0x02,                   /* SPI_PP */
0xEB,                   /* SPI_READ_FAST */
6,                      /* 6 read dummy byte*/
SECTOR_LAYOUT_REGULAR,  /* sane sectors */
{4096,{0,{0}}},         /* regular sector sizes */
0x05,                   /* SPI_RDSR */
0x01,                   /* SPI_WRSR */
0x01,                   /* SPI_WIP_BIT_MASK */