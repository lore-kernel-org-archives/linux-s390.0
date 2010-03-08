Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 8 Mar 2010 12:39:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33+ take 2
Message-ID: <20100308123930.49fb8363@mschwide.boeblingen.de.ibm.com>
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

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive a couple of bugfixes, small improvements and two new things:
i) automatic recognition of read-only dasd devices
ii) deliver z/VM CP special messages as uevents

Heiko Carstens (1):
      [S390] uaccess: make sure copy_from_user_overflow is builtin

Hendrik Brueckner (3):
      [S390] hvc_iucv: allocate memory buffers for IUCV in zone DMA
      [S390] smsgiucv: declare char pointers as "const"
      [S390] smsgiucv_app: deliver z/VM CP special messages (SMSG) as uevents

John Stultz (1):
      [S390] Cleanup xtime usage

Nigel Hislop (1):
      [S390] dasd: security and PSF update patch for EMC CKD ioctl

Sebastian Ott (1):
      [S390] cio: fix init_count in case of recognition after steal lock

Stefan Weinhuber (1):
      [S390] dasd: automatic recognition of read-only devices

Ursula Braun (2):
      [S390] qdio: add missing bracket
      [S390] remove unused qdio flags in zfcp and qeth

 arch/s390/include/asm/qdio.h       |    7 --
 arch/s390/kernel/time.c            |   10 +-
 arch/s390/lib/Makefile             |    3 +-
 arch/s390/mm/cmm.c                 |    2 +-
 drivers/char/hvc_iucv.c            |    6 +-
 drivers/s390/block/dasd.c          |   36 ++++++
 drivers/s390/block/dasd_3990_erp.c |    4 +
 drivers/s390/block/dasd_devmap.c   |   13 ++-
 drivers/s390/block/dasd_diag.c     |    6 +-
 drivers/s390/block/dasd_eckd.c     |   27 +++--
 drivers/s390/block/dasd_fba.c      |   10 ++-
 drivers/s390/block/dasd_genhd.c    |    3 +-
 drivers/s390/block/dasd_int.h      |    7 ++
 drivers/s390/block/dasd_ioctl.c    |    6 +-
 drivers/s390/cio/device.c          |    5 +-
 drivers/s390/cio/qdio_debug.c      |    1 -
 drivers/s390/cio/qdio_main.c       |    3 +-
 drivers/s390/net/Kconfig           |   10 ++
 drivers/s390/net/Makefile          |    1 +
 drivers/s390/net/qeth_core_main.c  |    3 -
 drivers/s390/net/smsgiucv.c        |   15 ++--
 drivers/s390/net/smsgiucv.h        |    8 +-
 drivers/s390/net/smsgiucv_app.c    |  211 ++++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_qdio.c      |    2 -
 24 files changed, 342 insertions(+), 57 deletions(-)
 create mode 100644 drivers/s390/net/smsgiucv_app.c

diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index c666bfe..9b04b11 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -321,11 +321,6 @@ typedef void qdio_handler_t(struct ccw_device *, unsigned int, int,
 #define QDIO_ERROR_ACTIVATE_CHECK_CONDITION	0x40
 #define QDIO_ERROR_SLSB_STATE			0x80
 
-/* for qdio_initialize */
-#define QDIO_INBOUND_0COPY_SBALS		0x01
-#define QDIO_OUTBOUND_0COPY_SBALS		0x02
-#define QDIO_USE_OUTBOUND_PCIS			0x04
-
 /* for qdio_cleanup */
 #define QDIO_FLAG_CLEANUP_USING_CLEAR		0x01
 #define QDIO_FLAG_CLEANUP_USING_HALT		0x02
@@ -344,7 +339,6 @@ typedef void qdio_handler_t(struct ccw_device *, unsigned int, int,
  * @input_handler: handler to be called for input queues
  * @output_handler: handler to be called for output queues
  * @int_parm: interruption parameter
- * @flags: initialization flags
  * @input_sbal_addr_array:  address of no_input_qs * 128 pointers
  * @output_sbal_addr_array: address of no_output_qs * 128 pointers
  */
@@ -361,7 +355,6 @@ struct qdio_initialize {
 	qdio_handler_t *input_handler;
 	qdio_handler_t *output_handler;
 	unsigned long int_parm;
-	unsigned long flags;
 	void **input_sbal_addr_array;
 	void **output_sbal_addr_array;
 };
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index a8f93f1..8b22e7f 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -73,15 +73,15 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);
 
-void tod_to_timeval(__u64 todval, struct timespec *xtime)
+void tod_to_timeval(__u64 todval, struct timespec *xt)
 {
 	unsigned long long sec;
 
 	sec = todval >> 12;
 	do_div(sec, 1000000);
-	xtime->tv_sec = sec;
+	xt->tv_sec = sec;
 	todval -= (sec * 1000000) << 12;
-	xtime->tv_nsec = ((todval * 1000) >> 12);
+	xt->tv_nsec = ((todval * 1000) >> 12);
 }
 EXPORT_SYMBOL(tod_to_timeval);
 
@@ -216,8 +216,8 @@ void update_vsyscall(struct timespec *wall_time, struct clocksource *clock,
 	++vdso_data->tb_update_count;
 	smp_wmb();
 	vdso_data->xtime_tod_stamp = clock->cycle_last;
-	vdso_data->xtime_clock_sec = xtime.tv_sec;
-	vdso_data->xtime_clock_nsec = xtime.tv_nsec;
+	vdso_data->xtime_clock_sec = wall_time->tv_sec;
+	vdso_data->xtime_clock_nsec = wall_time->tv_nsec;
 	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
 	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
 	smp_wmb();
diff --git a/arch/s390/lib/Makefile b/arch/s390/lib/Makefile
index cd54a1c..761ab8b 100644
--- a/arch/s390/lib/Makefile
+++ b/arch/s390/lib/Makefile
@@ -2,7 +2,8 @@
 # Makefile for s390-specific library files..
 #
 
-lib-y += delay.o string.o uaccess_std.o uaccess_pt.o usercopy.o
+lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
+obj-y += usercopy.o
 obj-$(CONFIG_32BIT) += div64.o qrnnd.o ucmpdi2.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
index 76a3637..f16bd04 100644
--- a/arch/s390/mm/cmm.c
+++ b/arch/s390/mm/cmm.c
@@ -374,7 +374,7 @@ static struct ctl_table cmm_dir_table[] = {
 #ifdef CONFIG_CMM_IUCV
 #define SMSG_PREFIX "CMM"
 static void
-cmm_smsg_target(char *from, char *msg)
+cmm_smsg_target(const char *from, char *msg)
 {
 	long nr, seconds;
 
diff --git a/drivers/char/hvc_iucv.c b/drivers/char/hvc_iucv.c
index 21681a8..37b0542 100644
--- a/drivers/char/hvc_iucv.c
+++ b/drivers/char/hvc_iucv.c
@@ -139,6 +139,8 @@ struct hvc_iucv_private *hvc_iucv_get_private(uint32_t num)
  *
  * This function allocates a new struct iucv_tty_buffer element and, optionally,
  * allocates an internal data buffer with the specified size @size.
+ * The internal data buffer is always allocated with GFP_DMA which is
+ * required for receiving and sending data with IUCV.
  * Note: The total message size arises from the internal buffer size and the
  *	 members of the iucv_tty_msg structure.
  * The function returns NULL if memory allocation has failed.
@@ -154,7 +156,7 @@ static struct iucv_tty_buffer *alloc_tty_buffer(size_t size, gfp_t flags)
 
 	if (size > 0) {
 		bufp->msg.length = MSG_SIZE(size);
-		bufp->mbuf = kmalloc(bufp->msg.length, flags);
+		bufp->mbuf = kmalloc(bufp->msg.length, flags | GFP_DMA);
 		if (!bufp->mbuf) {
 			mempool_free(bufp, hvc_iucv_mempool);
 			return NULL;
@@ -237,7 +239,7 @@ static int hvc_iucv_write(struct hvc_iucv_private *priv,
 	if (!rb->mbuf) { /* message not yet received ... */
 		/* allocate mem to store msg data; if no memory is available
 		 * then leave the buffer on the list and re-try later */
-		rb->mbuf = kmalloc(rb->msg.length, GFP_ATOMIC);
+		rb->mbuf = kmalloc(rb->msg.length, GFP_ATOMIC | GFP_DMA);
 		if (!rb->mbuf)
 			return -ENOMEM;
 
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4951aa8..bbea90b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -26,6 +26,7 @@
 #include <asm/ebcdic.h>
 #include <asm/idals.h>
 #include <asm/itcw.h>
+#include <asm/diag.h>
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd:"
@@ -2212,6 +2213,13 @@ static int dasd_open(struct block_device *bdev, fmode_t mode)
 		goto out;
 	}
 
+	if ((mode & FMODE_WRITE) &&
+	    (test_bit(DASD_FLAG_DEVICE_RO, &base->flags) ||
+	     (base->features & DASD_FEATURE_READONLY))) {
+		rc = -EROFS;
+		goto out;
+	}
+
 	return 0;
 
 out:
@@ -2289,6 +2297,34 @@ dasd_exit(void)
  * SECTION: common functions for ccw_driver use
  */
 
+/*
+ * Is the device read-only?
+ * Note that this function does not report the setting of the
+ * readonly device attribute, but how it is configured in z/VM.
+ */
+int dasd_device_is_ro(struct dasd_device *device)
+{
+	struct ccw_dev_id dev_id;
+	struct diag210 diag_data;
+	int rc;
+
+	if (!MACHINE_IS_VM)
+		return 0;
+	ccw_device_get_id(device->cdev, &dev_id);
+	memset(&diag_data, 0, sizeof(diag_data));
+	diag_data.vrdcdvno = dev_id.devno;
+	diag_data.vrdclen = sizeof(diag_data);
+	rc = diag210(&diag_data);
+	if (rc == 0 || rc == 2) {
+		return diag_data.vrdcvfla & 0x80;
+	} else {
+		DBF_EVENT(DBF_WARNING, "diag210 failed for dev=%04x with rc=%d",
+			  dev_id.devno, rc);
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(dasd_device_is_ro);
+
 static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 {
 	struct ccw_device *cdev = data;
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 44796ba..51224f7 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -1045,6 +1045,10 @@ dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
 
 		erp->retries = 5;
 
+	} else if (sense[1] & SNS1_WRITE_INHIBITED) {
+		dev_err(&device->cdev->dev, "An I/O request was rejected"
+			" because writing is inhibited\n");
+		erp = dasd_3990_erp_cleanup(erp, DASD_CQR_FAILED);
 	} else {
 		/* fatal error -  set status to FAILED
 		   internal error 09 - Command Reject */
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index d49766f..8e23919 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -742,6 +742,7 @@ dasd_ro_store(struct device *dev, struct device_attribute *attr,
 	      const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
+	struct dasd_device *device;
 	int val;
 	char *endp;
 
@@ -758,12 +759,14 @@ dasd_ro_store(struct device *dev, struct device_attribute *attr,
 		devmap->features |= DASD_FEATURE_READONLY;
 	else
 		devmap->features &= ~DASD_FEATURE_READONLY;
-	if (devmap->device)
-		devmap->device->features = devmap->features;
-	if (devmap->device && devmap->device->block
-	    && devmap->device->block->gdp)
-		set_disk_ro(devmap->device->block->gdp, val);
+	device = devmap->device;
+	if (device) {
+		device->features = devmap->features;
+		val = val || test_bit(DASD_FLAG_DEVICE_RO, &device->flags);
+	}
 	spin_unlock(&dasd_devmap_lock);
+	if (device && device->block && device->block->gdp)
+		set_disk_ro(device->block->gdp, val);
 	return count;
 }
 
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 6e14863..687f323 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -145,12 +145,10 @@ dasd_diag_erp(struct dasd_device *device)
 	mdsk_term_io(device);
 	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
 	if (rc == 4) {
-		if (!(device->features & DASD_FEATURE_READONLY)) {
+		if (!(test_and_set_bit(DASD_FLAG_DEVICE_RO, &device->flags)))
 			pr_warning("%s: The access mode of a DIAG device "
 				   "changed to read-only\n",
 				   dev_name(&device->cdev->dev));
-			device->features |= DASD_FEATURE_READONLY;
-		}
 		rc = 0;
 	}
 	if (rc)
@@ -449,7 +447,7 @@ dasd_diag_check_device(struct dasd_device *device)
 		rc = -EIO;
 	} else {
 		if (rc == 4)
-			device->features |= DASD_FEATURE_READONLY;
+			set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
 		pr_info("%s: New DASD with %ld byte/block, total size %ld "
 			"KB%s\n", dev_name(&device->cdev->dev),
 			(unsigned long) block->bp_block,
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 1cca21a..01f4e7a 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1089,6 +1089,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	struct dasd_eckd_private *private;
 	struct dasd_block *block;
 	int is_known, rc;
+	int readonly;
 
 	if (!ccw_device_is_pathgroup(device->cdev)) {
 		dev_warn(&device->cdev->dev,
@@ -1182,15 +1183,20 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	else
 		private->real_cyl = private->rdc_data.no_cyl;
 
+	readonly = dasd_device_is_ro(device);
+	if (readonly)
+		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
+
 	dev_info(&device->cdev->dev, "New DASD %04X/%02X (CU %04X/%02X) "
-		 "with %d cylinders, %d heads, %d sectors\n",
+		 "with %d cylinders, %d heads, %d sectors%s\n",
 		 private->rdc_data.dev_type,
 		 private->rdc_data.dev_model,
 		 private->rdc_data.cu_type,
 		 private->rdc_data.cu_model.model,
 		 private->real_cyl,
 		 private->rdc_data.trk_per_cyl,
-		 private->rdc_data.sec_per_trk);
+		 private->rdc_data.sec_per_trk,
+		 readonly ? ", read-only device" : "");
 	return 0;
 
 out_err3:
@@ -2839,8 +2845,13 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	char *psf_data, *rssd_result;
 	struct dasd_ccw_req *cqr;
 	struct ccw1 *ccw;
+	char psf0, psf1;
 	int rc;
 
+	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RAWIO))
+		return -EACCES;
+	psf0 = psf1 = 0;
+
 	/* Copy parms from caller */
 	rc = -EFAULT;
 	if (copy_from_user(&usrparm, argp, sizeof(usrparm)))
@@ -2869,12 +2880,8 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 			   (void __user *)(unsigned long) usrparm.psf_data,
 			   usrparm.psf_data_len))
 		goto out_free;
-
-	/* sanity check on syscall header */
-	if (psf_data[0] != 0x17 && psf_data[1] != 0xce) {
-		rc = -EINVAL;
-		goto out_free;
-	}
+	psf0 = psf_data[0];
+	psf1 = psf_data[1];
 
 	/* setup CCWs for PSF + RSSD */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 2 , 0, device);
@@ -2925,7 +2932,9 @@ out_free:
 	kfree(rssd_result);
 	kfree(psf_data);
 out:
-	DBF_DEV_EVENT(DBF_WARNING, device, "Symmetrix ioctl: rc=%d", rc);
+	DBF_DEV_EVENT(DBF_WARNING, device,
+		      "Symmetrix ioctl (0x%02x 0x%02x): rc=%d",
+		      (int) psf0, (int) psf1, rc);
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 0f15244..37282b9 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -124,6 +124,7 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 	struct dasd_fba_private *private;
 	struct ccw_device *cdev = device->cdev;
 	int rc;
+	int readonly;
 
 	private = (struct dasd_fba_private *) device->private;
 	if (!private) {
@@ -162,16 +163,21 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 		return rc;
 	}
 
+	readonly = dasd_device_is_ro(device);
+	if (readonly)
+		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
+
 	dev_info(&device->cdev->dev,
 		 "New FBA DASD %04X/%02X (CU %04X/%02X) with %d MB "
-		 "and %d B/blk\n",
+		 "and %d B/blk%s\n",
 		 cdev->id.dev_type,
 		 cdev->id.dev_model,
 		 cdev->id.cu_type,
 		 cdev->id.cu_model,
 		 ((private->rdc_data.blk_bdsa *
 		   (private->rdc_data.blk_size >> 9)) >> 11),
-		 private->rdc_data.blk_size);
+		 private->rdc_data.blk_size,
+		 readonly ? ", read-only device" : "");
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 94f92a1..30a1ca3 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -70,7 +70,8 @@ int dasd_gendisk_alloc(struct dasd_block *block)
 	}
 	len += sprintf(gdp->disk_name + len, "%c", 'a'+(base->devindex%26));
 
-	if (block->base->features & DASD_FEATURE_READONLY)
+	if (base->features & DASD_FEATURE_READONLY ||
+	    test_bit(DASD_FLAG_DEVICE_RO, &base->flags))
 		set_disk_ro(gdp, 1);
 	gdp->private_data = block;
 	gdp->queue = block->request_queue;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index ed73ce5..a91d4a9 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -436,6 +436,10 @@ struct dasd_block {
 #define DASD_FLAG_OFFLINE	3	/* device is in offline processing */
 #define DASD_FLAG_EER_SNSS	4	/* A SNSS is required */
 #define DASD_FLAG_EER_IN_USE	5	/* A SNSS request is running */
+#define DASD_FLAG_DEVICE_RO	6	/* The device itself is read-only. Don't
+					 * confuse this with the user specified
+					 * read-only feature.
+					 */
 
 void dasd_put_device_wake(struct dasd_device *);
 
@@ -609,6 +613,9 @@ char *dasd_get_sense(struct irb *);
 void dasd_device_set_stop_bits(struct dasd_device *, int);
 void dasd_device_remove_stop_bits(struct dasd_device *, int);
 
+int dasd_device_is_ro(struct dasd_device *);
+
+
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
 extern int dasd_probeonly;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 7039d9c..3479f81 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -199,7 +199,8 @@ dasd_ioctl_format(struct block_device *bdev, void __user *argp)
 	if (!argp)
 		return -EINVAL;
 
-	if (block->base->features & DASD_FEATURE_READONLY)
+	if (block->base->features & DASD_FEATURE_READONLY ||
+	    test_bit(DASD_FLAG_DEVICE_RO, &block->base->flags))
 		return -EROFS;
 	if (copy_from_user(&fdata, argp, sizeof(struct format_data_t)))
 		return -EFAULT;
@@ -349,7 +350,8 @@ dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
 		return -EINVAL;
 	if (get_user(intval, (int __user *)argp))
 		return -EFAULT;
-
+	if (!intval && test_bit(DASD_FLAG_DEVICE_RO, &block->base->flags))
+		return -EROFS;
 	set_disk_ro(bdev->bd_disk, intval);
 	return dasd_set_feature(block->base->cdev, DASD_FEATURE_READONLY, intval);
 }
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index c6abb75..6d229f3 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -764,7 +764,7 @@ static void sch_create_and_recog_new_device(struct subchannel *sch)
 static void io_subchannel_register(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
-	int ret;
+	int ret, adjust_init_count = 1;
 	unsigned long flags;
 
 	sch = to_subchannel(cdev->dev.parent);
@@ -793,6 +793,7 @@ static void io_subchannel_register(struct ccw_device *cdev)
 					      cdev->private->dev_id.ssid,
 					      cdev->private->dev_id.devno);
 		}
+		adjust_init_count = 0;
 		goto out;
 	}
 	/*
@@ -818,7 +819,7 @@ out:
 	cdev->private->flags.recog_done = 1;
 	wake_up(&cdev->private->wait_q);
 out_err:
-	if (atomic_dec_and_test(&ccw_device_init_count))
+	if (adjust_init_count && atomic_dec_and_test(&ccw_device_init_count))
 		wake_up(&ccw_device_init_wq);
 }
 
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index c94eb2a..6ce83f5 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -33,7 +33,6 @@ void qdio_allocate_dbf(struct qdio_initialize *init_data,
 	DBF_HEX(&init_data->input_handler, sizeof(void *));
 	DBF_HEX(&init_data->output_handler, sizeof(void *));
 	DBF_HEX(&init_data->int_parm, sizeof(long));
-	DBF_HEX(&init_data->flags, sizeof(long));
 	DBF_HEX(&init_data->input_sbal_addr_array, sizeof(void *));
 	DBF_HEX(&init_data->output_sbal_addr_array, sizeof(void *));
 	DBF_EVENT("irq:%8lx", (unsigned long)irq_ptr);
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 232ef04..4f8f743 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -588,10 +588,11 @@ static void qdio_kick_handler(struct qdio_q *q)
 	if (q->is_input_q) {
 		qperf_inc(q, inbound_handler);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "kih s:%02x c:%02x", start, count);
-	} else
+	} else {
 		qperf_inc(q, outbound_handler);
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "koh: s:%02x c:%02x",
 			      start, count);
+	}
 
 	q->handler(q->irq_ptr->cdev, q->qdio_error, q->nr, start, count,
 		   q->irq_ptr->int_parm);
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index cb909a5..977bb4d 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -43,6 +43,16 @@ config SMSGIUCV
 	  Select this option if you want to be able to receive SMSG messages
 	  from other VM guest systems.
 
+config SMSGIUCV_EVENT
+	tristate "Deliver IUCV special messages as uevents (VM only)"
+	depends on SMSGIUCV
+	help
+	  Select this option to deliver CP special messages (SMSGs) as
+	  uevents.  The driver handles only those special messages that
+	  start with "APP".
+
+	  To compile as a module, choose M. The module name is "smsgiucv_app".
+
 config CLAW
 	tristate "CLAW device support"
 	depends on CCW && NETDEVICES
diff --git a/drivers/s390/net/Makefile b/drivers/s390/net/Makefile
index 6cab5a6..4dfe8c1 100644
--- a/drivers/s390/net/Makefile
+++ b/drivers/s390/net/Makefile
@@ -6,6 +6,7 @@ ctcm-y += ctcm_main.o ctcm_fsms.o ctcm_mpc.o ctcm_sysfs.o ctcm_dbug.o
 obj-$(CONFIG_CTCM) += ctcm.o fsm.o
 obj-$(CONFIG_NETIUCV) += netiucv.o fsm.o
 obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
+obj-$(CONFIG_SMSGIUCV_EVENT) += smsgiucv_app.o
 obj-$(CONFIG_LCS) += lcs.o
 obj-$(CONFIG_CLAW) += claw.o
 qeth-y += qeth_core_sys.o qeth_core_main.o qeth_core_mpc.o
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index fa8a519..7d25bdd 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3805,9 +3805,6 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	init_data.input_handler          = card->discipline.input_handler;
 	init_data.output_handler         = card->discipline.output_handler;
 	init_data.int_parm               = (unsigned long) card;
-	init_data.flags                  = QDIO_INBOUND_0COPY_SBALS |
-					   QDIO_OUTBOUND_0COPY_SBALS |
-					   QDIO_USE_OUTBOUND_PCIS;
 	init_data.input_sbal_addr_array  = (void **) in_sbal_ptrs;
 	init_data.output_sbal_addr_array = (void **) out_sbal_ptrs;
 
diff --git a/drivers/s390/net/smsgiucv.c b/drivers/s390/net/smsgiucv.c
index 67f2485..ecef1ed 100644
--- a/drivers/s390/net/smsgiucv.c
+++ b/drivers/s390/net/smsgiucv.c
@@ -31,9 +31,9 @@
 
 struct smsg_callback {
 	struct list_head list;
-	char *prefix;
+	const char *prefix;
 	int len;
-	void (*callback)(char *from, char *str);
+	void (*callback)(const char *from, char *str);
 };
 
 MODULE_AUTHOR
@@ -100,8 +100,8 @@ static void smsg_message_pending(struct iucv_path *path,
 	kfree(buffer);
 }
 
-int smsg_register_callback(char *prefix,
-			   void (*callback)(char *from, char *str))
+int smsg_register_callback(const char *prefix,
+			   void (*callback)(const char *from, char *str))
 {
 	struct smsg_callback *cb;
 
@@ -117,8 +117,9 @@ int smsg_register_callback(char *prefix,
 	return 0;
 }
 
-void smsg_unregister_callback(char *prefix,
-			      void (*callback)(char *from, char *str))
+void smsg_unregister_callback(const char *prefix,
+			      void (*callback)(const char *from,
+					       char *str))
 {
 	struct smsg_callback *cb, *tmp;
 
@@ -176,7 +177,7 @@ static const struct dev_pm_ops smsg_pm_ops = {
 
 static struct device_driver smsg_driver = {
 	.owner = THIS_MODULE,
-	.name = "SMSGIUCV",
+	.name = SMSGIUCV_DRV_NAME,
 	.bus  = &iucv_bus,
 	.pm = &smsg_pm_ops,
 };
diff --git a/drivers/s390/net/smsgiucv.h b/drivers/s390/net/smsgiucv.h
index 67f5d4f..149a115 100644
--- a/drivers/s390/net/smsgiucv.h
+++ b/drivers/s390/net/smsgiucv.h
@@ -5,6 +5,10 @@
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
-int  smsg_register_callback(char *, void (*)(char *, char *));
-void smsg_unregister_callback(char *, void (*)(char *, char *));
+#define SMSGIUCV_DRV_NAME     "SMSGIUCV"
+
+int  smsg_register_callback(const char *,
+			    void (*)(const char *, char *));
+void smsg_unregister_callback(const char *,
+			      void (*)(const char *, char *));
 
diff --git a/drivers/s390/net/smsgiucv_app.c b/drivers/s390/net/smsgiucv_app.c
new file mode 100644
index 0000000..91579dc
--- /dev/null
+++ b/drivers/s390/net/smsgiucv_app.c
@@ -0,0 +1,211 @@
+/*
+ * Deliver z/VM CP special messages (SMSG) as uevents.
+ *
+ * The driver registers for z/VM CP special messages with the
+ * "APP" prefix. Incoming messages are delivered to user space
+ * as uevents.
+ *
+ * Copyright IBM Corp. 2010
+ * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+ *
+ */
+#define KMSG_COMPONENT		"smsgiucv_app"
+#define pr_fmt(fmt)		KMSG_COMPONENT ": " fmt
+
+#include <linux/ctype.h>
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <net/iucv/iucv.h>
+#include "smsgiucv.h"
+
+/* prefix used for SMSG registration */
+#define SMSG_PREFIX		"APP"
+
+/* SMSG related uevent environment variables */
+#define ENV_SENDER_STR		"SMSG_SENDER="
+#define ENV_SENDER_LEN		(strlen(ENV_SENDER_STR) + 8 + 1)
+#define ENV_PREFIX_STR		"SMSG_ID="
+#define ENV_PREFIX_LEN		(strlen(ENV_PREFIX_STR) + \
+				 strlen(SMSG_PREFIX) + 1)
+#define ENV_TEXT_STR		"SMSG_TEXT="
+#define ENV_TEXT_LEN(msg)	(strlen(ENV_TEXT_STR) + strlen((msg)) + 1)
+
+/* z/VM user ID which is permitted to send SMSGs
+ * If the value is undefined or empty (""), special messages are
+ * accepted from any z/VM user ID. */
+static char *sender;
+module_param(sender, charp, 0400);
+MODULE_PARM_DESC(sender, "z/VM user ID from which CP SMSGs are accepted");
+
+/* SMSG device representation */
+static struct device *smsg_app_dev;
+
+/* list element for queuing received messages for delivery */
+struct smsg_app_event {
+	struct list_head list;
+	char *buf;
+	char *envp[4];
+};
+
+/* queue for outgoing uevents */
+static LIST_HEAD(smsg_event_queue);
+static DEFINE_SPINLOCK(smsg_event_queue_lock);
+
+static void smsg_app_event_free(struct smsg_app_event *ev)
+{
+	kfree(ev->buf);
+	kfree(ev);
+}
+
+static struct smsg_app_event *smsg_app_event_alloc(const char *from,
+						   const char *msg)
+{
+	struct smsg_app_event *ev;
+
+	ev = kzalloc(sizeof(*ev), GFP_ATOMIC);
+	if (!ev)
+		return NULL;
+
+	ev->buf = kzalloc(ENV_SENDER_LEN + ENV_PREFIX_LEN +
+			  ENV_TEXT_LEN(msg), GFP_ATOMIC);
+	if (!ev->buf) {
+		kfree(ev);
+		return NULL;
+	}
+
+	/* setting up environment pointers into buf */
+	ev->envp[0] = ev->buf;
+	ev->envp[1] = ev->envp[0] + ENV_SENDER_LEN;
+	ev->envp[2] = ev->envp[1] + ENV_PREFIX_LEN;
+	ev->envp[3] = NULL;
+
+	/* setting up environment: sender, prefix name, and message text */
+	snprintf(ev->envp[0], ENV_SENDER_LEN, ENV_SENDER_STR "%s", from);
+	snprintf(ev->envp[1], ENV_PREFIX_LEN, ENV_PREFIX_STR "%s", SMSG_PREFIX);
+	snprintf(ev->envp[2], ENV_TEXT_LEN(msg), ENV_TEXT_STR "%s", msg);
+
+	return ev;
+}
+
+static void smsg_event_work_fn(struct work_struct *work)
+{
+	LIST_HEAD(event_queue);
+	struct smsg_app_event *p, *n;
+	struct device *dev;
+
+	dev = get_device(smsg_app_dev);
+	if (!dev)
+		return;
+
+	spin_lock_bh(&smsg_event_queue_lock);
+	list_splice_init(&smsg_event_queue, &event_queue);
+	spin_unlock_bh(&smsg_event_queue_lock);
+
+	list_for_each_entry_safe(p, n, &event_queue, list) {
+		list_del(&p->list);
+		kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, p->envp);
+		smsg_app_event_free(p);
+	}
+
+	put_device(dev);
+}
+static DECLARE_WORK(smsg_event_work, smsg_event_work_fn);
+
+static void smsg_app_callback(const char *from, char *msg)
+{
+	struct smsg_app_event *se;
+
+	/* check if the originating z/VM user ID matches
+	 * the configured sender. */
+	if (sender && strlen(sender) > 0 && strcmp(from, sender) != 0)
+		return;
+
+	/* get start of message text (skip prefix and leading blanks) */
+	msg += strlen(SMSG_PREFIX);
+	while (*msg && isspace(*msg))
+		msg++;
+	if (*msg == '\0')
+		return;
+
+	/* allocate event list element and its environment */
+	se = smsg_app_event_alloc(from, msg);
+	if (!se)
+		return;
+
+	/* queue event and schedule work function */
+	spin_lock(&smsg_event_queue_lock);
+	list_add_tail(&se->list, &smsg_event_queue);
+	spin_unlock(&smsg_event_queue_lock);
+
+	schedule_work(&smsg_event_work);
+	return;
+}
+
+static int __init smsgiucv_app_init(void)
+{
+	struct device_driver *smsgiucv_drv;
+	int rc;
+
+	if (!MACHINE_IS_VM)
+		return -ENODEV;
+
+	smsg_app_dev = kzalloc(sizeof(*smsg_app_dev), GFP_KERNEL);
+	if (!smsg_app_dev)
+		return -ENOMEM;
+
+	smsgiucv_drv = driver_find(SMSGIUCV_DRV_NAME, &iucv_bus);
+	if (!smsgiucv_drv) {
+		kfree(smsg_app_dev);
+		return -ENODEV;
+	}
+
+	rc = dev_set_name(smsg_app_dev, KMSG_COMPONENT);
+	if (rc) {
+		kfree(smsg_app_dev);
+		goto fail_put_driver;
+	}
+	smsg_app_dev->bus = &iucv_bus;
+	smsg_app_dev->parent = iucv_root;
+	smsg_app_dev->release = (void (*)(struct device *)) kfree;
+	smsg_app_dev->driver = smsgiucv_drv;
+	rc = device_register(smsg_app_dev);
+	if (rc) {
+		put_device(smsg_app_dev);
+		goto fail_put_driver;
+	}
+
+	/* register with the smsgiucv device driver */
+	rc = smsg_register_callback(SMSG_PREFIX, smsg_app_callback);
+	if (rc) {
+		device_unregister(smsg_app_dev);
+		goto fail_put_driver;
+	}
+
+	rc = 0;
+fail_put_driver:
+	put_driver(smsgiucv_drv);
+	return rc;
+}
+module_init(smsgiucv_app_init);
+
+static void __exit smsgiucv_app_exit(void)
+{
+	/* unregister callback */
+	smsg_unregister_callback(SMSG_PREFIX, smsg_app_callback);
+
+	/* cancel pending work and flush any queued event work */
+	cancel_work_sync(&smsg_event_work);
+	smsg_event_work_fn(&smsg_event_work);
+
+	device_unregister(smsg_app_dev);
+}
+module_exit(smsgiucv_app_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Deliver z/VM CP SMSG as uevents");
+MODULE_AUTHOR("Hendrik Brueckner <brueckner@linux.vnet.ibm.com>");
diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 71b97ff..6479273 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -319,8 +319,6 @@ static void zfcp_qdio_setup_init_data(struct qdio_initialize *id,
 	id->input_handler = zfcp_qdio_int_resp;
 	id->output_handler = zfcp_qdio_int_req;
 	id->int_parm = (unsigned long) qdio;
-	id->flags = QDIO_INBOUND_0COPY_SBALS |
-		    QDIO_OUTBOUND_0COPY_SBALS | QDIO_USE_OUTBOUND_PCIS;
 	id->input_sbal_addr_array = (void **) (qdio->resp_q.sbal);
 	id->output_sbal_addr_array = (void **) (qdio->req_q.sbal);
 
