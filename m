Return-Path: <linux-kernel-owner+w=401wt.eu-S1756103AbYK0Kjg@vger.kernel.org>
Message-Id: <20081127103133.084787041@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 19/60] struct device - replace bus_id with dev_name(), dev_set_name()
Content-Disposition: inline; filename=118-bus_id.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kay Sievers <kay.sievers@vrfy.org>

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   13 +++++++------
 drivers/s390/block/dcssblk.c     |    5 +++--
 drivers/s390/cio/ccwgroup.c      |    8 +++++---
 drivers/s390/cio/device.c        |    2 +-
 drivers/s390/scsi/zfcp_aux.c     |    6 ++++--
 5 files changed, 20 insertions(+), 14 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c
@@ -23,6 +23,7 @@
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_devmap:"
+#define DASD_BUS_ID_SIZE 20
 
 #include "dasd_int.h"
 
@@ -41,7 +42,7 @@ EXPORT_SYMBOL_GPL(dasd_page_cache);
  */
 struct dasd_devmap {
 	struct list_head list;
-	char bus_id[BUS_ID_SIZE];
+	char bus_id[DASD_BUS_ID_SIZE];
         unsigned int devindex;
         unsigned short features;
 	struct dasd_device *device;
@@ -94,7 +95,7 @@ dasd_hash_busid(const char *bus_id)
 	int hash, i;
 
 	hash = 0;
-	for (i = 0; (i < BUS_ID_SIZE) && *bus_id; i++, bus_id++)
+	for (i = 0; (i < DASD_BUS_ID_SIZE) && *bus_id; i++, bus_id++)
 		hash += *bus_id;
 	return hash & 0xff;
 }
@@ -301,7 +302,7 @@ dasd_parse_range( char *parsestring ) {
 	int from, from_id0, from_id1;
 	int to, to_id0, to_id1;
 	int features, rc;
-	char bus_id[BUS_ID_SIZE+1], *str;
+	char bus_id[DASD_BUS_ID_SIZE+1], *str;
 
 	str = parsestring;
 	rc = dasd_busid(&str, &from_id0, &from_id1, &from);
@@ -407,14 +408,14 @@ dasd_add_busid(const char *bus_id, int f
 	devmap = NULL;
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list)
-		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
+		if (strncmp(tmp->bus_id, bus_id, DASD_BUS_ID_SIZE) == 0) {
 			devmap = tmp;
 			break;
 		}
 	if (!devmap) {
 		/* This bus_id is new. */
 		new->devindex = dasd_max_devindex++;
-		strncpy(new->bus_id, bus_id, BUS_ID_SIZE);
+		strncpy(new->bus_id, bus_id, DASD_BUS_ID_SIZE);
 		new->features = features;
 		new->device = NULL;
 		list_add(&new->list, &dasd_hashlists[hash]);
@@ -439,7 +440,7 @@ dasd_find_busid(const char *bus_id)
 	devmap = ERR_PTR(-ENODEV);
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list) {
-		if (strncmp(tmp->bus_id, bus_id, BUS_ID_SIZE) == 0) {
+		if (strncmp(tmp->bus_id, bus_id, DASD_BUS_ID_SIZE) == 0) {
 			devmap = tmp;
 			break;
 		}
Index: quilt-2.6/drivers/s390/block/dcssblk.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dcssblk.c
+++ quilt-2.6/drivers/s390/block/dcssblk.c
@@ -21,6 +21,7 @@
 #define DCSSBLK_NAME "dcssblk"
 #define DCSSBLK_MINORS_PER_DISK 1
 #define DCSSBLK_PARM_LEN 400
+#define DCSS_BUS_ID_SIZE 20
 
 #ifdef DCSSBLK_DEBUG
 #define PRINT_DEBUG(x...) printk(KERN_DEBUG DCSSBLK_NAME " debug: " x)
@@ -50,7 +51,7 @@ static struct block_device_operations dc
 struct dcssblk_dev_info {
 	struct list_head lh;
 	struct device dev;
-	char segment_name[BUS_ID_SIZE];
+	char segment_name[DCSS_BUS_ID_SIZE];
 	atomic_t use_count;
 	struct gendisk *gd;
 	unsigned long start;
@@ -65,7 +66,7 @@ struct dcssblk_dev_info {
 
 struct segment_info {
 	struct list_head lh;
-	char segment_name[BUS_ID_SIZE];
+	char segment_name[DCSS_BUS_ID_SIZE];
 	unsigned long start;
 	unsigned long end;
 	int segment_type;
Index: quilt-2.6/drivers/s390/cio/ccwgroup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwgroup.c
+++ quilt-2.6/drivers/s390/cio/ccwgroup.c
@@ -19,6 +19,8 @@
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
 
+#define CCW_BUS_ID_SIZE		20
+
 /* In Linux 2.4, we had a channel device layer called "chandev"
  * that did all sorts of obscure stuff for networking devices.
  * This is another driver that serves as a replacement for just
@@ -172,7 +174,7 @@ static int __get_next_bus_id(const char 
 		len = end - start + 1;
 		end++;
 	}
-	if (len < BUS_ID_SIZE) {
+	if (len < CCW_BUS_ID_SIZE) {
 		strlcpy(bus_id, start, len);
 		rc = 0;
 	} else
@@ -181,7 +183,7 @@ static int __get_next_bus_id(const char 
 	return rc;
 }
 
-static int __is_valid_bus_id(char bus_id[BUS_ID_SIZE])
+static int __is_valid_bus_id(char bus_id[CCW_BUS_ID_SIZE])
 {
 	int cssid, ssid, devno;
 
@@ -213,7 +215,7 @@ int ccwgroup_create_from_string(struct d
 {
 	struct ccwgroup_device *gdev;
 	int rc, i;
-	char tmp_bus_id[BUS_ID_SIZE];
+	char tmp_bus_id[CCW_BUS_ID_SIZE];
 	const char *curr_buf;
 
 	gdev = kzalloc(sizeof(*gdev) + num_devices * sizeof(gdev->cdev[0]),
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1723,7 +1723,7 @@ __ccwdev_check_busid(struct device *dev,
 
 	bus_id = id;
 
-	return (strncmp(bus_id, dev_name(dev), BUS_ID_SIZE) == 0);
+	return (strcmp(bus_id, dev_name(dev)) == 0);
 }
 
 
Index: quilt-2.6/drivers/s390/scsi/zfcp_aux.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_aux.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_aux.c
@@ -29,6 +29,8 @@
 #include <linux/seq_file.h>
 #include "zfcp_ext.h"
 
+#define ZFCP_BUS_ID_SIZE	20
+
 static char *device;
 
 MODULE_AUTHOR("IBM Deutschland Entwicklung GmbH - linux390@de.ibm.com");
@@ -84,9 +86,9 @@ static int __init zfcp_device_setup(char
 	strcpy(str, devstr);
 
 	token = strsep(&str, ",");
-	if (!token || strlen(token) >= BUS_ID_SIZE)
+	if (!token || strlen(token) >= ZFCP_BUS_ID_SIZE)
 		goto err_out;
-	strncpy(zfcp_data.init_busid, token, BUS_ID_SIZE);
+	strncpy(zfcp_data.init_busid, token, ZFCP_BUS_ID_SIZE);
 
 	token = strsep(&str, ",");
 	if (!token || strict_strtoull(token, 0,

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
