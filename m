Return-Path: <linux-kernel-owner+w=401wt.eu-S1757249AbYK0Kra@vger.kernel.org>
Message-Id: <20081127103141.521288802@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 49/60] convert dcssblk and extmem printks messages to pr_xxx macros.
Content-Disposition: inline; filename=164-kmsg-dcss.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hongjie Yang <hongjie@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hongjie Yang <hongjie@us.ibm.com>

Signed-off-by: Hongjie Yang <hongjie@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/extmem.c        |  106 +++++++++++++++++--------------------------
 drivers/s390/block/dcssblk.c |   72 +++++++++++++----------------
 2 files changed, 76 insertions(+), 102 deletions(-)

Index: quilt-2.6/arch/s390/mm/extmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/extmem.c
+++ quilt-2.6/arch/s390/mm/extmem.c
@@ -7,6 +7,9 @@
  * (C) IBM Corporation 2002-2004
  */
 
+#define KMSG_COMPONENT "extmem"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
@@ -24,19 +27,6 @@
 #include <asm/cpcmd.h>
 #include <asm/setup.h>
 
-#define DCSS_DEBUG	/* Debug messages on/off */
-
-#define DCSS_NAME "extmem"
-#ifdef DCSS_DEBUG
-#define PRINT_DEBUG(x...)	printk(KERN_DEBUG DCSS_NAME " debug:" x)
-#else
-#define PRINT_DEBUG(x...)   do {} while (0)
-#endif
-#define PRINT_INFO(x...)	printk(KERN_INFO DCSS_NAME " info:" x)
-#define PRINT_WARN(x...)	printk(KERN_WARNING DCSS_NAME " warning:" x)
-#define PRINT_ERR(x...)		printk(KERN_ERR DCSS_NAME " error:" x)
-
-
 #define DCSS_LOADSHR    0x00
 #define DCSS_LOADNSR    0x04
 #define DCSS_PURGESEG   0x08
@@ -286,7 +276,7 @@ query_segment_type (struct dcss_segment 
 		goto out_free;
 	}
 	if (diag_cc > 1) {
-		PRINT_WARN ("segment_type: diag returned error %ld\n", vmrc);
+		pr_warning("Querying a DCSS type failed with rc=%ld\n", vmrc);
 		rc = dcss_diag_translate_rc (vmrc);
 		goto out_free;
 	}
