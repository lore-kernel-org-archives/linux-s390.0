Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jul 2015 09:22:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.2-rc3
Message-ID: <20150714092234.00d0c732@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

One improvement for the zcrypt driver, the quality attribute for the hwrng
device has been missing. Without it the kernel entropy seeding will not
happen automatically.

And six bug fixes, the most important one is the fix for the vector register
corruption due to machine checks.

Heiko Carstens (2):
      s390/process: fix sfpc inline assembly
      s390/nmi: fix vector register corruption

Ingo Tuchscherer (1):
      s390/zcrypt: enable s390 hwrng to seed kernel entropy

Martin Schwidefsky (1):
      s390/sclp: clear upper register halves in _sclp_print_early

Sebastian Ott (2):
      s390/sclp: fix compile error
      s390/oprofile: fix compile error

Stefan Haberland (1):
      s390/dasd: fix kernel panic when alias is set offline

 arch/s390/include/asm/ctl_reg.h    |  5 +++-
 arch/s390/include/asm/perf_event.h |  8 ++++++
 arch/s390/kernel/nmi.c             | 51 ++++++++++++++++++++++----------------
 arch/s390/kernel/process.c         |  2 +-
 arch/s390/kernel/sclp.S            |  4 +++
 arch/s390/oprofile/init.c          |  1 +
 drivers/s390/block/dasd.c          | 36 +++++++++++++++++++++------
 drivers/s390/block/dasd_alias.c    |  3 ++-
 drivers/s390/char/sclp_early.c     |  1 +
 drivers/s390/crypto/zcrypt_api.c   |  7 ++++++
 10 files changed, 87 insertions(+), 31 deletions(-)

diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
index cfad7fca..d7697ab 100644
--- a/arch/s390/include/asm/ctl_reg.h
+++ b/arch/s390/include/asm/ctl_reg.h
@@ -57,7 +57,10 @@ union ctlreg0 {
 		unsigned long lap  : 1; /* Low-address-protection control */
 		unsigned long	   : 4;
 		unsigned long edat : 1; /* Enhanced-DAT-enablement control */
-		unsigned long	   : 23;
+		unsigned long	   : 4;
+		unsigned long afp  : 1; /* AFP-register control */
+		unsigned long vx   : 1; /* Vector enablement control */
+		unsigned long	   : 17;
 	};
 };
 
diff --git a/arch/s390/include/asm/perf_event.h b/arch/s390/include/asm/perf_event.h
index 4cb19fe..f897ec7 100644
--- a/arch/s390/include/asm/perf_event.h
+++ b/arch/s390/include/asm/perf_event.h
@@ -87,7 +87,15 @@ struct sf_raw_sample {
 } __packed;
 
 /* Perf hardware reserve and release functions */
+#ifdef CONFIG_PERF_EVENTS
 int perf_reserve_sampling(void);
 void perf_release_sampling(void);
+#else /* CONFIG_PERF_EVENTS */
+static inline int perf_reserve_sampling(void)
+{
+	return 0;
+}
+static inline void perf_release_sampling(void) {}
+#endif /* CONFIG_PERF_EVENTS */
 
 #endif /* _ASM_S390_PERF_EVENT_H */
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 505c17c..56b5508 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -21,6 +21,7 @@
 #include <asm/nmi.h>
 #include <asm/crw.h>
 #include <asm/switch_to.h>
+#include <asm/ctl_reg.h>
 
 struct mcck_struct {
 	int kill_task;
@@ -129,26 +130,30 @@ static int notrace s390_revalidate_registers(struct mci *mci)
 	} else
 		asm volatile("lfpc 0(%0)" : : "a" (fpt_creg_save_area));
 
