Return-Path: <linux-kernel-owner+w=401wt.eu-S935347AbXLTPaX@vger.kernel.org>
Message-Id: <20071220152113.298722505@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 47/47] dasd: add hyper PAV support to DASD device driver, part 3
Content-Disposition: inline; filename=146-hyperpav-3.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   94 +---
 drivers/s390/block/dasd_diag.c   |  107 +++--
 drivers/s390/block/dasd_eckd.c   |  780 ++++++++++++++++++++++++++++-----------
 drivers/s390/block/dasd_eckd.h   |  125 ++++++
 drivers/s390/block/dasd_eer.c    |   11 
 drivers/s390/block/dasd_erp.c    |   25 -
 drivers/s390/block/dasd_fba.c    |  114 +++--
 drivers/s390/block/dasd_genhd.c  |   76 +--
 8 files changed, 912 insertions(+), 420 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c
@@ -49,22 +49,6 @@ struct dasd_devmap {
 };
 
 /*
- * dasd_server_ssid_map contains a globally unique storage server subsystem ID.
- * dasd_server_ssid_list contains the list of all subsystem IDs accessed by
- * the DASD device driver.
- */
-struct dasd_server_ssid_map {
-	struct list_head list;
-	struct system_id {
-		char vendor[4];
-		char serial[15];
-		__u16 ssid;
-	} sid;
-};
-
-static struct list_head dasd_server_ssid_list;
-
-/*
  * Parameter parsing functions for dasd= parameter. The syntax is:
  *   <devno>		: (0x)?[0-9a-fA-F]+
  *   <busid>		: [0-0a-f]\.[0-9a-f]\.(0x)?[0-9a-fA-F]+
@@ -721,8 +705,9 @@ dasd_ro_store(struct device *dev, struct
 		devmap->features &= ~DASD_FEATURE_READONLY;
 	if (devmap->device)
 		devmap->device->features = devmap->features;
-	if (devmap->device && devmap->device->gdp)
-		set_disk_ro(devmap->device->gdp, val);
+	if (devmap->device && devmap->device->block
+	    && devmap->device->block->gdp)
+		set_disk_ro(devmap->device->block->gdp, val);
 	spin_unlock(&dasd_devmap_lock);
 	return count;
 }
@@ -893,12 +878,16 @@ dasd_alias_show(struct device *dev, stru
 
 	devmap = dasd_find_busid(dev->bus_id);
 	spin_lock(&dasd_devmap_lock);
-	if (!IS_ERR(devmap))
-		alias = devmap->uid.alias;
+	if (IS_ERR(devmap) || strlen(devmap->uid.vendor) == 0) {
+		spin_unlock(&dasd_devmap_lock);
+		return sprintf(buf, "0\n");
+	}
+	if (devmap->uid.type == UA_BASE_PAV_ALIAS ||
+	    devmap->uid.type == UA_HYPER_PAV_ALIAS)
+		alias = 1;
 	else
 		alias = 0;
 	spin_unlock(&dasd_devmap_lock);
-
 	return sprintf(buf, alias ? "1\n" : "0\n");
 }
 
@@ -930,19 +919,36 @@ static ssize_t
 dasd_uid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
-	char uid[UID_STRLEN];
+	char uid_string[UID_STRLEN];
+	char ua_string[3];
+	struct dasd_uid *uid;
 
 	devmap = dasd_find_busid(dev->bus_id);
 	spin_lock(&dasd_devmap_lock);
-	if (!IS_ERR(devmap) && strlen(devmap->uid.vendor) > 0)
-		snprintf(uid, sizeof(uid), "%s.%s.%04x.%02x",
-			 devmap->uid.vendor, devmap->uid.serial,
-			 devmap->uid.ssid, devmap->uid.unit_addr);
-	else
-		uid[0] = 0;
+	if (IS_ERR(devmap) || strlen(devmap->uid.vendor) == 0) {
+		spin_unlock(&dasd_devmap_lock);
+		return sprintf(buf, "\n");
+	}
+	uid = &devmap->uid;
+	switch (uid->type) {
+	case UA_BASE_DEVICE:
+		sprintf(ua_string, "%02x", uid->real_unit_addr);
+		break;
+	case UA_BASE_PAV_ALIAS:
+		sprintf(ua_string, "%02x", uid->base_unit_addr);
+		break;
+	case UA_HYPER_PAV_ALIAS:
+		sprintf(ua_string, "xx");
+		break;
+	default:
+		/* should not happen, treat like base device */
+		sprintf(ua_string, "%02x", uid->real_unit_addr);
+		break;
+	}
+	snprintf(uid_string, sizeof(uid_string), "%s.%s.%04x.%s",
+		 uid->vendor, uid->serial, uid->ssid, ua_string);
 	spin_unlock(&dasd_devmap_lock);
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", uid);
+	return snprintf(buf, PAGE_SIZE, "%s\n", uid_string);
 }
 
 static DEVICE_ATTR(uid, 0444, dasd_uid_show, NULL);
@@ -1040,39 +1046,16 @@ int
 dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
 {
 	struct dasd_devmap *devmap;
-	struct dasd_server_ssid_map *srv, *tmp;
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
 
-	/* generate entry for server_ssid_map */
-	srv = (struct dasd_server_ssid_map *)
-		kzalloc(sizeof(struct dasd_server_ssid_map), GFP_KERNEL);
-	if (!srv)
-		return -ENOMEM;
-	strncpy(srv->sid.vendor, uid->vendor, sizeof(srv->sid.vendor) - 1);
-	strncpy(srv->sid.serial, uid->serial, sizeof(srv->sid.serial) - 1);
-	srv->sid.ssid = uid->ssid;
-
-	/* server is already contained ? */
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
-	list_for_each_entry(tmp, &dasd_server_ssid_list, list) {
-		if (!memcmp(&srv->sid, &tmp->sid,
-			    sizeof(struct system_id))) {
-			kfree(srv);
-			srv = NULL;
-			break;
-		}
-	}
-
-	/* add servermap to serverlist */
-	if (srv)
-		list_add(&srv->list, &dasd_server_ssid_list);
 	spin_unlock(&dasd_devmap_lock);
 
-	return (srv ? 1 : 0);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dasd_set_uid);
 
@@ -1138,9 +1121,6 @@ dasd_devmap_init(void)
 	dasd_max_devindex = 0;
 	for (i = 0; i < 256; i++)
 		INIT_LIST_HEAD(&dasd_hashlists[i]);