@@ -368,7 +358,6 @@ query_segment_type (struct dcss_segment 
  * -EIO     : could not perform query diagnose
  * -ENOENT  : no such segment
  * -ENOTSUPP: multi-part segment cannot be used with linux
- * -ENOSPC  : segment cannot be used (overlaps with storage)
  * -ENOMEM  : out of memory
  * 0 .. 6   : type of segment as defined in include/asm-s390/extmem.h
  */
@@ -480,9 +469,8 @@ __segment_load (char *name, int do_nonsh
 		goto out_resource;
 	}
 	if (diag_cc > 1) {
-		PRINT_WARN ("segment_load: could not load segment %s - "
-				"diag returned error (%ld)\n",
-				name, end_addr);
+		pr_warning("Loading DCSS %s failed with rc=%ld\n", name,
+			   end_addr);
 		rc = dcss_diag_translate_rc(end_addr);
 		dcss_diag(&purgeseg_scode, seg->dcss_name,
 				&dummy, &dummy);
@@ -496,15 +484,13 @@ __segment_load (char *name, int do_nonsh
 	*addr = seg->start_addr;
 	*end  = seg->end;
 	if (do_nonshared)
-		PRINT_INFO ("segment_load: loaded segment %s range %p .. %p "
-				"type %s in non-shared mode\n", name,
-				(void*)seg->start_addr, (void*)seg->end,
-				segtype_string[seg->vm_segtype]);
+		pr_info("DCSS %s of range %p to %p and type %s loaded as "
+			"exclusive-writable\n", name, (void*) seg->start_addr,
+			(void*) seg->end, segtype_string[seg->vm_segtype]);
 	else {
-		PRINT_INFO ("segment_load: loaded segment %s range %p .. %p "
-				"type %s in shared mode\n", name,
-				(void*)seg->start_addr, (void*)seg->end,
-				segtype_string[seg->vm_segtype]);
+		pr_info("DCSS %s of range %p to %p and type %s loaded in "
+			"shared access mode\n", name, (void*) seg->start_addr,
+			(void*) seg->end, segtype_string[seg->vm_segtype]);
 	}
 	goto out;
  out_resource:
@@ -593,14 +579,14 @@ segment_modify_shared (char *name, int d
 		goto out_unlock;
 	}
 	if (do_nonshared == seg->do_nonshared) {
-		PRINT_INFO ("segment_modify_shared: not reloading segment %s"
-				" - already in requested mode\n",name);
+		pr_info("DCSS %s is already in the requested access "
+			"mode\n", name);
 		rc = 0;
 		goto out_unlock;
 	}
 	if (atomic_read (&seg->ref_count) != 1) {
-		PRINT_WARN ("segment_modify_shared: not reloading segment %s - "
-				"segment is in use by other driver(s)\n",name);
+		pr_warning("DCSS %s is in use and cannot be reloaded\n",
+			   name);
 		rc = -EAGAIN;
 		goto out_unlock;
 	}
@@ -613,8 +599,8 @@ segment_modify_shared (char *name, int d
 			seg->res->flags |= IORESOURCE_READONLY;
 
 	if (request_resource(&iomem_resource, seg->res)) {
-		PRINT_WARN("segment_modify_shared: could not reload segment %s"
-			   " - overlapping resources\n", name);
+		pr_warning("DCSS %s overlaps with used memory resources "
+			   "and cannot be reloaded\n", name);
 		rc = -EBUSY;
 		kfree(seg->res);
 		goto out_del_mem;
@@ -632,9 +618,8 @@ segment_modify_shared (char *name, int d
 		goto out_del_res;
 	}
 	if (diag_cc > 1) {
-		PRINT_WARN ("segment_modify_shared: could not reload segment %s"
-				" - diag returned error (%ld)\n",
-				name, end_addr);
+		pr_warning("Reloading DCSS %s failed with rc=%ld\n", name,
+			   end_addr);
 		rc = dcss_diag_translate_rc(end_addr);
 		goto out_del_res;
 	}
@@ -673,8 +658,7 @@ segment_unload(char *name)
 	mutex_lock(&dcss_lock);
 	seg = segment_by_name (name);
 	if (seg == NULL) {
-		PRINT_ERR ("could not find segment %s in segment_unload, "
-				"please report to linux390@de.ibm.com\n",name);
+		pr_err("Unloading unknown DCSS %s failed\n", name);
 		goto out_unlock;
 	}
 	if (atomic_dec_return(&seg->ref_count) != 0)
@@ -709,8 +693,7 @@ segment_save(char *name)
 	seg = segment_by_name (name);
 
 	if (seg == NULL) {
-		PRINT_ERR("could not find segment %s in segment_save, please "
-			  "report to linux390@de.ibm.com\n", name);
+		pr_err("Saving unknown DCSS %s failed\n", name);
 		goto out;
 	}
 
@@ -727,14 +710,14 @@ segment_save(char *name)
 	response = 0;
 	cpcmd(cmd1, NULL, 0, &response);
 	if (response) {
-		PRINT_ERR("segment_save: DEFSEG failed with response code %i\n",
-			  response);
+		pr_err("Saving a DCSS failed with DEFSEG response code "
+		       "%i\n", response);
 		goto out;
 	}
 	cpcmd(cmd2, NULL, 0, &response);
 	if (response) {
-		PRINT_ERR("segment_save: SAVESEG failed with response code %i\n",
-			  response);
+		pr_err("Saving a DCSS failed with SAVESEG response code "
+		       "%i\n", response);
 		goto out;
 	}
 out:
@@ -749,44 +732,41 @@ void segment_warning(int rc, char *seg_n
 {
 	switch (rc) {
 	case -ENOENT:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "does not exist\n", seg_name);
+		pr_err("DCSS %s cannot be loaded or queried\n", seg_name);
 		break;
 	case -ENOSYS:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "not running on VM\n", seg_name);
+		pr_err("DCSS %s cannot be loaded or queried without "
+		       "z/VM\n", seg_name);
 		break;
 	case -EIO:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "hardware error\n", seg_name);
+		pr_err("Loading or querying DCSS %s resulted in a "
+		       "hardware error\n", seg_name);
 		break;
 	case -ENOTSUPP:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "is a multi-part segment\n", seg_name);
+		pr_err("DCSS %s has multiple page ranges and cannot be "
+		       "loaded or queried\n", seg_name);
 		break;
 	case -ENOSPC:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "overlaps with storage\n", seg_name);
+		pr_err("DCSS %s overlaps with used storage and cannot "
+		       "be loaded\n", seg_name);
 		break;
 	case -EBUSY:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "overlaps with already loaded dcss\n", seg_name);
+		pr_err("%s needs used memory resources and cannot be "
+		       "loaded or queried\n", seg_name);
 		break;
 	case -EPERM:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "already loaded in incompatible mode\n", seg_name);
+		pr_err("DCSS %s is already loaded in a different access "
+		       "mode\n", seg_name);
 		break;
 	case -ENOMEM:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "out of memory\n", seg_name);
