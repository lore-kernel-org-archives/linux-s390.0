Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH] s390/decompressor: fix initrd corruption caused by bss clear
Date: Mon, 13 Mar 2017 12:14:58 -0300
Message-Id: <1489418098-1564-1-git-send-email-marcelo.cerri@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Marcelo Henrique Cerri <marcelo.cerri@canonical.com>, Joy Latten <joy.latten@canonical.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Reorder the operations in decompress_kernel() to ensure initrd is moved
to a safe location before the bss section is zeroed.

During decompression bss can overlap with the initrd and this can
corrupt the initrd contents depending on the size of the compressed
kernel (which affects where the initrd is placed by the bootloader) and
the size of the bss section of the decompressor.

Also use the correct initrd size when checking for overlaps with
parmblock.

Fixes: 06c0dd72aea3 ([S390] fix boot failures with compressed kernels)
Cc: stable@vger.kernel.org
Reviewed-by: Joy Latten <joy.latten@canonical.com>
Reviewed-by: Vineetha HariPai <vineetha.hari.pai@canonical.com>
Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 arch/s390/boot/compressed/misc.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/s390/boot/compressed/misc.c b/arch/s390/boot/compressed/misc.c
index fa95041fa9f6..cf91297f4e7a 100644
--- a/arch/s390/boot/compressed/misc.c
+++ b/arch/s390/boot/compressed/misc.c
@@ -141,31 +141,34 @@ static void check_ipl_parmblock(void *start, unsigned long size)
 
 unsigned long decompress_kernel(void)
 {
-	unsigned long output_addr;
-	unsigned char *output;
+	void *output, *kernel_end;
 
-	output_addr = ((unsigned long) &_end + HEAP_SIZE + 4095UL) & -4096UL;
-	check_ipl_parmblock((void *) 0, output_addr + SZ__bss_start);
-	memset(&_bss, 0, &_ebss - &_bss);
-	free_mem_ptr = (unsigned long)&_end;
-	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
-	output = (unsigned char *) output_addr;
+	output = (void *) ALIGN((unsigned long) &_end + HEAP_SIZE, PAGE_SIZE);
+	kernel_end = output + SZ__bss_start;
+	check_ipl_parmblock(0, (unsigned long) kernel_end);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/*
 	 * Move the initrd right behind the end of the decompressed
-	 * kernel image.
+	 * kernel image. This also prevent the initrd corruption caused by the
+	 * bss clearing since kernel_end will always be located after the
+	 * current bss section..
 	 */
-	if (INITRD_START && INITRD_SIZE &&
-	    INITRD_START < (unsigned long) output + SZ__bss_start) {
-		check_ipl_parmblock(output + SZ__bss_start,
-				    INITRD_START + INITRD_SIZE);
-		memmove(output + SZ__bss_start,
-			(void *) INITRD_START, INITRD_SIZE);
-		INITRD_START = (unsigned long) output + SZ__bss_start;
+	if (INITRD_START && INITRD_SIZE && kernel_end > (void *) INITRD_START) {
+		check_ipl_parmblock(kernel_end, INITRD_SIZE);
+		memmove(kernel_end, (void *) INITRD_START, INITRD_SIZE);
+		INITRD_START = (unsigned long) kernel_end;
 	}
 #endif
 
+	/*
+	 * Clear the bss section. free_mem_ptr and free_mem_end_ptr need to be
+	 * initialized after since they reside on bss.
+	 */
+	memset(&_bss, 0, &_ebss - &_bss);
+	free_mem_ptr = (unsigned long) &_end;
+	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
+
 	puts("Uncompressing Linux... ");
 	__decompress(input_data, input_len, NULL, NULL, output, 0, NULL, error);
 	puts("Ok, booting the kernel.\n");
-- 
2.7.4
