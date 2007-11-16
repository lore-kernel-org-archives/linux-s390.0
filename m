Return-Path: <linux-kernel-owner+w=401wt.eu-S934099AbXKPOej@vger.kernel.org>
Message-Id: <20071116143321.502691250@de.ibm.com>
References: <20071116142942.978412023@de.ibm.com>
Date: Fri, 16 Nov 2007 15:29:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] sclp: call sclp_init() from start_kernel().
Content-Disposition: inline; filename=102-sclp-init.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This is needed since the sclp must be initialized before cpus are
brought online and after interrupts are enabled. The sclp interface
is used figure out which cpus are present and can be brought online.
Adding an sclp_init() call to __cpu_up() is not a valid option.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp.c |   12 ++----------
 init/main.c              |    6 ++++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/sclp.c linux-2.6-patched/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	2007-11-16 14:27:32.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/sclp.c	2007-11-16 14:27:47.000000000 +0100
@@ -95,7 +95,7 @@ static volatile enum sclp_mask_state_t {
 static void sclp_process_queue(void);
 static void __sclp_make_read_req(void);
 static int sclp_init_mask(int calculate);
-static int sclp_init(void);
+int sclp_init(void);
 
 /* Perform service call. Return 0 on success, non-zero otherwise. */
 int
@@ -877,8 +877,7 @@ static struct notifier_block sclp_reboot
 
 /* Initialize SCLP driver. Return zero if driver is operational, non-zero
  * otherwise. */
-static int
-sclp_init(void)
+int sclp_init(void)
 {
 	unsigned long flags;
 	int rc;
@@ -930,10 +929,3 @@ sclp_init(void)
 	sclp_init_mask(1);
 	return 0;
 }
-
-static __init int sclp_initcall(void)
-{
-	return sclp_init();
-}
-
-arch_initcall(sclp_initcall);
diff -urpN linux-2.6/init/main.c linux-2.6-patched/init/main.c
--- linux-2.6/init/main.c	2007-11-16 14:27:35.000000000 +0100
+++ linux-2.6-patched/init/main.c	2007-11-16 14:27:47.000000000 +0100
@@ -94,6 +94,11 @@ extern void acpi_early_init(void);
 #else
 static inline void acpi_early_init(void) { }
 #endif
+#ifdef CONFIG_S390
+extern int sclp_init(void);
+#else
+static inline int sclp_init(void) {return 0;}
+#endif
 #ifndef CONFIG_DEBUG_RODATA
 static inline void mark_rodata_ro(void) { }
 #endif
@@ -643,6 +648,7 @@ asmlinkage void __init start_kernel(void
 	check_bugs();
 
 	acpi_early_init(); /* before LAPIC and SMP init */
+	sclp_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
