Return-Path: <linux-kernel-owner+w=401wt.eu-S1752638AbZLRQvG@vger.kernel.org>
Date: Fri, 18 Dec 2009 17:51:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33-rc1
Message-ID: <20091218175109.42132c66@mschwide.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,
take two, forgot to add the usual Cc: list. Linus: sorry for the duplicate.

Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Heiko Carstens (2):
      [S390] wire up sys_recvmmsg
      [S390] Use strim instead of strstrip to avoid false warnings.

Jan Glauber (2):
      [S390] qdio: remove superfluous log entries and WARN_ONs.
      [S390] qdio: add counter for input queue full condition

Julia Lawall (1):
      [S390] drivers: Correct size given to memset

Martin Schwidefsky (1):
      [S390] rename NT_PRXSTATUS to NT_S390_HIGHREGS

Michael Holzheu (1):
      [S390] tape: Add pr_fmt() macro to all tape source files

Oleg Nesterov (1):
      [S390] ptrace: dont abuse PT_PTRACED

Peter Oberparleiter (1):
      [S390] cio: fix channel path vary

Roel Kluin (3):
      [S390] dasd: PTR_ERR return of wrong pointer in
      [S390] s390: PTR_ERR return of wrong pointer in fallback_init_cip()
      [S390] tty: PTR_ERR return of wrong pointer in fs3270_open()

Sebastian Ott (1):
      [S390] cio: fix drvdata usage for the console subchannel

Stefan Haberland (1):
      [S390] dasd: move dasd-diag kmsg to dasd

 arch/s390/crypto/aes_s390.c       |    2 +-
 arch/s390/hypfs/hypfs_diag.c      |    4 +-
 arch/s390/hypfs/hypfs_vm.c        |    2 +-
 arch/s390/include/asm/unistd.h    |    3 +-
 arch/s390/kernel/compat_wrapper.S |    9 ++++++++
 arch/s390/kernel/ipl.c            |    6 ++--
 arch/s390/kernel/ptrace.c         |    2 +-
 arch/s390/kernel/syscalls.S       |    1 +
 arch/s390/kernel/traps.c          |    6 ++--
 drivers/s390/block/dasd_alias.c   |    2 +-
 drivers/s390/block/dasd_diag.c    |   42 +++++++++++++++++++-----------------
 drivers/s390/char/fs3270.c        |    2 +-
 drivers/s390/char/tape_34xx.c     |    1 +
 drivers/s390/char/tape_3590.c     |    3 +-
 drivers/s390/char/tape_block.c    |    1 +
 drivers/s390/char/tape_char.c     |    3 ++
 drivers/s390/char/tape_class.c    |    4 +++
 drivers/s390/char/tape_core.c     |    2 +
 drivers/s390/char/tape_proc.c     |    3 ++
 drivers/s390/char/tape_std.c      |    3 ++
 drivers/s390/cio/ccwreq.c         |    3 --
 drivers/s390/cio/device.c         |    1 +
 drivers/s390/cio/device_pgid.c    |   29 +++++++++++++++---------
 drivers/s390/cio/fcx.c            |    4 +-
 drivers/s390/cio/io_sch.h         |    1 +
 drivers/s390/cio/qdio_main.c      |    3 +-
 drivers/s390/cio/qdio_perf.c      |    2 +
 drivers/s390/cio/qdio_perf.h      |    1 +
 drivers/s390/cio/qdio_setup.c     |   10 +--------
 include/linux/elf.h               |    2 +-
 30 files changed, 95 insertions(+), 62 deletions(-)

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 6118890..6be4503 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -174,7 +174,7 @@ static int fallback_init_cip(struct crypto_tfm *tfm)
 	if (IS_ERR(sctx->fallback.cip)) {
 		pr_err("Allocating AES fallback algorithm %s failed\n",
 		       name);
-		return PTR_ERR(sctx->fallback.blk);
+		return PTR_ERR(sctx->fallback.cip);
 	}
 
 	return 0;
diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index 77df726..2b92d50 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -164,7 +164,7 @@ static inline void part_hdr__part_name(enum diag204_format type, void *hdr,
 		       LPAR_NAME_LEN);
 	EBCASC(name, LPAR_NAME_LEN);
 	name[LPAR_NAME_LEN] = 0;