+		pr_err("There is not enough memory to load or query "
+		       "DCSS %s\n", seg_name);
 		break;
 	case -ERANGE:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "exceeds kernel mapping range\n", seg_name);
+		pr_err("DCSS %s exceeds the kernel mapping range (%lu) "
+		       "and cannot be loaded\n", seg_name, VMEM_MAX_PHYS);
 		break;
 	default:
-		PRINT_WARN("cannot load/query segment %s, "
-			   "return value %i\n", seg_name, rc);
 		break;
 	}
 }
Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -4,6 +4,9 @@
  * Authors: Carsten Otte, Stefan Weinhuber, Gerald Schaefer
  */
 
+#define KMSG_COMPONENT "dcssblk"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ctype.h>
@@ -17,21 +20,11 @@
 #include <linux/interrupt.h>
 #include <asm/s390_rdev.h>
 
-//#define DCSSBLK_DEBUG		/* Debug messages on/off */
 #define DCSSBLK_NAME "dcssblk"
 #define DCSSBLK_MINORS_PER_DISK 1
 #define DCSSBLK_PARM_LEN 400
 #define DCSS_BUS_ID_SIZE 20
 
-#ifdef DCSSBLK_DEBUG
-#define PRINT_DEBUG(x...) printk(KERN_DEBUG DCSSBLK_NAME " debug: " x)
-#else
-#define PRINT_DEBUG(x...) do {} while (0)
-#endif
-#define PRINT_INFO(x...)  printk(KERN_INFO DCSSBLK_NAME " info: " x)
-#define PRINT_WARN(x...)  printk(KERN_WARNING DCSSBLK_NAME " warning: " x)
-#define PRINT_ERR(x...)	  printk(KERN_ERR DCSSBLK_NAME " error: " x)
-
 static int dcssblk_open(struct block_device *bdev, fmode_t mode);
 static int dcssblk_release(struct gendisk *disk, fmode_t mode);
 static int dcssblk_make_request(struct request_queue *q, struct bio *bio);
