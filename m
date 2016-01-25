From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 03/16] sparc/syscall: Fix syscall_get_arch
Date: Mon, 25 Jan 2016 14:24:17 -0800
Message-ID: <dc060687116306416e656e25c6a02611bf6e894e.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Sparc's syscall_get_arch was buggy: it returned the task arch, not the
syscall arch.  This could confuse seccomp and audit.

I don't think this is as bad for seccomp as it looks: sparc's
32-bit and 64-bit syscalls are numbered the same.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/sparc/include/asm/syscall.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/syscall.h b/arch/sparc/include/asm/syscall.h
index 49f71fd5b56e..1757cd6c521b 100644
--- a/arch/sparc/include/asm/syscall.h
+++ b/arch/sparc/include/asm/syscall.h
@@ -3,6 +3,7 @@
 
 #include <uapi/linux/audit.h>
 #include <linux/kernel.h>
+#include <linux/compat.h>
 #include <linux/sched.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -128,7 +129,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
 
 static inline int syscall_get_arch(void)
 {
-	return is_32bit_task() ? AUDIT_ARCH_SPARC : AUDIT_ARCH_SPARC64;
+#if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
+	return in_compat_syscall() ? AUDIT_ARCH_SPARC : AUDIT_ARCH_SPARC64;
+#elif defined(CONFIG_SPARC64)
+	return AUDIT_ARCH_SPARC64;
+#else
+	return AUDIT_ARCH_SPARC;
+#endif
 }
 
 #endif /* __ASM_SPARC_SYSCALL_H */
-- 
2.5.0
