Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/12] s390: avoid __builtin_return_address(n) on clang
Date: Mon,  8 Apr 2019 23:26:23 +0200
Message-Id: <20190408212648.2407234-10-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

llvm on s390 has problems with __builtin_return_address(n), with n>0,
this results in a somewhat cryptic error message:

fatal error: error in backend: Unsupported stack frame traversal count

To work around it, use the direct return address directly. This
is probably not ideal here, but gets things to compile and should
only lead to inferior reporting, not to misbehavior of the generated
code.

Link: https://bugs.llvm.org/show_bug.cgi?id=41424
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/ftrace.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a3c95b11952..7923c63946fb 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -13,7 +13,12 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_CC_IS_CLANG
+/* https://bugs.llvm.org/show_bug.cgi?id=41424 */
+#define ftrace_return_address(n) __builtin_return_address(0)
+#else
 #define ftrace_return_address(n) __builtin_return_address(n)
+#endif
 
 void _mcount(void);
 void ftrace_caller(void);
-- 
2.20.0
