Return-Path: <linux-kernel-owner+w=401wt.eu-S1755152AbYJAJBJ@vger.kernel.org>
Message-Id: <20081001084130.599948666@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/21] Add ioctl support for EMC Symmetrix Subsystem Control I/O
Content-Disposition: inline; filename=120-dasd-emc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Nigel Hislop <hislop_nigel@emc.com>, Hannes Reinecke <hare@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Nigel Hislop <hislop_nigel@emc.com>

EMC Symmetrix Subsystem Control I/O through CKD dasd requires a
specific parameter list sent to the array via a Perform Subsystem
Function CCW. The Symmetrix response is retrieved from the array
via a Read Subsystem Data CCW.
    
Signed-off-by: Nigel Hislop <hislop_nigel@emc.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/dasd.h   |   13 +++++
 drivers/s390/block/dasd_eckd.c |   98 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

Index: quilt-2.6/arch/s390/include/asm/dasd.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/dasd.h
+++ quilt-2.6/arch/s390/include/asm/dasd.h
@@ -3,6 +3,8 @@
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
+ * EMC Symmetrix ioctl Copyright EMC Corporation, 2008
+ * Author.........: Nigel Hislop <hislop_nigel@emc.com>
  *
  * This file is the interface of the DASD device driver, which is exported to user space
  * any future changes wrt the API will result in a change of the APIVERSION reported
@@ -202,6 +204,16 @@ typedef struct attrib_data_t {
 #define DASD_SEQ_PRESTAGE  0x4
 #define DASD_REC_ACCESS    0x5
 
+/*
+ * Perform EMC Symmetrix I/O
+ */
+typedef struct dasd_symmio_parms {
+	unsigned char reserved[8];	/* compat with older releases */
+	unsigned long long psf_data;	/* char * cast to u64 */
+	unsigned long long rssd_result; /* char * cast to u64 */
+	int psf_data_len;
+	int rssd_result_len;
+} __attribute__ ((packed)) dasd_symmio_parms_t;
 
 /********************************************************************************
  * SECTION: Definition of IOCTLs
@@ -247,6 +259,7 @@ typedef struct attrib_data_t {
 /* Set Attributes (cache operations) */
 #define BIODASDSATTR   _IOW(DASD_IOCTL_LETTER,2,attrib_data_t) 
 
+#define BIODASDSYMMIO  _IOWR(DASD_IOCTL_LETTER, 240, dasd_symmio_parms_t)
 
 #endif				/* DASD_H */
 
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -6,6 +6,8 @@
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
+ * EMC Symmetrix ioctl Copyright EMC Corporation, 2008
+ * Author.........: Nigel Hislop <hislop_nigel@emc.com>
  *
  */
 
@@ -2083,6 +2085,100 @@ dasd_eckd_set_attrib(struct dasd_device 
 	return 0;
 }
 
+/*
+ * Issue syscall I/O to EMC Symmetrix array.
+ * CCWs are PSF and RSSD
+ */
+static int dasd_symm_io(struct dasd_device *device, void __user *argp)
+{
+	struct dasd_symmio_parms usrparm;
+	char *psf_data, *rssd_result;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	/* Copy parms from caller */
+	rc = copy_from_user(&usrparm, argp, sizeof(usrparm)) ? -EFAULT : 0;
+	if (rc)
+		goto out;
+#ifndef CONFIG_64BIT
+	/* Make sure pointers are sane even on 31 bit. */
+	if ((usrparm.psf_data >> 32) != 0 || (usrparm.rssd_result >> 32) != 0) {
+		rc = -EINVAL;
+		goto out;
+	}
+#endif
+	/* alloc I/O data area */
+	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
+	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
+	if (!psf_data || !rssd_result) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+
+	/* get syscall header from user space */
+	rc = copy_from_user(psf_data,
+			    (void __user *)(unsigned long) usrparm.psf_data,
+			    usrparm.psf_data_len) ? -EFAULT : 0;
+	if (rc)
+		goto out_free;
+
+	/* sanity check on syscall header */
+	if (psf_data[0] != 0x17 && psf_data[1] != 0xce) {
+		rc = -EINVAL;
+		goto out_free;
+	}
+
+	/* setup CCWs for PSF + RSSD */
+	cqr = dasd_smalloc_request("ECKD", 2 , 0, device);
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			"Could not allocate initialization request");
+		rc = PTR_ERR(cqr);
+		goto out_free;
+	}
+
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->retries = 3;
+	cqr->expires = 10 * HZ;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	/* Build the ccws */
+	ccw = cqr->cpaddr;
+
+	/* PSF ccw */
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = usrparm.psf_data_len;
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->cda = (__u32)(addr_t) psf_data;
+
+	ccw++;
+
+	/* RSSD ccw  */
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = usrparm.rssd_result_len;
+	ccw->flags = CCW_FLAG_SLI ;
+	ccw->cda = (__u32)(addr_t) rssd_result;
+
+	rc = dasd_sleep_on(cqr);
+	if (rc)
+		goto out_sfree;
+
+	rc = copy_to_user((void __user *)(unsigned long) usrparm.rssd_result,
+			   rssd_result, usrparm.rssd_result_len) ? -EFAULT : 0;
+
+out_sfree:
+	dasd_sfree_request(cqr, cqr->memdev);
+out_free:
+	kfree(rssd_result);
+	kfree(psf_data);
+out:
+	DBF_DEV_EVENT(DBF_WARNING, device, "Symmetrix ioctl: rc=%d", rc);
+	return rc;
+}
+
 static int
 dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
 {
@@ -2101,6 +2197,8 @@ dasd_eckd_ioctl(struct dasd_block *block
 		return dasd_eckd_reserve(device);
 	case BIODASDSLCK:
 		return dasd_eckd_steal_lock(device);
+	case BIODASDSYMMIO:
+		return dasd_symm_io(device, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
