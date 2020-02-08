Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42848 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgBHOLJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 09:11:09 -0500
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390/kaslr: Fix casts in get_random
Date: Sat,  8 Feb 2020 07:10:52 -0700
Message-Id: <20200208141052.48476-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
of type 'const u8 *' (aka 'const unsigned char *') converts between
pointers to integer
types with different sign [-Wpointer-sign]
                                  (char *) entropy, (char *) entropy,
                                                    ^~~~~~~~~~~~~~~~
../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
parameter 'src' here
                            u8 *dest, const u8 *src, long src_len)
                                                ^
2 warnings generated.

Fix the cast to match what else is done in this function.

Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
Link: https://github.com/ClangBuiltLinux/linux/issues/862
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/s390/boot/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
index 5d12352545c5..5591243d673e 100644
--- a/arch/s390/boot/kaslr.c
+++ b/arch/s390/boot/kaslr.c
@@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
 		*(unsigned long *) prng.parm_block ^= seed;
 		for (i = 0; i < 16; i++) {
 			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
-				  (char *) entropy, (char *) entropy,
+				  (u8 *) entropy, (u8 *) entropy,
 				  sizeof(entropy));
 			memcpy(prng.parm_block, entropy, sizeof(entropy));
 		}
-- 
2.25.0
