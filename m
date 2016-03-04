Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH] s390: Use pr_warn instead of pr_warning
Date: Thu,  3 Mar 2016 20:49:57 -0800
Message-Id: <43507081eed8c522d66746b916f098b4ca39461d.1457066864.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Convert the uses of pr_warning to pr_warn so there are fewer
uses of the old pr_warning.

Miscellanea:

o Align arguments
o Coalesce formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/s390/kernel/cpcmd.c         |  3 +--
 arch/s390/kernel/debug.c         |  6 ++----
 arch/s390/kernel/time.c          |  6 ++----
 arch/s390/mm/extmem.c            | 16 +++++++---------
 drivers/s390/block/dasd_devmap.c | 10 ++++------
 drivers/s390/block/dasd_diag.c   | 28 +++++++++++++---------------
 drivers/s390/block/dasd_genhd.c  |  4 ++--
 drivers/s390/block/dasd_ioctl.c  |  5 ++---
 drivers/s390/block/dasd_proc.c   |  5 ++---
 drivers/s390/block/dcssblk.c     | 13 ++++++-------
 drivers/s390/char/monreader.c    | 10 +++++-----
 drivers/s390/char/sclp_cmd.c     | 27 ++++++++++++---------------
 drivers/s390/char/sclp_cpi_sys.c |  6 ++----
 drivers/s390/char/tape_core.c    |  4 ++--
 drivers/s390/char/vmlogrdr.c     |  6 ++----
 drivers/s390/cio/blacklist.c     |  9 ++++-----
 drivers/s390/cio/ccwreq.c        | 13 ++++++-------
 drivers/s390/cio/cio.c           |  2 +-
 drivers/s390/cio/device.c        | 23 ++++++++++-------------
 drivers/s390/net/lcs.c           |  4 ++--
 drivers/s390/net/qeth_l3_main.c  |  2 +-
 21 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/arch/s390/kernel/cpcmd.c b/arch/s390/kernel/cpcmd.c
index 7f76891..7f48e56 100644
--- a/arch/s390/kernel/cpcmd.c
+++ b/arch/s390/kernel/cpcmd.c
@@ -96,8 +96,7 @@ int cpcmd(const char *cmd, char *response, int rlen, int *response_code)
 			(((unsigned long)response + rlen) >> 31)) {
 		lowbuf = kmalloc(rlen, GFP_KERNEL | GFP_DMA);
 		if (!lowbuf) {
-			pr_warning("The cpcmd kernel function failed to "
-				   "allocate a response buffer\n");
+			pr_warn("The cpcmd kernel function failed to allocate a response buffer\n");
 			return -ENOMEM;
 		}
 		spin_lock_irqsave(&cpcmd_lock, flags);
diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index c890a55..aa12de7 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -699,8 +699,7 @@ debug_info_t *debug_register_mode(const char *name, int pages_per_area,
 	/* Since debugfs currently does not support uid/gid other than root, */
 	/* we do not allow gid/uid != 0 until we get support for that. */
 	if ((uid != 0) || (gid != 0))
-		pr_warning("Root becomes the owner of all s390dbf files "
-			   "in sysfs\n");
+		pr_warn("Root becomes the owner of all s390dbf files in sysfs\n");
 	BUG_ON(!initialized);
 	mutex_lock(&debug_mutex);
 
@@ -1307,8 +1306,7 @@ debug_input_level_fn(debug_info_t * id, struct debug_view *view,
 		new_level = debug_get_uint(str);
 	}
 	if(new_level < 0) {
-		pr_warning("%s is not a valid level for a debug "
-			   "feature\n", str);
+		pr_warn("%s is not a valid level for a debug feature\n", str);
 		rc = -EINVAL;
 	} else {
 		debug_set_level(id, new_level);
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 580bc72..9409d32 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -499,8 +499,7 @@ static void etr_reset(void)
 		if (etr_port0_online && etr_port1_online)
 			set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	} else if (etr_port0_online || etr_port1_online) {
-		pr_warning("The real or virtual hardware system does "
-			   "not provide an ETR interface\n");
+		pr_warn("The real or virtual hardware system does not provide an ETR interface\n");
 		etr_port0_online = etr_port1_online = 0;
 	}
 }
@@ -1460,8 +1459,7 @@ static void __init stp_reset(void)
 	if (rc == 0)
 		set_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags);
 	else if (stp_online) {
-		pr_warning("The real or virtual hardware system does "
-			   "not provide an STP interface\n");
+		pr_warn("The real or virtual hardware system does not provide an STP interface\n");
 		free_page((unsigned long) stp_page);
 		stp_page = NULL;
 		stp_online = 0;
diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index a1bf4ad..02042b6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -265,7 +265,7 @@ query_segment_type (struct dcss_segment *seg)
 		goto out_free;
 	}
 	if (diag_cc > 1) {
-		pr_warning("Querying a DCSS type failed with rc=%ld\n", vmrc);
+		pr_warn("Querying a DCSS type failed with rc=%ld\n", vmrc);
 		rc = dcss_diag_translate_rc (vmrc);
 		goto out_free;
 	}