-	strstrip(name);
+	strim(name);
 }
 
 struct cpu_info {
@@ -523,7 +523,7 @@ static int diag224_idx2name(int index, char *name)
 	memcpy(name, diag224_cpu_names + ((index + 1) * CPU_NAME_LEN),
 		CPU_NAME_LEN);
 	name[CPU_NAME_LEN] = 0;
-	strstrip(name);
+	strim(name);
 	return 0;
 }
 
diff --git a/arch/s390/hypfs/hypfs_vm.c b/arch/s390/hypfs/hypfs_vm.c
index d01fc8f..f0b0d31 100644
--- a/arch/s390/hypfs/hypfs_vm.c
+++ b/arch/s390/hypfs/hypfs_vm.c
@@ -124,7 +124,7 @@ static int hpyfs_vm_create_guest(struct super_block *sb,
 	/* guest dir */
 	memcpy(guest_name, data->guest_name, NAME_LEN);
 	EBCASC(guest_name, NAME_LEN);
-	strstrip(guest_name);
+	strim(guest_name);
 	guest_dir = hypfs_mkdir(sb, systems_dir, guest_name);
 	if (IS_ERR(guest_dir))
 		return PTR_ERR(guest_dir);
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index cb5232d..192a720 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -269,7 +269,8 @@
 #define	__NR_pwritev		329
 #define __NR_rt_tgsigqueueinfo	330
 #define __NR_perf_event_open	331
-#define NR_syscalls 332
+#define __NR_recvmmsg		332
+#define NR_syscalls 333
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 30de2d0..faeaccc 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1853,3 +1853,12 @@ sys32_execve_wrapper:
 	llgtr	%r3,%r3			# compat_uptr_t *
 	llgtr	%r4,%r4			# compat_uptr_t *
 	jg	sys32_execve		# branch to system call
+
+	.globl	compat_sys_recvmmsg_wrapper
+compat_sys_recvmmsg_wrapper:
+	lgfr	%r2,%r2			# int
+	llgtr	%r3,%r3			# struct compat_mmsghdr *
+	llgfr	%r4,%r4			# unsigned int
+	llgfr	%r5,%r5			# unsigned int
+	llgtr	%r6,%r6			# struct compat_timespec *
+	jg	compat_sys_recvmmsg
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 4890ac6..4d73296 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -221,7 +221,7 @@ static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
 		const char *buf, size_t len)				\
 {									\
 	strncpy(_value, buf, sizeof(_value) - 1);			\
-	strstrip(_value);						\
+	strim(_value);							\
 	return len;							\
 }									\
 static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
@@ -472,7 +472,7 @@ static ssize_t ipl_ccw_loadparm_show(struct kobject *kobj,
 		return sprintf(page, "#unknown#\n");
 	memcpy(loadparm, &sclp_ipl_info.loadparm, LOADPARM_LEN);
 	EBCASC(loadparm, LOADPARM_LEN);
-	strstrip(loadparm);
+	strim(loadparm);
 	return sprintf(page, "%s\n", loadparm);
 }
 
@@ -776,7 +776,7 @@ static void reipl_get_ascii_loadparm(char *loadparm,
 	memcpy(loadparm, ibp->ipl_info.ccw.load_parm, LOADPARM_LEN);
 	EBCASC(loadparm, LOADPARM_LEN);
 	loadparm[LOADPARM_LEN] = 0;
-	strstrip(loadparm);
+	strim(loadparm);
 }
 
 static ssize_t reipl_generic_loadparm_show(struct ipl_parameter_block *ipb,
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 653c6a1..13815d3 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -959,7 +959,7 @@ static const struct user_regset s390_compat_regsets[] = {
 		.set = s390_fpregs_set,
 	},
 	[REGSET_GENERAL_EXTENDED] = {
-		.core_note_type = NT_PRXSTATUS,
+		.core_note_type = NT_S390_HIGH_GPRS,
 		.n = sizeof(s390_compat_regs_high) / sizeof(compat_long_t),
 		.size = sizeof(compat_long_t),
 		.align = sizeof(compat_long_t),
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 30eca07..4f292c9 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -340,3 +340,4 @@ SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
 SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)
 SYSCALL(sys_rt_tgsigqueueinfo,sys_rt_tgsigqueueinfo,compat_sys_rt_tgsigqueueinfo_wrapper) /* 330 */
 SYSCALL(sys_perf_event_open,sys_perf_event_open,sys_perf_event_open_wrapper)
+SYSCALL(sys_recvmmsg,sys_recvmmsg,compat_sys_recvmmsg_wrapper)
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index c2e42cc..6e7ad63 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -18,7 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
-#include <linux/ptrace.h>
+#include <linux/tracehook.h>
 #include <linux/timer.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
@@ -382,7 +382,7 @@ void __kprobes do_single_step(struct pt_regs *regs)
 					SIGTRAP) == NOTIFY_STOP){
 		return;
 	}
