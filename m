Return-Path: <linux-kernel-owner+w=401wt.eu-S1759230AbYEOPGj@vger.kernel.org>
Message-Id: <20080515150008.852139975@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/11] dasd: Use const in busid functions.
Content-Disposition: inline; filename=006-dasd-const.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We should use 'const char *' in the busid functions since the
strings are not modified anyway.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |   10 +++++-----
 drivers/s390/block/dasd_int.h    |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_devmap.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_devmap.c
+++ quilt-2.6/drivers/s390/block/dasd_devmap.c
@@ -86,10 +86,10 @@ static DEFINE_SPINLOCK(dasd_devmap_lock)
 static struct list_head dasd_hashlists[256];
 int dasd_max_devindex;
 
-static struct dasd_devmap *dasd_add_busid(char *, int);
+static struct dasd_devmap *dasd_add_busid(const char *, int);
 
 static inline int
-dasd_hash_busid(char *bus_id)
+dasd_hash_busid(const char *bus_id)
 {
 	int hash, i;
 
@@ -394,7 +394,7 @@ dasd_parse(void)
  * devices.
  */
 static struct dasd_devmap *
-dasd_add_busid(char *bus_id, int features)
+dasd_add_busid(const char *bus_id, int features)
 {
 	struct dasd_devmap *devmap, *new, *tmp;
 	int hash;
@@ -430,7 +430,7 @@ dasd_add_busid(char *bus_id, int feature
  * Find devmap for device with given bus_id.
  */
 static struct dasd_devmap *
-dasd_find_busid(char *bus_id)
+dasd_find_busid(const char *bus_id)
 {
 	struct dasd_devmap *devmap, *tmp;
 	int hash;
@@ -452,7 +452,7 @@ dasd_find_busid(char *bus_id)
  * Check if busid has been added to the list of dasd ranges.
  */
 int
-dasd_busid_known(char *bus_id)
+dasd_busid_known(const char *bus_id)
 {
 	return IS_ERR(dasd_find_busid(bus_id)) ? -ENOENT : 0;
 }
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h
+++ quilt-2.6/drivers/s390/block/dasd_int.h
@@ -598,7 +598,7 @@ struct dasd_device *dasd_device_from_cde
 struct dasd_device *dasd_device_from_devindex(int);
 
 int dasd_parse(void);
-int dasd_busid_known(char *);
+int dasd_busid_known(const char *);
 
 /* externals in dasd_gendisk.c */
 int  dasd_gendisk_init(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