@@ -457,8 +457,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		goto out_resource;
 	}
 	if (diag_cc > 1) {
-		pr_warning("Loading DCSS %s failed with rc=%ld\n", name,
-			   end_addr);
+		pr_warn("Loading DCSS %s failed with rc=%ld\n", name, end_addr);
 		rc = dcss_diag_translate_rc(end_addr);
 		dcss_diag(&purgeseg_scode, seg->dcss_name,
 				&dummy, &dummy);
@@ -574,8 +573,7 @@ segment_modify_shared (char *name, int do_nonshared)
 		goto out_unlock;
 	}
 	if (atomic_read (&seg->ref_count) != 1) {
-		pr_warning("DCSS %s is in use and cannot be reloaded\n",
-			   name);
+		pr_warn("DCSS %s is in use and cannot be reloaded\n", name);
 		rc = -EAGAIN;
 		goto out_unlock;
 	}
@@ -588,8 +586,8 @@ segment_modify_shared (char *name, int do_nonshared)
 			seg->res->flags |= IORESOURCE_READONLY;
 
 	if (request_resource(&iomem_resource, seg->res)) {
-		pr_warning("DCSS %s overlaps with used memory resources "
-			   "and cannot be reloaded\n", name);
+		pr_warn("DCSS %s overlaps with used memory resources and cannot be reloaded\n",
+			name);
 		rc = -EBUSY;
 		kfree(seg->res);
 		goto out_del_mem;
@@ -607,8 +605,8 @@ segment_modify_shared (char *name, int do_nonshared)
 		goto out_del_res;
 	}
 	if (diag_cc > 1) {
-		pr_warning("Reloading DCSS %s failed with rc=%ld\n", name,
-			   end_addr);
+		pr_warn("Reloading DCSS %s failed with rc=%ld\n",
+			name, end_addr);
 		rc = dcss_diag_translate_rc(end_addr);
 		goto out_del_res;
 	}
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 8286f74..2f18f61 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -214,8 +214,8 @@ dasd_feature_list(char *str, char **endp)
 		else if (len == 8 && !strncmp(str, "failfast", 8))
 			features |= DASD_FEATURE_FAILFAST;
 		else {
-			pr_warning("%*s is not a supported device option\n",
-				   len, str);
+			pr_warn("%*s is not a supported device option\n",
+				len, str);
 			rc = -EINVAL;
 		}
 		str += len;
@@ -224,8 +224,7 @@ dasd_feature_list(char *str, char **endp)
 		str++;
 	}
 	if (*str != ')') {
-		pr_warning("A closing parenthesis ')' is missing in the "
-			   "dasd= parameter\n");
+		pr_warn("A closing parenthesis ')' is missing in the dasd= parameter\n");
 		rc = -EINVAL;
 	} else
 		str++;
