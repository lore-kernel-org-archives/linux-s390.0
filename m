Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 6 Jul 2017 08:31:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.13 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20170706083112.03321bb0@mschwideX1>
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

* The fixup for the blk-mq clash with the scm driver

* An improvement for the driver in regard to raw I/O

* Bug fixes and cleanup

Cornelia Huck (1):
      Update my email address

Harald Freudenberger (1):
      s390/zcrypt: Fix missing newlines at some debug feature messages.

Jan Höppner (3):
      s390/dasd: Refactor prefix_LRE() and related functions
      s390/dasd: Rename dasd_raw_build_cp()
      s390/dasd: Make raw I/O usable without prefix support

Jiri Olsa (1):
      s390/syscalls: Fix out of bounds arguments access

Michael Holzheu (1):
      s390/crash: Remove unused KEXEC_NOTE_BYTES

Sebastian Ott (2):
      s390/dasd: remove unneeded code
      s390/vfio_ccw: remove unused variable

Stephen Rothwell (1):
      s390: fix up for "blk-mq: switch ->queue_rq return value to blk_status_t"

 MAINTAINERS                      |   6 +-
 arch/s390/include/asm/kexec.h    |  18 ---
 arch/s390/include/asm/syscall.h  |   6 +
 drivers/s390/block/dasd.c        |   3 +-
 drivers/s390/block/dasd_alias.c  |   3 +-
 drivers/s390/block/dasd_devmap.c |   2 +-
 drivers/s390/block/dasd_eckd.c   | 310 ++++++++++++++++-----------------------
 drivers/s390/block/dasd_eckd.h   |   1 +
 drivers/s390/block/scm_blk.c     |  10 +-
 drivers/s390/cio/vfio_ccw_drv.c  |   2 -
 drivers/s390/crypto/zcrypt_api.c |  10 +-
 include/linux/crash_core.h       |   5 +
 include/linux/kexec.h            |   9 --
 13 files changed, 154 insertions(+), 231 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61d0ac6..1190392 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7324,7 +7324,7 @@ F:	arch/powerpc/kvm/
 
 KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
 M:	Christian Borntraeger <borntraeger@de.ibm.com>
-M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Cornelia Huck <cohuck@redhat.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git
@@ -11109,7 +11109,7 @@ S:	Supported
 F:	drivers/iommu/s390-iommu.c
 
 S390 VFIO-CCW DRIVER
-M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Cornelia Huck <cohuck@redhat.com>
 M:	Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	kvm@vger.kernel.org
@@ -13639,7 +13639,7 @@ F:	include/uapi/linux/virtio_*.h
 F:	drivers/crypto/virtio/
 
 VIRTIO DRIVERS FOR S390
-M:	Cornelia Huck <cornelia.huck@de.ibm.com>
+M:	Cornelia Huck <cohuck@redhat.com>
 M:	Halil Pasic <pasic@linux.vnet.ibm.com>
 L:	linux-s390@vger.kernel.org
 L:	virtualization@lists.linux-foundation.org
diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 2f924bc..dccf24e 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -41,24 +41,6 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
-/*
- * Size for s390x ELF notes per CPU
- *
- * Seven notes plus zero note at the end: prstatus, fpregset, timer,
- * tod_cmp, tod_reg, control regs, and prefix
- */
-#define KEXEC_NOTE_BYTES \
-	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
-	 ALIGN(sizeof("CORE"), 4) * 7 + \
-	 ALIGN(sizeof(struct elf_prstatus), 4) + \
-	 ALIGN(sizeof(elf_fpregset_t), 4) + \
-	 ALIGN(sizeof(u64), 4) + \
-	 ALIGN(sizeof(u64), 4) + \
-	 ALIGN(sizeof(u32), 4) + \
-	 ALIGN(sizeof(u64) * 16, 4) + \
-	 ALIGN(sizeof(u32), 4) \
-	)
-
 /* Provide a dummy definition to avoid build failures. */
 static inline void crash_setup_regs(struct pt_regs *newregs,
 					struct pt_regs *oldregs) { }
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 6ba0bf9..6bc941b 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -64,6 +64,12 @@ static inline void syscall_get_arguments(struct task_struct *task,
 {
 	unsigned long mask = -1UL;
 
+	/*
+	 * No arguments for this syscall, there's nothing to do.
+	 */
+	if (!n)
+		return;
+
 	BUG_ON(i + n > 6);
 #ifdef CONFIG_COMPAT
 	if (test_tsk_thread_flag(task, TIF_31BIT))
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0f1fe4f..670ac0a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3921,7 +3921,6 @@ EXPORT_SYMBOL(dasd_schedule_requeue);
 int dasd_generic_pm_freeze(struct ccw_device *cdev)
 {
 	struct dasd_device *device = dasd_device_from_cdev(cdev);
-	int rc;
 
 	if (IS_ERR(device))
 		return PTR_ERR(device);
@@ -3930,7 +3929,7 @@ int dasd_generic_pm_freeze(struct ccw_device *cdev)
 	set_bit(DASD_FLAG_SUSPENDED, &device->flags);
 
 	if (device->discipline->freeze)
-		rc = device->discipline->freeze(device);
+		device->discipline->freeze(device);
 
 	/* disallow new I/O  */
 	dasd_device_set_stop_bits(device, DASD_STOPPED_PM);
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 1e56018..0e0e622 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -754,7 +754,6 @@ static void flush_all_alias_devices_on_lcu(struct alias_lcu *lcu)
 	struct alias_pav_group *pavgroup;
 	struct dasd_device *device, *temp;
 	struct dasd_eckd_private *private;
-	int rc;
 	unsigned long flags;
 	LIST_HEAD(active);
 
@@ -785,7 +784,7 @@ static void flush_all_alias_devices_on_lcu(struct alias_lcu *lcu)
 		device = list_first_entry(&active, struct dasd_device,
 					  alias_list);
 		spin_unlock_irqrestore(&lcu->lock, flags);
-		rc = dasd_flush_device_queue(device);
+		dasd_flush_device_queue(device);
 		spin_lock_irqsave(&lcu->lock, flags);
 		/*
 		 * only move device around if it wasn't moved away while we
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 7c73512..779dce0 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -150,7 +150,7 @@ static int __init dasd_busid(char *str, int *id0, int *id1, int *devno)
 	/* Old style 0xXXXX or XXXX */
 	if (!kstrtouint(str, 16, &val)) {
 		*id0 = *id1 = 0;
-		if (val < 0 || val > 0xffff)
+		if (val > 0xffff)
 			return -EINVAL;
 		*devno = val;
 		return 0;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 122456e..c3e5ad6 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -213,10 +213,8 @@ static void set_ch_t(struct ch_t *geo, __u32 cyl, __u8 head)
 	geo->head |= head;
 }
 
-static int
-check_XRC (struct ccw1         *de_ccw,
-           struct DE_eckd_data *data,
-           struct dasd_device  *device)
+static int check_XRC(struct ccw1 *ccw, struct DE_eckd_data *data,
+		     struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 	int rc;
@@ -224,7 +222,7 @@ check_XRC (struct ccw1         *de_ccw,
 	if (!private->rdc_data.facilities.XRC_supported)
 		return 0;
 
-        /* switch on System Time Stamp - needed for XRC Support */
+	/* switch on System Time Stamp - needed for XRC Support */
 	data->ga_extended |= 0x08; /* switch on 'Time Stamp Valid'   */
 	data->ga_extended |= 0x02; /* switch on 'Extended Parameter' */
 
@@ -233,24 +231,30 @@ check_XRC (struct ccw1         *de_ccw,
 	if (rc == -EOPNOTSUPP || rc == -EACCES)
 		rc = 0;
 
-	de_ccw->count = sizeof(struct DE_eckd_data);
-	de_ccw->flags |= CCW_FLAG_SLI;
+	if (ccw) {
+		ccw->count = sizeof(struct DE_eckd_data);
+		ccw->flags |= CCW_FLAG_SLI;
+	}
+
 	return rc;
 }
 
 static int
 define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
-	      unsigned int totrk, int cmd, struct dasd_device *device)
+	      unsigned int totrk, int cmd, struct dasd_device *device,
+	      int blksize)
 {
 	struct dasd_eckd_private *private = device->private;
-	u32 begcyl, endcyl;
 	u16 heads, beghead, endhead;
+	u32 begcyl, endcyl;
 	int rc = 0;
 
-	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
-	ccw->flags = 0;
-	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	if (ccw) {
+		ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
+		ccw->flags = 0;
+		ccw->count = 16;
+		ccw->cda = (__u32)__pa(data);
+	}
 
 	memset(data, 0, sizeof(struct DE_eckd_data));
 	switch (cmd) {
@@ -269,18 +273,24 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		data->mask.perm = 0x1;
 		data->attributes.operation = DASD_BYPASS_CACHE;
 		break;
+	case DASD_ECKD_CCW_READ_TRACK:
+	case DASD_ECKD_CCW_READ_TRACK_DATA:
+		data->mask.perm = 0x1;
+		data->attributes.operation = private->attrib.operation;
+		data->blk_size = 0;
+		break;
 	case DASD_ECKD_CCW_WRITE:
 	case DASD_ECKD_CCW_WRITE_MT:
 	case DASD_ECKD_CCW_WRITE_KD:
 	case DASD_ECKD_CCW_WRITE_KD_MT:
 		data->mask.perm = 0x02;
 		data->attributes.operation = private->attrib.operation;
-		rc = check_XRC (ccw, data, device);
+		rc = check_XRC(ccw, data, device);
 		break;
 	case DASD_ECKD_CCW_WRITE_CKD:
 	case DASD_ECKD_CCW_WRITE_CKD_MT:
 		data->attributes.operation = DASD_BYPASS_CACHE;
-		rc = check_XRC (ccw, data, device);
+		rc = check_XRC(ccw, data, device);
 		break;
 	case DASD_ECKD_CCW_ERASE:
 	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
@@ -288,7 +298,18 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		data->mask.perm = 0x3;
 		data->mask.auth = 0x1;
 		data->attributes.operation = DASD_BYPASS_CACHE;
-		rc = check_XRC (ccw, data, device);
+		rc = check_XRC(ccw, data, device);
+		break;
+	case DASD_ECKD_CCW_WRITE_FULL_TRACK:
+		data->mask.perm = 0x03;
+		data->attributes.operation = private->attrib.operation;
+		data->blk_size = 0;
+		break;
+	case DASD_ECKD_CCW_WRITE_TRACK_DATA:
+		data->mask.perm = 0x02;
+		data->attributes.operation = private->attrib.operation;
+		data->blk_size = blksize;
+		rc = check_XRC(ccw, data, device);
 		break;
 	default:
 		dev_err(&device->cdev->dev,
@@ -325,36 +346,26 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 	return rc;
 }
 
-static int check_XRC_on_prefix(struct PFX_eckd_data *pfxdata,
-			       struct dasd_device  *device)
-{
-	struct dasd_eckd_private *private = device->private;
-	int rc;
-
-	if (!private->rdc_data.facilities.XRC_supported)
-		return 0;
-
-	/* switch on System Time Stamp - needed for XRC Support */
-	pfxdata->define_extent.ga_extended |= 0x08; /* 'Time Stamp Valid'   */
-	pfxdata->define_extent.ga_extended |= 0x02; /* 'Extended Parameter' */
-	pfxdata->validity.time_stamp = 1;	    /* 'Time Stamp Valid'   */
-
-	rc = get_phys_clock(&pfxdata->define_extent.ep_sys_time);
-	/* Ignore return code if sync clock is switched off. */
-	if (rc == -EOPNOTSUPP || rc == -EACCES)
-		rc = 0;
-	return rc;
-}
 
-static void fill_LRE_data(struct LRE_eckd_data *data, unsigned int trk,
-			  unsigned int rec_on_trk, int count, int cmd,
-			  struct dasd_device *device, unsigned int reclen,
-			  unsigned int tlf)
+static void locate_record_ext(struct ccw1 *ccw, struct LRE_eckd_data *data,
+			      unsigned int trk, unsigned int rec_on_trk,
+			      int count, int cmd, struct dasd_device *device,
+			      unsigned int reclen, unsigned int tlf)
 {
 	struct dasd_eckd_private *private = device->private;
 	int sector;
 	int dn, d;
 
+	if (ccw) {
+		ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD_EXT;
+		ccw->flags = 0;
+		if (cmd == DASD_ECKD_CCW_WRITE_FULL_TRACK)
+			ccw->count = 22;
+		else
+			ccw->count = 20;
+		ccw->cda = (__u32)__pa(data);
+	}
+
 	memset(data, 0, sizeof(*data));
 	sector = 0;
 	if (rec_on_trk) {
@@ -481,14 +492,12 @@ static void fill_LRE_data(struct LRE_eckd_data *data, unsigned int trk,
 static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 		      unsigned int trk, unsigned int totrk, int cmd,
 		      struct dasd_device *basedev, struct dasd_device *startdev,
-		      unsigned char format, unsigned int rec_on_trk, int count,
+		      unsigned int format, unsigned int rec_on_trk, int count,
 		      unsigned int blksize, unsigned int tlf)
 {
 	struct dasd_eckd_private *basepriv, *startpriv;
-	struct DE_eckd_data *dedata;
 	struct LRE_eckd_data *lredata;
-	u32 begcyl, endcyl;
-	u16 heads, beghead, endhead;
+	struct DE_eckd_data *dedata;
 	int rc = 0;
 
 	basepriv = basedev->private;
@@ -527,98 +536,19 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 			pfxdata->validity.hyper_pav = 1;
 	}
 
-	/* define extend data (mostly)*/
-	switch (cmd) {
-	case DASD_ECKD_CCW_READ_HOME_ADDRESS:
-	case DASD_ECKD_CCW_READ_RECORD_ZERO:
-	case DASD_ECKD_CCW_READ:
-	case DASD_ECKD_CCW_READ_MT:
-	case DASD_ECKD_CCW_READ_CKD:
-	case DASD_ECKD_CCW_READ_CKD_MT:
-	case DASD_ECKD_CCW_READ_KD:
-	case DASD_ECKD_CCW_READ_KD_MT:
-		dedata->mask.perm = 0x1;
-		dedata->attributes.operation = basepriv->attrib.operation;
-		break;
-	case DASD_ECKD_CCW_READ_COUNT:
-		dedata->mask.perm = 0x1;
-		dedata->attributes.operation = DASD_BYPASS_CACHE;
-		break;
-	case DASD_ECKD_CCW_READ_TRACK:
-	case DASD_ECKD_CCW_READ_TRACK_DATA:
-		dedata->mask.perm = 0x1;
-		dedata->attributes.operation = basepriv->attrib.operation;
-		dedata->blk_size = 0;
-		break;
-	case DASD_ECKD_CCW_WRITE:
-	case DASD_ECKD_CCW_WRITE_MT:
-	case DASD_ECKD_CCW_WRITE_KD:
-	case DASD_ECKD_CCW_WRITE_KD_MT:
-		dedata->mask.perm = 0x02;
-		dedata->attributes.operation = basepriv->attrib.operation;
-		rc = check_XRC_on_prefix(pfxdata, basedev);
-		break;
-	case DASD_ECKD_CCW_WRITE_CKD:
-	case DASD_ECKD_CCW_WRITE_CKD_MT:
-		dedata->attributes.operation = DASD_BYPASS_CACHE;
-		rc = check_XRC_on_prefix(pfxdata, basedev);
-		break;
-	case DASD_ECKD_CCW_ERASE:
-	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
-	case DASD_ECKD_CCW_WRITE_RECORD_ZERO:
-		dedata->mask.perm = 0x3;
-		dedata->mask.auth = 0x1;
-		dedata->attributes.operation = DASD_BYPASS_CACHE;
-		rc = check_XRC_on_prefix(pfxdata, basedev);
-		break;
-	case DASD_ECKD_CCW_WRITE_FULL_TRACK:
-		dedata->mask.perm = 0x03;
-		dedata->attributes.operation = basepriv->attrib.operation;
-		dedata->blk_size = 0;
-		break;
-	case DASD_ECKD_CCW_WRITE_TRACK_DATA:
-		dedata->mask.perm = 0x02;
-		dedata->attributes.operation = basepriv->attrib.operation;
-		dedata->blk_size = blksize;
-		rc = check_XRC_on_prefix(pfxdata, basedev);
-		break;
-	default:
-		DBF_DEV_EVENT(DBF_ERR, basedev,
-			    "PFX LRE unknown opcode 0x%x", cmd);
-		BUG();
-		return -EINVAL;
-	}
-
-	dedata->attributes.mode = 0x3;	/* ECKD */
-
-	if ((basepriv->rdc_data.cu_type == 0x2105 ||
-	     basepriv->rdc_data.cu_type == 0x2107 ||
-	     basepriv->rdc_data.cu_type == 0x1750)
-	    && !(basepriv->uses_cdl && trk < 2))
-		dedata->ga_extended |= 0x40; /* Regular Data Format Mode */
-
-	heads = basepriv->rdc_data.trk_per_cyl;
-	begcyl = trk / heads;
-	beghead = trk % heads;
-	endcyl = totrk / heads;
-	endhead = totrk % heads;
-
-	/* check for sequential prestage - enhance cylinder range */
-	if (dedata->attributes.operation == DASD_SEQ_PRESTAGE ||
-	    dedata->attributes.operation == DASD_SEQ_ACCESS) {
-
-		if (endcyl + basepriv->attrib.nr_cyl < basepriv->real_cyl)
-			endcyl += basepriv->attrib.nr_cyl;
-		else
-			endcyl = (basepriv->real_cyl - 1);
-	}
+	rc = define_extent(NULL, dedata, trk, totrk, cmd, basedev, blksize);
 
-	set_ch_t(&dedata->beg_ext, begcyl, beghead);
-	set_ch_t(&dedata->end_ext, endcyl, endhead);
+	/*
+	 * For some commands the System Time Stamp is set in the define extent
+	 * data when XRC is supported. The validity of the time stamp must be
+	 * reflected in the prefix data as well.
+	 */
+	if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
+		pfxdata->validity.time_stamp = 1; /* 'Time Stamp Valid'   */
 
 	if (format == 1) {
-		fill_LRE_data(lredata, trk, rec_on_trk, count, cmd,
-			      basedev, blksize, tlf);
+		locate_record_ext(NULL, lredata, trk, rec_on_trk, count, cmd,
+				  basedev, blksize, tlf);
 	}
 
 	return rc;
@@ -1887,7 +1817,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	ccw = cqr->cpaddr;
 	/* Define extent for the first 3 tracks. */
 	define_extent(ccw++, cqr->data, 0, 2,
-		      DASD_ECKD_CCW_READ_COUNT, device);
+		      DASD_ECKD_CCW_READ_COUNT, device, 0);
 	LO_data = cqr->data + sizeof(struct DE_eckd_data);
 	/* Locate record for the first 4 records on track 0. */
 	ccw[-1].flags |= CCW_FLAG_CC;
@@ -2266,7 +2196,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 			   count, 0, 0);
 	} else {
 		define_extent(ccw++, data, fdata->start_unit, fdata->stop_unit,
-			      DASD_ECKD_CCW_READ_COUNT, startdev);
+			      DASD_ECKD_CCW_READ_COUNT, startdev, 0);
 
 		data += sizeof(struct DE_eckd_data);
 		ccw[-1].flags |= CCW_FLAG_CC;
@@ -2420,7 +2350,7 @@ dasd_eckd_build_format(struct dasd_device *base,
 		} else {
 			define_extent(ccw++, (struct DE_eckd_data *) data,
 				      fdata->start_unit, fdata->stop_unit,
-				      DASD_ECKD_CCW_WRITE_CKD, startdev);
+				      DASD_ECKD_CCW_WRITE_CKD, startdev, 0);
 			/* grant subsystem permission to format R0 */
 			if (r0_perm)
 				((struct DE_eckd_data *) data)
@@ -2444,7 +2374,7 @@ dasd_eckd_build_format(struct dasd_device *base,
 		} else {
 			define_extent(ccw++, (struct DE_eckd_data *) data,
 			       fdata->start_unit, fdata->stop_unit,
-			       DASD_ECKD_CCW_WRITE_RECORD_ZERO, startdev);
+			       DASD_ECKD_CCW_WRITE_RECORD_ZERO, startdev, 0);
 			data += sizeof(struct DE_eckd_data);
 		}
 		ccw[-1].flags |= CCW_FLAG_CC;
@@ -2463,7 +2393,7 @@ dasd_eckd_build_format(struct dasd_device *base,
 		} else {
 			define_extent(ccw++, (struct DE_eckd_data *) data,
 			       fdata->start_unit, fdata->stop_unit,
-			       DASD_ECKD_CCW_WRITE_CKD, startdev);
+			       DASD_ECKD_CCW_WRITE_CKD, startdev, 0);
 			data += sizeof(struct DE_eckd_data);
 		}
 		ccw[-1].flags |= CCW_FLAG_CC;
@@ -3187,7 +3117,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 					   sizeof(struct PFX_eckd_data));
 	} else {
 		if (define_extent(ccw++, cqr->data, first_trk,
-				  last_trk, cmd, basedev) == -EAGAIN) {
+				  last_trk, cmd, basedev, 0) == -EAGAIN) {
 			/* Clock not in sync and XRC is enabled.
 			 * Try again later.
 			 */
@@ -3509,12 +3439,19 @@ static int prepare_itcw(struct itcw *itcw,
 		dedata->mask.perm = 0x02;
 		dedata->attributes.operation = basepriv->attrib.operation;
 		dedata->blk_size = blksize;
-		rc = check_XRC_on_prefix(&pfxdata, basedev);
+		rc = check_XRC(NULL, dedata, basedev);
 		dedata->ga_extended |= 0x42;
 		lredata->operation.orientation = 0x0;
 		lredata->operation.operation = 0x3F;
 		lredata->extended_operation = 0x23;
 		lredata->auxiliary.check_bytes = 0x2;
+		/*
+		 * If XRC is supported the System Time Stamp is set. The
+		 * validity of the time stamp must be reflected in the prefix
+		 * data as well.
+		 */
+		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
+			pfxdata.validity.time_stamp = 1; /* 'Time Stamp Valid' */
 		pfx_cmd = DASD_ECKD_CCW_PFX;
 		break;
 	case DASD_ECKD_CCW_READ_COUNT_MT:
@@ -3842,25 +3779,28 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	return cqr;
 }
 
-static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
-					       struct dasd_block *block,
-					       struct request *req)
+static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
+						   struct dasd_block *block,
+						   struct request *req)
 {
-	unsigned long *idaws;
+	sector_t start_padding_sectors, end_sector_offset, end_padding_sectors;
+	unsigned int seg_len, len_to_track_end;
+	unsigned int cidaw, cplength, datasize;
+	sector_t first_trk, last_trk, sectors;
+	struct dasd_eckd_private *base_priv;
 	struct dasd_device *basedev;
-	struct dasd_ccw_req *cqr;
-	struct ccw1 *ccw;
 	struct req_iterator iter;
+	struct dasd_ccw_req *cqr;
+	unsigned int first_offs;
+	unsigned int trkcount;
+	unsigned long *idaws;
+	unsigned int size;
+	unsigned char cmd;
 	struct bio_vec bv;
+	struct ccw1 *ccw;
+	int use_prefix;
+	void *data;
 	char *dst;
-	unsigned char cmd;
-	unsigned int trkcount;
-	unsigned int seg_len, len_to_track_end;
-	unsigned int first_offs;
-	unsigned int cidaw, cplength, datasize;
-	sector_t first_trk, last_trk, sectors;
-	sector_t start_padding_sectors, end_sector_offset, end_padding_sectors;
-	unsigned int pfx_datasize;
 
 	/*
 	 * raw track access needs to be mutiple of 64k and on 64k boundary
@@ -3878,8 +3818,7 @@ static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
 		DBF_DEV_EVENT(DBF_ERR, basedev,
 			      "raw write not track aligned (%lu,%lu) req %p",
 			      start_padding_sectors, end_padding_sectors, req);
-		cqr = ERR_PTR(-EINVAL);
-		goto out;
+		return ERR_PTR(-EINVAL);
 	}
 
 	first_trk = blk_rq_pos(req) / DASD_RAW_SECTORS_PER_TRACK;
@@ -3892,10 +3831,8 @@ static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
 		cmd = DASD_ECKD_CCW_READ_TRACK;
 	else if (rq_data_dir(req) == WRITE)
 		cmd = DASD_ECKD_CCW_WRITE_FULL_TRACK;
-	else {
-		cqr = ERR_PTR(-EINVAL);
-		goto out;
-	}
+	else
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Raw track based I/O needs IDAWs for each page,
@@ -3903,38 +3840,46 @@ static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
 	 */
 	cidaw = trkcount * DASD_RAW_BLOCK_PER_TRACK;
 
-	/* 1x prefix + one read/write ccw per track */
-	cplength = 1 + trkcount;
-
 	/*
-	 * struct PFX_eckd_data has up to 2 byte as extended parameter
-	 * this is needed for write full track and has to be mentioned
-	 * separately
-	 * add 8 instead of 2 to keep 8 byte boundary
+	 * struct PFX_eckd_data and struct LRE_eckd_data can have up to 2 bytes
+	 * of extended parameter. This is needed for write full track.
 	 */
-	pfx_datasize = sizeof(struct PFX_eckd_data) + 8;
+	base_priv = basedev->private;
+	use_prefix = base_priv->features.feature[8] & 0x01;
+	if (use_prefix) {
+		cplength = 1 + trkcount;
+		size = sizeof(struct PFX_eckd_data) + 2;
+	} else {
+		cplength = 2 + trkcount;
+		size = sizeof(struct DE_eckd_data) +
+			sizeof(struct LRE_eckd_data) + 2;
+	}
+	size = ALIGN(size, 8);
 
-	datasize = pfx_datasize + cidaw * sizeof(unsigned long long);
+	datasize = size + cidaw * sizeof(unsigned long long);
 
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, cplength,
 				   datasize, startdev);
 	if (IS_ERR(cqr))