@@ -262,10 +255,9 @@ dcssblk_is_continuous(struct dcssblk_dev
 	/* check continuity */
 	for (i = 0; i < dev_info->num_of_segments - 1; i++) {
 		if ((sort_list[i].end + 1) != sort_list[i+1].start) {
-			PRINT_ERR("Segment %s is not contiguous with "
-				"segment %s\n",
-				sort_list[i].segment_name,
-				sort_list[i+1].segment_name);
+			pr_err("Adjacent DCSSs %s and %s are not "
+			       "contiguous\n", sort_list[i].segment_name,
+			       sort_list[i+1].segment_name);
 			rc = -EINVAL;
 			goto out;
 		}
@@ -276,10 +268,10 @@ dcssblk_is_continuous(struct dcssblk_dev
 				!(sort_list[i+1].segment_type &
 				SEGMENT_EXCLUSIVE) ||
 				(sort_list[i+1].segment_type == SEG_TYPE_ER)) {
-				PRINT_ERR("Segment %s has different type from "
-					"segment %s\n",
-					sort_list[i].segment_name,
-					sort_list[i+1].segment_name);
+				pr_err("DCSS %s and DCSS %s have "
+				       "incompatible types\n",
+				       sort_list[i].segment_name,
+				       sort_list[i+1].segment_name);
 				rc = -EINVAL;
 				goto out;
 			}
@@ -381,8 +373,9 @@ dcssblk_shared_store(struct device *dev,
 	} else if (inbuf[0] == '0') {
 		/* reload segments in exclusive mode */
 		if (dev_info->segment_type == SEG_TYPE_SC) {
-			PRINT_ERR("Segment type SC (%s) cannot be loaded in "
-				"non-shared mode\n", dev_info->segment_name);
+			pr_err("DCSS %s is of type SC and cannot be "
+			       "loaded as exclusive-writable\n",
+			       dev_info->segment_name);
 			rc = -EINVAL;
 			goto out;
 		}
@@ -405,9 +398,8 @@ dcssblk_shared_store(struct device *dev,
 	goto out;
 
 removeseg:
-	PRINT_ERR("Could not reload segment(s) of the device %s, removing "
-		"segment(s) now!\n",
-		dev_info->segment_name);
+	pr_err("DCSS device %s is removed after a failed access mode "
+	       "change\n", dev_info->segment_name);
 	temp = entry;
 	list_for_each_entry(entry, &dev_info->seg_list, lh) {
 		if (entry != temp)
@@ -455,17 +447,17 @@ dcssblk_save_store(struct device *dev, s
 	if (inbuf[0] == '1') {
 		if (atomic_read(&dev_info->use_count) == 0) {
 			// device is idle => we save immediately
-			PRINT_INFO("Saving segment(s) of the device %s\n",
-				   dev_info->segment_name);
+			pr_info("All DCSSs that map to device %s are "
+				"saved\n", dev_info->segment_name);
 			list_for_each_entry(entry, &dev_info->seg_list, lh) {
 				segment_save(entry->segment_name);
 			}
 		}  else {
 			// device is busy => we save it when it becomes
 			// idle in dcssblk_release
-			PRINT_INFO("Device %s is currently busy, segment(s) "
-				   "will be saved when it becomes idle...\n",
-				   dev_info->segment_name);
+			pr_info("Device %s is in use, its DCSSs will be "
+				"saved when it becomes idle\n",
+				dev_info->segment_name);
 			dev_info->save_pending = 1;
 		}
 	} else if (inbuf[0] == '0') {
@@ -473,9 +465,9 @@ dcssblk_save_store(struct device *dev, s
 			// device is busy & the user wants to undo his save
 			// request
 			dev_info->save_pending = 0;
-			PRINT_INFO("Pending save for segment(s) of the device "
-					"%s deactivated\n",
-					dev_info->segment_name);
+			pr_info("A pending save request for device %s "
+				"has been canceled\n",
+				dev_info->segment_name);
 		}
 	} else {
 		up_write(&dcssblk_devices_sem);
@@ -615,9 +607,8 @@ dcssblk_add_store(struct device *dev, st
 
 	seg_byte_size = (dev_info->end - dev_info->start + 1);
 	set_capacity(dev_info->gd, seg_byte_size >> 9); // size in sectors
-	PRINT_INFO("Loaded segment(s) %s, size = %lu Byte, "
-		   "capacity = %lu (512 Byte) sectors\n", local_buf,
-		   seg_byte_size, seg_byte_size >> 9);
+	pr_info("Loaded %s with total size %lu bytes and capacity %lu "
+		"sectors\n", local_buf, seg_byte_size, seg_byte_size >> 9);
 
 	dev_info->save_pending = 0;
 	dev_info->is_shared = 1;
@@ -745,13 +736,15 @@ dcssblk_remove_store(struct device *dev,
 	dev_info = dcssblk_get_device_by_name(local_buf);
 	if (dev_info == NULL) {
 		up_write(&dcssblk_devices_sem);
-		PRINT_WARN("Device %s is not loaded!\n", local_buf);
+		pr_warning("Device %s cannot be removed because it is not a "
+			   "known device\n", local_buf);
 		rc = -ENODEV;
 		goto out_buf;
 	}
 	if (atomic_read(&dev_info->use_count) != 0) {
 		up_write(&dcssblk_devices_sem);
-		PRINT_WARN("Device %s is in use!\n", local_buf);
+		pr_warning("Device %s cannot be removed while it is in "
+			   "use\n", local_buf);
 		rc = -EBUSY;
 		goto out_buf;
 	}
@@ -808,8 +801,8 @@ dcssblk_release(struct gendisk *disk, fm
 	down_write(&dcssblk_devices_sem);
 	if (atomic_dec_and_test(&dev_info->use_count)
 	    && (dev_info->save_pending)) {
-		PRINT_INFO("Device %s became idle and is being saved now\n",
-			    dev_info->segment_name);
+		pr_info("Device %s has become idle and is being saved "
+			"now\n", dev_info->segment_name);
 		list_for_each_entry(entry, &dev_info->seg_list, lh) {
 			segment_save(entry->segment_name);
 		}
@@ -852,7 +845,8 @@ dcssblk_make_request(struct request_queu
 		case SEG_TYPE_SC:
 			/* cannot write to these segments */
 			if (bio_data_dir(bio) == WRITE) {
-				PRINT_WARN("rejecting write to ro device %s\n",
+				pr_warning("Writing to %s failed because it "
+					   "is a read-only device\n",
 					   dev_name(&dev_info->dev));
 				goto fail;
 			}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
