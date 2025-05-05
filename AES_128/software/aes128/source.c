#include "system.h"
#include "io.h"
#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>

int main(void) {
    uint32_t key[4] = {
        0x2b7e1516, 0x28aed2a6,
        0xabf71588, 0x09cf4f3c
    };
    uint32_t data[4] = {
        0x3243f6a8, 0x885a308d,
        0x313198a2, 0xe0370734
    };
    uint32_t ciphertext[5];
    uint32_t tmp;

    int i;
    // Ghi key vào iData[0..3]
    for (i = 0; i < 4; i++) {
        IOWR(TEMP_0_BASE, i, key[i]);
    }
    // Xác nhận lại in_data qua địa chỉ 11..14
    for (i = 0; i < 4; i++) {
        tmp = IORD(TEMP_0_BASE, 11 + i);
        printf("in_data[%d] = 0x%08" PRIx32 "\n", i, tmp);
    }

    // Xung Load_Key (địa chỉ 5)
    IOWR(TEMP_0_BASE, 5, 1);

    // Ghi plaintext vào iData[0..3]
    for (i = 0; i < 4; i++) {
        IOWR(TEMP_0_BASE, i, data[i]);
    }
    // Xác nhận lại in_data qua địa chỉ 11..14
    for (i = 0; i < 4; i++) {
        tmp = IORD(TEMP_0_BASE, 11 + i);
        printf("in_data[%d] = 0x%08" PRIx32 "\n", i, tmp);
    }

    // Xung Load_Data (địa chỉ 4)
    IOWR(TEMP_0_BASE, 4, 1);

    // Polling CTValid (bit tmp_valid ở addr 10)
    do {
        tmp = IORD(TEMP_0_BASE, 10) & 0x1;
    } while (!tmp);
    for(i=0; i<500 ; i++);
    // Đọc 4 từ ciphertext tại addr 6..9
    for (i = 0; i < 4; i++) {
        ciphertext[i] = IORD(TEMP_0_BASE, 6 + i);
    }

    // In kết quả
    printf("CipherText =");
    for (i = 0; i < 4; i++) {
        printf(" 0x%08" PRIx32, ciphertext[i]);
    }
    printf("\n");

    return 0;
}
