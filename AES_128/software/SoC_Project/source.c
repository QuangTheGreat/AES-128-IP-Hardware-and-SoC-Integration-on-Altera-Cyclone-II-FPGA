#include "system.h"
#include "io.h"
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

int main(void) {
    /* Mẫu dữ liệu cố định */
    uint32_t key[4]   = { 0x2b7e1516, 0x28aed2a6, 0xabf71588, 0x09cf4f3c };
    uint32_t data[4]  = { 0x3243f6a8, 0x885a308d, 0x313198a2, 0xe0370734 };

    uint32_t key1[4]  = { 0x54686174, 0x73206d79, 0x204b756e, 0x67204675 };
    uint32_t data1[4] = { 0xDEADBEEF, 0x01234567, 0x89ABCDEF, 0xFEDCBA98 };

    uint32_t data2[4] = { 0x54776f20, 0x4f6e6520, 0x4e696e65, 0x2054776f };

    uint32_t ct1[4], ct2[4], ct3[4];
    uint32_t tmp;
    int i;

    /* ----- Lần 1: dùng key & data gốc ----- */
    // Nạp key vào addr 0..3
    for (i = 0; i < 4; i++) {
        IOWR(IP_SLAVE_0_BASE, i, key[i]);
    }
    // Xung Load_Key
    IOWR(IP_SLAVE_0_BASE, 5, 1);

    // Nạp plaintext gốc vào addr 0..3
    for (i = 0; i < 4; i++) {
        IOWR(IP_SLAVE_0_BASE, i, data[i]);
    }
    // Xung Load_Data
    IOWR(IP_SLAVE_0_BASE, 4, 1);

    // Chờ CTValid (addr 10 bit0)
    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    // Đọc ciphertext
    for (i = 0; i < 4; i++) {
        ct1[i] = IORD(IP_SLAVE_0_BASE, 6 + i);
    }
    // In kết quả
    printf("Key      =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, key[i]);
    printf("\nPlain    =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, data[i]);
    printf("\nCipher1  =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, ct1[i]);
    printf("\n\n");

    /* ----- Lần 2: plaintext mẫu data1, key cũ ----- */
    // Chờ Ready_new_input (addr 15 bit0)
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }

    // Nạp data1
    for (i = 0; i < 4; i++) {
        IOWR(IP_SLAVE_0_BASE, i, data1[i]);
    }
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    // Chờ CTValid
    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    // Đọc ciphertext2
    for (i = 0; i < 4; i++) {
        ct2[i] = IORD(IP_SLAVE_0_BASE, 6 + i);
    }
    printf("Plain1   =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, data1[i]);
    printf("\nCipher2  =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, ct2[i]);
    printf("\n\n");

    /* ----- Lần 3: nạp key mới key1 ----- */
    while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++) {
        IOWR(IP_SLAVE_0_BASE, i, key1[i]);
    }
    IOWR(IP_SLAVE_0_BASE, 5, 1);  // Load_Key
    printf("Key1     =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, key1[i]);
    printf("\n\n");

    /* ----- Lần 4: plaintext mẫu data2, key1 ----- */
    //while (!(IORD(IP_SLAVE_0_BASE, 15) & 0x1)) { }
    for (i = 0; i < 4; i++) {
        IOWR(IP_SLAVE_0_BASE, i, data2[i]);
    }
    IOWR(IP_SLAVE_0_BASE, 4, 1);  // Load_Data

    while (!(IORD(IP_SLAVE_0_BASE, 10) & 0x1)) { }
    for (i = 0; i < 4; i++) {
        ct3[i] = IORD(IP_SLAVE_0_BASE, 6 + i);
    }
    printf("Plain2   =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, data2[i]);
    printf("\nCipher3  =");
    for (i = 0; i < 4; i++) printf(" 0x%08" PRIx32, ct3[i]);
    printf("\n");

    return 0;
}