-	asm volatile(
-		"	ld	0,0(%0)\n"
-		"	ld	1,8(%0)\n"
-		"	ld	2,16(%0)\n"
-		"	ld	3,24(%0)\n"
-		"	ld	4,32(%0)\n"
-		"	ld	5,40(%0)\n"
-		"	ld	6,48(%0)\n"
-		"	ld	7,56(%0)\n"
-		"	ld	8,64(%0)\n"
-		"	ld	9,72(%0)\n"
-		"	ld	10,80(%0)\n"
-		"	ld	11,88(%0)\n"
-		"	ld	12,96(%0)\n"
-		"	ld	13,104(%0)\n"
-		"	ld	14,112(%0)\n"
-		"	ld	15,120(%0)\n"
-		: : "a" (fpt_save_area));
-	/* Revalidate vector registers */
-	if (MACHINE_HAS_VX && current->thread.vxrs) {
+	if (!MACHINE_HAS_VX) {
+		/* Revalidate floating point registers */
+		asm volatile(
+			"	ld	0,0(%0)\n"
+			"	ld	1,8(%0)\n"
+			"	ld	2,16(%0)\n"
+			"	ld	3,24(%0)\n"
+			"	ld	4,32(%0)\n"
+			"	ld	5,40(%0)\n"
+			"	ld	6,48(%0)\n"
+			"	ld	7,56(%0)\n"
+			"	ld	8,64(%0)\n"
+			"	ld	9,72(%0)\n"
+			"	ld	10,80(%0)\n"
+			"	ld	11,88(%0)\n"
+			"	ld	12,96(%0)\n"
+			"	ld	13,104(%0)\n"
+			"	ld	14,112(%0)\n"
+			"	ld	15,120(%0)\n"
+			: : "a" (fpt_save_area));
+	} else {
+		/* Revalidate vector registers */
+		union ctlreg0 cr0;
+
 		if (!mci->vr) {
 			/*
 			 * Vector registers can't be restored and therefore
@@ -156,8 +161,12 @@ static int notrace s390_revalidate_registers(struct mci *mci)
 			 */
 			kill_task = 1;
 		}
+		cr0.val = S390_lowcore.cregs_save_area[0];
+		cr0.afp = cr0.vx = 1;
+		__ctl_load(cr0.val, 0, 0);
 		restore_vx_regs((__vector128 *)
-				S390_lowcore.vector_save_area_addr);
+				&S390_lowcore.vector_save_area);
+		__ctl_load(S390_lowcore.cregs_save_area[0], 0, 0);
 	}
 	/* Revalidate access registers */
 	asm volatile(
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index dc5edc2..8f587d8 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -163,7 +163,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 asmlinkage void execve_tail(void)
 {
 	current->thread.fp_regs.fpc = 0;
-	asm volatile("sfpc %0,%0" : : "d" (0));
+	asm volatile("sfpc %0" : : "d" (0));
 }
 
 /*
diff --git a/arch/s390/kernel/sclp.S b/arch/s390/kernel/sclp.S
index 43c3169..ada0c07 100644
--- a/arch/s390/kernel/sclp.S
+++ b/arch/s390/kernel/sclp.S
@@ -270,6 +270,8 @@ ENTRY(_sclp_print_early)
 	jno	.Lesa2
 	ahi	%r15,-80
 	stmh	%r6,%r15,96(%r15)		# store upper register halves
+	basr	%r13,0
+	lmh	%r0,%r15,.Lzeroes-.(%r13)	# clear upper register halves
 .Lesa2:
 	lr	%r10,%r2			# save string pointer
 	lhi	%r2,0
@@ -291,6 +293,8 @@ ENTRY(_sclp_print_early)
 .Lesa3:
 	lm	%r6,%r15,120(%r15)		# restore registers
 	br	%r14
+.Lzeroes:
+	.fill	64,4,0
 
 .LwritedataS4:
 	.long	0x00760005			# SCLP command for write data
diff --git a/arch/s390/oprofile/init.c b/arch/s390/oprofile/init.c
index bc927a0..9cfa2ff 100644
--- a/arch/s390/oprofile/init.c
+++ b/arch/s390/oprofile/init.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <asm/processor.h>
+#include <asm/perf_event.h>
 
 #include "../../../drivers/oprofile/oprof.h"
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 1aec8ff..f73d2f5 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1863,6 +1863,33 @@ static void __dasd_device_check_expire(struct dasd_device *device)
 }
 
 /*
+ * return 1 when device is not eligible for IO
+ */
+static int __dasd_device_is_unusable(struct dasd_device *device,
+				     struct dasd_ccw_req *cqr)
+{
+	int mask = ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM);
+
+	if (test_bit(DASD_FLAG_OFFLINE, &device->flags)) {
+		/* dasd is being set offline. */
+		return 1;
+	}
+	if (device->stopped) {
+		if (device->stopped & mask) {
+			/* stopped and CQR will not change that. */
+			return 1;
+		}
+		if (!test_bit(DASD_CQR_VERIFY_PATH, &cqr->flags)) {
+			/* CQR is not able to change device to
+			 * operational. */
+			return 1;
+		}
+		/* CQR required to get device operational. */
+	}
+	return 0;
+}
+
+/*
  * Take a look at the first request on the ccw queue and check
  * if it needs to be started.
  */
