Return-Path: <linux-kernel-owner+w=401wt.eu-S1761708AbXHVMko@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Wed, 22 Aug 2007 14:44:18 +0200
Message-Id: <1187786658.5921.15.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/hypfs/inode.c        |   33 ++++--
 arch/s390/kernel/Makefile      |    2 +-
 arch/s390/kernel/diag.c        |  102 ++++++++++++++++
 arch/s390/kernel/dis.c         |    2 +-
 arch/s390/kernel/kprobes.c     |    2 +-
 arch/s390/kernel/s390_ksyms.c  |    1 -
 arch/s390/mm/cmm.c             |    1 +
 arch/s390/mm/init.c            |   17 ---
 drivers/s390/block/dasd_diag.c |    1 +
 drivers/s390/char/raw3270.c    |    1 +
 drivers/s390/char/vmur.c       |  250 ++++++++++++++++++++++++++--------------
 drivers/s390/char/vmur.h       |    1 +
 drivers/s390/cio/cmf.c         |   10 +-
 drivers/s390/cio/device.c      |    5 +-
 drivers/s390/cio/device_id.c   |   48 +--------
 drivers/s390/cio/qdio.c        |    5 +-
 include/asm-s390/atomic.h      |   26 ++++-
 include/asm-s390/cio.h         |   15 ---
 include/asm-s390/diag.h        |   39 ++++++
 include/asm-s390/pgalloc.h     |    2 -
 20 files changed, 371 insertions(+), 192 deletions(-)
 create mode 100644 arch/s390/kernel/diag.c
 create mode 100644 include/asm-s390/diag.h

Christian Borntraeger (1):
      [S390] disassembler: fix b2 opcodes like srst, bsg, and others

Cornelia Huck (2):
      [S390] cio: dont forget to set last slot to NULL in ccw_uevent().
      [S390] cio: change confusing message in cmf.

David Wilder (1):
      [S390] kprobes: fix instruction length calculation

Heiko Carstens (1):
      [S390] Change atomic_read/set to inline functions with barrier semantics.

Klaus D. Wacker (2):
      [S390] qdio: fix EQBS handling on CCQ96
      [S390] qdio: Refresh buffer states for IQDIO Asynchronous output queue

Michael Holzheu (3):
      [S390] vmur: fix diag14 exceptions with addresses > 2GB.
      [S390] vmur: fix reference counting for vmur device structure
      [S390] hypfs: inode corruption due to missing locking

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index ad4ca75..5245717 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -60,17 +60,28 @@ static void hypfs_add_dentry(struct dentry *dentry)
 	hypfs_last_dentry = dentry;
 }
 
+static inline int hypfs_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
 static void hypfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
 
 	parent = dentry->d_parent;
-	if (S_ISDIR(dentry->d_inode->i_mode))
-		simple_rmdir(parent->d_inode, dentry);
-	else
-		simple_unlink(parent->d_inode, dentry);
+	if (!parent || !parent->d_inode)
+		return;
+	mutex_lock(&parent->d_inode->i_mutex);
+	if (hypfs_positive(dentry)) {
+		if (S_ISDIR(dentry->d_inode->i_mode))
+			simple_rmdir(parent->d_inode, dentry);
+		else
+			simple_unlink(parent->d_inode, dentry);
+	}
 	d_delete(dentry);
 	dput(dentry);
+	mutex_unlock(&parent->d_inode->i_mutex);
 }
 
 static void hypfs_delete_tree(struct dentry *root)
@@ -315,6 +326,7 @@ static int hypfs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	hypfs_update_update(sb);
 	sb->s_root = root_dentry;
+	printk(KERN_INFO "hypfs: Hypervisor filesystem mounted\n");
 	return 0;
 
 err_tree:
