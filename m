Return-Path: <linux-kernel-owner+w=401wt.eu-S1031273AbXEKTsd@vger.kernel.org>
Message-ID: <4644C746.7050806@simon.arlott.org.uk>
Date: Fri, 11 May 2007 20:43:02 +0100
From: Simon Arlott <simon@fire.lp0.eu>
MIME-Version: 1.0
Subject: [PATCH] spelling fixes: arch/s390/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, trivial@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Spelling fixes in arch/s390/.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 arch/s390/crypto/des_s390.c |    4 ++--
 arch/s390/kernel/debug.c    |   18 +++++++++---------
 arch/s390/kernel/irq.c      |    2 +-
 arch/s390/kernel/time.c     |    6 +++---
 arch/s390/kernel/vtime.c    |    6 +++---
 arch/s390/lib/delay.c       |    2 +-
 arch/s390/math-emu/math.c   |    4 ++--
 arch/s390/mm/fault.c        |    2 +-
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/s390/crypto/des_s390.c b/arch/s390/crypto/des_s390.c
index ea22707..8b36da6 100644
--- a/arch/s390/crypto/des_s390.c
+++ b/arch/s390/crypto/des_s390.c
@@ -239,7 +239,7 @@ static struct crypto_alg cbc_des_alg = {
  *
  *   However, if the two  independent 64-bit keys are equal,
  *   then the DES3 operation is simply the same as DES.
- *   Implementers MUST reject keys that exhibit this property.
+ *   Implementors MUST reject keys that exhibit this property.
  *
  */
 static int des3_128_setkey(struct crypto_tfm *tfm, const u8 *key,
@@ -397,7 +397,7 @@ static struct crypto_alg cbc_des3_128_alg = {
  *
  *   However, if the first two or last two independent 64-bit keys are
  *   equal (k1 == k2 or k2 == k3), then the DES3 operation is simply the
- *   same as DES.  Implementers MUST reject keys that exhibit this
+ *   same as DES.  Implementors MUST reject keys that exhibit this
  *   property.
  *
  */
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index dca6eaf..f075e31 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -34,13 +34,13 @@
 
 typedef struct file_private_info {
 	loff_t offset;			/* offset of last read in file */
-	int    act_area;                /* number of last formated area */
+	int    act_area;                /* number of last formatted area */
 	int    act_page;                /* act page in given area */
-	int    act_entry;               /* last formated entry (offset */
+	int    act_entry;               /* last formatted entry (offset */
                                         /* relative to beginning of last */
-                                        /* formated page) */
+                                        /* formatted page) */
 	size_t act_entry_offset;        /* up to this offset we copied */
-					/* in last read the last formated */
+					/* in last read the last formatted */
 					/* entry to userland */
 	char   temp_buf[2048];		/* buffer for output */
 	debug_info_t *debug_info_org;   /* original debug information */
@@ -63,7 +63,7 @@ typedef struct
 
 extern void tod_to_timeval(uint64_t todval, struct timespec *xtime);
 
-/* internal function prototyes */
+/* internal function prototypes */
 
 static int debug_init(void);
 static ssize_t debug_output(struct file *file, char __user *user_buf,
@@ -442,7 +442,7 @@ debug_info_put(debug_info_t *db_info)
 
 /*
  * debug_format_entry:
- * - format one debug entry and return size of formated data
+ * - format one debug entry and return size of formatted data
  */
 
 static int
@@ -514,7 +514,7 @@ out:
 /*
  * debug_output:
  * - called for user read()
- * - copies formated debug entries to the user buffer
+ * - copies formatted debug entries to the user buffer
  */
 
 static ssize_t
@@ -591,7 +591,7 @@ debug_input(struct file *file, const char __user *user_buf, size_t length,
 /*
  * debug_open:
  * - called for user open()
- * - copies formated output to private_data area of the file
+ * - copies formatted output to private_data area of the file
  *   handle
  */
 
@@ -1461,7 +1461,7 @@ debug_dflt_header_fn(debug_info_t * id, struct debug_view *view,
 }
 
 /*
- * prints debug data sprintf-formated:
+ * prints debug data sprintf-formatted:
  * debug_sprinf_event/exception calls must be used together with this view
  */
 
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 8f0cbca..c0c87bb 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -48,7 +48,7 @@ int show_interrupts(struct seq_file *p, void *v)
 }
 
 /*
- * For compatibilty only. S/390 specific setup of interrupts et al. is done
+ * For compatibility only. S/390 specific setup of interrupts et al. is done
  * much later in init_channel_subsystem().
  */
 void __init
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 9c2872a..7d39a46 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -784,7 +784,7 @@ static void etr_sync_cpu_end(void *dummy)
 #endif /* CONFIG_SMP */
 
 /*
- * Sync the TOD clock using the port refered to by aibp. This port
+ * Sync the TOD clock using the port referred to by aibp. This port
  * has to be enabled and the other port has to be disabled. The
  * last eacr update has to be more than 1.6 seconds in the past.
  */
@@ -1046,7 +1046,7 @@ static void etr_work_fn(struct work_struct *work)
 		eacr = etr_handle_update(&aib, eacr);
 
 	/*
-	 * Select ports to enable. The prefered synchronization mode is PPS.
+	 * Select ports to enable. The preferred synchronization mode is PPS.
 	 * If a port can be enabled depends on a number of things:
 	 * 1) The port needs to be online and uptodate. A port is not
 	 *    disabled just because it is not uptodate, but it is only
@@ -1130,7 +1130,7 @@ static void etr_work_fn(struct work_struct *work)
 	/*
 	 * Update eacr and try to synchronize the clock. If the update
 	 * of eacr caused a stepping port switch (or if we have to
-	 * assume that a stepping port switch has occured) or the
+	 * assume that a stepping port switch has occurred) or the
 	 * clock syncing failed, reset the sync check control bit
 	 * and set up a timer to try again after 0.5 seconds
 	 */
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 1e1a6ee..38e55f2 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -122,7 +122,7 @@ static inline void set_vtimer(__u64 expires)
 	__u64 timer;
 
 	asm volatile ("  STPT %0\n"  /* Store current cpu timer value */
-		      "  SPT %1"     /* Set new value immediatly afterwards */
+		      "  SPT %1"     /* Set new value immediately afterwards */
 		      : "=m" (timer) : "m" (expires) );
 	S390_lowcore.system_timer += S390_lowcore.last_update_timer - timer;
 	S390_lowcore.last_update_timer = expires;
@@ -147,7 +147,7 @@ static void start_cpu_timer(void)
 
 	vt_list = &__get_cpu_var(virt_cpu_timer);
 
-	/* CPU timer interrupt is pending, don't reprogramm it */
+	/* CPU timer interrupt is pending, don't reprogram it */
 	if (vt_list->idle & 1LL<<63)
 		return;
 
@@ -171,7 +171,7 @@ static void stop_cpu_timer(void)
 	asm volatile ("STPT %0" : "=m" (vt_list->idle));
 
 	/*
-	 * If the CPU timer is negative we don't reprogramm
+	 * If the CPU timer is negative we don't reprogram
 	 * it because we will get instantly an interrupt.
 	 */
 	if (vt_list->idle & 1LL<<63)
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 70f2a86..2539751 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -20,7 +20,7 @@
 void __delay(unsigned long loops)
 {
         /*
-         * To end the bloody studid and useless discussion about the
+         * To end the bloody stupid and useless discussion about the
          * BogoMips number I took the liberty to define the __delay
          * function in a way that that resulting BogoMips number will
          * yield the megahertz number of the cpu. The important function
diff --git a/arch/s390/math-emu/math.c b/arch/s390/math-emu/math.c
index 3ee78cc..cd4e9c1 100644
--- a/arch/s390/math-emu/math.c
+++ b/arch/s390/math-emu/math.c
@@ -2088,7 +2088,7 @@ int math_emu_ldr(__u8 *opcode) {
         __u16 opc = *((__u16 *) opcode);
 
         if ((opc & 0x90) == 0) {           /* test if rx in {0,2,4,6} */
-                /* we got an exception therfore ry can't be in {0,2,4,6} */
+                /* we got an exception therefore ry can't be in {0,2,4,6} */
 		asm volatile(		/* load rx from fp_regs.fprs[ry] */
 			"	bras	1,0f\n"
 			"	ld	0,0(%1)\n"
@@ -2118,7 +2118,7 @@ int math_emu_ler(__u8 *opcode) {
         __u16 opc = *((__u16 *) opcode);
 
         if ((opc & 0x90) == 0) {           /* test if rx in {0,2,4,6} */
-                /* we got an exception therfore ry can't be in {0,2,4,6} */
+                /* we got an exception therefore ry can't be in {0,2,4,6} */
 		asm volatile(		/* load rx from fp_regs.fprs[ry] */
 			"	bras	1,0f\n"
 			"	le	0,0(%1)\n"
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index b446e1c..ed88045 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -425,7 +425,7 @@ no_context:
 void __kprobes do_protection_exception(struct pt_regs *regs,
 				       unsigned long error_code)
 {
-	/* Protection exception is supressing, decrement psw address. */
+	/* Protection exception is suppressing, decrement psw address. */
 	regs->psw.addr -= (error_code >> 16);
 	/*
 	 * Check for low-address protection.  This needs to be treated
-- 
1.5.0.1

-- 
Simon Arlott