@@ -348,8 +347,7 @@ dasd_parse_range( char *parsestring ) {
 		return str + 1;
 	if (*str == '\0')
 		return str;
-	pr_warning("The dasd= parameter value %s has an invalid ending\n",
-		   str);
+	pr_warn("The dasd= parameter value %s has an invalid ending\n", str);
 	return ERR_PTR(-EINVAL);
 }
 
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index cb61f30..1636986 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -148,14 +148,13 @@ dasd_diag_erp(struct dasd_device *device)
 	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
 	if (rc == 4) {
 		if (!(test_and_set_bit(DASD_FLAG_DEVICE_RO, &device->flags)))
-			pr_warning("%s: The access mode of a DIAG device "
-				   "changed to read-only\n",
-				   dev_name(&device->cdev->dev));
+			pr_warn("%s: The access mode of a DIAG device changed to read-only\n",
+				dev_name(&device->cdev->dev));
 		rc = 0;
 	}
 	if (rc)
-		pr_warning("%s: DIAG ERP failed with "
-			    "rc=%d\n", dev_name(&device->cdev->dev), rc);
+		pr_warn("%s: DIAG ERP failed with rc=%d\n",
+			dev_name(&device->cdev->dev), rc);
 }
 
 /* Start a given request at the device. Return zero on success, non-zero
@@ -372,9 +371,9 @@ dasd_diag_check_device(struct dasd_device *device)
 		private->pt_block = 2;
 		break;
 	default:
-		pr_warning("%s: Device type %d is not supported "
-			   "in DIAG mode\n", dev_name(&device->cdev->dev),
-			   private->rdc_data.vdev_class);
+		pr_warn("%s: Device type %d is not supported in DIAG mode\n",
+			dev_name(&device->cdev->dev),
+			private->rdc_data.vdev_class);
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
@@ -415,8 +414,8 @@ dasd_diag_check_device(struct dasd_device *device)
 		private->iob.flaga = DASD_DIAG_FLAGA_DEFAULT;
 		rc = dia250(&private->iob, RW_BIO);
 		if (rc == 3) {
-			pr_warning("%s: A 64-bit DIAG call failed\n",
-				   dev_name(&device->cdev->dev));
+			pr_warn("%s: A 64-bit DIAG call failed\n",
+				dev_name(&device->cdev->dev));
 			rc = -EOPNOTSUPP;
 			goto out_label;
 		}
@@ -425,9 +424,8 @@ dasd_diag_check_device(struct dasd_device *device)
 			break;
 	}
 	if (bsize > PAGE_SIZE) {
-		pr_warning("%s: Accessing the DASD failed because of an "
-			   "incorrect format (rc=%d)\n",
-			   dev_name(&device->cdev->dev), rc);
+		pr_warn("%s: Accessing the DASD failed because of an incorrect format (rc=%d)\n",
+			dev_name(&device->cdev->dev), rc);
 		rc = -EIO;
 		goto out_label;
 	}
@@ -445,8 +443,8 @@ dasd_diag_check_device(struct dasd_device *device)
 		block->s2b_shift++;
 	rc = mdsk_init_io(device, block->bp_block, 0, NULL);
 	if (rc && (rc != 4)) {
-		pr_warning("%s: DIAG initialization failed with rc=%d\n",
-			   dev_name(&device->cdev->dev), rc);
+		pr_warn("%s: DIAG initialization failed with rc=%d\n",
+			dev_name(&device->cdev->dev), rc);
 		rc = -EIO;
 	} else {
 		if (rc == 4)
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index ef1d9fb..31d544a 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -178,8 +178,8 @@ int dasd_gendisk_init(void)
 	/* Register to static dasd major 94 */
 	rc = register_blkdev(DASD_MAJOR, "dasd");
 	if (rc != 0) {
-		pr_warning("Registering the device driver with major number "
-			   "%d failed\n", DASD_MAJOR);
+		pr_warn("Registering the device driver with major number %d failed\n",
+			DASD_MAJOR);
 		return rc;
 	}
 	return 0;
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 02837d0..a3a20de 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -286,9 +286,8 @@ dasd_ioctl_format(struct block_device *bdev, void __user *argp)
 		return -EFAULT;
 	}
 	if (bdev != bdev->bd_contains) {
-		pr_warning("%s: The specified DASD is a partition and cannot "
-			   "be formatted\n",
-			   dev_name(&base->cdev->dev));
+		pr_warn("%s: The specified DASD is a partition and cannot be formatted\n",
+			dev_name(&base->cdev->dev));
 		dasd_put_device(base);
 		return -EINVAL;
 	}
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index aa7bb2d..bad7a19 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -322,13 +322,12 @@ static ssize_t dasd_stats_proc_write(struct file *file,
 	return user_len;
 out_parse_error:
 	rc = -EINVAL;
-	pr_warning("%s is not a supported value for /proc/dasd/statistics\n",
-		str);
+	pr_warn("%s is not a supported value for /proc/dasd/statistics\n", str);
 out_error:
 	vfree(buffer);
 	return rc;
 #else
-	pr_warning("/proc/dasd/statistics: is not activated in this kernel\n");
+	pr_warn("/proc/dasd/statistics: is not activated in this kernel\n");
 	return user_len;
 #endif				/* CONFIG_DASD_PROFILE */
 }
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index ce7b701..1bce9cf 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -738,15 +738,15 @@ dcssblk_remove_store(struct device *dev, struct device_attribute *attr, const ch
 	dev_info = dcssblk_get_device_by_name(local_buf);
 	if (dev_info == NULL) {
 		up_write(&dcssblk_devices_sem);
-		pr_warning("Device %s cannot be removed because it is not a "
-			   "known device\n", local_buf);
+		pr_warn("Device %s cannot be removed because it is not a known device\n",
+			local_buf);
 		rc = -ENODEV;
 		goto out_buf;
 	}
 	if (atomic_read(&dev_info->use_count) != 0) {
 		up_write(&dcssblk_devices_sem);
-		pr_warning("Device %s cannot be removed while it is in "
-			   "use\n", local_buf);
+		pr_warn("Device %s cannot be removed while it is in use\n",
+			local_buf);
 		rc = -EBUSY;
 		goto out_buf;
 	}
@@ -850,9 +850,8 @@ dcssblk_make_request(struct request_queue *q, struct bio *bio)
 		case SEG_TYPE_SC:
 			/* cannot write to these segments */
 			if (bio_data_dir(bio) == WRITE) {
-				pr_warning("Writing to %s failed because it "
-					   "is a read-only device\n",
-					   dev_name(&dev_info->dev));
+				pr_warn("Writing to %s failed because it is a read-only device\n",
+					dev_name(&dev_info->dev));
 				goto fail;
 			}
 		}
diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index fc94bfd..ebdeaa5 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -257,7 +257,7 @@ static void mon_iucv_message_pending(struct iucv_path *path,
 	memcpy(&monpriv->msg_array[monpriv->write_index]->msg,
 	       msg, sizeof(*msg));
 	if (atomic_inc_return(&monpriv->msglim_count) == MON_MSGLIM) {
-		pr_warning("The read queue for monitor data is full\n");
+		pr_warn("The read queue for monitor data is full\n");
 		monpriv->msg_array[monpriv->write_index]->msglim_reached = 1;
 	}
 	monpriv->write_index = (monpriv->write_index + 1) % MON_MSGLIM;
@@ -342,8 +342,8 @@ static int mon_close(struct inode *inode, struct file *filp)
 	if (monpriv->path) {
 		rc = iucv_path_sever(monpriv->path, user_data_sever);
 		if (rc)
-			pr_warning("Disconnecting the z/VM *MONITOR system "
-				   "service failed with rc=%i\n", rc);
+			pr_warn("Disconnecting the z/VM *MONITOR system service failed with rc=%i\n",
+				rc);
 		iucv_path_free(monpriv->path);
 	}
 
@@ -469,8 +469,8 @@ static int monreader_freeze(struct device *dev)
 	if (monpriv->path) {
 		rc = iucv_path_sever(monpriv->path, user_data_sever);
 		if (rc)
-			pr_warning("Disconnecting the z/VM *MONITOR system "
-				   "service failed with rc=%i\n", rc);
+			pr_warn("Disconnecting the z/VM *MONITOR system service failed with rc=%i\n",
+				rc);
 		iucv_path_free(monpriv->path);
 	}
 	atomic_set(&monpriv->iucv_severed, 0);
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 806239c..d3947ea 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -67,8 +67,8 @@ int sclp_sync_request_timeout(sclp_cmdw_t cmd, void *sccb, int timeout)
 
 	/* Check response. */
 	if (request->status != SCLP_REQ_DONE) {
-		pr_warning("sync request failed (cmd=0x%08x, "
-			   "status=0x%02x)\n", cmd, request->status);
+		pr_warn("sync request failed (cmd=0x%08x, status=0x%02x)\n",
+			cmd, request->status);
 		rc = -EIO;
 	}
 out:
@@ -122,8 +122,8 @@ int sclp_get_core_info(struct sclp_core_info *info)
 	if (rc)
 		goto out;
 	if (sccb->header.response_code != 0x0010) {
-		pr_warning("readcpuinfo failed (response=0x%04x)\n",
-			   sccb->header.response_code);
+		pr_warn("readcpuinfo failed (response=0x%04x)\n",
+			sccb->header.response_code);
 		rc = -EIO;
 		goto out;
 	}
@@ -160,9 +160,8 @@ static int do_core_configure(sclp_cmdw_t cmd)
 	case 0x0120:
 		break;
 	default:
-		pr_warning("configure cpu failed (cmd=0x%08x, "
-			   "response=0x%04x)\n", cmd,
-			   sccb->header.response_code);
+		pr_warn("configure cpu failed (cmd=0x%08x, response=0x%04x)\n",
+			cmd, sccb->header.response_code);
 		rc = -EIO;
 		break;
 	}
