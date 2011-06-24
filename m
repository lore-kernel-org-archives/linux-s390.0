Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Will Drewry <wad@chromium.org>
Subject: [PATCH v9 10/13] s390: select HAVE_SECCOMP_FILTER and provide seccomp_execve
Date: Thu, 23 Jun 2011 19:36:49 -0500
Message-Id: <1308875813-20122-10-git-send-email-wad@chromium.org>
In-Reply-To: <1308875813-20122-1-git-send-email-wad@chromium.org>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, djm@mindrot.org, segoon@openwall.com, kees.cook@canonical.com, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, fweisbec@gmail.com, tglx@linutronix.de, scarybeasts@gmail.com, Will Drewry <wad@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
system call numbering for execve and selecting HAVE_SECCOMP_FILTER.

v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/s390/Kconfig               |    1 +
 arch/s390/include/asm/seccomp.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 90d77bd..327d16a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -64,6 +64,7 @@ config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 config S390
 	def_bool y
 	select USE_GENERIC_SMP_HELPERS if SMP
+	select HAVE_SECCOMP_FILTER
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 781a9cf..e5792f5 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -7,10 +7,11 @@
 #define __NR_seccomp_write	__NR_write
 #define __NR_seccomp_exit	__NR_exit
 #define __NR_seccomp_sigreturn	__NR_sigreturn
+#define __NR_seccomp_execve	__NR_execve
 
 #define __NR_seccomp_read_32	__NR_read
 #define __NR_seccomp_write_32	__NR_write
 #define __NR_seccomp_exit_32	__NR_exit
-#define __NR_seccomp_sigreturn_32 __NR_sigreturn
+#define __NR_seccomp_execve_32	__NR_execve
 
 #endif	/* _ASM_S390_SECCOMP_H */
-- 
1.7.0.4