@@ -356,13 +368,17 @@ static struct dentry *hypfs_create_file(struct super_block *sb,
 	qname.name = name;
 	qname.len = strlen(name);
 	qname.hash = full_name_hash(name, qname.len);
+	mutex_lock(&parent->d_inode->i_mutex);
 	dentry = lookup_one_len(name, parent, strlen(name));
-	if (IS_ERR(dentry))
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(dentry)) {
+		dentry = ERR_PTR(-ENOMEM);
+		goto fail;
+	}
 	inode = hypfs_make_inode(sb, mode);
 	if (!inode) {
 		dput(dentry);
-		return ERR_PTR(-ENOMEM);
+		dentry = ERR_PTR(-ENOMEM);
+		goto fail;
 	}
 	if (mode & S_IFREG) {
 		inode->i_fop = &hypfs_file_ops;
@@ -379,6 +395,8 @@ static struct dentry *hypfs_create_file(struct super_block *sb,
 	inode->i_private = data;
 	d_instantiate(dentry, inode);
 	dget(dentry);
+fail:
+	mutex_unlock(&parent->d_inode->i_mutex);
 	return dentry;
 }
 
@@ -391,7 +409,6 @@ struct dentry *hypfs_mkdir(struct super_block *sb, struct dentry *parent,
 	if (IS_ERR(dentry))
 		return dentry;
 	hypfs_add_dentry(dentry);
-	parent->d_inode->i_nlink++;
 	return dentry;
 }
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 3195d37..56cb710 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -6,7 +6,7 @@ EXTRA_AFLAGS	:= -traditional
 
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-	    semaphore.o s390_ext.o debug.o irq.o ipl.o dis.o
+	    semaphore.o s390_ext.o debug.o irq.o ipl.o dis.o diag.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
new file mode 100644
index 0000000..c032d11
--- /dev/null
+++ b/arch/s390/kernel/diag.c
@@ -0,0 +1,102 @@
+/*
+ * Implementation of s390 diagnose codes
+ *
+ * Copyright IBM Corp. 2007
+ * Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <asm/diag.h>
+
+/*
+ * Diagnose 10: Release pages
+ */
+void diag10(unsigned long addr)
+{
+	if (addr >= 0x7ff00000)
+		return;
+	asm volatile(
+#ifdef CONFIG_64BIT
+		"	sam31\n"
+		"	diag	%0,%0,0x10\n"
+		"0:	sam64\n"
+#else
+		"	diag	%0,%0,0x10\n"
+		"0:\n"
+#endif
+		EX_TABLE(0b, 0b)
+		: : "a" (addr));
+}
+EXPORT_SYMBOL(diag10);
+
+/*
+ * Diagnose 14: Input spool file manipulation
+ */
+int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode)
+{
+	register unsigned long _ry1 asm("2") = ry1;
+	register unsigned long _ry2 asm("3") = subcode;
+	int rc = 0;
+
+	asm volatile(
+#ifdef CONFIG_64BIT
+		"   sam31\n"
+		"   diag    %2,2,0x14\n"
+		"   sam64\n"
+#else
+		"   diag    %2,2,0x14\n"
+#endif
+		"   ipm     %0\n"
+		"   srl     %0,28\n"
+		: "=d" (rc), "+d" (_ry2)
+		: "d" (rx), "d" (_ry1)
+		: "cc");
+
+	return rc;
+}
+EXPORT_SYMBOL(diag14);
+
+/*
+ * Diagnose 210: Get information about a virtual device
+ */
+int diag210(struct diag210 *addr)
+{
+	/*
+	 * diag 210 needs its data below the 2GB border, so we
+	 * use a static data area to be sure
+	 */
+	static struct diag210 diag210_tmp;
+	static DEFINE_SPINLOCK(diag210_lock);
+	unsigned long flags;
+	int ccode;
+
+	spin_lock_irqsave(&diag210_lock, flags);
+	diag210_tmp = *addr;
+
+#ifdef CONFIG_64BIT
+	asm volatile(
+		"	lhi	%0,-1\n"
+		"	sam31\n"
+		"	diag	%1,0,0x210\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:	sam64\n"
+		EX_TABLE(0b, 1b)
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
+#else
+	asm volatile(
+		"	lhi	%0,-1\n"
+		"	diag	%1,0,0x210\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
+#endif
+
+	*addr = diag210_tmp;
+	spin_unlock_irqrestore(&diag210_lock, flags);
+
+	return ccode;
+}
+EXPORT_SYMBOL(diag210);
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index d305731..50d2235 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -577,7 +577,7 @@ static struct insn opcode_b2[] = {
 	{ "esta", 0x4a, INSTR_RRE_RR },
 	{ "lura", 0x4b, INSTR_RRE_RR },
 	{ "tar", 0x4c, INSTR_RRE_AR },
-	{ "cpya", INSTR_RRE_AA },
+	{ "cpya", 0x4d, INSTR_RRE_AA },
 	{ "sar", 0x4e, INSTR_RRE_AR },
 	{ "ear", 0x4f, INSTR_RRE_RA },
 	{ "csp", 0x50, INSTR_RRE_RR },
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 358d2bb..e40373d 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -85,7 +85,7 @@ void __kprobes get_instruction_type(struct arch_specific_insn *ainsn)
 	ainsn->reg = (*ainsn->insn & 0xf0) >> 4;
 
 	/* save the instruction length (pop 5-5) in bytes */
-	switch (*(__u8 *) (ainsn->insn) >> 4) {
+	switch (*(__u8 *) (ainsn->insn) >> 6) {
 	case 0:
 		ainsn->ilen = 2;
 		break;
diff --git a/arch/s390/kernel/s390_ksyms.c b/arch/s390/kernel/s390_ksyms.c
index 90b5ef5..7234c73 100644
--- a/arch/s390/kernel/s390_ksyms.c
+++ b/arch/s390/kernel/s390_ksyms.c
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(_oi_bitmap);
 EXPORT_SYMBOL(_ni_bitmap);
 EXPORT_SYMBOL(_zb_findmap);
 EXPORT_SYMBOL(_sb_findmap);
-EXPORT_SYMBOL(diag10);
 
 /*
  * semaphore ops
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index c5b2f4f..fabc50a 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -20,6 +20,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
+#include <asm/diag.h>
 
 static char *sender = "VMRMSVM";
 module_param(sender, charp, 0400);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 9098531..3a25bbf 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -42,23 +42,6 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
-void diag10(unsigned long addr)
-{
-        if (addr >= 0x7ff00000)
-                return;
-	asm volatile(
-#ifdef CONFIG_64BIT
-		"	sam31\n"
-		"	diag	%0,%0,0x10\n"
-		"0:	sam64\n"
-#else
-		"	diag	%0,%0,0x10\n"
-		"0:\n"
-#endif
-		EX_TABLE(0b,0b)
-		: : "a" (addr));
-}
-
 void show_mem(void)
 {
 	int i, total = 0, reserved = 0;
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index eccac1c..d32c60d 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -24,6 +24,7 @@
 #include <asm/s390_ext.h>
 #include <asm/todclk.h>
 #include <asm/vtoc.h>
+#include <asm/diag.h>
 
 #include "dasd_int.h"
 #include "dasd_diag.h"
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 4f2f81b..2edd5fb 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -21,6 +21,7 @@
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
+#include <asm/diag.h>
 
 #include "raw3270.h"
 
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 04b19bd..d70a6e6 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -14,6 +14,7 @@
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
 #include <asm/debug.h>
+#include <asm/diag.h>
 
 #include "vmur.h"
 
@@ -68,8 +69,26 @@ static struct ccw_driver ur_driver = {
 	.set_offline	= ur_set_offline,
 };
 
+static DEFINE_MUTEX(vmur_mutex);
+
 /*
  * Allocation, freeing, getting and putting of urdev structures
+ *
+ * Each ur device (urd) contains a reference to its corresponding ccw device
+ * (cdev) using the urd->cdev pointer. Each ccw device has a reference to the
+ * ur device using the cdev->dev.driver_data pointer.
+ *
+ * urd references:
+ * - ur_probe gets a urd reference, ur_remove drops the reference
+ *   (cdev->dev.driver_data)
+ * - ur_open gets a urd reference, ur_relase drops the reference
+ *   (urf->urd)
+ *
+ * cdev references:
+ * - urdev_alloc get a cdev reference (urd->cdev)
+ * - urdev_free drops the cdev reference (urd->cdev)
+ *
+ * Setting and clearing of cdev->dev.driver_data is protected by the ccwdev lock
  */
 static struct urdev *urdev_alloc(struct ccw_device *cdev)
 {
@@ -78,42 +97,61 @@ static struct urdev *urdev_alloc(struct ccw_device *cdev)
 	urd = kzalloc(sizeof(struct urdev), GFP_KERNEL);
 	if (!urd)
 		return NULL;
-	urd->cdev = cdev;
 	urd->reclen = cdev->id.driver_info;
 	ccw_device_get_id(cdev, &urd->dev_id);
 	mutex_init(&urd->io_mutex);
 	mutex_init(&urd->open_mutex);
+	atomic_set(&urd->ref_count,  1);
+	urd->cdev = cdev;
+	get_device(&cdev->dev);
 	return urd;
 }
 
 static void urdev_free(struct urdev *urd)
 {
+	TRACE("urdev_free: %p\n", urd);
+	if (urd->cdev)
+		put_device(&urd->cdev->dev);
 	kfree(urd);
 }
 
-/*
- * This is how the character device driver gets a reference to a
- * ur device. When this call returns successfully, a reference has
- * been taken (by get_device) on the underlying kobject. The recipient
- * of this urdev pointer must eventually drop it with urdev_put(urd)
- * which does the corresponding put_device().
- */
+static void urdev_get(struct urdev *urd)
+{
+	atomic_inc(&urd->ref_count);
+}
+
+static struct urdev *urdev_get_from_cdev(struct ccw_device *cdev)
+{
+	struct urdev *urd;
+	unsigned long flags;
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	urd = cdev->dev.driver_data;
+	if (urd)
+		urdev_get(urd);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	return urd;
+}
+
 static struct urdev *urdev_get_from_devno(u16 devno)
 {
 	char bus_id[16];
 	struct ccw_device *cdev;
+	struct urdev *urd;
 
 	sprintf(bus_id, "0.0.%04x", devno);
 	cdev = get_ccwdev_by_busid(&ur_driver, bus_id);
 	if (!cdev)
 		return NULL;
-
-	return cdev->dev.driver_data;
+	urd = urdev_get_from_cdev(cdev);
+	put_device(&cdev->dev);
+	return urd;
 }
 
 static void urdev_put(struct urdev *urd)
 {
-	put_device(&urd->cdev->dev);
+	if (atomic_dec_and_test(&urd->ref_count))
+		urdev_free(urd);
 }
 
 /*
@@ -245,6 +283,7 @@ static void ur_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		return;
 	}
 	urd = cdev->dev.driver_data;
+	BUG_ON(!urd);
 	/* On special conditions irb is an error pointer */
 	if (IS_ERR(irb))
 		urd->io_request_rc = PTR_ERR(irb);
@@ -262,9 +301,15 @@ static void ur_int_handler(struct ccw_device *cdev, unsigned long intparm,
 static ssize_t ur_attr_reclen_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct urdev *urd = dev->driver_data;
+	struct urdev *urd;
+	int rc;
 
-	return sprintf(buf, "%zu\n", urd->reclen);
+	urd = urdev_get_from_cdev(to_ccwdev(dev));
+	if (!urd)
+		return -ENODEV;
+	rc = sprintf(buf, "%zu\n", urd->reclen);
+	urdev_put(urd);
+	return rc;
 }
 
 static DEVICE_ATTR(reclen, 0444, ur_attr_reclen_show, NULL);
@@ -379,31 +424,6 @@ static ssize_t ur_write(struct file *file, const char __user *udata,
 	return do_write(urf->urd, udata, count, urf->dev_reclen, ppos);
 }
 
-static int do_diag_14(unsigned long rx, unsigned long ry1,
-		      unsigned long subcode)
-{
-	register unsigned long _ry1 asm("2") = ry1;
-	register unsigned long _ry2 asm("3") = subcode;
-	int rc = 0;
-
-	asm volatile(
-#ifdef CONFIG_64BIT
-		"   sam31\n"
-		"   diag    %2,2,0x14\n"
-		"   sam64\n"
-#else
-		"   diag    %2,2,0x14\n"
-#endif
-		"   ipm     %0\n"
-		"   srl     %0,28\n"
-		: "=d" (rc), "+d" (_ry2)
-		: "d" (rx), "d" (_ry1)
-		: "cc");
-
-	TRACE("diag 14: subcode=0x%lx, cc=%i\n", subcode, rc);
-	return rc;
-}
-
 /*
  * diagnose code 0x14 subcode 0x0028 - position spool file to designated
  *				       record
@@ -415,7 +435,7 @@ static int diag_position_to_record(int devno, int record)
 {
 	int cc;
 
-	cc = do_diag_14(record, devno, 0x28);
+	cc = diag14(record, devno, 0x28);
 	switch (cc) {
 	case 0:
 		return 0;
@@ -440,7 +460,7 @@ static int diag_read_file(int devno, char *buf)
 {
 	int cc;
 
-	cc = do_diag_14((unsigned long) buf, devno, 0x00);
+	cc = diag14((unsigned long) buf, devno, 0x00);
 	switch (cc) {
 	case 0:
 		return 0;
@@ -533,7 +553,7 @@ static int diag_read_next_file_info(struct file_control_block *buf, int spid)
 {
 	int cc;
 
-	cc = do_diag_14((unsigned long) buf, spid, 0xfff);
+	cc = diag14((unsigned long) buf, spid, 0xfff);
 	switch (cc) {
 	case 0:
 		return 0;
@@ -750,64 +770,63 @@ static struct file_operations ur_fops = {
 
 /*
  * ccw_device infrastructure:
- *     ur_probe gets its own ref to the device (i.e. get_device),
- *     creates the struct urdev, the device attributes, sets up
- *     the interrupt handler and validates the virtual unit record device.
- *     ur_remove removes the device attributes, frees the struct urdev
- *     and drops (put_device) the ref to the device we got in ur_probe.
+ *     ur_probe creates the struct urdev (with refcount = 1), the device
+ *     attributes, sets up the interrupt handler and validates the virtual
+ *     unit record device.
+ *     ur_remove removes the device attributes and drops the reference to
+ *     struct urdev.
+ *
+ *     ur_probe, ur_remove, ur_set_online and ur_set_offline are serialized
+ *     by the vmur_mutex lock.
+ *
+ *     urd->char_device is used as indication that the online function has
+ *     been completed successfully.
  */
 static int ur_probe(struct ccw_device *cdev)
 {
 	struct urdev *urd;
 	int rc;
 
-	TRACE("ur_probe: cdev=%p state=%d\n", cdev, *(int *) cdev->private);
-
-	if (!get_device(&cdev->dev))
-		return -ENODEV;
+	TRACE("ur_probe: cdev=%p\n", cdev);
 
+	mutex_lock(&vmur_mutex);
 	urd = urdev_alloc(cdev);
 	if (!urd) {
 		rc = -ENOMEM;
-		goto fail;
+		goto fail_unlock;
 	}
+
 	rc = ur_create_attributes(&cdev->dev);
 	if (rc) {
 		rc = -ENOMEM;
-		goto fail;
+		goto fail_urdev_put;
 	}
-	cdev->dev.driver_data = urd;
 	cdev->handler = ur_int_handler;
 
 	/* validate virtual unit record device */
 	urd->class = get_urd_class(urd);
 	if (urd->class < 0) {
 		rc = urd->class;
-		goto fail;
+		goto fail_remove_attr;
 	}
 	if ((urd->class != DEV_CLASS_UR_I) && (urd->class != DEV_CLASS_UR_O)) {
 		rc = -ENOTSUPP;
-		goto fail;
+		goto fail_remove_attr;
 	}
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	cdev->dev.driver_data = urd;
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 
+	mutex_unlock(&vmur_mutex);
 	return 0;
 
-fail:
-	urdev_free(urd);
-	put_device(&cdev->dev);
-	return rc;
-}
-
-static void ur_remove(struct ccw_device *cdev)
-{
-	struct urdev *urd = cdev->dev.driver_data;
-
-	TRACE("ur_remove\n");
-	if (cdev->online)
-		ur_set_offline(cdev);
+fail_remove_attr:
 	ur_remove_attributes(&cdev->dev);
-	urdev_free(urd);
-	put_device(&cdev->dev);
+fail_urdev_put:
+	urdev_put(urd);
+fail_unlock:
+	mutex_unlock(&vmur_mutex);
+	return rc;
 }
 
 static int ur_set_online(struct ccw_device *cdev)
@@ -816,20 +835,29 @@ static int ur_set_online(struct ccw_device *cdev)
 	int minor, major, rc;
 	char node_id[16];
 
-	TRACE("ur_set_online: cdev=%p state=%d\n", cdev,
-	      *(int *) cdev->private);
+	TRACE("ur_set_online: cdev=%p\n", cdev);
 
-	if (!try_module_get(ur_driver.owner))
-		return -EINVAL;
+	mutex_lock(&vmur_mutex);
+	urd = urdev_get_from_cdev(cdev);
+	if (!urd) {
+		/* ur_remove already deleted our urd */
+		rc = -ENODEV;
+		goto fail_unlock;
+	}
+
+	if (urd->char_device) {
+		/* Another ur_set_online was faster */
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
 
-	urd = (struct urdev *) cdev->dev.driver_data;
 	minor = urd->dev_id.devno;
 	major = MAJOR(ur_first_dev_maj_min);
 
 	urd->char_device = cdev_alloc();
 	if (!urd->char_device) {
 		rc = -ENOMEM;
-		goto fail_module_put;
+		goto fail_urdev_put;
 	}
 
 	cdev_init(urd->char_device, &ur_fops);
@@ -858,29 +886,79 @@ static int ur_set_online(struct ccw_device *cdev)
 		TRACE("ur_set_online: device_create rc=%d\n", rc);
 		goto fail_free_cdev;
 	}
-
+	urdev_put(urd);
+	mutex_unlock(&vmur_mutex);
 	return 0;
 
 fail_free_cdev:
 	cdev_del(urd->char_device);
-fail_module_put:
-	module_put(ur_driver.owner);
-
+	urd->char_device = NULL;
+fail_urdev_put:
+	urdev_put(urd);
+fail_unlock:
+	mutex_unlock(&vmur_mutex);
 	return rc;
 }
 
-static int ur_set_offline(struct ccw_device *cdev)
+static int ur_set_offline_force(struct ccw_device *cdev, int force)
 {
 	struct urdev *urd;
+	int rc;
 
-	TRACE("ur_set_offline: cdev=%p cdev->private=%p state=%d\n",
-		cdev, cdev->private, *(int *) cdev->private);
-	urd = (struct urdev *) cdev->dev.driver_data;
+	TRACE("ur_set_offline: cdev=%p\n", cdev);
+	urd = urdev_get_from_cdev(cdev);
+	if (!urd)
+		/* ur_remove already deleted our urd */
+		return -ENODEV;
+	if (!urd->char_device) {
+		/* Another ur_set_offline was faster */
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
+	if (!force && (atomic_read(&urd->ref_count) > 2)) {
+		/* There is still a user of urd (e.g. ur_open) */
+		TRACE("ur_set_offline: BUSY\n");
+		rc = -EBUSY;
+		goto fail_urdev_put;
+	}
 	device_destroy(vmur_class, urd->char_device->dev);
 	cdev_del(urd->char_device);
-	module_put(ur_driver.owner);
+	urd->char_device = NULL;
+	rc = 0;
 
-	return 0;
+fail_urdev_put:
+	urdev_put(urd);
+	return rc;
+}
+
+static int ur_set_offline(struct ccw_device *cdev)
+{
+	int rc;
+
+	mutex_lock(&vmur_mutex);
+	rc = ur_set_offline_force(cdev, 0);
+	mutex_unlock(&vmur_mutex);
+	return rc;
+}
+
+static void ur_remove(struct ccw_device *cdev)
+{
+	unsigned long flags;
+
+	TRACE("ur_remove\n");
+
+	mutex_lock(&vmur_mutex);
+
+	if (cdev->online)
+		ur_set_offline_force(cdev, 1);
+	ur_remove_attributes(&cdev->dev);
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	urdev_put(cdev->dev.driver_data);
+	cdev->dev.driver_data = NULL;
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+
+	mutex_unlock(&vmur_mutex);
 }
 
 /*
diff --git a/drivers/s390/char/vmur.h b/drivers/s390/char/vmur.h
index 2b3c564..fa95964 100644
--- a/drivers/s390/char/vmur.h
+++ b/drivers/s390/char/vmur.h
@@ -70,6 +70,7 @@ struct urdev {
 	size_t reclen;			/* Record length for *write* CCWs */
 	int class;			/* VM device class */
 	int io_request_rc;		/* return code from I/O request */
+	atomic_t ref_count;		/* reference counter */
 };
 
 /*
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 02fd00b..34a7969 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -594,6 +594,9 @@ alloc_cmb (struct ccw_device *cdev)
 			free_pages((unsigned long)mem, get_order(size));
 		} else if (!mem) {
 			/* no luck */
+			printk(KERN_WARNING "cio: failed to allocate area "
+			       "for measuring %d subchannels\n",
+			       cmb_area.num_channels);
 			ret = -ENOMEM;
 			goto out;
 		} else {
@@ -1279,13 +1282,6 @@ init_cmf(void)
 	case CMF_BASIC:
 		format_string = "basic";
 		cmbops = &cmbops_basic;
-		if (cmb_area.num_channels > 4096 || cmb_area.num_channels < 1) {
-			printk(KERN_ERR "cio: Basic channel measurement "
-			       "facility can only use 1 to 4096 devices\n"
-			       KERN_ERR "when the cmf driver is built"
-			       " as a loadable module\n");
-			return 1;
-		}
 		break;
 	case CMF_EXTENDED:
  		format_string = "extended";
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 297659f..e44d92e 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -117,7 +117,10 @@ static int ccw_uevent(struct device *dev, char **envp, int num_envp,
 	snprint_alias(modalias_buf, sizeof(modalias_buf), id, "");
 	ret = add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &len,
 			     "MODALIAS=%s", modalias_buf);
-	return ret;
+	if (ret)
+		return ret;
+	envp[i] = NULL;
+	return 0;
 }
 
 struct bus_type ccw_bus_type;
diff --git a/drivers/s390/cio/device_id.c b/drivers/s390/cio/device_id.c
index 60b9347..f232832 100644
--- a/drivers/s390/cio/device_id.c
+++ b/drivers/s390/cio/device_id.c
@@ -17,6 +17,7 @@
 #include <asm/delay.h>
 #include <asm/cio.h>
 #include <asm/lowcore.h>
+#include <asm/diag.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -25,51 +26,6 @@
 #include "ioasm.h"
 
 /*
- * diag210 is used under VM to get information about a virtual device
- */
-int
-diag210(struct diag210 * addr)
-{
-	/*
-	 * diag 210 needs its data below the 2GB border, so we
-	 * use a static data area to be sure
-	 */
-	static struct diag210 diag210_tmp;
-	static DEFINE_SPINLOCK(diag210_lock);
-	unsigned long flags;
-	int ccode;
-
-	spin_lock_irqsave(&diag210_lock, flags);
-	diag210_tmp = *addr;
-
-#ifdef CONFIG_64BIT
-	asm volatile(
-		"	lhi	%0,-1\n"
-		"	sam31\n"
-		"	diag	%1,0,0x210\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:	sam64\n"
-		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
-#else
-	asm volatile(
-		"	lhi	%0,-1\n"
-		"	diag	%1,0,0x210\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
-#endif
-
-	*addr = diag210_tmp;
-	spin_unlock_irqrestore(&diag210_lock, flags);
-
-	return ccode;
-}
-
-/*
  * Input :
  *   devno - device number
  *   ps	   - pointer to sense ID data area
@@ -349,5 +305,3 @@ ccw_device_sense_id_irq(struct ccw_device *cdev, enum dev_event dev_event)
 		break;
 	}
 }
-
-EXPORT_SYMBOL(diag210);
diff --git a/drivers/s390/cio/qdio.c b/drivers/s390/cio/qdio.c
index 03347ae..d8d4798 100644
--- a/drivers/s390/cio/qdio.c
+++ b/drivers/s390/cio/qdio.c
@@ -195,6 +195,8 @@ qdio_do_eqbs(struct qdio_q *q, unsigned char *state,
 again:
 	ccq = do_eqbs(irq->sch_token, state, q_no, start, cnt);
 	rc = qdio_check_ccq(q, ccq);
+	if ((ccq == 96) && (tmp_cnt != *cnt))
+		rc = 0;
 	if (rc == 1) {
 		QDIO_DBF_TEXT5(1,trace,"eqAGAIN");
 		goto again;
@@ -740,7 +742,8 @@ qdio_get_outbound_buffer_frontier(struct qdio_q *q)
 	first_not_to_check=f+qdio_min(atomic_read(&q->number_of_buffers_used),
 				      (QDIO_MAX_BUFFERS_PER_Q-1));
 
-	if ((!q->is_iqdio_q)&&(!q->hydra_gives_outbound_pcis))
+	if (((!q->is_iqdio_q) && (!q->hydra_gives_outbound_pcis)) ||
+		 (q->queue_type == QDIO_IQDIO_QFMT_ASYNCH))
 		SYNC_MEMORY;
 
 check_next:
diff --git a/include/asm-s390/atomic.h b/include/asm-s390/atomic.h
index ea48695..2d18465 100644
--- a/include/asm-s390/atomic.h
+++ b/include/asm-s390/atomic.h
@@ -67,8 +67,17 @@ typedef struct {
 
 #endif /* __GNUC__ */
 
-#define atomic_read(v)          ((v)->counter)
-#define atomic_set(v,i)         (((v)->counter) = (i))
+static inline int atomic_read(const atomic_t *v)
+{
+	barrier();
+	return v->counter;
+}
+
+static inline void atomic_set(atomic_t *v, int i)
+{
+	v->counter = i;
+	barrier();
+}
 
 static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
@@ -182,8 +191,17 @@ typedef struct {
 
 #endif /* __GNUC__ */
 
-#define atomic64_read(v)          ((v)->counter)
-#define atomic64_set(v,i)         (((v)->counter) = (i))
+static inline long long atomic64_read(const atomic64_t *v)
+{
+	barrier();
+	return v->counter;
+}
+
+static inline void atomic64_set(atomic64_t *v, long long i)
+{
+	v->counter = i;
+	barrier();
+}
 
 static __inline__ long long atomic64_add_return(long long i, atomic64_t * v)
 {
diff --git a/include/asm-s390/cio.h b/include/asm-s390/cio.h
index f738d28..1982fb3 100644
--- a/include/asm-s390/cio.h
+++ b/include/asm-s390/cio.h
@@ -258,19 +258,6 @@ struct ciw {
 /* Sick revalidation of device. */
 #define CIO_REVALIDATE 0x0008
 
-struct diag210 {
-	__u16 vrdcdvno : 16;   /* device number (input) */
-	__u16 vrdclen  : 16;   /* data block length (input) */
-	__u32 vrdcvcla : 8;    /* virtual device class (output) */
-	__u32 vrdcvtyp : 8;    /* virtual device type (output) */
-	__u32 vrdcvsta : 8;    /* virtual device status (output) */
-	__u32 vrdcvfla : 8;    /* virtual device flags (output) */
-	__u32 vrdcrccl : 8;    /* real device class (output) */
-	__u32 vrdccrty : 8;    /* real device type (output) */
-	__u32 vrdccrmd : 8;    /* real device model (output) */
-	__u32 vrdccrft : 8;    /* real device feature (output) */
-} __attribute__ ((packed,aligned(4)));
-
 struct ccw_dev_id {
 	u8 ssid;
 	u16 devno;
@@ -285,8 +272,6 @@ static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
 	return 0;
 }
 
-extern int diag210(struct diag210 *addr);
-
 extern void wait_cons_dev(void);
 
 extern void css_schedule_reprobe(void);
diff --git a/include/asm-s390/diag.h b/include/asm-s390/diag.h
new file mode 100644
index 0000000..72b2e2f
--- /dev/null
+++ b/include/asm-s390/diag.h
@@ -0,0 +1,39 @@
+/*
+ * s390 diagnose functions
+ *
+ * Copyright IBM Corp. 2007
+ * Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_DIAG_H
+#define _ASM_S390_DIAG_H
+
+/*
+ * Diagnose 10: Release pages
+ */
+extern void diag10(unsigned long addr);
+
+/*
+ * Diagnose 14: Input spool file manipulation
+ */
+extern int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode);
+
+/*
+ * Diagnose 210: Get information about a virtual device
+ */
+struct diag210 {
+	u16 vrdcdvno;	/* device number (input) */
+	u16 vrdclen;	/* data block length (input) */
+	u8 vrdcvcla;	/* virtual device class (output) */
+	u8 vrdcvtyp;	/* virtual device type (output) */
+	u8 vrdcvsta;	/* virtual device status (output) */
+	u8 vrdcvfla;	/* virtual device flags (output) */
+	u8 vrdcrccl;	/* real device class (output) */
+	u8 vrdccrty;	/* real device type (output) */
+	u8 vrdccrmd;	/* real device model (output) */
+	u8 vrdccrft;	/* real device feature (output) */
+} __attribute__((packed, aligned(4)));
+
+extern int diag210(struct diag210 *addr);
+
+#endif /* _ASM_S390_DIAG_H */
diff --git a/include/asm-s390/pgalloc.h b/include/asm-s390/pgalloc.h
index 56c8a6c..e45d3c9 100644
--- a/include/asm-s390/pgalloc.h
+++ b/include/asm-s390/pgalloc.h
@@ -19,8 +19,6 @@
 
 #define check_pgt_cache()	do {} while (0)
 
-extern void diag10(unsigned long addr);
-
 /*
  * Page allocation orders.
  */
