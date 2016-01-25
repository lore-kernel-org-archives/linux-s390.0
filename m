From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 01/16] compat: Add in_compat_syscall to ask whether we're in a compat syscall
Date: Mon, 25 Jan 2016 14:24:15 -0800
Message-ID: <4cd121066a85fe57356569e3bae28fe9d7098806.1453759363.git.luto@kernel.org>
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

A lot of code currently abuses is_compat_task to determine this.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 include/linux/compat.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index a76c9172b2eb..f911bcec618f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -5,6 +5,8 @@
  * syscall compatibility layer.
  */
 
+#include <linux/types.h>
+
 #ifdef CONFIG_COMPAT
 
 #include <linux/stat.h>
@@ -713,9 +715,22 @@ asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
+
+/*
+ * For most but not all architectures, "am I in a compat syscall?" and
+ * "am I a compat task?" are the same question.  For architectures on which
+ * they aren't the same question, arch code can override in_compat_syscall.
+ */
+
+#ifndef in_compat_syscall
+static inline bool in_compat_syscall(void) { return is_compat_task(); }
+#endif
+
 #else
 
 #define is_compat_task() (0)
+static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
+
 #endif /* _LINUX_COMPAT_H */
-- 
2.5.0
