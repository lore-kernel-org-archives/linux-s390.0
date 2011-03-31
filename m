From: Alexander Graf <agraf@suse.de>
Date: Thu, 31 Mar 2011 15:59:12 +0000
Subject: [PATCH] s390x: Add force flag for dasd style partition label detection
Message-Id: <1301587152-23728-1-git-send-email-agraf@suse.de>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Currently we can only use the DASD partition label on DASD disks. When running
a VM in KVM, we only have virtio disks available though. In order to still be
able to use DASD formatted disks, we need a flag that allows us to force enable
detection of the DASD partition label. This patch implements parameters to
achieve this.

For example, to activate the label code to force devices "vda" and "vdb" to be
detected as CDL style label, add "ibm.dasd_force_cdl=vda,vdb" to your kernel
command line. A respective parameter is also added for the LDL label type.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 fs/partitions/ibm.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/partitions/ibm.c b/fs/partitions/ibm.c
index d513a07..5a4b9f6 100644
--- a/fs/partitions/ibm.c
+++ b/fs/partitions/ibm.c
@@ -17,6 +17,30 @@
 #include "check.h"
 #include "ibm.h"
 
+static char *dasd_force_ldl[4];
+static char *dasd_force_cdl[4];
+
+module_param_array(dasd_force_ldl, charp, NULL, 0);
+MODULE_PARM_DESC(dasd_force_ldl, "force a block device to be detected as DASD "
+                                 "(LDL format)");
+module_param_array(dasd_force_cdl, charp, NULL, 0);
+MODULE_PARM_DESC(dasd_force_cdl, "force a block device to be detected as DASD "
+                                 "(CDL format)");
+
+static inline bool match_array(char **arr, const char *match)
+{
+	if (!arr)
+		return false;
+
+	while (*arr) {
+		if (!strcmp(*arr, match))
+			return true;
+		arr++;
+	}
+
+	return false;
+}
+
 /*
  * compute the block number from a
  * cyl-cyl-head-head structure
@@ -76,6 +100,7 @@ int ibm_partition(struct parsed_partitions *state)
 	Sector sect;
 	sector_t labelsect;
 	char tmp[64];
+	bool fake_cdl = false;
 
 	res = 0;
 	blocksize = bdev_logical_block_size(bdev);
@@ -95,10 +120,31 @@ int ibm_partition(struct parsed_partitions *state)
 	if (label == NULL)
 		goto out_nolab;
 
-	if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0 ||
-	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
+	if (match_array(dasd_force_ldl, bdev->bd_disk->disk_name)) {
+		memset(info, 0, sizeof(dasd_information2_t));
+		info->format = DASD_FORMAT_LDL;
+		info->label_block = 2;
+	} else if (match_array(dasd_force_cdl, bdev->bd_disk->disk_name)) {
+		memset(info, 0, sizeof(dasd_information2_t));
+		info->format = DASD_FORMAT_CDL;
+		info->label_block = 2;
+		fake_cdl = true;
+	} else if (ioctl_by_bdev(bdev, BIODASDINFO2, (unsigned long)info) != 0) {
+		goto out_freeall;
+	}
+
+	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
 		goto out_freeall;
 
+	if (fake_cdl) {
+		memset(geo, 0, sizeof(dasd_information2_t));
+		/* CDL disks always are on 15/12 layout, so calculate over */
+		geo->cylinders = (geo->heads * geo->sectors * geo->cylinders)
+				/ (15 * 12);
+		geo->heads = 15;
+		geo->sectors = 12;
+	}
+
 	/*
 	 * Special case for FBA disks: label sector does not depend on
 	 * blocksize.
-- 
1.7.3.4