@@ -1876,13 +1903,8 @@ static void __dasd_device_start_head(struct dasd_device *device)
 	cqr = list_entry(device->ccw_queue.next, struct dasd_ccw_req, devlist);
 	if (cqr->status != DASD_CQR_QUEUED)
 		return;
-	/* when device is stopped, return request to previous layer
-	 * exception: only the disconnect or unresumed bits are set and the
-	 * cqr is a path verification request
-	 */
-	if (device->stopped &&
-	    !(!(device->stopped & ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM))
-	      && test_bit(DASD_CQR_VERIFY_PATH, &cqr->flags))) {
+	/* if device is not usable return request to upper layer */
+	if (__dasd_device_is_unusable(device, cqr)) {
 		cqr->intrc = -EAGAIN;
 		cqr->status = DASD_CQR_CLEARED;
 		dasd_schedule_device_bh(device);
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index a2597e6..ee3a6fa 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -699,7 +699,8 @@ struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *base_device)
 					       struct dasd_device, alias_list);
 	spin_unlock_irqrestore(&lcu->lock, flags);
 	alias_priv = (struct dasd_eckd_private *) alias_device->private;
-	if ((alias_priv->count < private->count) && !alias_device->stopped)
+	if ((alias_priv->count < private->count) && !alias_device->stopped &&
+	    !test_bit(DASD_FLAG_OFFLINE, &alias_device->flags))
 		return alias_device;
 	else
 		return NULL;
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index aeed796..7bc6df3 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -7,6 +7,7 @@
 #define KMSG_COMPONENT "sclp_early"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/errno.h>
 #include <asm/ctl_reg.h>
 #include <asm/sclp.h>
 #include <asm/ipl.h>
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 08f1830..01bf1f5 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -54,6 +54,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
 		   "Copyright IBM Corp. 2001, 2012");
 MODULE_LICENSE("GPL");
 
+static int zcrypt_hwrng_seed = 1;
+module_param_named(hwrng_seed, zcrypt_hwrng_seed, int, S_IRUSR|S_IRGRP);
+MODULE_PARM_DESC(hwrng_seed, "Turn on/off hwrng auto seed, default is 1 (on).");
+
 static DEFINE_SPINLOCK(zcrypt_device_lock);
 static LIST_HEAD(zcrypt_device_list);
 static int zcrypt_device_count = 0;
@@ -1373,6 +1377,7 @@ static int zcrypt_rng_data_read(struct hwrng *rng, u32 *data)
 static struct hwrng zcrypt_rng_dev = {
 	.name		= "zcrypt",
 	.data_read	= zcrypt_rng_data_read,
+	.quality	= 990,
 };
 
 static int zcrypt_rng_device_add(void)
@@ -1387,6 +1392,8 @@ static int zcrypt_rng_device_add(void)
 			goto out;
 		}
 		zcrypt_rng_buffer_index = 0;
+		if (!zcrypt_hwrng_seed)
+			zcrypt_rng_dev.quality = 0;
 		rc = hwrng_register(&zcrypt_rng_dev);
 		if (rc)
 			goto out_free;