@@ -230,9 +229,8 @@ static int do_assign_storage(sclp_cmdw_t cmd, u16 rn)
 	case 0x0120:
 		break;
 	default:
-		pr_warning("assign storage failed (cmd=0x%08x, "
-			   "response=0x%04x, rn=0x%04x)\n", cmd,
-			   sccb->header.response_code, rn);
+		pr_warn("assign storage failed (cmd=0x%08x, response=0x%04x, rn=0x%04x)\n",
+			cmd, sccb->header.response_code, rn);
 		rc = -EIO;
 		break;
 	}
@@ -675,9 +673,8 @@ static int do_chp_configure(sclp_cmdw_t cmd)
 	case 0x0450:
 		break;
 	default:
-		pr_warning("configure channel-path failed "
-			   "(cmd=0x%08x, response=0x%04x)\n", cmd,
-			   sccb->header.response_code);
+		pr_warn("configure channel-path failed (cmd=0x%08x, response=0x%04x)\n",
+			cmd, sccb->header.response_code);
 		rc = -EIO;
 		break;
 	}
@@ -744,8 +741,8 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
 	if (rc)
 		goto out;
 	if (sccb->header.response_code != 0x0010) {
-		pr_warning("read channel-path info failed "
-			   "(response=0x%04x)\n", sccb->header.response_code);
+		pr_warn("read channel-path info failed (response=0x%04x)\n",
+			sccb->header.response_code);
 		rc = -EIO;
 		goto out;
 	}
diff --git a/drivers/s390/char/sclp_cpi_sys.c b/drivers/s390/char/sclp_cpi_sys.c
index 2acea80..f344e5b 100644
--- a/drivers/s390/char/sclp_cpi_sys.c
+++ b/drivers/s390/char/sclp_cpi_sys.c
@@ -154,16 +154,14 @@ static int cpi_req(void)
 	wait_for_completion(&completion);
 
 	if (req->status != SCLP_REQ_DONE) {
-		pr_warning("request failed (status=0x%02x)\n",
-			   req->status);
+		pr_warn("request failed (status=0x%02x)\n", req->status);
 		rc = -EIO;
 		goto out_free_req;
 	}
 
 	response = ((struct cpi_sccb *) req->sccb)->header.response_code;
 	if (response != 0x0020) {
-		pr_warning("request failed with response code 0x%x\n",
-			   response);
+		pr_warn("request failed with response code 0x%x\n", response);
 		rc = -EIO;
 	}
 
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index f3b5123..3c379da 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -699,8 +699,8 @@ tape_generic_remove(struct ccw_device *cdev)
 			 */
 			DBF_EVENT(3, "(%08x): Drive in use vanished!\n",
 				device->cdev_id);
