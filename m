Return-Path: <linux-kernel-owner+w=401wt.eu-S1756310AbZHNLcu@vger.kernel.org>
Message-Id: <20090814112618.906049273@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:44 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/34] kernel: always keep machine flags in lowcore
Content-Disposition: inline; filename=126-machine-flags.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Eleminate the local variable machine_flags and always change machine
flags directly in the lowcore.
This avoids confusion about when and why the two variables have to be
synchronized.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -35,8 +35,6 @@
 
 char kernel_nss_name[NSS_NAME_SIZE + 1];
 
-static unsigned long machine_flags;
-
 static void __init setup_boot_command_line(void);
 
 /*
@@ -206,12 +204,9 @@ static noinline __init void detect_machi
 
 	/* Running under KVM? If not we assume z/VM */
 	if (!memcmp(vmms.vm[0].cpi, "\xd2\xe5\xd4", 3))
-		machine_flags |= MACHINE_FLAG_KVM;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_KVM;
 	else
-		machine_flags |= MACHINE_FLAG_VM;
-
-	/* Store machine flags for setting up lowcore early */
-	S390_lowcore.machine_flags = machine_flags;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_VM;
 }
 
 static __init void early_pgm_check_handler(void)
@@ -246,7 +241,7 @@ static noinline __init void setup_hpage(
 	facilities = stfl();
 	if (!(facilities & (1UL << 23)) || !(facilities & (1UL << 29)))
 		return;
-	machine_flags |= MACHINE_FLAG_HPAGE;
+	S390_lowcore.machine_flags |= MACHINE_FLAG_HPAGE;
 	__ctl_set_bit(0, 23);
 #endif
 }
@@ -264,7 +259,7 @@ static __init void detect_mvpg(void)
 		EX_TABLE(0b,1b)
 		: "=d" (rc) : "0" (-EOPNOTSUPP), "a" (0) : "memory", "cc", "0");
 	if (!rc)
-		machine_flags |= MACHINE_FLAG_MVPG;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_MVPG;
 #endif
 }
 
@@ -280,7 +275,7 @@ static __init void detect_ieee(void)
 		EX_TABLE(0b,1b)
 		: "=d" (rc), "=d" (tmp): "0" (-EOPNOTSUPP) : "cc");
 	if (!rc)
-		machine_flags |= MACHINE_FLAG_IEEE;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_IEEE;
 #endif
 }
 
@@ -299,7 +294,7 @@ static __init void detect_csp(void)
 		EX_TABLE(0b,1b)
 		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc", "0", "1", "2");
 	if (!rc)
-		machine_flags |= MACHINE_FLAG_CSP;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_CSP;
 #endif
 }
 
@@ -316,7 +311,7 @@ static __init void detect_diag9c(void)
 		EX_TABLE(0b,1b)
 		: "=d" (rc) : "0" (-EOPNOTSUPP), "d" (cpu_address) : "cc");
 	if (!rc)
-		machine_flags |= MACHINE_FLAG_DIAG9C;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_DIAG9C;
 }
 
 static __init void detect_diag44(void)
@@ -331,7 +326,7 @@ static __init void detect_diag44(void)
 		EX_TABLE(0b,1b)
 		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc");
 	if (!rc)
-		machine_flags |= MACHINE_FLAG_DIAG44;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_DIAG44;
 #endif
 }
 
@@ -342,11 +337,11 @@ static __init void detect_machine_facili
 
 	facilities = stfl();
 	if (facilities & (1 << 28))
-		machine_flags |= MACHINE_FLAG_IDTE;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_IDTE;
 	if (facilities & (1 << 23))
-		machine_flags |= MACHINE_FLAG_PFMF;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_PFMF;
 	if (facilities & (1 << 4))
-		machine_flags |= MACHINE_FLAG_MVCOS;
+		S390_lowcore.machine_flags |= MACHINE_FLAG_MVCOS;
 #endif
 }
 
@@ -428,7 +423,6 @@ void __init startup_init(void)
 	setup_hpage();
 	sclp_facilities_detect();
 	detect_memory_layout(memory_chunk);
-	S390_lowcore.machine_flags = machine_flags;
 #ifdef CONFIG_DYNAMIC_FTRACE
 	S390_lowcore.ftrace_func = (unsigned long)ftrace_caller;
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
