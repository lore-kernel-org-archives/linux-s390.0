Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stephen Kitt <steve@sk2.org>
Subject: [PATCH] s390: remove obsolete ieee_emulation_warnings
Date: Fri, 14 Feb 2020 18:26:28 +0100
Message-Id: <20200214172628.3598516-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>

s390 math emulation was removed with commit 5a79859ae0f3 ("s390:
remove 31 bit support"), rendering ieee_emulation_warnings useless.
The code still built because it was protected by CONFIG_MATHEMU, which
was no longer selectable.

This patch removes the sysctl_ieee_emulation_warnings declaration and
the sysctl entry declaration.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 arch/s390/include/asm/processor.h | 1 -
 kernel/sysctl.c                   | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 361ef5eda468..aadb3d0e2adc 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -84,7 +84,6 @@ void s390_update_cpu_mhz(void);
 void cpu_detect_mhz_feature(void);
 
 extern const struct seq_operations cpuinfo_op;
-extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
 extern void __bpon(void);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index d396aaaf19a3..ad5b88a53c5a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -805,15 +805,6 @@ static struct ctl_table kern_table[] = {
 		.extra2		= &maxolduid,
 	},
 #ifdef CONFIG_S390
-#ifdef CONFIG_MATHEMU
-	{
-		.procname	= "ieee_emulation_warnings",
-		.data		= &sysctl_ieee_emulation_warnings,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-#endif
 	{
 		.procname	= "userprocess_debug",
 		.data		= &show_unhandled_signals,

base-commit: 359c92c02bfae1a6f1e8e37c298e518fd256642c
-- 
2.24.1
