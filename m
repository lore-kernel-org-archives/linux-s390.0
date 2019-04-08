Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/12] s390: syscall_wrapper: avoid clang warning
Date: Mon,  8 Apr 2019 23:26:21 +0200
Message-Id: <20190408212648.2407234-8-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Building system calls with clang results in a warning
about an alias from a global function to a static one:

../fs/namei.c:3847:1: warning: unused function '__se_sys_mkdirat' [-Wunused-function]
SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
^
../include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE3'
 #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
                                   ^
../include/linux/syscalls.h:228:2: note: expanded from macro 'SYSCALL_DEFINEx'
        __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
        ^
../arch/s390/include/asm/syscall_wrapper.h:126:18: note: expanded from macro '__SYSCALL_DEFINEx'
        asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))          \
                        ^
<scratch space>:31:1: note: expanded from here
__se_sys_mkdirat
^

The only reference to the static __se_sys_mkdirat() here is the alias, but
this only gets evaluated later. Making this function global as well avoids
the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I considered opening a bug report for llvm here, but I suspect the
behavior is intentional, so I'm just fixing it here. Let me know if
you disagree.
---
 arch/s390/include/asm/syscall_wrapper.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/syscall_wrapper.h b/arch/s390/include/asm/syscall_wrapper.h
index 5596c5c625d2..3c3d6fe8e2f0 100644
--- a/arch/s390/include/asm/syscall_wrapper.h
+++ b/arch/s390/include/asm/syscall_wrapper.h
@@ -119,8 +119,8 @@
 		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long __s390x_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));		\
-	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);				\
-	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	ALLOW_ERROR_INJECTION(__s390x_sys##name, ERRNO);			\
+	long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));			\
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	__S390_SYS_STUBx(x, name, __VA_ARGS__)					\
 	asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
-- 
2.20.0
