#include "system.h"
#include "io.h"
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

int main(void) {
    /* Các mảng key */
    uint32_t key[4]   = { 0x2b7e1516, 0x28aed2a6, 0xabf71588, 0x09cf4f3c };
    uint32_t key1[4]  = { 0x54686174, 0x73206d79, 0x204b756e, 0x67204675 };
    uint32_t key2[4]  = { 0xA1A2A3A4, 0xB1B2B3B4, 0xC1C2C3C4, 0xD1D2D3D4 };

    /* Các mảng plaintext */
    uint32_t data[4]  = { 0x3243f6a8, 0x885a308d, 0x313198a2, 0xe0370734 };
    uint32_t data1[4] = { 0xDEADBEEF, 0x01234567, 0x89ABCDEF, 0xFEDCBA98 };
    uint32_t data2[4] = { 0x54776f20, 0x4f6e6520, 0x4e696e65, 0x2054776f };
    uint32_t data3[4] = { 0x11223344, 0x55667788, 0x99AABBCC, 0xDDEEFF00 };
    uint32_t data4[4] = { 0x0F1E2D3C, 0x4B5A6978, 0x8796A5B4, 0xC3D2E1F0 };
    uint32_t data5[4] = { 0xCAFEBABE, 0x8BADF00D, 0xFEEDFACE, 0xDEADC0DE };
    uint32_t data6[4] = { 0x13371337, 0xC001D00D, 0x0BADCAFE, 0xFACEB00C };

    uint32_t ct[4];
    int i;

    /* -------- Lần 1: Dùng key và data ban đầu -------- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, key[i]);
    IOWR(IP_SLAVE_0_BASE, 5, 1);  // Load_Key

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Write Key\n");
    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 2: Dùng key cũ, plaintext data1 -------- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data1[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data1[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 3: Dùng key1, plaintext data2 -------- */

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, key1[i]);
    IOWR(IP_SLAVE_0_BASE, 5, 1);  // Load_Key
    printf("Write Key1\n");

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data2[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key1[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data2[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 4: Dùng key1, plaintext data3 -------- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data3[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key1[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data3[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 5: Dùng key1, plaintext data4 -------- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data4[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key1[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data4[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 6: Dùng key2, plaintext data5 -------- */

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, key2[i]);
    IOWR(IP_SLAVE_0_BASE, 5, 1);  // Load_Key
    printf("Write Key2\n");

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
        IOWR(IP_SLAVE_0_BASE, i, data5[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key2[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data5[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    /* -------- Lần 7: Dùng key2, plaintext data6 -------- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
        for (i = 0; i < 4; i++)
            IOWR(IP_SLAVE_0_BASE, i, key2[i]);
        IOWR(IP_SLAVE_0_BASE, 5, 1);  // Load_Key
        //Test ghi lai Key cu Key2

    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++)
       IOWR(IP_SLAVE_0_BASE, i, data6[i]);
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++)
        ct[i] = IORD(IP_SLAVE_0_BASE, 6 + i);

    printf("Key      =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, key2[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, data6[i]);
    printf("\nCipher   =");
    for (i = 0; i < 4; i++)
        printf(" 0x%08" PRIx32, ct[i]);
    printf("\n\n");

    return 0;
}