-			pr_warning("%s: A tape unit was detached while in "
-				   "use\n", dev_name(&device->cdev->dev));
+			pr_warn("%s: A tape unit was detached while in use\n",
+				dev_name(&device->cdev->dev));
 			tape_state_set(device, TS_NOT_OPER);
 			__tape_discard_requests(device);
 			spin_unlock_irq(get_ccwdev_lock(device->cdev));
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 799c152..e883063 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -343,8 +343,7 @@ static int vmlogrdr_open (struct inode *inode, struct file *filp)
 	if (logptr->autorecording) {
 		ret = vmlogrdr_recording(logptr,1,logptr->autopurge);
 		if (ret)
-			pr_warning("vmlogrdr: failed to start "
-				   "recording automatically\n");
+			pr_warn("vmlogrdr: failed to start recording automatically\n");
 	}
 
 	/* create connection to the system service */
@@ -396,8 +395,7 @@ static int vmlogrdr_release (struct inode *inode, struct file *filp)
 	if (logptr->autorecording) {
 		ret = vmlogrdr_recording(logptr,0,logptr->autopurge);
 		if (ret)
-			pr_warning("vmlogrdr: failed to stop "
-				   "recording automatically\n");
+			pr_warn("vmlogrdr: failed to stop recording automatically\n");
 	}
 	logptr->dev_in_use = 0;
 
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 20314aa..9082476 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -51,9 +51,8 @@ static int blacklist_range(range_action action, unsigned int from_ssid,
 {
 	if ((from_ssid > to_ssid) || ((from_ssid == to_ssid) && (from > to))) {
 		if (msgtrigger)
-			pr_warning("0.%x.%04x to 0.%x.%04x is not a valid "
-				   "range for cio_ignore\n", from_ssid, from,
-				   to_ssid, to);
+			pr_warn("0.%x.%04x to 0.%x.%04x is not a valid range for cio_ignore\n",
+				from_ssid, from, to_ssid, to);
 
 		return 1;
 	}
@@ -140,8 +139,8 @@ static int parse_busid(char *str, unsigned int *cssid, unsigned int *ssid,
 	rc = 0;
 out:
 	if (rc && msgtrigger)
-		pr_warning("%s is not a valid device for the cio_ignore "
-			   "kernel parameter\n", str);
+		pr_warn("%s is not a valid device for the cio_ignore kernel parameter\n",
+			str);
 
 	return rc;
 }
diff --git a/drivers/s390/cio/ccwreq.c b/drivers/s390/cio/ccwreq.c
index 79f5991..2782100 100644
--- a/drivers/s390/cio/ccwreq.c
+++ b/drivers/s390/cio/ccwreq.c
@@ -333,13 +333,12 @@ void ccw_request_timeout(struct ccw_device *cdev)
 
 	for (chp = 0; chp < 8; chp++) {
 		if ((0x80 >> chp) & sch->schib.pmcw.lpum)
-			pr_warning("%s: No interrupt was received within %lus "
-				   "(CS=%02x, DS=%02x, CHPID=%x.%02x)\n",
-				   dev_name(&cdev->dev), req->timeout / HZ,
-				   scsw_cstat(&sch->schib.scsw),
-				   scsw_dstat(&sch->schib.scsw),
-				   sch->schid.cssid,
-				   sch->schib.pmcw.chpid[chp]);
+			pr_warn("%s: No interrupt was received within %lus (CS=%02x, DS=%02x, CHPID=%x.%02x)\n",
+				dev_name(&cdev->dev), req->timeout / HZ,
+				scsw_cstat(&sch->schib.scsw),
+				scsw_dstat(&sch->schib.scsw),
+				sch->schid.cssid,
+				sch->schib.pmcw.chpid[chp]);
 	}
 
 	if (!ccwreq_next_path(cdev)) {
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 39a8ae5..de6fccc 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -656,7 +656,7 @@ struct subchannel *cio_probe_console(void)
 
 	sch_no = cio_get_console_sch_no();
 	if (sch_no == -1) {
-		pr_warning("No CCW console was found\n");
+		pr_warn("No CCW console was found\n");
 		return ERR_PTR(-ENODEV);
 	}
 	init_subchannel_id(&schid);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6aae684..7ada078 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -364,11 +364,11 @@ int ccw_device_set_offline(struct ccw_device *cdev)
 		   cdev->private->state == DEV_STATE_DISCONNECTED));
 	/* Inform the user if set offline failed. */
 	if (cdev->private->state == DEV_STATE_BOXED) {
-		pr_warning("%s: The device entered boxed state while "
-			   "being set offline\n", dev_name(&cdev->dev));
+		pr_warn("%s: The device entered boxed state while being set offline\n",
+			dev_name(&cdev->dev));
 	} else if (cdev->private->state == DEV_STATE_NOT_OPER) {
-		pr_warning("%s: The device stopped operating while "
-			   "being set offline\n", dev_name(&cdev->dev));
+		pr_warn("%s: The device stopped operating while being set offline\n",
+			dev_name(&cdev->dev));
 	}
 	/* Give up reference from ccw_device_set_online(). */
 	put_device(&cdev->dev);
@@ -429,13 +429,11 @@ int ccw_device_set_online(struct ccw_device *cdev)
 		spin_unlock_irq(cdev->ccwlock);
 		/* Inform the user that set online failed. */
 		if (cdev->private->state == DEV_STATE_BOXED) {
-			pr_warning("%s: Setting the device online failed "
-				   "because it is boxed\n",
-				   dev_name(&cdev->dev));
+			pr_warn("%s: Setting the device online failed because it is boxed\n",
+				dev_name(&cdev->dev));
 		} else if (cdev->private->state == DEV_STATE_NOT_OPER) {
-			pr_warning("%s: Setting the device online failed "
-				   "because it is not operational\n",
-				   dev_name(&cdev->dev));
+			pr_warn("%s: Setting the device online failed because it is not operational\n",
+				dev_name(&cdev->dev));
 		}
 		/* Give up online reference since onlining failed. */
 		put_device(&cdev->dev);
@@ -619,9 +617,8 @@ initiate_logging(struct device *dev, struct device_attribute *attr,
 
 	rc = chsc_siosl(sch->schid);
 	if (rc < 0) {
-		pr_warning("Logging for subchannel 0.%x.%04x failed with "
-			   "errno=%d\n",
-			   sch->schid.ssid, sch->schid.sch_no, rc);
+		pr_warn("Logging for subchannel 0.%x.%04x failed with errno=%d\n",
+			sch->schid.ssid, sch->schid.sch_no, rc);
 		return rc;
 	}
 	pr_notice("Logging for subchannel 0.%x.%04x was triggered\n",
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 2f5b518..251db0a 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1761,8 +1761,8 @@ lcs_get_control(struct lcs_card *card, struct lcs_cmd *cmd)
 			lcs_schedule_recovery(card);
 			break;
 		case LCS_CMD_STOPLAN:
-			pr_warning("Stoplan for %s initiated by LGW.\n",
-				   card->dev->name);
+			pr_warn("Stoplan for %s initiated by LGW\n",
+				card->dev->name);
 			if (card->dev)
 				netif_carrier_off(card->dev);
 			break;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7c8c68c..ac54433 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3624,7 +3624,7 @@ static int qeth_l3_register_notifiers(void)
 		return rc;
 	}
 #else
-	pr_warning("There is no IPv6 support for the layer 3 discipline\n");
+	pr_warn("There is no IPv6 support for the layer 3 discipline\n");
 #endif
 	return 0;
 }
-- 
2.6.3.368.gf34be46