-	if ((current->ptrace & PT_PTRACED) != 0)
+	if (tracehook_consider_fatal_signal(current, SIGTRAP))
 		force_sig(SIGTRAP, current);
 }
 
@@ -483,7 +483,7 @@ static void illegal_op(struct pt_regs * regs, long interruption_code)
 		if (get_user(*((__u16 *) opcode), (__u16 __user *) location))
 			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
-			if (current->ptrace & PT_PTRACED)
+			if (tracehook_consider_fatal_signal(current, SIGTRAP))
 				force_sig(SIGTRAP, current);
 			else
 				signal = SIGILL;
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index fd12317..148b1dd 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -218,7 +218,7 @@ int dasd_alias_make_device_known_to_lcu(struct dasd_device *device)
 		spin_unlock_irqrestore(&aliastree.lock, flags);
 		newlcu = _allocate_lcu(uid);
 		if (IS_ERR(newlcu))
-			return PTR_ERR(lcu);
+			return PTR_ERR(newlcu);
 		spin_lock_irqsave(&aliastree.lock, flags);
 		lcu = _find_lcu(server, uid);
 		if (!lcu) {
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index f64d0db..6e14863 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -8,7 +8,7 @@
  *
  */
 
-#define KMSG_COMPONENT "dasd-diag"
+#define KMSG_COMPONENT "dasd"
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
@@ -146,16 +146,16 @@ dasd_diag_erp(struct dasd_device *device)
 	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
 	if (rc == 4) {
 		if (!(device->features & DASD_FEATURE_READONLY)) {
-			dev_warn(&device->cdev->dev,
-				 "The access mode of a DIAG device changed"
-				 " to read-only");
+			pr_warning("%s: The access mode of a DIAG device "
+				   "changed to read-only\n",
+				   dev_name(&device->cdev->dev));
 			device->features |= DASD_FEATURE_READONLY;
 		}
 		rc = 0;
 	}
 	if (rc)
-		dev_warn(&device->cdev->dev, "DIAG ERP failed with "
-			    "rc=%d\n", rc);
+		pr_warning("%s: DIAG ERP failed with "
+			    "rc=%d\n", dev_name(&device->cdev->dev), rc);
 }
 
 /* Start a given request at the device. Return zero on success, non-zero
@@ -371,8 +371,9 @@ dasd_diag_check_device(struct dasd_device *device)
 		private->pt_block = 2;
 		break;
 	default:
-		dev_warn(&device->cdev->dev, "Device type %d is not supported "
-			    "in DIAG mode\n", private->rdc_data.vdev_class);
+		pr_warning("%s: Device type %d is not supported "
+			   "in DIAG mode\n", dev_name(&device->cdev->dev),
+			   private->rdc_data.vdev_class);
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
@@ -413,8 +414,8 @@ dasd_diag_check_device(struct dasd_device *device)
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
 		if (rc == 3) {
-			dev_warn(&device->cdev->dev,
-				"A 64-bit DIAG call failed\n");
+			pr_warning("%s: A 64-bit DIAG call failed\n",
+				   dev_name(&device->cdev->dev));
 			rc = -EOPNOTSUPP;
 			goto out_label;
 		}
@@ -423,8 +424,9 @@ dasd_diag_check_device(struct dasd_device *device)
 			break;
 	}
 	if (bsize > PAGE_SIZE) {
-		dev_warn(&device->cdev->dev, "Accessing the DASD failed because"
-			 " of an incorrect format (rc=%d)\n", rc);
+		pr_warning("%s: Accessing the DASD failed because of an "
+			   "incorrect format (rc=%d)\n",
+			   dev_name(&device->cdev->dev), rc);
 		rc = -EIO;
 		goto out_label;
 	}
@@ -442,18 +444,18 @@ dasd_diag_check_device(struct dasd_device *device)
 		block->s2b_shift++;
 	rc = mdsk_init_io(device, block->bp_block, 0, NULL);
 	if (rc && (rc != 4)) {
-		dev_warn(&device->cdev->dev, "DIAG initialization "
-			"failed with rc=%d\n", rc);
+		pr_warning("%s: DIAG initialization failed with rc=%d\n",
+			   dev_name(&device->cdev->dev), rc);
 		rc = -EIO;
 	} else {
 		if (rc == 4)
 			device->features |= DASD_FEATURE_READONLY;
-		dev_info(&device->cdev->dev,
-			 "New DASD with %ld byte/block, total size %ld KB%s\n",
-			 (unsigned long) block->bp_block,
-			 (unsigned long) (block->blocks <<
-					  block->s2b_shift) >> 1,
-			 (rc == 4) ? ", read-only device" : "");
+		pr_info("%s: New DASD with %ld byte/block, total size %ld "
+			"KB%s\n", dev_name(&device->cdev->dev),
+			(unsigned long) block->bp_block,
+			(unsigned long) (block->blocks <<
+					 block->s2b_shift) >> 1,
+			(rc == 4) ? ", read-only device" : "");
 		rc = 0;
 	}
 out_label:
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 28e4649..247b2b9 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -467,7 +467,7 @@ fs3270_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(ib)) {
 		raw3270_put_view(&fp->view);
 		raw3270_del_view(&fp->view);
-		rc = PTR_ERR(fp);
+		rc = PTR_ERR(ib);
 		goto out;
 	}
 	fp->rdbuf = ib;
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 3657fe1..cb70fa1 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -9,6 +9,7 @@
  */
 
 #define KMSG_COMPONENT "tape_34xx"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 0c72aad..9821c58 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -9,6 +9,7 @@
  */
 
 #define KMSG_COMPONENT "tape_3590"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -136,7 +137,7 @@ static void int_to_ext_kekl(struct tape3592_kekl *in,
 		out->type_on_tape = TAPE390_KEKL_TYPE_LABEL;
 	memcpy(out->label, in->label, sizeof(in->label));
 	EBCASC(out->label, sizeof(in->label));
