Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in inline assembly
Date: Mon,  8 Apr 2019 23:26:25 +0200
Message-Id: <20190408212648.2407234-12-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

clang does not understand the contraint "0" in the CALL_ON_STACK()
macro:

../arch/s390/mm/maccess.c:117:10: error: invalid input constraint '0' in asm
                return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
                       ^
../arch/s390/include/asm/processor.h:292:20: note: expanded from macro 'CALL_ON_STACK'
                  [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);    \
                                 ^
<scratch space>:207:1: note: expanded from here
CALL_FMT_3
^
../arch/s390/include/asm/processor.h:267:20: note: expanded from macro 'CALL_FMT_3'
 #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
                   ^
../arch/s390/include/asm/processor.h:266:20: note: expanded from macro 'CALL_FMT_2'
 #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
                   ^
../arch/s390/include/asm/processor.h:265:32: note: expanded from macro 'CALL_FMT_1'
 #define CALL_FMT_1 CALL_FMT_0, "0" (r2)
                               ^

I don't know what the correct fix here would be, changing it to "d" made
it build, since clang does understand this one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 700c650ffd4f..84c59c99668a 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
 	register unsigned long r4 asm("6") = (unsigned long)(arg5)
 
 #define CALL_FMT_0
-#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
+#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
 #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
 #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
 #define CALL_FMT_4 CALL_FMT_3, "d" (r5)
-- 
2.20.0
