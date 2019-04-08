Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/12] s390: make __load_psw_mask work with clang
Date: Mon,  8 Apr 2019 23:26:22 +0200
Message-Id: <20190408212648.2407234-9-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

clang fails to use the %O and %R inline assembly modifiers
the same way as gcc, leading to build failures with every use
of __load_psw_mask():

/tmp/nmi-4a9f80.s: Assembler messages:
/tmp/nmi-4a9f80.s:571: Error: junk at end of line: `+8(160(%r11))'
/tmp/nmi-4a9f80.s:626: Error: junk at end of line: `+8(160(%r11))'

Replace these with a more conventional way of passing the addresses
that should work with both clang and gcc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/processor.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 81038ab357ce..700c650ffd4f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -339,10 +339,10 @@ static __no_kasan_or_inline void __load_psw_mask(unsigned long mask)
 
 	asm volatile(
 		"	larl	%0,1f\n"
-		"	stg	%0,%O1+8(%R1)\n"
-		"	lpswe	%1\n"
+		"	stg	%0,%1\n"
+		"	lpswe	%2\n"
 		"1:"
-		: "=&d" (addr), "=Q" (psw) : "Q" (psw) : "memory", "cc");
+		: "=&d" (addr), "=Q" (psw.addr) : "Q" (psw) : "memory", "cc");
 }
 
 /*
-- 
2.20.0