-	strstrip(out->label);
+	strim(out->label);
 }
 
 static void int_to_ext_kekl_pair(struct tape3592_kekl_pair *in,
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 4799cc2..9681614 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -11,6 +11,7 @@
  */
 
 #define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/fs.h>
 #include <linux/module.h>
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index 23d773a..2125ec7 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -10,6 +10,9 @@
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index ddc914c..b2864e3 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -7,6 +7,10 @@
  * Author: Stefan Bader <shbader@de.ibm.com>
  * Based on simple class device code by Greg K-H
  */
+
+#define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include "tape_class.h"
 
 MODULE_AUTHOR("Stefan Bader <shbader@de.ibm.com>");
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index f5d6802..81b094e 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -12,6 +12,8 @@
  */
 
 #define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>	     // for kernel parameters
 #include <linux/kmod.h>	     // for requesting modules
diff --git a/drivers/s390/char/tape_proc.c b/drivers/s390/char/tape_proc.c
index ebd820c..0ceb379 100644
--- a/drivers/s390/char/tape_proc.c
+++ b/drivers/s390/char/tape_proc.c
@@ -11,6 +11,9 @@
  * PROCFS Functions
  */
 
+#define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/seq_file.h>
diff --git a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
index 750354a..03f07e5 100644
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -11,6 +11,9 @@
  *		 Stefan Bader <shbader@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "tape"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
diff --git a/drivers/s390/cio/ccwreq.c b/drivers/s390/cio/ccwreq.c
index 9509e38..7a28a30 100644
--- a/drivers/s390/cio/ccwreq.c
+++ b/drivers/s390/cio/ccwreq.c
@@ -49,7 +49,6 @@ static u16 ccwreq_next_path(struct ccw_device *cdev)
  */
 static void ccwreq_stop(struct ccw_device *cdev, int rc)
 {
-	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct ccw_request *req = &cdev->private->req;
 
 	if (req->done)
@@ -57,7 +56,6 @@ static void ccwreq_stop(struct ccw_device *cdev, int rc)
 	req->done = 1;
 	ccw_device_set_timeout(cdev, 0);
 	memset(&cdev->private->irb, 0, sizeof(struct irb));
-	sch->lpm = sch->schib.pmcw.pam;
 	if (rc && rc != -ENODEV && req->drc)
 		rc = req->drc;
 	req->callback(cdev, req->data, rc);
@@ -80,7 +78,6 @@ static void ccwreq_do(struct ccw_device *cdev)
 			continue;
 		}
 		/* Perform start function. */
-		sch->lpm = 0xff;
 		memset(&cdev->private->irb, 0, sizeof(struct irb));
 		rc = cio_start(sch, cp, (u8) req->mask);
 		if (rc == 0) {
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 73901c9..a6c7d54 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1519,6 +1519,7 @@ static int ccw_device_console_enable(struct ccw_device *cdev,
 	sch->driver = &io_subchannel_driver;
 	/* Initialize the ccw_device structure. */
 	cdev->dev.parent= &sch->dev;
+	sch_set_cdev(sch, cdev);
 	io_subchannel_recog(cdev, sch);
 	/* Now wait for the async. recognition to come to an end. */
 	spin_lock_irq(cdev->ccwlock);
diff --git a/drivers/s390/cio/device_pgid.c b/drivers/s390/cio/device_pgid.c
index aad188e..6facb54 100644
--- a/drivers/s390/cio/device_pgid.c
+++ b/drivers/s390/cio/device_pgid.c
@@ -142,7 +142,7 @@ static void spid_do(struct ccw_device *cdev)
 	u8 fn;
 
 	/* Use next available path that is not already in correct state. */
-	req->lpm = lpm_adjust(req->lpm, sch->schib.pmcw.pam & ~sch->vpm);
+	req->lpm = lpm_adjust(req->lpm, cdev->private->pgid_todo_mask);
 	if (!req->lpm)
 		goto out_nopath;
 	/* Channel program setup. */
@@ -254,15 +254,15 @@ static void pgid_analyze(struct ccw_device *cdev, struct pgid **p,
 	*p = first;
 }
 
-static u8 pgid_to_vpm(struct ccw_device *cdev)
+static u8 pgid_to_donepm(struct ccw_device *cdev)
 {
 	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	struct pgid *pgid;
 	int i;
 	int lpm;
-	u8 vpm = 0;
+	u8 donepm = 0;
 
-	/* Set VPM bits for paths which are already in the target state. */
+	/* Set bits for paths which are already in the target state. */
 	for (i = 0; i < 8; i++) {
 		lpm = 0x80 >> i;
 		if ((cdev->private->pgid_valid_mask & lpm) == 0)
@@ -282,10 +282,10 @@ static u8 pgid_to_vpm(struct ccw_device *cdev)
 			if (pgid->inf.ps.state3 != SNID_STATE3_SINGLE_PATH)
 				continue;
 		}
-		vpm |= lpm;
+		donepm |= lpm;
 	}
 
-	return vpm;
+	return donepm;
 }
 
 static void pgid_fill(struct ccw_device *cdev, struct pgid *pgid)
@@ -307,6 +307,7 @@ static void snid_done(struct ccw_device *cdev, int rc)
 	int mismatch = 0;
 	int reserved = 0;
 	int reset = 0;
+	u8 donepm;
 
 	if (rc)
 		goto out;
@@ -316,18 +317,20 @@ static void snid_done(struct ccw_device *cdev, int rc)
 	else if (mismatch)
 		rc = -EOPNOTSUPP;
 	else {
-		sch->vpm = pgid_to_vpm(cdev);
+		donepm = pgid_to_donepm(cdev);
+		sch->vpm = donepm & sch->opm;
+		cdev->private->pgid_todo_mask &= ~donepm;
 		pgid_fill(cdev, pgid);
 	}
 out:
 	CIO_MSG_EVENT(2, "snid: device 0.%x.%04x: rc=%d pvm=%02x vpm=%02x "
-		      "mism=%d rsvd=%d reset=%d\n", id->ssid, id->devno, rc,
-		      cdev->private->pgid_valid_mask, sch->vpm, mismatch,
-		      reserved, reset);
+		      "todo=%02x mism=%d rsvd=%d reset=%d\n", id->ssid,
+		      id->devno, rc, cdev->private->pgid_valid_mask, sch->vpm,
+		      cdev->private->pgid_todo_mask, mismatch, reserved, reset);
 	switch (rc) {
 	case 0:
 		/* Anything left to do? */
-		if (sch->vpm == sch->schib.pmcw.pam) {
+		if (cdev->private->pgid_todo_mask == 0) {
 			verify_done(cdev, sch->vpm == 0 ? -EACCES : 0);
 			return;
 		}
@@ -411,6 +414,7 @@ static void verify_start(struct ccw_device *cdev)
 	struct ccw_dev_id *devid = &cdev->private->dev_id;
 
 	sch->vpm = 0;
+	sch->lpm = sch->schib.pmcw.pam;
 	/* Initialize request data. */
 	memset(req, 0, sizeof(*req));
 	req->timeout	= PGID_TIMEOUT;
@@ -442,11 +446,14 @@ static void verify_start(struct ccw_device *cdev)
  */
 void ccw_device_verify_start(struct ccw_device *cdev)
 {
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
+
 	CIO_TRACE_EVENT(4, "vrfy");
 	CIO_HEX_EVENT(4, &cdev->private->dev_id, sizeof(cdev->private->dev_id));
 	/* Initialize PGID data. */
 	memset(cdev->private->pgid, 0, sizeof(cdev->private->pgid));
 	cdev->private->pgid_valid_mask = 0;
+	cdev->private->pgid_todo_mask = sch->schib.pmcw.pam;
 	/*
 	 * Initialize pathgroup and multipath state with target values.
 	 * They may change in the course of path verification.
diff --git a/drivers/s390/cio/fcx.c b/drivers/s390/cio/fcx.c
index 61677df..ca5e9bb 100644
--- a/drivers/s390/cio/fcx.c
+++ b/drivers/s390/cio/fcx.c
@@ -163,7 +163,7 @@ void tcw_finalize(struct tcw *tcw, int num_tidaws)
 	/* Add tcat to tccb. */
 	tccb = tcw_get_tccb(tcw);
 	tcat = (struct tccb_tcat *) &tccb->tca[tca_size(tccb)];
-	memset(tcat, 0, sizeof(tcat));
+	memset(tcat, 0, sizeof(*tcat));
 	/* Calculate tcw input/output count and tcat transport count. */
 	count = calc_dcw_count(tccb);
 	if (tcw->w && (tcw->flags & TCW_FLAGS_OUTPUT_TIDA))
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(tccb_init);
  */
 void tsb_init(struct tsb *tsb)
 {
-	memset(tsb, 0, sizeof(tsb));
+	memset(tsb, 0, sizeof(*tsb));
 }
 EXPORT_SYMBOL(tsb_init);
 
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index d72ae4c..b9ce712 100644
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -150,6 +150,7 @@ struct ccw_device_private {
 	struct ccw_request req;		/* internal I/O request */
 	int iretry;
 	u8 pgid_valid_mask;		/* mask of valid PGIDs */
+	u8 pgid_todo_mask;		/* mask of PGIDs to be adjusted */
 	struct {
 		unsigned int fast:1;	/* post with "channel end" */
 		unsigned int repall:1;	/* report every interrupt status */
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 4be6e84..b2275c5 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -486,7 +486,8 @@ static int get_inbound_buffer_frontier(struct qdio_q *q)
 	case SLSB_P_INPUT_PRIMED:
 		inbound_primed(q, count);
 		q->first_to_check = add_buf(q->first_to_check, count);
-		atomic_sub(count, &q->nr_buf_used);
+		if (atomic_sub(count, &q->nr_buf_used) == 0)
+			qdio_perf_stat_inc(&perf_stats.inbound_queue_full);
 		break;
 	case SLSB_P_INPUT_ERROR:
 		announce_buffer_error(q, count);
diff --git a/drivers/s390/cio/qdio_perf.c b/drivers/s390/cio/qdio_perf.c
index 968e3c7..54f7c32 100644
--- a/drivers/s390/cio/qdio_perf.c
+++ b/drivers/s390/cio/qdio_perf.c
@@ -64,6 +64,8 @@ static int qdio_perf_proc_show(struct seq_file *m, void *v)
 		   (long)atomic_long_read(&perf_stats.fast_requeue));
 	seq_printf(m, "Number of outbound target full condition\t: %li\n",
 		   (long)atomic_long_read(&perf_stats.outbound_target_full));
+	seq_printf(m, "Number of inbound queue full condition\t\t: %li\n",
+		   (long)atomic_long_read(&perf_stats.inbound_queue_full));
 	seq_printf(m, "Number of outbound tasklet mod_timer calls\t: %li\n",
 		   (long)atomic_long_read(&perf_stats.debug_tl_out_timer));
 	seq_printf(m, "Number of stop polling calls\t\t\t: %li\n",
diff --git a/drivers/s390/cio/qdio_perf.h b/drivers/s390/cio/qdio_perf.h
index ff4504c..1245423 100644
--- a/drivers/s390/cio/qdio_perf.h
+++ b/drivers/s390/cio/qdio_perf.h
@@ -36,6 +36,7 @@ struct qdio_perf_stats {
 	atomic_long_t outbound_handler;
 	atomic_long_t fast_requeue;
 	atomic_long_t outbound_target_full;
+	atomic_long_t inbound_queue_full;
 
 	/* for debugging */
 	atomic_long_t debug_tl_out_timer;
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 18d54fc..8c2dea5 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -48,7 +48,6 @@ static void set_impl_params(struct qdio_irq *irq_ptr,
 	if (!irq_ptr)
 		return;
 
-	WARN_ON((unsigned long)&irq_ptr->qib & 0xff);
 	irq_ptr->qib.pfmt = qib_param_field_format;
 	if (qib_param_field)
 		memcpy(irq_ptr->qib.parm, qib_param_field,
@@ -82,14 +81,12 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
-		WARN_ON((unsigned long)q & 0xff);
 
 		q->slib = (struct slib *) __get_free_page(GFP_KERNEL);
 		if (!q->slib) {
 			kmem_cache_free(qdio_q_cache, q);
 			return -ENOMEM;
 		}
-		WARN_ON((unsigned long)q->slib & 0x7ff);
 		irq_ptr_qs[i] = q;
 	}
 	return 0;
@@ -131,7 +128,7 @@ static void setup_storage_lists(struct qdio_q *q, struct qdio_irq *irq_ptr,
 	/* fill in sbal */
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++) {
 		q->sbal[j] = *sbals_array++;
-		WARN_ON((unsigned long)q->sbal[j] & 0xff);
+		BUG_ON((unsigned long)q->sbal[j] & 0xff);
 	}
 
 	/* fill in slib */
@@ -147,11 +144,6 @@ static void setup_storage_lists(struct qdio_q *q, struct qdio_irq *irq_ptr,
 	/* fill in sl */
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; j++)
 		q->sl->element[j].sbal = (unsigned long)q->sbal[j];
-
-	DBF_EVENT("sl-slsb-sbal");
-	DBF_HEX(q->sl, sizeof(void *));
-	DBF_HEX(&q->slsb, sizeof(void *));
-	DBF_HEX(q->sbal, sizeof(void *));
 }
 
 static void setup_queues(struct qdio_irq *irq_ptr,
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 90a4ed0..0cc4d55 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -361,7 +361,7 @@ typedef struct elf64_shdr {
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
-#define NT_PRXSTATUS	0x300		/* s390 upper register halves */
+#define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 
 
 /* Note header in a PT_NOTE section */
