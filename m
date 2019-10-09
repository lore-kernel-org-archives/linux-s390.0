Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:54905 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfJILkN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 07:40:13 -0400
From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] proc: centralise declaration of cpuinfo_op
Date: Wed,  9 Oct 2019 12:39:30 +0100
Message-Id: <20191009113930.13236-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org

When building for arm, cpuinfo_op generates a warning due
to no declaration. Since this is used in fs/proc/cpuinfo.c
and inconsitently declared across archiectures move the
declaration info <linux/seq_file.h>. This means that the
cpuinfo_op will have a declaration any place it is used.

Removes the following sparse warning:

arch/arm/kernel/setup.c:1320:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/c6x/include/asm/processor.h        | 2 --
 arch/microblaze/include/asm/processor.h | 3 ---
 arch/s390/include/asm/processor.h       | 1 -
 arch/sh/include/asm/processor.h         | 1 -
 arch/sparc/include/asm/cpudata.h        | 2 --
 arch/x86/include/asm/processor.h        | 2 --
 include/linux/seq_file.h                | 2 ++
 7 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/c6x/include/asm/processor.h b/arch/c6x/include/asm/processor.h
index 1456f5e11de3..ecc906854b6a 100644
--- a/arch/c6x/include/asm/processor.h
+++ b/arch/c6x/include/asm/processor.h
@@ -100,8 +100,6 @@ extern unsigned long get_wchan(struct task_struct *p);
 
 #define cpu_relax()		do { } while (0)
 
-extern const struct seq_operations cpuinfo_op;
-
 /* Reset the board */
 #define HARD_RESET_NOW()
 
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 66b537b8d138..8ab09e94b8ae 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -18,9 +18,6 @@
 #include <asm/current.h>
 
 # ifndef __ASSEMBLY__
-/* from kernel/cpu/mb.c */
-extern const struct seq_operations cpuinfo_op;
-
 # define cpu_relax()		barrier()
 
 #define task_pt_regs(tsk) \
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 51a0e4a2dc96..813d2bfc63ac 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -83,7 +83,6 @@ void s390_adjust_jiffies(void);
 void s390_update_cpu_mhz(void);
 void cpu_detect_mhz_feature(void);
 
-extern const struct seq_operations cpuinfo_op;
 extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
 extern void __bpon(void);
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 6fbf8c80e498..25ddb34f31d9 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -128,7 +128,6 @@ extern unsigned int mem_init_done;
 
 /* arch/sh/kernel/setup.c */
 const char *get_cpu_subtype(struct sh_cpuinfo *c);
-extern const struct seq_operations cpuinfo_op;
 
 /* thread_struct flags */
 #define SH_THREAD_UAC_NOPRINT	(1 << 0)
diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
index d213165ee713..f7e690a7860b 100644
--- a/arch/sparc/include/asm/cpudata.h
+++ b/arch/sparc/include/asm/cpudata.h
@@ -7,8 +7,6 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 
-extern const struct seq_operations cpuinfo_op;
-
 #endif /* !(__ASSEMBLY__) */
 
 #if defined(__sparc__) && defined(__arch64__)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 6e0a3b43d027..6f22daf892ea 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -169,8 +169,6 @@ DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		boot_cpu_data
 #endif
 
-extern const struct seq_operations cpuinfo_op;
-
 #define cache_line_size()	(boot_cpu_data.x86_cache_alignment)
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 5998e1f4ff06..629b0d8302e8 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -36,6 +36,8 @@ struct seq_operations {
 	int (*show) (struct seq_file *m, void *v);
 };
 
+extern const struct seq_operations cpuinfo_op;
+
 #define SEQ_SKIP 1
 
 /**
-- 
2.23.0
