From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 16/16] x86/compat: Remove is_compat_task
Date: Mon, 25 Jan 2016 14:24:30 -0800
Message-ID: <c48a8336218fcd6e27a386d89afef155458f1551.1453759363.git.luto@kernel.org>
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

x86's is_compat_task always checked the current syscall type, not
the task type.  It has no non-arch users any more, so just remove it
to avoid confusion.

On x86, nothing should really be checking the task ABI.  There are
legitimate users for the syscall ABI and for the mm ABI.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/compat.h | 3 ++-
 arch/x86/include/asm/ftrace.h | 2 +-
 arch/x86/kernel/process_64.c  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index acdee09228b3..ebb102e1bbc7 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -316,9 +316,10 @@ static inline bool is_x32_task(void)
 	return false;
 }
 
-static inline bool is_compat_task(void)
+static inline bool in_compat_syscall(void)
 {
 	return is_ia32_task() || is_x32_task();
 }
+#define in_compat_syscall in_compat_syscall	/* override the generic impl */
 
 #endif /* _ASM_X86_COMPAT_H */
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 24938852db30..21b66dbf3601 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -58,7 +58,7 @@ int ftrace_int3_handler(struct pt_regs *regs);
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS 1
 static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
-	if (is_compat_task())
+	if (in_compat_syscall())
 		return true;
 	return false;
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b9d99e0f82c4..71a18a22ae2f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -476,7 +476,7 @@ void set_personality_ia32(bool x32)
 		if (current->mm)
 			current->mm->context.ia32_compat = TIF_X32;
 		current->personality &= ~READ_IMPLIES_EXEC;
-		/* is_compat_task() uses the presence of the x32
+		/* in_compat_syscall() uses the presence of the x32
 		   syscall bit flag to determine compat status */
 		current_thread_info()->status &= ~TS_COMPAT;
 	} else {
-- 
2.5.0