-
-	/* Initialize servermap structure. */
-	INIT_LIST_HEAD(&dasd_server_ssid_list);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -142,7 +142,7 @@ dasd_diag_erp(struct dasd_device *device
 	int rc;
 
 	mdsk_term_io(device);
-	rc = mdsk_init_io(device, device->bp_block, 0, NULL);
+	rc = mdsk_init_io(device, device->block->bp_block, 0, NULL);
 	if (rc)
 		DEV_MESSAGE(KERN_WARNING, device, "DIAG ERP unsuccessful, "
 			    "rc=%d", rc);
@@ -158,11 +158,11 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	struct dasd_diag_req *dreq;
 	int rc;
 
-	device = cqr->device;
+	device = cqr->startdev;
 	if (cqr->retries < 0) {
 		DEV_MESSAGE(KERN_WARNING, device, "DIAG start_IO: request %p "
 			    "- no retry left)", cqr);
-		cqr->status = DASD_CQR_FAILED;
+		cqr->status = DASD_CQR_ERROR;
 		return -EIO;
 	}
 	private = (struct dasd_diag_private *) device->private;
@@ -184,7 +184,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	switch (rc) {
 	case 0: /* Synchronous I/O finished successfully */
 		cqr->stopclk = get_clock();
-		cqr->status = DASD_CQR_DONE;
+		cqr->status = DASD_CQR_SUCCESS;
 		/* Indicate to calling function that only a dasd_schedule_bh()
 		   and no timer is needed */
                 rc = -EACCES;
@@ -209,12 +209,12 @@ dasd_diag_term_IO(struct dasd_ccw_req * 
 {
 	struct dasd_device *device;
 
-	device = cqr->device;
+	device = cqr->startdev;
 	mdsk_term_io(device);
-	mdsk_init_io(device, device->bp_block, 0, NULL);
-	cqr->status = DASD_CQR_CLEAR;
+	mdsk_init_io(device, device->block->bp_block, 0, NULL);
+	cqr->status = DASD_CQR_CLEAR_PENDING;
 	cqr->stopclk = get_clock();
-	dasd_schedule_bh(device);
+	dasd_schedule_device_bh(device);
 	return 0;
 }
 
@@ -247,7 +247,7 @@ dasd_ext_handler(__u16 code)
 		return;
 	}
 	cqr = (struct dasd_ccw_req *) ip;
-	device = (struct dasd_device *) cqr->device;
+	device = (struct dasd_device *) cqr->startdev;
 	if (strncmp(device->discipline->ebcname, (char *) &cqr->magic, 4)) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    " magic number of dasd_ccw_req 0x%08X doesn't"
@@ -260,10 +260,10 @@ dasd_ext_handler(__u16 code)
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 
 	/* Check for a pending clear operation */
-	if (cqr->status == DASD_CQR_CLEAR) {
-		cqr->status = DASD_CQR_QUEUED;
-		dasd_clear_timer(device);
-		dasd_schedule_bh(device);
+	if (cqr->status == DASD_CQR_CLEAR_PENDING) {
+		cqr->status = DASD_CQR_CLEARED;
+		dasd_device_clear_timer(device);
+		dasd_schedule_device_bh(device);
 		spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 		return;
 	}
@@ -272,11 +272,11 @@ dasd_ext_handler(__u16 code)
 
 	expires = 0;
 	if (status == 0) {
-		cqr->status = DASD_CQR_DONE;
+		cqr->status = DASD_CQR_SUCCESS;
 		/* Start first request on queue if possible -> fast_io. */
 		if (!list_empty(&device->ccw_queue)) {
 			next = list_entry(device->ccw_queue.next,
-					  struct dasd_ccw_req, list);
+					  struct dasd_ccw_req, devlist);
 			if (next->status == DASD_CQR_QUEUED) {
 				rc = dasd_start_diag(next);
 				if (rc == 0)
@@ -296,10 +296,10 @@ dasd_ext_handler(__u16 code)
 	}
 
 	if (expires != 0)
-		dasd_set_timer(device, expires);
+		dasd_device_set_timer(device, expires);
 	else
-		dasd_clear_timer(device);
-	dasd_schedule_bh(device);
+		dasd_device_clear_timer(device);
+	dasd_schedule_device_bh(device);
 
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 }
@@ -309,6 +309,7 @@ dasd_ext_handler(__u16 code)
 static int
 dasd_diag_check_device(struct dasd_device *device)
 {
+	struct dasd_block *block;
 	struct dasd_diag_private *private;
 	struct dasd_diag_characteristics *rdc_data;
 	struct dasd_diag_bio bio;
@@ -328,6 +329,16 @@ dasd_diag_check_device(struct dasd_devic
 		ccw_device_get_id(device->cdev, &private->dev_id);
 		device->private = (void *) private;
 	}
+	block = dasd_alloc_block();
+	if (IS_ERR(block)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "could not allocate dasd block structure");
+		kfree(device->private);
+		return PTR_ERR(block);
+	}
+	device->block = block;
+	block->base = device;
+
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	rdc_data->dev_nr = private->dev_id.devno;
@@ -409,14 +420,14 @@ dasd_diag_check_device(struct dasd_devic
 		  sizeof(DASD_DIAG_CMS1)) == 0) {
 		/* get formatted blocksize from label block */
 		bsize = (unsigned int) label->block_size;
-		device->blocks = (unsigned long) label->block_count;
+		block->blocks = (unsigned long) label->block_count;
 	} else
-		device->blocks = end_block;
-	device->bp_block = bsize;
-	device->s2b_shift = 0;	/* bits to shift 512 to get a block */
+		block->blocks = end_block;
+	block->bp_block = bsize;
+	block->s2b_shift = 0;	/* bits to shift 512 to get a block */
 	for (sb = 512; sb < bsize; sb = sb << 1)
-		device->s2b_shift++;
-	rc = mdsk_init_io(device, device->bp_block, 0, NULL);
+		block->s2b_shift++;
+	rc = mdsk_init_io(device, block->bp_block, 0, NULL);
 	if (rc) {
 		DEV_MESSAGE(KERN_WARNING, device, "DIAG initialization "
 			"failed (rc=%d)", rc);
@@ -424,9 +435,9 @@ dasd_diag_check_device(struct dasd_devic
 	} else {
 		DEV_MESSAGE(KERN_INFO, device,
 			    "(%ld B/blk): %ldkB",
-			    (unsigned long) device->bp_block,
-			    (unsigned long) (device->blocks <<
-				device->s2b_shift) >> 1);
+			    (unsigned long) block->bp_block,
+			    (unsigned long) (block->blocks <<
+				block->s2b_shift) >> 1);
 	}
 out:
 	free_page((long) label);
@@ -436,22 +447,16 @@ out:
 /* Fill in virtual disk geometry for device. Return zero on success, non-zero
  * otherwise. */
 static int
-dasd_diag_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
+dasd_diag_fill_geometry(struct dasd_block *block, struct hd_geometry *geo)
 {
-	if (dasd_check_blocksize(device->bp_block) != 0)
+	if (dasd_check_blocksize(block->bp_block) != 0)
 		return -EINVAL;
-	geo->cylinders = (device->blocks << device->s2b_shift) >> 10;
+	geo->cylinders = (block->blocks << block->s2b_shift) >> 10;
 	geo->heads = 16;
-	geo->sectors = 128 >> device->s2b_shift;
+	geo->sectors = 128 >> block->s2b_shift;
 	return 0;
 }
 
-static dasd_era_t
-dasd_diag_examine_error(struct dasd_ccw_req * cqr, struct irb * stat)
-{
-	return dasd_era_fatal;
-}
-
 static dasd_erp_fn_t
 dasd_diag_erp_action(struct dasd_ccw_req * cqr)
 {
@@ -466,8 +471,9 @@ dasd_diag_erp_postaction(struct dasd_ccw
 
 /* Create DASD request from block device request. Return pointer to new
  * request on success, ERR_PTR otherwise. */
-static struct dasd_ccw_req *
-dasd_diag_build_cp(struct dasd_device * device, struct request *req)
+static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
+					       struct dasd_block *block,
+					       struct request *req)
 {
 	struct dasd_ccw_req *cqr;
 	struct dasd_diag_req *dreq;
@@ -486,17 +492,17 @@ dasd_diag_build_cp(struct dasd_device * 
 		rw_cmd = MDSK_WRITE_REQ;
 	else
 		return ERR_PTR(-EINVAL);
-	blksize = device->bp_block;
+	blksize = block->bp_block;
 	/* Calculate record id of first and last block. */
-	first_rec = req->sector >> device->s2b_shift;
-	last_rec = (req->sector + req->nr_sectors - 1) >> device->s2b_shift;
+	first_rec = req->sector >> block->s2b_shift;
+	last_rec = (req->sector + req->nr_sectors - 1) >> block->s2b_shift;
 	/* Check struct bio and count the number of blocks for the request. */
 	count = 0;
 	rq_for_each_segment(bv, req, iter) {
 		if (bv->bv_len & (blksize - 1))
 			/* Fba can only do full blocks. */
 			return ERR_PTR(-EINVAL);
-		count += bv->bv_len >> (device->s2b_shift + 9);
+		count += bv->bv_len >> (block->s2b_shift + 9);
 	}
 	/* Paranoia. */
 	if (count != last_rec - first_rec + 1)
@@ -505,7 +511,7 @@ dasd_diag_build_cp(struct dasd_device * 
 	datasize = sizeof(struct dasd_diag_req) +
 		count*sizeof(struct dasd_diag_bio);
 	cqr = dasd_smalloc_request(dasd_diag_discipline.name, 0,
-				   datasize, device);
+				   datasize, memdev);
 	if (IS_ERR(cqr))
 		return cqr;
 
@@ -529,7 +535,9 @@ dasd_diag_build_cp(struct dasd_device * 
 	cqr->buildclk = get_clock();
 	if (req->cmd_flags & REQ_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
-	cqr->device = device;
+	cqr->startdev = memdev;
+	cqr->memdev = memdev;
+	cqr->block = block;
 	cqr->expires = DIAG_TIMEOUT;
 	cqr->status = DASD_CQR_FILLED;
 	return cqr;
@@ -543,10 +551,15 @@ dasd_diag_free_cp(struct dasd_ccw_req *c
 	int status;
 
 	status = cqr->status == DASD_CQR_DONE;
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return status;
 }
 
+static void dasd_diag_handle_terminated_request(struct dasd_ccw_req *cqr)
+{
+	cqr->status = DASD_CQR_FILLED;
+};
+
 /* Fill in IOCTL data for device. */
 static int
 dasd_diag_fill_info(struct dasd_device * device,
@@ -583,7 +596,7 @@ static struct dasd_discipline dasd_diag_
 	.fill_geometry = dasd_diag_fill_geometry,
 	.start_IO = dasd_start_diag,
 	.term_IO = dasd_diag_term_IO,
-	.examine_error = dasd_diag_examine_error,
+	.handle_terminated_request = dasd_diag_handle_terminated_request,
 	.erp_action = dasd_diag_erp_action,
 	.erp_postaction = dasd_diag_erp_postaction,
 	.build_cp = dasd_diag_build_cp,
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c
@@ -52,16 +52,6 @@ MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_eckd_discipline;
 
-struct dasd_eckd_private {
-	struct dasd_eckd_characteristics rdc_data;
-	struct dasd_eckd_confdata conf_data;
-	struct dasd_eckd_path path_data;
-	struct eckd_count count_area[5];
-	int init_cqr_status;
-	int uses_cdl;
-	struct attrib_data_t attrib;	/* e.g. cache operations */
-};
-
 /* The ccw bus type uses this table to find devices that it sends to
  * dasd_eckd_probe */
 static struct ccw_device_id dasd_eckd_ids[] = {
@@ -188,7 +178,7 @@ check_XRC (struct ccw1         *de_ccw,
 	if (rc == -ENOSYS || rc == -EACCES)
 		rc = 0;
 
-	de_ccw->count = sizeof (struct DE_eckd_data);
+	de_ccw->count = sizeof(struct DE_eckd_data);
 	de_ccw->flags |= CCW_FLAG_SLI;
 	return rc;
 }
@@ -208,7 +198,7 @@ define_extent(struct ccw1 * ccw, struct 
 	ccw->count = 16;
 	ccw->cda = (__u32) __pa(data);
 
-	memset(data, 0, sizeof (struct DE_eckd_data));
+	memset(data, 0, sizeof(struct DE_eckd_data));
 	switch (cmd) {
 	case DASD_ECKD_CCW_READ_HOME_ADDRESS:
 	case DASD_ECKD_CCW_READ_RECORD_ZERO:
@@ -280,6 +270,132 @@ define_extent(struct ccw1 * ccw, struct 
 	return rc;
 }
 
+static int check_XRC_on_prefix(struct PFX_eckd_data *pfxdata,
+			       struct dasd_device  *device)
+{
+	struct dasd_eckd_private *private;
+	int rc;
+
+	private = (struct dasd_eckd_private *) device->private;
+	if (!private->rdc_data.facilities.XRC_supported)
+		return 0;
+
+	/* switch on System Time Stamp - needed for XRC Support */
+	pfxdata->define_extend.ga_extended |= 0x08; /* 'Time Stamp Valid'   */
+	pfxdata->define_extend.ga_extended |= 0x02; /* 'Extended Parameter' */
+	pfxdata->validity.time_stamp = 1;	    /* 'Time Stamp Valid'   */
+
+	rc = get_sync_clock(&pfxdata->define_extend.ep_sys_time);
+	/* Ignore return code if sync clock is switched off. */
+	if (rc == -ENOSYS || rc == -EACCES)
+		rc = 0;
+	return rc;
+}
+
+static int prefix(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata, int trk,
+		  int totrk, int cmd, struct dasd_device *basedev,
+		  struct dasd_device *startdev)
+{
+	struct dasd_eckd_private *basepriv, *startpriv;
+	struct DE_eckd_data *data;
+	struct ch_t geo, beg, end;
+	int rc = 0;
+
+	basepriv = (struct dasd_eckd_private *) basedev->private;
+	startpriv = (struct dasd_eckd_private *) startdev->private;
+	data = &pfxdata->define_extend;
+
+	ccw->cmd_code = DASD_ECKD_CCW_PFX;
+	ccw->flags = 0;
+	ccw->count = sizeof(*pfxdata);
+	ccw->cda = (__u32) __pa(pfxdata);
+
+	memset(pfxdata, 0, sizeof(*pfxdata));
+	/* prefix data */
+	pfxdata->format = 0;
+	pfxdata->base_address = basepriv->conf_data.ned1.unit_addr;
+	pfxdata->base_lss = basepriv->conf_data.ned1.ID;
+	pfxdata->validity.define_extend = 1;
+
+	/* private uid is kept up to date, conf_data may be outdated */
+	if (startpriv->uid.type != UA_BASE_DEVICE) {
+		pfxdata->validity.verify_base = 1;
+		if (startpriv->uid.type == UA_HYPER_PAV_ALIAS)
+			pfxdata->validity.hyper_pav = 1;
+	}
+
+	/* define extend data (mostly)*/
+	switch (cmd) {
+	case DASD_ECKD_CCW_READ_HOME_ADDRESS:
+	case DASD_ECKD_CCW_READ_RECORD_ZERO:
+	case DASD_ECKD_CCW_READ:
+	case DASD_ECKD_CCW_READ_MT:
+	case DASD_ECKD_CCW_READ_CKD:
+	case DASD_ECKD_CCW_READ_CKD_MT:
+	case DASD_ECKD_CCW_READ_KD:
+	case DASD_ECKD_CCW_READ_KD_MT:
+	case DASD_ECKD_CCW_READ_COUNT:
+		data->mask.perm = 0x1;
+		data->attributes.operation = basepriv->attrib.operation;
+		break;
+	case DASD_ECKD_CCW_WRITE:
+	case DASD_ECKD_CCW_WRITE_MT:
+	case DASD_ECKD_CCW_WRITE_KD:
+	case DASD_ECKD_CCW_WRITE_KD_MT:
+		data->mask.perm = 0x02;
+		data->attributes.operation = basepriv->attrib.operation;
+		rc = check_XRC_on_prefix(pfxdata, basedev);
+		break;
+	case DASD_ECKD_CCW_WRITE_CKD:
+	case DASD_ECKD_CCW_WRITE_CKD_MT:
+		data->attributes.operation = DASD_BYPASS_CACHE;
+		rc = check_XRC_on_prefix(pfxdata, basedev);
+		break;
+	case DASD_ECKD_CCW_ERASE:
+	case DASD_ECKD_CCW_WRITE_HOME_ADDRESS:
+	case DASD_ECKD_CCW_WRITE_RECORD_ZERO:
+		data->mask.perm = 0x3;
+		data->mask.auth = 0x1;
+		data->attributes.operation = DASD_BYPASS_CACHE;
+		rc = check_XRC_on_prefix(pfxdata, basedev);
+		break;
+	default:
+		DEV_MESSAGE(KERN_ERR, basedev, "unknown opcode 0x%x", cmd);
+		break;
+	}
+
+	data->attributes.mode = 0x3;	/* ECKD */
+
+	if ((basepriv->rdc_data.cu_type == 0x2105 ||
+	     basepriv->rdc_data.cu_type == 0x2107 ||
+	     basepriv->rdc_data.cu_type == 0x1750)
+	    && !(basepriv->uses_cdl && trk < 2))
+		data->ga_extended |= 0x40; /* Regular Data Format Mode */
+
+	geo.cyl = basepriv->rdc_data.no_cyl;
+	geo.head = basepriv->rdc_data.trk_per_cyl;
+	beg.cyl = trk / geo.head;
+	beg.head = trk % geo.head;
+	end.cyl = totrk / geo.head;
+	end.head = totrk % geo.head;
+
+	/* check for sequential prestage - enhance cylinder range */
+	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
+	    data->attributes.operation == DASD_SEQ_ACCESS) {
+
+		if (end.cyl + basepriv->attrib.nr_cyl < geo.cyl)
+			end.cyl += basepriv->attrib.nr_cyl;
+		else
+			end.cyl = (geo.cyl - 1);
+	}
+
+	data->beg_ext.cyl = beg.cyl;
+	data->beg_ext.head = beg.head;
+	data->end_ext.cyl = end.cyl;
+	data->end_ext.head = end.head;
+	return rc;
+}
+
 static void
 locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, int trk,
 	      int rec_on_trk, int no_rec, int cmd,
@@ -300,7 +416,7 @@ locate_record(struct ccw1 *ccw, struct L
 	ccw->count = 16;
 	ccw->cda = (__u32) __pa(data);
 
-	memset(data, 0, sizeof (struct LO_eckd_data));
+	memset(data, 0, sizeof(struct LO_eckd_data));
 	sector = 0;
 	if (rec_on_trk) {
 		switch (private->rdc_data.dev_type) {
@@ -441,12 +557,15 @@ dasd_eckd_generate_uid(struct dasd_devic
 	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
 	uid->ssid = confdata->neq.subsystemID;
-	if (confdata->ned2.sneq.flags == 0x40) {
-		uid->alias = 1;
-		uid->unit_addr = confdata->ned2.sneq.base_unit_addr;
-	} else
-		uid->unit_addr = confdata->ned1.unit_addr;
-
+	uid->real_unit_addr = confdata->ned1.unit_addr;
+	if (confdata->ned2.sneq.flags == 0x40 &&
+	    confdata->ned2.sneq.format == 0x0001) {
+		uid->type = confdata->ned2.sneq.sua_flags;
+		if (uid->type == UA_BASE_PAV_ALIAS)
+			uid->base_unit_addr = confdata->ned2.sneq.base_unit_addr;
+	} else {
+		uid->type = UA_BASE_DEVICE;
+	}
 	return 0;
 }
 
@@ -470,7 +589,9 @@ static struct dasd_ccw_req *dasd_eckd_bu
 	ccw->cda = (__u32)(addr_t)rcd_buffer;
 	ccw->count = ciw->count;
 
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
 	cqr->expires = 10*HZ;
 	cqr->lpm = lpm;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -511,7 +632,7 @@ static int dasd_eckd_read_conf_lpm(struc
 	/*
 	 * on success we update the user input parms
 	 */
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	if (ret)
 		goto out_error;
 
@@ -557,19 +678,19 @@ dasd_eckd_read_conf(struct dasd_device *
 					"data retrieved");
 				continue;	/* no error */
 			}
-			if (conf_len != sizeof (struct dasd_eckd_confdata)) {
+			if (conf_len != sizeof(struct dasd_eckd_confdata)) {
 				MESSAGE(KERN_WARNING,
 					"sizes of configuration data mismatch"
 					"%d (read) vs %ld (expected)",
 					conf_len,
-					sizeof (struct dasd_eckd_confdata));
+					sizeof(struct dasd_eckd_confdata));
 				kfree(conf_data);
 				continue;	/* no error */
 			}
 			/* save first valid configuration data */
 			if (!conf_data_saved){
 				memcpy(&private->conf_data, conf_data,
-				       sizeof (struct dasd_eckd_confdata));
+				       sizeof(struct dasd_eckd_confdata));
 				conf_data_saved++;
 			}
 			switch (((char *)conf_data)[242] & 0x07){
@@ -586,39 +707,106 @@ dasd_eckd_read_conf(struct dasd_device *
 	return 0;
 }
 
+static int
+dasd_eckd_read_features(struct dasd_device *device)
+{
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_rssd_features *features;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+	struct dasd_eckd_private *private;
+
+	private = (struct dasd_eckd_private *) device->private;
+	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
+				   1 /* PSF */	+ 1 /* RSSD */ ,
+				   (sizeof(struct dasd_psf_prssd_data) +
+				    sizeof(struct dasd_rssd_features)),
+				   device);
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "Could not allocate initialization request");
+		return PTR_ERR(cqr);
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
+	cqr->retries = 5;
+	cqr->expires = 10 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = 0x41;	/* Read Feature Codes */
+	/* all other bytes of prssdp must be zero */
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->cda = (__u32)(addr_t) prssdp;
+
+	/* Read Subsystem Data - feature codes */
+	features = (struct dasd_rssd_features *) (prssdp + 1);
+	memset(features, 0, sizeof(struct dasd_rssd_features));
+
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(struct dasd_rssd_features);
+	ccw->cda = (__u32)(addr_t) features;
+
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	rc = dasd_sleep_on(cqr);
+	if (rc == 0) {
+		/* Prepare for Read Subsystem Data */
+		prssdp = (struct dasd_psf_prssd_data *) cqr->data;
+		features = (struct dasd_rssd_features *) (prssdp + 1);
+		memcpy(&private->features, features,
+		       sizeof(struct dasd_rssd_features));
+	}
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
+
 /*
  * Build CP for Perform Subsystem Function - SSC.
  */
-static struct dasd_ccw_req *
-dasd_eckd_build_psf_ssc(struct dasd_device *device)
+static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device)
 {
-       struct dasd_ccw_req *cqr;
-       struct dasd_psf_ssc_data *psf_ssc_data;
-       struct ccw1 *ccw;
+	struct dasd_ccw_req *cqr;
+	struct dasd_psf_ssc_data *psf_ssc_data;
+	struct ccw1 *ccw;
 
-       cqr = dasd_smalloc_request("ECKD", 1 /* PSF */ ,
+	cqr = dasd_smalloc_request("ECKD", 1 /* PSF */ ,
 				  sizeof(struct dasd_psf_ssc_data),
 				  device);
 
-       if (IS_ERR(cqr)) {
-	       DEV_MESSAGE(KERN_WARNING, device, "%s",
+	if (IS_ERR(cqr)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
 			   "Could not allocate PSF-SSC request");
-	       return cqr;
-       }
-       psf_ssc_data = (struct dasd_psf_ssc_data *)cqr->data;
-       psf_ssc_data->order = PSF_ORDER_SSC;
-       psf_ssc_data->suborder = 0x08;
-
-       ccw = cqr->cpaddr;
-       ccw->cmd_code = DASD_ECKD_CCW_PSF;
-       ccw->cda = (__u32)(addr_t)psf_ssc_data;
-       ccw->count = 66;
-
-       cqr->device = device;
-       cqr->expires = 10*HZ;
-       cqr->buildclk = get_clock();
-       cqr->status = DASD_CQR_FILLED;
-       return cqr;
+		return cqr;
+	}
+	psf_ssc_data = (struct dasd_psf_ssc_data *)cqr->data;
+	psf_ssc_data->order = PSF_ORDER_SSC;
+	psf_ssc_data->suborder = 0x88;
+	psf_ssc_data->reserved[0] = 0x88;
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->cda = (__u32)(addr_t)psf_ssc_data;
+	ccw->count = 66;
+
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->expires = 10*HZ;
+	cqr->buildclk = get_clock();
+	cqr->status = DASD_CQR_FILLED;
+	return cqr;
 }
 
 /*
@@ -629,28 +817,29 @@ dasd_eckd_build_psf_ssc(struct dasd_devi
 static int
 dasd_eckd_psf_ssc(struct dasd_device *device)
 {
-       struct dasd_ccw_req *cqr;
-       int rc;
+	struct dasd_ccw_req *cqr;
+	int rc;
 
-       cqr = dasd_eckd_build_psf_ssc(device);
-       if (IS_ERR(cqr))
-	       return PTR_ERR(cqr);
-
-       rc = dasd_sleep_on(cqr);
-       if (!rc)
-	       /* trigger CIO to reprobe devices */
-	       css_schedule_reprobe();
-       dasd_sfree_request(cqr, cqr->device);
-       return rc;
+	cqr = dasd_eckd_build_psf_ssc(device);
+	if (IS_ERR(cqr))
+		return PTR_ERR(cqr);
+
+	rc = dasd_sleep_on(cqr);
+	if (!rc)
+		/* trigger CIO to reprobe devices */
+		css_schedule_reprobe();
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
 }
 
 /*
  * Valide storage server of current device.
  */
 static int
-dasd_eckd_validate_server(struct dasd_device *device, struct dasd_uid *uid)
+dasd_eckd_validate_server(struct dasd_device *device)
 {
 	int rc;
+	struct dasd_eckd_private *private;
 
 	/* Currently PAV is the only reason to 'validate' server on LPAR */
 	if (dasd_nopav || MACHINE_IS_VM)
@@ -659,9 +848,11 @@ dasd_eckd_validate_server(struct dasd_de
 	rc = dasd_eckd_psf_ssc(device);
 	/* may be requested feature is not available on server,
 	 * therefore just report error and go ahead */
+	private = (struct dasd_eckd_private *) device->private;
 	DEV_MESSAGE(KERN_INFO, device,
 		    "PSF-SSC on storage subsystem %s.%s.%04x returned rc=%d",
-		    uid->vendor, uid->serial, uid->ssid, rc);
+		    private->uid.vendor, private->uid.serial,
+		    private->uid.ssid, rc);
 	/* RE-Read Configuration Data */
 	return dasd_eckd_read_conf(device);
 }
@@ -674,9 +865,9 @@ static int
 dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private;
-	struct dasd_uid uid;
+	struct dasd_block *block;
 	void *rdc_data;
-	int rc;
+	int is_known, rc;
 
 	private = (struct dasd_eckd_private *) device->private;
 	if (private == NULL) {
@@ -699,27 +890,52 @@ dasd_eckd_check_characteristics(struct d
 	/* Read Configuration Data */
 	rc = dasd_eckd_read_conf(device);
 	if (rc)
-		return rc;
+		goto out_err1;
 
 	/* Generate device unique id and register in devmap */
-	rc = dasd_eckd_generate_uid(device, &uid);
+	rc = dasd_eckd_generate_uid(device, &private->uid);
 	if (rc)
-		return rc;
-	rc = dasd_set_uid(device->cdev, &uid);
-	if (rc == 1)	/* new server found */
-		rc = dasd_eckd_validate_server(device, &uid);
+		goto out_err1;
+	dasd_set_uid(device->cdev, &private->uid);
+	/* register lcu with alias handling, enable PAV if this is a new lcu */
+	is_known = dasd_alias_make_device_known_to_lcu(device);
+	if (is_known < 0) {
+		rc = is_known;
+		goto out_err1;
+	}
+	if (!is_known) {
+		/* new lcu found */
+		rc = dasd_eckd_validate_server(device); /* will switch pav on */
+		if (rc)
+			goto out_err2;
+	}
+	if (private->uid.type == UA_BASE_DEVICE) {
+		block = dasd_alloc_block();
+		if (IS_ERR(block)) {
+			DEV_MESSAGE(KERN_WARNING, device, "%s",
+				    "could not allocate dasd block structure");
+			rc = PTR_ERR(block);
+			goto out_err2;
+		}
+		device->block = block;
+		block->base = device;
+	}
+
+	/* Read Feature Codes */
+	rc = dasd_eckd_read_features(device);
 	if (rc)
-		return rc;
+		goto out_err3;
 
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	memset(rdc_data, 0, sizeof(rdc_data));
 	rc = dasd_generic_read_dev_chars(device, "ECKD", &rdc_data, 64);
-	if (rc)
+	if (rc) {
 		DEV_MESSAGE(KERN_WARNING, device,
 			    "Read device characteristics returned "
 			    "rc=%d", rc);
-
+		goto out_err3;
+	}
 	DEV_MESSAGE(KERN_INFO, device,
 		    "%04X/%02X(CU:%04X/%02X) Cyl:%d Head:%d Sec:%d",
 		    private->rdc_data.dev_type,
@@ -729,9 +945,24 @@ dasd_eckd_check_characteristics(struct d
 		    private->rdc_data.no_cyl,
 		    private->rdc_data.trk_per_cyl,
 		    private->rdc_data.sec_per_trk);
+	return 0;
+
+out_err3:
+	dasd_free_block(device->block);
+	device->block = NULL;
+out_err2:
+	dasd_alias_disconnect_device_from_lcu(device);
+out_err1:
+	kfree(device->private);
+	device->private = NULL;
 	return rc;
 }
 
+static void dasd_eckd_uncheck_device(struct dasd_device *device)
+{
+	dasd_alias_disconnect_device_from_lcu(device);
+}
+
 static struct dasd_ccw_req *
 dasd_eckd_analysis_ccw(struct dasd_device *device)
 {
@@ -755,7 +986,7 @@ dasd_eckd_analysis_ccw(struct dasd_devic
 	/* Define extent for the first 3 tracks. */
 	define_extent(ccw++, cqr->data, 0, 2,
 		      DASD_ECKD_CCW_READ_COUNT, device);
-	LO_data = cqr->data + sizeof (struct DE_eckd_data);
+	LO_data = cqr->data + sizeof(struct DE_eckd_data);
 	/* Locate record for the first 4 records on track 0. */
 	ccw[-1].flags |= CCW_FLAG_CC;
 	locate_record(ccw++, LO_data++, 0, 0, 4,
@@ -783,7 +1014,9 @@ dasd_eckd_analysis_ccw(struct dasd_devic
 	ccw->count = 8;
 	ccw->cda = (__u32)(addr_t) count_data;
 
-	cqr->device = device;
+	cqr->block = NULL;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	cqr->retries = 0;
 	cqr->buildclk = get_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -803,7 +1036,7 @@ dasd_eckd_analysis_callback(struct dasd_
 	struct dasd_eckd_private *private;
 	struct dasd_device *device;
 
-	device = init_cqr->device;
+	device = init_cqr->startdev;
 	private = (struct dasd_eckd_private *) device->private;
 	private->init_cqr_status = init_cqr->status;
 	dasd_sfree_request(init_cqr, device);
@@ -811,13 +1044,13 @@ dasd_eckd_analysis_callback(struct dasd_
 }
 
 static int
-dasd_eckd_start_analysis(struct dasd_device *device)
+dasd_eckd_start_analysis(struct dasd_block *block)
 {
 	struct dasd_eckd_private *private;
 	struct dasd_ccw_req *init_cqr;
 
-	private = (struct dasd_eckd_private *) device->private;
-	init_cqr = dasd_eckd_analysis_ccw(device);
+	private = (struct dasd_eckd_private *) block->base->private;
+	init_cqr = dasd_eckd_analysis_ccw(block->base);
 	if (IS_ERR(init_cqr))
 		return PTR_ERR(init_cqr);
 	init_cqr->callback = dasd_eckd_analysis_callback;
@@ -828,13 +1061,15 @@ dasd_eckd_start_analysis(struct dasd_dev
 }
 
 static int
-dasd_eckd_end_analysis(struct dasd_device *device)
+dasd_eckd_end_analysis(struct dasd_block *block)
 {
+	struct dasd_device *device;
 	struct dasd_eckd_private *private;
 	struct eckd_count *count_area;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 
+	device = block->base;
 	private = (struct dasd_eckd_private *) device->private;
 	status = private->init_cqr_status;
 	private->init_cqr_status = -1;
@@ -846,7 +1081,7 @@ dasd_eckd_end_analysis(struct dasd_devic
 
 	private->uses_cdl = 1;
 	/* Calculate number of blocks/records per track. */
-	blk_per_trk = recs_per_track(&private->rdc_data, 0, device->bp_block);
+	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
 	/* Check Track 0 for Compatible Disk Layout */
 	count_area = NULL;
 	for (i = 0; i < 3; i++) {
@@ -876,29 +1111,29 @@ dasd_eckd_end_analysis(struct dasd_devic
 	if (count_area != NULL && count_area->kl == 0) {
 		/* we found notthing violating our disk layout */
 		if (dasd_check_blocksize(count_area->dl) == 0)
-			device->bp_block = count_area->dl;
+			block->bp_block = count_area->dl;
 	}
-	if (device->bp_block == 0) {
+	if (block->bp_block == 0) {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
 			    "Volume has incompatible disk layout");
 		return -EMEDIUMTYPE;
 	}
-	device->s2b_shift = 0;	/* bits to shift 512 to get a block */
-	for (sb = 512; sb < device->bp_block; sb = sb << 1)
-		device->s2b_shift++;
+	block->s2b_shift = 0;	/* bits to shift 512 to get a block */
+	for (sb = 512; sb < block->bp_block; sb = sb << 1)
+		block->s2b_shift++;
 
-	blk_per_trk = recs_per_track(&private->rdc_data, 0, device->bp_block);
-	device->blocks = (private->rdc_data.no_cyl *
+	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
+	block->blocks = (private->rdc_data.no_cyl *
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
 	DEV_MESSAGE(KERN_INFO, device,
 		    "(%dkB blks): %dkB at %dkB/trk %s",
-		    (device->bp_block >> 10),
+		    (block->bp_block >> 10),
 		    ((private->rdc_data.no_cyl *
 		      private->rdc_data.trk_per_cyl *
-		      blk_per_trk * (device->bp_block >> 9)) >> 1),
-		    ((blk_per_trk * device->bp_block) >> 10),
+		      blk_per_trk * (block->bp_block >> 9)) >> 1),
+		    ((blk_per_trk * block->bp_block) >> 10),
 		    private->uses_cdl ?
 		    "compatible disk layout" : "linux disk layout");
 
@@ -906,26 +1141,36 @@ dasd_eckd_end_analysis(struct dasd_devic
 }
 
 static int
-dasd_eckd_do_analysis(struct dasd_device *device)
+dasd_eckd_do_analysis(struct dasd_block *block)
 {
 	struct dasd_eckd_private *private;
 
-	private = (struct dasd_eckd_private *) device->private;
+	private = (struct dasd_eckd_private *) block->base->private;
 	if (private->init_cqr_status < 0)
-		return dasd_eckd_start_analysis(device);
+		return dasd_eckd_start_analysis(block);
 	else
-		return dasd_eckd_end_analysis(device);
+		return dasd_eckd_end_analysis(block);
 }
 
+static int dasd_eckd_ready_to_online(struct dasd_device *device)
+{
+	return dasd_alias_add_device(device);
+};
+
+static int dasd_eckd_online_to_ready(struct dasd_device *device)
+{
+	return dasd_alias_remove_device(device);
+};
+
 static int
-dasd_eckd_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
+dasd_eckd_fill_geometry(struct dasd_block *block, struct hd_geometry *geo)
 {
 	struct dasd_eckd_private *private;
 
-	private = (struct dasd_eckd_private *) device->private;
-	if (dasd_check_blocksize(device->bp_block) == 0) {
+	private = (struct dasd_eckd_private *) block->base->private;
+	if (dasd_check_blocksize(block->bp_block) == 0) {
 		geo->sectors = recs_per_track(&private->rdc_data,
-					      0, device->bp_block);
+					      0, block->bp_block);
 	}
 	geo->cylinders = private->rdc_data.no_cyl;
 	geo->heads = private->rdc_data.trk_per_cyl;
@@ -1037,7 +1282,7 @@ dasd_eckd_format_device(struct dasd_devi
 		locate_record(ccw++, (struct LO_eckd_data *) data,
 			      fdata->start_unit, 0, rpt + 1,
 			      DASD_ECKD_CCW_WRITE_RECORD_ZERO, device,
-			      device->bp_block);
+			      device->block->bp_block);
 		data += sizeof(struct LO_eckd_data);
 		break;
 	case 0x04: /* Invalidate track. */
@@ -1110,43 +1355,28 @@ dasd_eckd_format_device(struct dasd_devi
 			ccw++;
 		}
 	}
-	fcp->device = device;
-	fcp->retries = 2;	/* set retry counter to enable ERP */
+	fcp->startdev = device;
+	fcp->memdev = device;
+	clear_bit(DASD_CQR_FLAGS_USE_ERP, &fcp->flags);
+	fcp->retries = 5;	/* set retry counter to enable default ERP */
 	fcp->buildclk = get_clock();
 	fcp->status = DASD_CQR_FILLED;
 	return fcp;
 }
 
-static dasd_era_t
-dasd_eckd_examine_error(struct dasd_ccw_req * cqr, struct irb * irb)
+static void dasd_eckd_handle_terminated_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_device *device = (struct dasd_device *) cqr->device;
-	struct ccw_device *cdev = device->cdev;
-
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-
-	switch (cdev->id.cu_type) {
-	case 0x3990:
-	case 0x2105:
-	case 0x2107:
-	case 0x1750:
-		return dasd_3990_erp_examine(cqr, irb);
-	case 0x9343:
-		return dasd_9343_erp_examine(cqr, irb);
-	case 0x3880:
-	default:
-		DEV_MESSAGE(KERN_WARNING, device, "%s",
-			    "default (unknown CU type) - RECOVERABLE return");
-		return dasd_era_recover;
+	cqr->status = DASD_CQR_FILLED;
+	if (cqr->block && (cqr->startdev != cqr->block->base)) {
+		dasd_eckd_reset_ccw_to_base_io(cqr);
+		cqr->startdev = cqr->block->base;
 	}
-}
+};
 
 static dasd_erp_fn_t
 dasd_eckd_erp_action(struct dasd_ccw_req * cqr)
 {
-	struct dasd_device *device = (struct dasd_device *) cqr->device;
+	struct dasd_device *device = (struct dasd_device *) cqr->startdev;
 	struct ccw_device *cdev = device->cdev;
 
 	switch (cdev->id.cu_type) {
@@ -1168,8 +1398,35 @@ dasd_eckd_erp_postaction(struct dasd_ccw
 	return dasd_default_erp_postaction;
 }
 
-static struct dasd_ccw_req *
-dasd_eckd_build_cp(struct dasd_device * device, struct request *req)
+
+static void dasd_eckd_handle_unsolicited_interrupt(struct dasd_device *device,
+						   struct irb *irb)
+{
+	char mask;
+
+	/* first of all check for state change pending interrupt */
+	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
+	if ((irb->scsw.dstat & mask) == mask) {
+		dasd_generic_handle_state_change(device);
+		return;
+	}
+
+	/* summary unit check */
+	if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) && irb->ecw[7] == 0x0D) {
+		dasd_alias_handle_summary_unit_check(device, irb);
+		return;
+	}
+
+	/* just report other unsolicited interrupts */
+	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		    "unsolicited interrupt received");
+	device->discipline->dump_sense(device, NULL, irb);
+	return;
+};
+
+static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
+					       struct dasd_block *block,
+					       struct request *req)
 {
 	struct dasd_eckd_private *private;
 	unsigned long *idaws;
@@ -1185,8 +1442,11 @@ dasd_eckd_build_cp(struct dasd_device * 
 	sector_t first_trk, last_trk;
 	unsigned int first_offs, last_offs;
 	unsigned char cmd, rcmd;
+	int use_prefix;
+	struct dasd_device *basedev;
 
-	private = (struct dasd_eckd_private *) device->private;
+	basedev = block->base;
+	private = (struct dasd_eckd_private *) basedev->private;
 	if (rq_data_dir(req) == READ)
 		cmd = DASD_ECKD_CCW_READ_MT;
 	else if (rq_data_dir(req) == WRITE)
@@ -1194,13 +1454,13 @@ dasd_eckd_build_cp(struct dasd_device * 
 	else
 		return ERR_PTR(-EINVAL);
 	/* Calculate number of blocks/records per track. */
-	blksize = device->bp_block;
+	blksize = block->bp_block;
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
 	/* Calculate record id of first and last block. */
-	first_rec = first_trk = req->sector >> device->s2b_shift;
+	first_rec = first_trk = req->sector >> block->s2b_shift;
 	first_offs = sector_div(first_trk, blk_per_trk);
 	last_rec = last_trk =
-		(req->sector + req->nr_sectors - 1) >> device->s2b_shift;
+		(req->sector + req->nr_sectors - 1) >> block->s2b_shift;
 	last_offs = sector_div(last_trk, blk_per_trk);
 	/* Check struct bio and count the number of blocks for the request. */
 	count = 0;
@@ -1209,20 +1469,33 @@ dasd_eckd_build_cp(struct dasd_device * 
 		if (bv->bv_len & (blksize - 1))
 			/* Eckd can only do full blocks. */
 			return ERR_PTR(-EINVAL);
-		count += bv->bv_len >> (device->s2b_shift + 9);
+		count += bv->bv_len >> (block->s2b_shift + 9);
 #if defined(CONFIG_64BIT)
 		if (idal_is_needed (page_address(bv->bv_page), bv->bv_len))
-			cidaw += bv->bv_len >> (device->s2b_shift + 9);
+			cidaw += bv->bv_len >> (block->s2b_shift + 9);
 #endif
 	}
 	/* Paranoia. */
 	if (count != last_rec - first_rec + 1)
 		return ERR_PTR(-EINVAL);
-	/* 1x define extent + 1x locate record + number of blocks */
-	cplength = 2 + count;
-	/* 1x define extent + 1x locate record + cidaws*sizeof(long) */
-	datasize = sizeof(struct DE_eckd_data) + sizeof(struct LO_eckd_data) +
-		cidaw * sizeof(unsigned long);
+
+	/* use the prefix command if available */
+	use_prefix = private->features.feature[8] & 0x01;
+	if (use_prefix) {
+		/* 1x prefix + number of blocks */
+		cplength = 2 + count;
+		/* 1x prefix + cidaws*sizeof(long) */
+		datasize = sizeof(struct PFX_eckd_data) +
+			sizeof(struct LO_eckd_data) +
+			cidaw * sizeof(unsigned long);
+	} else {
+		/* 1x define extent + 1x locate record + number of blocks */
+		cplength = 2 + count;
+		/* 1x define extent + 1x locate record + cidaws*sizeof(long) */
+		datasize = sizeof(struct DE_eckd_data) +
+			sizeof(struct LO_eckd_data) +
+			cidaw * sizeof(unsigned long);
+	}
 	/* Find out the number of additional locate record ccws for cdl. */
 	if (private->uses_cdl && first_rec < 2*blk_per_trk) {
 		if (last_rec >= 2*blk_per_trk)
@@ -1232,26 +1505,42 @@ dasd_eckd_build_cp(struct dasd_device * 
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
-				   cplength, datasize, device);
+				   cplength, datasize, startdev);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
-	/* First ccw is define extent. */
-	if (define_extent(ccw++, cqr->data, first_trk,
-			  last_trk, cmd, device) == -EAGAIN) {
-		/* Clock not in sync and XRC is enabled. Try again later. */
-		dasd_sfree_request(cqr, device);
-		return ERR_PTR(-EAGAIN);
+	/* First ccw is define extent or prefix. */
+	if (use_prefix) {
+		if (prefix(ccw++, cqr->data, first_trk,
+			   last_trk, cmd, basedev, startdev) == -EAGAIN) {
+			/* Clock not in sync and XRC is enabled.
+			 * Try again later.
+			 */
+			dasd_sfree_request(cqr, startdev);
+			return ERR_PTR(-EAGAIN);
+		}
+		idaws = (unsigned long *) (cqr->data +
+					   sizeof(struct PFX_eckd_data));
+	} else {
+		if (define_extent(ccw++, cqr->data, first_trk,
+				  last_trk, cmd, startdev) == -EAGAIN) {
+			/* Clock not in sync and XRC is enabled.
+			 * Try again later.
+			 */
+			dasd_sfree_request(cqr, startdev);
+			return ERR_PTR(-EAGAIN);
+		}
+		idaws = (unsigned long *) (cqr->data +
+					   sizeof(struct DE_eckd_data));
 	}
 	/* Build locate_record+read/write/ccws. */
-	idaws = (unsigned long *) (cqr->data + sizeof(struct DE_eckd_data));
 	LO_data = (struct LO_eckd_data *) (idaws + cidaw);
 	recid = first_rec;
 	if (private->uses_cdl == 0 || recid > 2*blk_per_trk) {
 		/* Only standard blocks so there is just one locate record. */
 		ccw[-1].flags |= CCW_FLAG_CC;
 		locate_record(ccw++, LO_data++, first_trk, first_offs + 1,
-			      last_rec - recid + 1, cmd, device, blksize);
+			      last_rec - recid + 1, cmd, basedev, blksize);
 	}
 	rq_for_each_segment(bv, req, iter) {
 		dst = page_address(bv->bv_page) + bv->bv_offset;
@@ -1281,7 +1570,7 @@ dasd_eckd_build_cp(struct dasd_device * 
 				ccw[-1].flags |= CCW_FLAG_CC;
 				locate_record(ccw++, LO_data++,
 					      trkid, recoffs + 1,
-					      1, rcmd, device, count);
+					      1, rcmd, basedev, count);
 			}
 			/* Locate record for standard blocks ? */
 			if (private->uses_cdl && recid == 2*blk_per_trk) {
@@ -1289,7 +1578,7 @@ dasd_eckd_build_cp(struct dasd_device * 
 				locate_record(ccw++, LO_data++,
 					      trkid, recoffs + 1,
 					      last_rec - recid + 1,
-					      cmd, device, count);
+					      cmd, basedev, count);
 			}
 			/* Read/write ccw. */
 			ccw[-1].flags |= CCW_FLAG_CC;
@@ -1310,7 +1599,9 @@ dasd_eckd_build_cp(struct dasd_device * 
 	}
 	if (req->cmd_flags & REQ_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
-	cqr->device = device;
+	cqr->startdev = startdev;
+	cqr->memdev = startdev;
+	cqr->block = block;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
 	cqr->lpm = private->path_data.ppm;
 	cqr->retries = 256;
@@ -1333,10 +1624,10 @@ dasd_eckd_free_cp(struct dasd_ccw_req *c
 
 	if (!dasd_page_cache)
 		goto out;
-	private = (struct dasd_eckd_private *) cqr->device->private;
-	blksize = cqr->device->bp_block;
+	private = (struct dasd_eckd_private *) cqr->block->base->private;
+	blksize = cqr->block->bp_block;
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
-	recid = req->sector >> cqr->device->s2b_shift;
+	recid = req->sector >> cqr->block->s2b_shift;
 	ccw = cqr->cpaddr;
 	/* Skip over define extent & locate record. */
 	ccw++;
@@ -1367,10 +1658,71 @@ dasd_eckd_free_cp(struct dasd_ccw_req *c
 	}
 out:
 	status = cqr->status == DASD_CQR_DONE;
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return status;
 }
 
+/*
+ * Modify ccw chain in cqr so it can be started on a base device.
+ *
+ * Note that this is not enough to restart the cqr!
+ * Either reset cqr->startdev as well (summary unit check handling)
+ * or restart via separate cqr (as in ERP handling).
+ */
+void dasd_eckd_reset_ccw_to_base_io(struct dasd_ccw_req *cqr)
+{
+	struct ccw1 *ccw;
+	struct PFX_eckd_data *pfxdata;
+
+	ccw = cqr->cpaddr;
+	pfxdata = cqr->data;
+
+	if (ccw->cmd_code == DASD_ECKD_CCW_PFX) {
+		pfxdata->validity.verify_base = 0;
+		pfxdata->validity.hyper_pav = 0;
+	}
+}
+
+#define DASD_ECKD_CHANQ_MAX_SIZE 4
+
+static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
+						     struct dasd_block *block,
+						     struct request *req)
+{
+	struct dasd_eckd_private *private;
+	struct dasd_device *startdev;
+	unsigned long flags;
+	struct dasd_ccw_req *cqr;
+
+	startdev = dasd_alias_get_start_dev(base);
+	if (!startdev)
+		startdev = base;
+	private = (struct dasd_eckd_private *) startdev->private;
+	if (private->count >= DASD_ECKD_CHANQ_MAX_SIZE)
+		return ERR_PTR(-EBUSY);
+
+	spin_lock_irqsave(get_ccwdev_lock(startdev->cdev), flags);
+	private->count++;
+	cqr = dasd_eckd_build_cp(startdev, block, req);
+	if (IS_ERR(cqr))
+		private->count--;
+	spin_unlock_irqrestore(get_ccwdev_lock(startdev->cdev), flags);
+	return cqr;
+}
+
+static int dasd_eckd_free_alias_cp(struct dasd_ccw_req *cqr,
+				   struct request *req)
+{
+	struct dasd_eckd_private *private;
+	unsigned long flags;
+
+	spin_lock_irqsave(get_ccwdev_lock(cqr->memdev->cdev), flags);
+	private = (struct dasd_eckd_private *) cqr->memdev->private;
+	private->count--;
+	spin_unlock_irqrestore(get_ccwdev_lock(cqr->memdev->cdev), flags);
+	return dasd_eckd_free_cp(cqr, req);
+}
+
 static int
 dasd_eckd_fill_info(struct dasd_device * device,
 		    struct dasd_information2_t * info)
@@ -1384,9 +1736,9 @@ dasd_eckd_fill_info(struct dasd_device *
 	info->characteristics_size = sizeof(struct dasd_eckd_characteristics);
 	memcpy(info->characteristics, &private->rdc_data,
 	       sizeof(struct dasd_eckd_characteristics));
-	info->confdata_size = sizeof (struct dasd_eckd_confdata);
+	info->confdata_size = sizeof(struct dasd_eckd_confdata);
 	memcpy(info->configuration_data, &private->conf_data,
-	       sizeof (struct dasd_eckd_confdata));
+	       sizeof(struct dasd_eckd_confdata));
 	return 0;
 }
 
@@ -1419,7 +1771,8 @@ dasd_eckd_release(struct dasd_device *de
         cqr->cpaddr->flags |= CCW_FLAG_SLI;
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 2;	/* set retry counter to enable basic ERP */
@@ -1429,7 +1782,7 @@ dasd_eckd_release(struct dasd_device *de
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
 
@@ -1459,7 +1812,8 @@ dasd_eckd_reserve(struct dasd_device *de
         cqr->cpaddr->flags |= CCW_FLAG_SLI;
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 2;	/* set retry counter to enable basic ERP */
@@ -1469,7 +1823,7 @@ dasd_eckd_reserve(struct dasd_device *de
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
 
@@ -1498,7 +1852,8 @@ dasd_eckd_steal_lock(struct dasd_device 
         cqr->cpaddr->flags |= CCW_FLAG_SLI;
         cqr->cpaddr->count = 32;
 	cqr->cpaddr->cda = (__u32)(addr_t) cqr->data;
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
 	set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
 	cqr->retries = 2;	/* set retry counter to enable basic ERP */
@@ -1508,7 +1863,7 @@ dasd_eckd_steal_lock(struct dasd_device 
 
 	rc = dasd_sleep_on_immediatly(cqr);
 
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
 
@@ -1526,38 +1881,39 @@ dasd_eckd_performance(struct dasd_device
 
 	cqr = dasd_smalloc_request(dasd_eckd_discipline.name,
 				   1 /* PSF */  + 1 /* RSSD */ ,
-				   (sizeof (struct dasd_psf_prssd_data) +
-				    sizeof (struct dasd_rssd_perf_stats_t)),
+				   (sizeof(struct dasd_psf_prssd_data) +
+				    sizeof(struct dasd_rssd_perf_stats_t)),
 				   device);
 	if (IS_ERR(cqr)) {
 		DEV_MESSAGE(KERN_WARNING, device, "%s",
 			    "Could not allocate initialization request");
 		return PTR_ERR(cqr);
 	}
-	cqr->device = device;
+	cqr->startdev = device;
+	cqr->memdev = device;
 	cqr->retries = 0;
 	cqr->expires = 10 * HZ;
 
 	/* Prepare for Read Subsystem Data */
 	prssdp = (struct dasd_psf_prssd_data *) cqr->data;
-	memset(prssdp, 0, sizeof (struct dasd_psf_prssd_data));
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = 0x01;	/* Performance Statistics */
 	prssdp->varies[1] = 0x01;	/* Perf Statistics for the Subsystem */
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->count = sizeof (struct dasd_psf_prssd_data);
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->cda = (__u32)(addr_t) prssdp;
 
 	/* Read Subsystem Data - Performance Statistics */
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
-	memset(stats, 0, sizeof (struct dasd_rssd_perf_stats_t));
+	memset(stats, 0, sizeof(struct dasd_rssd_perf_stats_t));
 
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
-	ccw->count = sizeof (struct dasd_rssd_perf_stats_t);
+	ccw->count = sizeof(struct dasd_rssd_perf_stats_t);
 	ccw->cda = (__u32)(addr_t) stats;
 
 	cqr->buildclk = get_clock();
@@ -1571,7 +1927,7 @@ dasd_eckd_performance(struct dasd_device
 				 sizeof(struct dasd_rssd_perf_stats_t)))
 			rc = -EFAULT;
 	}
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return rc;
 }
 
@@ -1594,7 +1950,7 @@ dasd_eckd_get_attrib(struct dasd_device 
 
 	rc = 0;
 	if (copy_to_user(argp, (long *) &attrib,
-			 sizeof (struct attrib_data_t)))
+			 sizeof(struct attrib_data_t)))
 		rc = -EFAULT;
 
 	return rc;
@@ -1627,8 +1983,10 @@ dasd_eckd_set_attrib(struct dasd_device 
 }
 
 static int
-dasd_eckd_ioctl(struct dasd_device *device, unsigned int cmd, void __user *argp)
+dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
 {
+	struct dasd_device *device = block->base;
+
 	switch (cmd) {
 	case BIODASDGATTR:
 		return dasd_eckd_get_attrib(device, argp);
@@ -1685,9 +2043,8 @@ dasd_eckd_dump_ccw_range(struct ccw1 *fr
  * Print sense data and related channel program.
  * Parts are printed because printk buffer is only 1024 bytes.
  */
-static void
-dasd_eckd_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
-		     struct irb *irb)
+static void dasd_eckd_dump_sense(struct dasd_device *device,
+				 struct dasd_ccw_req *req, struct irb *irb)
 {
 	char *page;
 	struct ccw1 *first, *last, *fail, *from, *to;
@@ -1743,37 +2100,40 @@ dasd_eckd_dump_sense(struct dasd_device 
 	}
 	printk("%s", page);
 
-	/* dump the Channel Program (max 140 Bytes per line) */
-	/* Count CCW and print first CCWs (maximum 1024 % 140 = 7) */
-	first = req->cpaddr;
-	for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
-	to = min(first + 6, last);
-	len = sprintf(page,  KERN_ERR PRINTK_HEADER
-		      " Related CP in req: %p\n", req);
-	dasd_eckd_dump_ccw_range(first, to, page + len);
-	printk("%s", page);
+	if (req) {
+		/* req == NULL for unsolicited interrupts */
+		/* dump the Channel Program (max 140 Bytes per line) */
+		/* Count CCW and print first CCWs (maximum 1024 % 140 = 7) */
+		first = req->cpaddr;
+		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
+		to = min(first + 6, last);
+		len = sprintf(page,  KERN_ERR PRINTK_HEADER
+			      " Related CP in req: %p\n", req);
+		dasd_eckd_dump_ccw_range(first, to, page + len);
+		printk("%s", page);
 
-	/* print failing CCW area (maximum 4) */
-	/* scsw->cda is either valid or zero  */
-	len = 0;
-	from = ++to;
-	fail = (struct ccw1 *)(addr_t) irb->scsw.cpa; /* failing CCW */
-	if (from <  fail - 2) {
-		from = fail - 2;     /* there is a gap - print header */
-		len += sprintf(page, KERN_ERR PRINTK_HEADER "......\n");
-	}
-	to = min(fail + 1, last);
-	len += dasd_eckd_dump_ccw_range(from, to, page + len);
-
-	/* print last CCWs (maximum 2) */
-	from = max(from, ++to);
-	if (from < last - 1) {
-		from = last - 1;     /* there is a gap - print header */
-		len += sprintf(page + len, KERN_ERR PRINTK_HEADER "......\n");
+		/* print failing CCW area (maximum 4) */
+		/* scsw->cda is either valid or zero  */
+		len = 0;
+		from = ++to;
+		fail = (struct ccw1 *)(addr_t) irb->scsw.cpa; /* failing CCW */
+		if (from <  fail - 2) {
+			from = fail - 2;     /* there is a gap - print header */
+			len += sprintf(page, KERN_ERR PRINTK_HEADER "......\n");
+		}
+		to = min(fail + 1, last);
+		len += dasd_eckd_dump_ccw_range(from, to, page + len);
+
+		/* print last CCWs (maximum 2) */
+		from = max(from, ++to);
+		if (from < last - 1) {
+			from = last - 1;     /* there is a gap - print header */
+			len += sprintf(page + len, KERN_ERR PRINTK_HEADER "......\n");
+		}
+		len += dasd_eckd_dump_ccw_range(from, last, page + len);
+		if (len > 0)
+			printk("%s", page);
 	}
-	len += dasd_eckd_dump_ccw_range(from, last, page + len);
-	if (len > 0)
-		printk("%s", page);
 	free_page((unsigned long) page);
 }
 
@@ -1796,16 +2156,20 @@ static struct dasd_discipline dasd_eckd_
 	.ebcname = "ECKD",
 	.max_blocks = 240,
 	.check_device = dasd_eckd_check_characteristics,
+	.uncheck_device = dasd_eckd_uncheck_device,
 	.do_analysis = dasd_eckd_do_analysis,
+	.ready_to_online = dasd_eckd_ready_to_online,
+	.online_to_ready = dasd_eckd_online_to_ready,
 	.fill_geometry = dasd_eckd_fill_geometry,
 	.start_IO = dasd_start_IO,
 	.term_IO = dasd_term_IO,
+	.handle_terminated_request = dasd_eckd_handle_terminated_request,
 	.format_device = dasd_eckd_format_device,
-	.examine_error = dasd_eckd_examine_error,
 	.erp_action = dasd_eckd_erp_action,
 	.erp_postaction = dasd_eckd_erp_postaction,
-	.build_cp = dasd_eckd_build_cp,
-	.free_cp = dasd_eckd_free_cp,
+	.handle_unsolicited_interrupt = dasd_eckd_handle_unsolicited_interrupt,
+	.build_cp = dasd_eckd_build_alias_cp,
+	.free_cp = dasd_eckd_free_alias_cp,
 	.dump_sense = dasd_eckd_dump_sense,
 	.fill_info = dasd_eckd_fill_info,
 	.ioctl = dasd_eckd_ioctl,
Index: quilt-2.6/drivers/s390/block/dasd_eckd.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.h
+++ quilt-2.6/drivers/s390/block/dasd_eckd.h
@@ -39,6 +39,8 @@
 #define DASD_ECKD_CCW_READ_CKD_MT	 0x9e
 #define DASD_ECKD_CCW_WRITE_CKD_MT	 0x9d
 #define DASD_ECKD_CCW_RESERVE		 0xB4
+#define DASD_ECKD_CCW_PFX		 0xE7
+#define DASD_ECKD_CCW_RSCK		 0xF9
 
 /*
  * Perform Subsystem Function / Sub-Orders
@@ -137,6 +139,25 @@ struct LO_eckd_data {
 	__u16 length;
 } __attribute__ ((packed));
 
+/* Prefix data for format 0x00 and 0x01 */
+struct PFX_eckd_data {
+	unsigned char format;
+	struct {
+		unsigned char define_extend:1;
+		unsigned char time_stamp:1;
+		unsigned char verify_base:1;
+		unsigned char hyper_pav:1;
+		unsigned char reserved:4;
+	} __attribute__ ((packed)) validity;
+	__u8 base_address;
+	__u8 aux;
+	__u8 base_lss;
+	__u8 reserved[7];
+	struct DE_eckd_data define_extend;
+	struct LO_eckd_data locate_record;
+	__u8 LO_extended_data[4];
+} __attribute__ ((packed));
+
 struct dasd_eckd_characteristics {
 	__u16 cu_type;
 	struct {
@@ -254,7 +275,9 @@ struct dasd_eckd_confdata {
 		} __attribute__ ((packed)) ned;
 		struct {
 			unsigned char flags;            /* byte  0    */
-			unsigned char res2[7];          /* byte  1- 7 */
+			unsigned char res1;		/* byte  1    */
+			__u16 format;			/* byte  2-3  */
+			unsigned char res2[4];		/* byte  4-7  */
 			unsigned char sua_flags;	/* byte  8    */
 			__u8 base_unit_addr;            /* byte  9    */
 			unsigned char res3[22];	        /* byte 10-31 */
@@ -343,6 +366,11 @@ struct dasd_eckd_path {
 	__u8 npm;
 };
 
+struct dasd_rssd_features {
+	char feature[256];
+} __attribute__((packed));
+
+
 /*
  * Perform Subsystem Function - Prepare for Read Subsystem Data
  */
@@ -365,4 +393,99 @@ struct dasd_psf_ssc_data {
 	unsigned char reserved[59];
 } __attribute__((packed));
 
+
+/*
+ * some structures and definitions for alias handling
+ */
+struct dasd_unit_address_configuration {
+	struct {
+		char ua_type;
+		char base_ua;
+	} unit[256];
+} __attribute__((packed));
+
+
+#define MAX_DEVICES_PER_LCU 256
+
+/* flags on the LCU  */
+#define NEED_UAC_UPDATE  0x01
+#define UPDATE_PENDING	0x02
+
+enum pavtype {NO_PAV, BASE_PAV, HYPER_PAV};
+
+
+struct alias_root {
+	struct list_head serverlist;
+	spinlock_t lock;
+};
+
+struct alias_server {
+	struct list_head server;
+	struct dasd_uid uid;
+	struct list_head lculist;
+};
+
+struct summary_unit_check_work_data {
+	char reason;
+	struct dasd_device *device;
+	struct work_struct worker;
+};
+
+struct read_uac_work_data {
+	struct dasd_device *device;
+	struct delayed_work dwork;
+};
+
+struct alias_lcu {
+	struct list_head lcu;
+	struct dasd_uid uid;
+	enum pavtype pav;
+	char flags;
+	spinlock_t lock;
+	struct list_head grouplist;
+	struct list_head active_devices;
+	struct list_head inactive_devices;
+	struct dasd_unit_address_configuration *uac;
+	struct summary_unit_check_work_data suc_data;
+	struct read_uac_work_data ruac_data;
+	struct dasd_ccw_req *rsu_cqr;
+};
+
+struct alias_pav_group {
+	struct list_head group;
+	struct dasd_uid uid;
+	struct alias_lcu *lcu;
+	struct list_head baselist;
+	struct list_head aliaslist;
+	struct dasd_device *next;
+};
+
+
+struct dasd_eckd_private {
+	struct dasd_eckd_characteristics rdc_data;
+	struct dasd_eckd_confdata conf_data;
+	struct dasd_eckd_path path_data;
+	struct eckd_count count_area[5];
+	int init_cqr_status;
+	int uses_cdl;
+	struct attrib_data_t attrib;	/* e.g. cache operations */
+	struct dasd_rssd_features features;
+
+	/* alias managemnet */
+	struct dasd_uid uid;
+	struct alias_pav_group *pavgroup;
+	struct alias_lcu *lcu;
+	int count;
+};
+
+
+
+int dasd_alias_make_device_known_to_lcu(struct dasd_device *);
+void dasd_alias_disconnect_device_from_lcu(struct dasd_device *);
+int dasd_alias_add_device(struct dasd_device *);
+int dasd_alias_remove_device(struct dasd_device *);
+struct dasd_device *dasd_alias_get_start_dev(struct dasd_device *);
+void dasd_alias_handle_summary_unit_check(struct dasd_device *, struct irb *);
+void dasd_eckd_reset_ccw_to_base_io(struct dasd_ccw_req *);
+
 #endif				/* DASD_ECKD_H */
Index: quilt-2.6/drivers/s390/block/dasd_eer.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eer.c
+++ quilt-2.6/drivers/s390/block/dasd_eer.c
@@ -336,7 +336,7 @@ static void dasd_eer_write_snss_trigger(
 	unsigned long flags;
 	struct eerbuffer *eerb;
 
-	snss_rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
+	snss_rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
 	if (snss_rc)
 		data_size = 0;
 	else
@@ -404,10 +404,11 @@ void dasd_eer_snss(struct dasd_device *d
 		set_bit(DASD_FLAG_EER_SNSS, &device->flags);
 		return;
 	}
+	/* cdev is already locked, can't use dasd_add_request_head */
 	clear_bit(DASD_FLAG_EER_SNSS, &device->flags);
 	cqr->status = DASD_CQR_QUEUED;
-	list_add(&cqr->list, &device->ccw_queue);
-	dasd_schedule_bh(device);
+	list_add(&cqr->devlist, &device->ccw_queue);
+	dasd_schedule_device_bh(device);
 }
 
 /*
@@ -415,7 +416,7 @@ void dasd_eer_snss(struct dasd_device *d
  */
 static void dasd_eer_snss_cb(struct dasd_ccw_req *cqr, void *data)
 {
-        struct dasd_device *device = cqr->device;
+	struct dasd_device *device = cqr->startdev;
 	unsigned long flags;
 
 	dasd_eer_write(device, cqr, DASD_EER_STATECHANGE);
@@ -458,7 +459,7 @@ int dasd_eer_enable(struct dasd_device *
 	if (!cqr)
 		return -ENOMEM;
 
-	cqr->device = device;
+	cqr->startdev = device;
 	cqr->retries = 255;
 	cqr->expires = 10 * HZ;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
Index: quilt-2.6/drivers/s390/block/dasd_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_erp.c
+++ quilt-2.6/drivers/s390/block/dasd_erp.c
@@ -46,6 +46,8 @@ dasd_alloc_erp_request(char *magic, int 
 	if (cqr == NULL)
 		return ERR_PTR(-ENOMEM);
 	memset(cqr, 0, sizeof(struct dasd_ccw_req));
+	INIT_LIST_HEAD(&cqr->devlist);
+	INIT_LIST_HEAD(&cqr->blocklist);
 	data = (char *) cqr + ((sizeof(struct dasd_ccw_req) + 7L) & -8L);
 	cqr->cpaddr = NULL;
 	if (cplength > 0) {
@@ -66,7 +68,7 @@ dasd_alloc_erp_request(char *magic, int 
 }
 
 void
-dasd_free_erp_request(struct dasd_ccw_req * cqr, struct dasd_device * device)
+dasd_free_erp_request(struct dasd_ccw_req *cqr, struct dasd_device * device)
 {
 	unsigned long flags;
 
@@ -81,11 +83,11 @@ dasd_free_erp_request(struct dasd_ccw_re
  * dasd_default_erp_action just retries the current cqr
  */
 struct dasd_ccw_req *
-dasd_default_erp_action(struct dasd_ccw_req * cqr)
+dasd_default_erp_action(struct dasd_ccw_req *cqr)
 {
 	struct dasd_device *device;
 
-	device = cqr->device;
+	device = cqr->startdev;
 
         /* just retry - there is nothing to save ... I got no sense data.... */
         if (cqr->retries > 0) {
@@ -93,12 +95,12 @@ dasd_default_erp_action(struct dasd_ccw_
                              "default ERP called (%i retries left)",
                              cqr->retries);
 		cqr->lpm    = LPM_ANYPATH;
-		cqr->status = DASD_CQR_QUEUED;
+		cqr->status = DASD_CQR_FILLED;
         } else {
                 DEV_MESSAGE (KERN_WARNING, device, "%s",
 			     "default ERP called (NO retry left)");
 		cqr->status = DASD_CQR_FAILED;
-		cqr->stopclk = get_clock ();
+		cqr->stopclk = get_clock();
         }
         return cqr;
 }				/* end dasd_default_erp_action */
@@ -117,15 +119,12 @@ dasd_default_erp_action(struct dasd_ccw_
  * RETURN VALUES
  *   cqr		pointer to the original CQR
  */
-struct dasd_ccw_req *
-dasd_default_erp_postaction(struct dasd_ccw_req * cqr)
+struct dasd_ccw_req *dasd_default_erp_postaction(struct dasd_ccw_req *cqr)
 {
-	struct dasd_device *device;
 	int success;
 
 	BUG_ON(cqr->refers == NULL || cqr->function == NULL);
 
-	device = cqr->device;
 	success = cqr->status == DASD_CQR_DONE;
 
 	/* free all ERPs - but NOT the original cqr */
@@ -133,10 +132,10 @@ dasd_default_erp_postaction(struct dasd_
 		struct dasd_ccw_req *refers;
 
 		refers = cqr->refers;
-		/* remove the request from the device queue */
-		list_del(&cqr->list);
+		/* remove the request from the block queue */
+		list_del(&cqr->blocklist);
 		/* free the finished erp request */
-		dasd_free_erp_request(cqr, device);
+		dasd_free_erp_request(cqr, cqr->memdev);
 		cqr = refers;
 	}
 
@@ -157,7 +156,7 @@ dasd_log_sense(struct dasd_ccw_req *cqr,
 {
 	struct dasd_device *device;
 
-	device = cqr->device;
+	device = cqr->startdev;
 	/* dump sense data */
 	if (device->discipline && device->discipline->dump_sense)
 		device->discipline->dump_sense(device, cqr, irb);
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c
+++ quilt-2.6/drivers/s390/block/dasd_fba.c
@@ -117,6 +117,7 @@ locate_record(struct ccw1 * ccw, struct 
 static int
 dasd_fba_check_characteristics(struct dasd_device *device)
 {
+	struct dasd_block *block;
 	struct dasd_fba_private *private;
 	struct ccw_device *cdev = device->cdev;
 	void *rdc_data;
@@ -133,6 +134,16 @@ dasd_fba_check_characteristics(struct da
 		}
 		device->private = (void *) private;
 	}
+	block = dasd_alloc_block();
+	if (IS_ERR(block)) {
+		DEV_MESSAGE(KERN_WARNING, device, "%s",
+			    "could not allocate dasd block structure");
+		kfree(device->private);
+		return PTR_ERR(block);
+	}
+	device->block = block;
+	block->base = device;
+
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
 	rc = dasd_generic_read_dev_chars(device, "FBA ", &rdc_data, 32);
@@ -156,59 +167,37 @@ dasd_fba_check_characteristics(struct da
 }
 
 static int
-dasd_fba_do_analysis(struct dasd_device *device)
+dasd_fba_do_analysis(struct dasd_block *block)
 {
 	struct dasd_fba_private *private;
 	int sb, rc;
 
-	private = (struct dasd_fba_private *) device->private;
+	private = (struct dasd_fba_private *) block->base->private;
 	rc = dasd_check_blocksize(private->rdc_data.blk_size);
 	if (rc) {
-		DEV_MESSAGE(KERN_INFO, device, "unknown blocksize %d",
+		DEV_MESSAGE(KERN_INFO, block->base, "unknown blocksize %d",
 			    private->rdc_data.blk_size);
 		return rc;
 	}
-	device->blocks = private->rdc_data.blk_bdsa;
-	device->bp_block = private->rdc_data.blk_size;
-	device->s2b_shift = 0;	/* bits to shift 512 to get a block */
+	block->blocks = private->rdc_data.blk_bdsa;
+	block->bp_block = private->rdc_data.blk_size;
+	block->s2b_shift = 0;	/* bits to shift 512 to get a block */
 	for (sb = 512; sb < private->rdc_data.blk_size; sb = sb << 1)
-		device->s2b_shift++;
+		block->s2b_shift++;
 	return 0;
 }
 
 static int
-dasd_fba_fill_geometry(struct dasd_device *device, struct hd_geometry *geo)
+dasd_fba_fill_geometry(struct dasd_block *block, struct hd_geometry *geo)
 {
-	if (dasd_check_blocksize(device->bp_block) != 0)
+	if (dasd_check_blocksize(block->bp_block) != 0)
 		return -EINVAL;
-	geo->cylinders = (device->blocks << device->s2b_shift) >> 10;
+	geo->cylinders = (block->blocks << block->s2b_shift) >> 10;
 	geo->heads = 16;
-	geo->sectors = 128 >> device->s2b_shift;
+	geo->sectors = 128 >> block->s2b_shift;
 	return 0;
 }
 
-static dasd_era_t
-dasd_fba_examine_error(struct dasd_ccw_req * cqr, struct irb * irb)
-{
-	struct dasd_device *device;
-	struct ccw_device *cdev;
-
-	device = (struct dasd_device *) cqr->device;
-	if (irb->scsw.cstat == 0x00 &&
-	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
-		return dasd_era_none;
-
-	cdev = device->cdev;
-	switch (cdev->id.dev_type) {
-	case 0x3370:
-		return dasd_3370_erp_examine(cqr, irb);
-	case 0x9336:
-		return dasd_9336_erp_examine(cqr, irb);
-	default:
-		return dasd_era_recover;
-	}
-}
-
 static dasd_erp_fn_t
 dasd_fba_erp_action(struct dasd_ccw_req * cqr)
 {
@@ -221,13 +210,32 @@ dasd_fba_erp_postaction(struct dasd_ccw_
 	if (cqr->function == dasd_default_erp_action)
 		return dasd_default_erp_postaction;
 
-	DEV_MESSAGE(KERN_WARNING, cqr->device, "unknown ERP action %p",
+	DEV_MESSAGE(KERN_WARNING, cqr->startdev, "unknown ERP action %p",
 		    cqr->function);
 	return NULL;
 }
 
-static struct dasd_ccw_req *
-dasd_fba_build_cp(struct dasd_device * device, struct request *req)
+static void dasd_fba_handle_unsolicited_interrupt(struct dasd_device *device,
+						   struct irb *irb) {
+	char mask;
+
+	/* first of all check for state change pending interrupt */
+	mask = DEV_STAT_ATTENTION | DEV_STAT_DEV_END | DEV_STAT_UNIT_EXCEP;
+	if ((irb->scsw.dstat & mask) == mask) {
+		dasd_generic_handle_state_change(device);
+		return;
+	}
+
+	/* check for unsolicited interrupts */
+	DEV_MESSAGE(KERN_DEBUG, device, "%s",
+		    "unsolicited interrupt received");
+	device->discipline->dump_sense(device, NULL, irb);
+	return;
+};
+
+static struct dasd_ccw_req *dasd_fba_build_cp(struct dasd_device * memdev,
+					      struct dasd_block *block,
+					      struct request *req)
 {
 	struct dasd_fba_private *private;
 	unsigned long *idaws;
@@ -242,17 +250,17 @@ dasd_fba_build_cp(struct dasd_device * d
 	unsigned int blksize, off;
 	unsigned char cmd;
 
-	private = (struct dasd_fba_private *) device->private;
+	private = (struct dasd_fba_private *) block->base->private;
 	if (rq_data_dir(req) == READ) {
 		cmd = DASD_FBA_CCW_READ;
 	} else if (rq_data_dir(req) == WRITE) {
 		cmd = DASD_FBA_CCW_WRITE;
 	} else
 		return ERR_PTR(-EINVAL);
-	blksize = device->bp_block;
+	blksize = block->bp_block;
 	/* Calculate record id of first and last block. */
-	first_rec = req->sector >> device->s2b_shift;
-	last_rec = (req->sector + req->nr_sectors - 1) >> device->s2b_shift;
+	first_rec = req->sector >> block->s2b_shift;
+	last_rec = (req->sector + req->nr_sectors - 1) >> block->s2b_shift;
 	/* Check struct bio and count the number of blocks for the request. */
 	count = 0;
 	cidaw = 0;
@@ -260,7 +268,7 @@ dasd_fba_build_cp(struct dasd_device * d
 		if (bv->bv_len & (blksize - 1))
 			/* Fba can only do full blocks. */
 			return ERR_PTR(-EINVAL);
-		count += bv->bv_len >> (device->s2b_shift + 9);
+		count += bv->bv_len >> (block->s2b_shift + 9);
 #if defined(CONFIG_64BIT)
 		if (idal_is_needed (page_address(bv->bv_page), bv->bv_len))
 			cidaw += bv->bv_len / blksize;
@@ -284,13 +292,13 @@ dasd_fba_build_cp(struct dasd_device * d
 	}
 	/* Allocate the ccw request. */
 	cqr = dasd_smalloc_request(dasd_fba_discipline.name,
-				   cplength, datasize, device);
+				   cplength, datasize, memdev);
 	if (IS_ERR(cqr))
 		return cqr;
 	ccw = cqr->cpaddr;
 	/* First ccw is define extent. */
 	define_extent(ccw++, cqr->data, rq_data_dir(req),
-		      device->bp_block, req->sector, req->nr_sectors);
+		      block->bp_block, req->sector, req->nr_sectors);
 	/* Build locate_record + read/write ccws. */
 	idaws = (unsigned long *) (cqr->data + sizeof(struct DE_fba_data));
 	LO_data = (struct LO_fba_data *) (idaws + cidaw);
@@ -326,7 +334,7 @@ dasd_fba_build_cp(struct dasd_device * d
 					ccw[-1].flags |= CCW_FLAG_CC;
 			}
 			ccw->cmd_code = cmd;
-			ccw->count = device->bp_block;
+			ccw->count = block->bp_block;
 			if (idal_is_needed(dst, blksize)) {
 				ccw->cda = (__u32)(addr_t) idaws;
 				ccw->flags = CCW_FLAG_IDA;
@@ -342,7 +350,9 @@ dasd_fba_build_cp(struct dasd_device * d
 	}
 	if (req->cmd_flags & REQ_FAILFAST)
 		set_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags);
-	cqr->device = device;
+	cqr->startdev = memdev;
+	cqr->memdev = memdev;
+	cqr->block = block;
 	cqr->expires = 5 * 60 * HZ;	/* 5 minutes */
 	cqr->retries = 32;
 	cqr->buildclk = get_clock();
@@ -363,8 +373,8 @@ dasd_fba_free_cp(struct dasd_ccw_req *cq
 
 	if (!dasd_page_cache)
 		goto out;
-	private = (struct dasd_fba_private *) cqr->device->private;
-	blksize = cqr->device->bp_block;
+	private = (struct dasd_fba_private *) cqr->block->base->private;
+	blksize = cqr->block->bp_block;
 	ccw = cqr->cpaddr;
 	/* Skip over define extent & locate record. */
 	ccw++;
@@ -394,10 +404,15 @@ dasd_fba_free_cp(struct dasd_ccw_req *cq
 	}
 out:
 	status = cqr->status == DASD_CQR_DONE;
-	dasd_sfree_request(cqr, cqr->device);
+	dasd_sfree_request(cqr, cqr->memdev);
 	return status;
 }
 
+static void dasd_fba_handle_terminated_request(struct dasd_ccw_req *cqr)
+{
+	cqr->status = DASD_CQR_FILLED;
+};
+
 static int
 dasd_fba_fill_info(struct dasd_device * device,
 		   struct dasd_information2_t * info)
@@ -546,9 +561,10 @@ static struct dasd_discipline dasd_fba_d
 	.fill_geometry = dasd_fba_fill_geometry,
 	.start_IO = dasd_start_IO,
 	.term_IO = dasd_term_IO,
-	.examine_error = dasd_fba_examine_error,
+	.handle_terminated_request = dasd_fba_handle_terminated_request,
 	.erp_action = dasd_fba_erp_action,
 	.erp_postaction = dasd_fba_erp_postaction,
+	.handle_unsolicited_interrupt = dasd_fba_handle_unsolicited_interrupt,
 	.build_cp = dasd_fba_build_cp,
 	.free_cp = dasd_fba_free_cp,
 	.dump_sense = dasd_fba_dump_sense,
Index: quilt-2.6/drivers/s390/block/dasd_genhd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_genhd.c
+++ quilt-2.6/drivers/s390/block/dasd_genhd.c
@@ -25,14 +25,15 @@
 /*
  * Allocate and register gendisk structure for device.
  */
-int
-dasd_gendisk_alloc(struct dasd_device *device)
+int dasd_gendisk_alloc(struct dasd_block *block)
 {
 	struct gendisk *gdp;
+	struct dasd_device *base;
 	int len;
 
 	/* Make sure the minor for this device exists. */
-	if (device->devindex >= DASD_PER_MAJOR)
+	base = block->base;
+	if (base->devindex >= DASD_PER_MAJOR)
 		return -EBUSY;
 
 	gdp = alloc_disk(1 << DASD_PARTN_BITS);
@@ -41,9 +42,9 @@ dasd_gendisk_alloc(struct dasd_device *d
 
 	/* Initialize gendisk structure. */
 	gdp->major = DASD_MAJOR;
-	gdp->first_minor = device->devindex << DASD_PARTN_BITS;
+	gdp->first_minor = base->devindex << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
-	gdp->driverfs_dev = &device->cdev->dev;
+	gdp->driverfs_dev = &base->cdev->dev;
 
 	/*
 	 * Set device name.
@@ -53,53 +54,51 @@ dasd_gendisk_alloc(struct dasd_device *d
 	 *   dasdaaaa - dasdzzzz : 456976 devices, added up = 475252
 	 */
 	len = sprintf(gdp->disk_name, "dasd");
-	if (device->devindex > 25) {
-	        if (device->devindex > 701) {
-		        if (device->devindex > 18277)
+	if (base->devindex > 25) {
+		if (base->devindex > 701) {
+			if (base->devindex > 18277)
 			        len += sprintf(gdp->disk_name + len, "%c",
-					       'a'+(((device->devindex-18278)
+					       'a'+(((base->devindex-18278)
 						     /17576)%26));
 			len += sprintf(gdp->disk_name + len, "%c",
-				       'a'+(((device->devindex-702)/676)%26));
+				       'a'+(((base->devindex-702)/676)%26));
 		}
 		len += sprintf(gdp->disk_name + len, "%c",
-			       'a'+(((device->devindex-26)/26)%26));
+			       'a'+(((base->devindex-26)/26)%26));
 	}
-	len += sprintf(gdp->disk_name + len, "%c", 'a'+(device->devindex%26));
+	len += sprintf(gdp->disk_name + len, "%c", 'a'+(base->devindex%26));
 
-	if (device->features & DASD_FEATURE_READONLY)
+	if (block->base->features & DASD_FEATURE_READONLY)
 		set_disk_ro(gdp, 1);
-	gdp->private_data = device;
-	gdp->queue = device->request_queue;
-	device->gdp = gdp;
-	set_capacity(device->gdp, 0);
-	add_disk(device->gdp);
+	gdp->private_data = block;
+	gdp->queue = block->request_queue;
+	block->gdp = gdp;
+	set_capacity(block->gdp, 0);
+	add_disk(block->gdp);
 	return 0;
 }
 
 /*
  * Unregister and free gendisk structure for device.
  */
-void
-dasd_gendisk_free(struct dasd_device *device)
+void dasd_gendisk_free(struct dasd_block *block)
 {
-	if (device->gdp) {
-		del_gendisk(device->gdp);
-		device->gdp->queue = NULL;
-		put_disk(device->gdp);
-		device->gdp = NULL;
+	if (block->gdp) {
+		del_gendisk(block->gdp);
+		block->gdp->queue = NULL;
+		put_disk(block->gdp);
+		block->gdp = NULL;
 	}
 }
 
 /*
  * Trigger a partition detection.
  */
-int
-dasd_scan_partitions(struct dasd_device * device)
+int dasd_scan_partitions(struct dasd_block *block)
 {
 	struct block_device *bdev;
 
-	bdev = bdget_disk(device->gdp, 0);
+	bdev = bdget_disk(block->gdp, 0);
 	if (!bdev || blkdev_get(bdev, FMODE_READ, 1) < 0)
 		return -ENODEV;
 	/*
@@ -117,7 +116,7 @@ dasd_scan_partitions(struct dasd_device 
 	 * is why the assignment to device->bdev is done AFTER
 	 * the BLKRRPART ioctl.
 	 */
-	device->bdev = bdev;
+	block->bdev = bdev;
 	return 0;
 }
 
@@ -125,8 +124,7 @@ dasd_scan_partitions(struct dasd_device 
  * Remove all inodes in the system for a device, delete the
  * partitions and make device unusable by setting its size to zero.
  */
-void
-dasd_destroy_partitions(struct dasd_device * device)
+void dasd_destroy_partitions(struct dasd_block *block)
 {
 	/* The two structs have 168/176 byte on 31/64 bit. */
 	struct blkpg_partition bpart;
@@ -137,8 +135,8 @@ dasd_destroy_partitions(struct dasd_devi
 	 * Get the bdev pointer from the device structure and clear
 	 * device->bdev to lower the offline open_count limit again.
 	 */
-	bdev = device->bdev;
-	device->bdev = NULL;
+	bdev = block->bdev;
+	block->bdev = NULL;
 
 	/*
 	 * See fs/partition/check.c:delete_partition
@@ -149,17 +147,16 @@ dasd_destroy_partitions(struct dasd_devi
 	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
 	barg.data = (void __force __user *) &bpart;
 	barg.op = BLKPG_DEL_PARTITION;
-	for (bpart.pno = device->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
+	for (bpart.pno = block->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
 		ioctl_by_bdev(bdev, BLKPG, (unsigned long) &barg);
 
-	invalidate_partition(device->gdp, 0);
+	invalidate_partition(block->gdp, 0);
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
 	blkdev_put(bdev);
-	set_capacity(device->gdp, 0);
+	set_capacity(block->gdp, 0);
 }
 
-int
-dasd_gendisk_init(void)
+int dasd_gendisk_init(void)
 {
 	int rc;
 
@@ -174,8 +171,7 @@ dasd_gendisk_init(void)
 	return 0;
 }
 
-void
-dasd_gendisk_exit(void)
+void dasd_gendisk_exit(void)
 {
 	unregister_blkdev(DASD_MAJOR, "dasd");
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
