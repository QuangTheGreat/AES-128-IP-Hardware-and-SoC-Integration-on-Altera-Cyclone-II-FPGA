#include "system.h"
#include "io.h"
#include <stdio.h>

int main(void) {
//    unsigned int key[4] = {0x2b7e1516, 0x28aed2a6, 0xabf71588, 0x09cf4f3c};
//    unsigned int data[4] = {0x3243f6a8, 0x885a308d, 0x313198a2, 0xe0370734};
    unsigned int ciphertext[6];

    // Cấu hình ngắt (đăng ký ngắt cho thiết bị của bạn)

    // Gửi dữ liệu vào các cổng
    IOWR(NEW_COMPONENT_0_BASE, 0, 0x2b7e1516);
    IOWR(NEW_COMPONENT_0_BASE, 1, 0x28aed2a6);
    IOWR(NEW_COMPONENT_0_BASE, 2, 0xabf71588);
    IOWR(NEW_COMPONENT_0_BASE, 3, 0x09cf4f3c);

    IOWR(NEW_COMPONENT_0_BASE, 5, 1); // Generate Load_Key pulse

    IOWR(NEW_COMPONENT_0_BASE, 0, 0x3243f6a8);
    IOWR(NEW_COMPONENT_0_BASE, 1, 0x885a308d);
    IOWR(NEW_COMPONENT_0_BASE, 2, 0x313198a2);
    IOWR(NEW_COMPONENT_0_BASE, 3, 0xe0370734);

    IOWR(NEW_COMPONENT_0_BASE, 4, 1); // Generate Load_Data pulse

//   while((IORD(WRAPPER_AVALON_0_BASE, 4) == 0x00000000));
    int i;
    for(i = 0; i < 600; i++){
    	printf("abs\n");
    }

    ciphertext[0] = IORD(NEW_COMPONENT_0_BASE, 0);
    ciphertext[1] = IORD(NEW_COMPONENT_0_BASE, 1);
    ciphertext[2] = IORD(NEW_COMPONENT_0_BASE, 2);
    ciphertext[3] = IORD(NEW_COMPONENT_0_BASE, 3);
    ciphertext[4] = IORD(NEW_COMPONENT_0_BASE, 4);
    ciphertext[5] = IORD(NEW_COMPONENT_0_BASE, 5);

    printf("CipherText: %08x %08x %08x %08x %08x %08x\n", ciphertext[0], ciphertext[1], ciphertext[2], ciphertext[3], ciphertext[4], ciphertext[5]);

    return 0;
}