-		goto out;
+		return cqr;
+
 	ccw = cqr->cpaddr;
+	data = cqr->data;
 
-	if (prefix_LRE(ccw++, cqr->data, first_trk, last_trk, cmd,
-		       basedev, startdev, 1 /* format */, first_offs + 1,
-		       trkcount, 0, 0) == -EAGAIN) {
-		/* Clock not in sync and XRC is enabled.
-		 * Try again later.
-		 */
-		dasd_sfree_request(cqr, startdev);
-		cqr = ERR_PTR(-EAGAIN);
-		goto out;
+	if (use_prefix) {
+		prefix_LRE(ccw++, data, first_trk, last_trk, cmd, basedev,
+			   startdev, 1, first_offs + 1, trkcount, 0, 0);
+	} else {
+		define_extent(ccw++, data, first_trk, last_trk, cmd, basedev, 0);
+		ccw[-1].flags |= CCW_FLAG_CC;
+
+		data += sizeof(struct DE_eckd_data);
+		locate_record_ext(ccw++, data, first_trk, first_offs + 1,
+				  trkcount, cmd, basedev, 0, 0);
 	}
 
-	idaws = (unsigned long *)(cqr->data + pfx_datasize);
+	idaws = (unsigned long *)(cqr->data + size);
 	len_to_track_end = 0;
 	if (start_padding_sectors) {
 		ccw[-1].flags |= CCW_FLAG_CC;
@@ -3984,9 +3929,6 @@ static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
 
-	if (IS_ERR(cqr) && PTR_ERR(cqr) != -EAGAIN)
-		cqr = NULL;
-out:
 	return cqr;
 }
 
@@ -4096,7 +4038,7 @@ static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
 	spin_lock_irqsave(get_ccwdev_lock(startdev->cdev), flags);
 	private->count++;
 	if ((base->features & DASD_FEATURE_USERAW))
-		cqr = dasd_raw_build_cp(startdev, block, req);
+		cqr = dasd_eckd_build_cp_raw(startdev, block, req);
 	else
 		cqr = dasd_eckd_build_cp(startdev, block, req);
 	if (IS_ERR(cqr))
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index e2a710c..fb1f537d 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -29,6 +29,7 @@
 #define DASD_ECKD_CCW_SNID		 0x34
 #define DASD_ECKD_CCW_RSSD		 0x3e
 #define DASD_ECKD_CCW_LOCATE_RECORD	 0x47
+#define DASD_ECKD_CCW_LOCATE_RECORD_EXT	 0x4b
 #define DASD_ECKD_CCW_SNSS		 0x54
 #define DASD_ECKD_CCW_DEFINE_EXTENT	 0x63
 #define DASD_ECKD_CCW_WRITE_MT		 0x85
diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 42018a2..0071feb 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -278,7 +278,7 @@ struct scm_queue {
 	spinlock_t lock;
 };
 
-static int scm_blk_request(struct blk_mq_hw_ctx *hctx,
+static blk_status_t scm_blk_request(struct blk_mq_hw_ctx *hctx,
 			   const struct blk_mq_queue_data *qd)
 {
 	struct scm_device *scmdev = hctx->queue->queuedata;
@@ -290,7 +290,7 @@ static int scm_blk_request(struct blk_mq_hw_ctx *hctx,
 	spin_lock(&sq->lock);
 	if (!scm_permit_request(bdev, req)) {
 		spin_unlock(&sq->lock);
-		return BLK_MQ_RQ_QUEUE_BUSY;
+		return BLK_STS_RESOURCE;
 	}
 
 	scmrq = sq->scmrq;
@@ -299,7 +299,7 @@ static int scm_blk_request(struct blk_mq_hw_ctx *hctx,
 		if (!scmrq) {
 			SCM_LOG(5, "no request");
 			spin_unlock(&sq->lock);
-			return BLK_MQ_RQ_QUEUE_BUSY;
+			return BLK_STS_RESOURCE;
 		}
 		scm_request_init(bdev, scmrq);
 		sq->scmrq = scmrq;
@@ -315,7 +315,7 @@ static int scm_blk_request(struct blk_mq_hw_ctx *hctx,
 
 		sq->scmrq = NULL;
 		spin_unlock(&sq->lock);
-		return BLK_MQ_RQ_QUEUE_BUSY;
+		return BLK_STS_RESOURCE;
 	}
 	blk_mq_start_request(req);
 
@@ -324,7 +324,7 @@ static int scm_blk_request(struct blk_mq_hw_ctx *hctx,
 		sq->scmrq = NULL;
 	}
 	spin_unlock(&sq->lock);
-	return BLK_MQ_RQ_QUEUE_OK;
+	return BLK_STS_OK;
 }
 
 static int scm_blk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index a25367e..82f05c4 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -69,12 +69,10 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 static void vfio_ccw_sch_io_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
-	struct subchannel *sch;
 	struct irb *irb;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	irb = &private->irb;
-	sch = private->sch;
 
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index b1c27e2..b5f4006 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -94,7 +94,7 @@ static inline int zcrypt_process_rescan(void)
 		atomic_set(&zcrypt_rescan_req, 0);
 		atomic_inc(&zcrypt_rescan_count);
 		ap_bus_force_rescan();
-		ZCRYPT_DBF(DBF_INFO, "rescan count=%07d",
+		ZCRYPT_DBF(DBF_INFO, "rescan count=%07d\n",
 			   atomic_inc_return(&zcrypt_rescan_count));
 		return 1;
 	}
@@ -822,7 +822,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				rc = zcrypt_rsa_modexpo(&mex);
 			} while (rc == -EAGAIN);
 		if (rc) {
-			ZCRYPT_DBF(DBF_DEBUG, "ioctl ICARSAMODEXPO rc=%d", rc);
+			ZCRYPT_DBF(DBF_DEBUG, "ioctl ICARSAMODEXPO rc=%d\n", rc);
 			return rc;
 		}
 		return put_user(mex.outputdatalength, &umex->outputdatalength);
@@ -841,7 +841,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				rc = zcrypt_rsa_crt(&crt);
 			} while (rc == -EAGAIN);
 		if (rc) {
-			ZCRYPT_DBF(DBF_DEBUG, "ioctl ICARSACRT rc=%d", rc);
+			ZCRYPT_DBF(DBF_DEBUG, "ioctl ICARSACRT rc=%d\n", rc);
 			return rc;
 		}
 		return put_user(crt.outputdatalength, &ucrt->outputdatalength);
@@ -860,7 +860,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				rc = zcrypt_send_cprb(&xcRB);
 			} while (rc == -EAGAIN);
 		if (rc)
-			ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDCPRB rc=%d", rc);
+			ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDCPRB rc=%d\n", rc);
 		if (copy_to_user(uxcRB, &xcRB, sizeof(xcRB)))
 			return -EFAULT;
 		return rc;
@@ -879,7 +879,7 @@ static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
 				rc = zcrypt_send_ep11_cprb(&xcrb);
 			} while (rc == -EAGAIN);
 		if (rc)
-			ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDEP11CPRB rc=%d", rc);
+			ZCRYPT_DBF(DBF_DEBUG, "ioctl ZSENDEP11CPRB rc=%d\n", rc);
 		if (copy_to_user(uxcrb, &xcrb, sizeof(xcrb)))
 			return -EFAULT;
 		return rc;
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 541a197..4090a42 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -10,6 +10,11 @@
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
 
+/*
+ * The per-cpu notes area is a list of notes terminated by a "NULL"
+ * note header.  For kdump, the code in vmcore.c runs in the context
+ * of the second kernel to combine them into one note.
+ */
 #define CRASH_CORE_NOTE_BYTES	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
 				     CRASH_CORE_NOTE_NAME_BYTES +	\
 				     CRASH_CORE_NOTE_DESC_BYTES)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c9481eb..6588841 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -63,15 +63,6 @@
 #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
 
 /*
- * The per-cpu notes area is a list of notes terminated by a "NULL"
- * note header.  For kdump, the code in vmcore.c runs in the context
- * of the second kernel to combine them into one note.
- */
-#ifndef KEXEC_NOTE_BYTES
-#define KEXEC_NOTE_BYTES	CRASH_CORE_NOTE_BYTES
-#endif
-
-/*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
  */
