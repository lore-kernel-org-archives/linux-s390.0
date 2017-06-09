Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/11] s390: drivers: convert to use DRIVER_ATTR_RO/WO
Date: Fri,  9 Jun 2017 11:03:13 +0200
Message-Id: <20170609090314.13991-10-gregkh@linuxfoundation.org>
In-Reply-To: <20170609090314.13991-1-gregkh@linuxfoundation.org>
References: <20170609090314.13991-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We are trying to get rid of DRIVER_ATTR(), and the s390 drivers'
attributes can be trivially changed to use DRIVER_ATTR_RO() and
DRIVER_ATTR_WO().

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: <linux-s390@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/char/sclp.c          | 12 ++++++------
 drivers/s390/char/vmlogrdr.c      |  7 ++-----
 drivers/s390/net/ctcm_main.c      |  6 +++---
 drivers/s390/net/lcs.c            |  6 +++---
 drivers/s390/net/netiucv.c        | 14 ++++++--------
 drivers/s390/net/qeth_core_main.c |  6 +++---
 6 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 9c471ea1b99c..6111c1fa2d1e 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1096,26 +1096,26 @@ static const struct dev_pm_ops sclp_pm_ops = {
 	.restore	= sclp_restore,
 };
 
-static ssize_t sclp_show_console_pages(struct device_driver *dev, char *buf)
+static ssize_t con_pages_show(struct device_driver *dev, char *buf)
 {
 	return sprintf(buf, "%i\n", sclp_console_pages);
 }
 
-static DRIVER_ATTR(con_pages, S_IRUSR, sclp_show_console_pages, NULL);
+static DRIVER_ATTR_RO(con_pages);
 
-static ssize_t sclp_show_con_drop(struct device_driver *dev, char *buf)
+static ssize_t con_drop_show(struct device_driver *dev, char *buf)
 {
 	return sprintf(buf, "%i\n", sclp_console_drop);
 }
 
-static DRIVER_ATTR(con_drop, S_IRUSR, sclp_show_con_drop, NULL);
+static DRIVER_ATTR_RO(con_drop);
 
-static ssize_t sclp_show_console_full(struct device_driver *dev, char *buf)
+static ssize_t con_full_show(struct device_driver *dev, char *buf)
 {
 	return sprintf(buf, "%lu\n", sclp_console_full);
 }
 
-static DRIVER_ATTR(con_full, S_IRUSR, sclp_show_console_full, NULL);
+static DRIVER_ATTR_RO(con_full);
 
 static struct attribute *sclp_drv_attrs[] = {
 	&driver_attr_con_pages.attr,
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index 57974a1e0e03..b19020b9efff 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -641,10 +641,8 @@ static ssize_t vmlogrdr_recording_store(struct device * dev,
 static DEVICE_ATTR(recording, 0200, NULL, vmlogrdr_recording_store);
 
 
-static ssize_t vmlogrdr_recording_status_show(struct device_driver *driver,
-					      char *buf)
+static ssize_t recording_status_show(struct device_driver *driver, char *buf)
 {
-
 	static const char cp_command[] = "QUERY RECORDING ";
 	int len;
 
@@ -652,8 +650,7 @@ static ssize_t vmlogrdr_recording_status_show(struct device_driver *driver,
 	len = strlen(buf);
 	return len;
 }
-static DRIVER_ATTR(recording_status, 0444, vmlogrdr_recording_status_show,
-		   NULL);
+static DRIVER_ATTR_RO(recording_status);
 static struct attribute *vmlogrdr_drv_attrs[] = {
 	&driver_attr_recording_status.attr,
 	NULL,
diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 198842ce6876..b1fa38a6733f 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1770,15 +1770,15 @@ static struct ccwgroup_driver ctcm_group_driver = {
 	.restore     = ctcm_pm_resume,
 };
 
-static ssize_t ctcm_driver_group_store(struct device_driver *ddrv,
-				       const char *buf,	size_t count)
+static ssize_t group_store(struct device_driver *ddrv, const char *buf,
+			   size_t count)
 {
 	int err;
 
 	err = ccwgroup_create_dev(ctcm_root_dev, &ctcm_group_driver, 2, buf);
 	return err ? err : count;
 }
-static DRIVER_ATTR(group, 0200, NULL, ctcm_driver_group_store);
+static DRIVER_ATTR_WO(group);
 
 static struct attribute *ctcm_drv_attrs[] = {
 	&driver_attr_group.attr,
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 211b31d9f157..589dba69db17 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2411,14 +2411,14 @@ static struct ccwgroup_driver lcs_group_driver = {
 	.restore     = lcs_restore,
 };
 
-static ssize_t lcs_driver_group_store(struct device_driver *ddrv,
-				      const char *buf, size_t count)
+static ssize_t group_store(struct device_driver *ddrv, const char *buf,
+			   size_t count)
 {
 	int err;
 	err = ccwgroup_create_dev(lcs_root_dev, &lcs_group_driver, 2, buf);
 	return err ? err : count;
 }
-static DRIVER_ATTR(group, 0200, NULL, lcs_driver_group_store);
+static DRIVER_ATTR_WO(group);
 
 static struct attribute *lcs_drv_attrs[] = {
 	&driver_attr_group.attr,
diff --git a/drivers/s390/net/netiucv.c b/drivers/s390/net/netiucv.c
index dba94b486f05..fed9d6b56e5b 100644
--- a/drivers/s390/net/netiucv.c
+++ b/drivers/s390/net/netiucv.c
@@ -2020,8 +2020,8 @@ static struct net_device *netiucv_init_netdevice(char *username, char *userdata)
 	return NULL;
 }
 
-static ssize_t conn_write(struct device_driver *drv,
-			  const char *buf, size_t count)
+static ssize_t connection_store(struct device_driver *drv, const char *buf,
+				size_t count)
 {
 	char username[9];
 	char userdata[17];
@@ -2082,11 +2082,10 @@ static ssize_t conn_write(struct device_driver *drv,
 	netiucv_free_netdevice(dev);
 	return rc;
 }
+static DRIVER_ATTR_WO(connection);
 
-static DRIVER_ATTR(connection, 0200, NULL, conn_write);
-
-static ssize_t remove_write (struct device_driver *drv,
-			     const char *buf, size_t count)
+static ssize_t remove_store(struct device_driver *drv, const char *buf,
+			    size_t count)
 {
 	struct iucv_connection *cp;
         struct net_device *ndev;
@@ -2132,8 +2131,7 @@ static ssize_t remove_write (struct device_driver *drv,
 	IUCV_DBF_TEXT(data, 2, "remove_write: unknown device\n");
         return -EINVAL;
 }
-
-static DRIVER_ATTR(remove, 0200, NULL, remove_write);
+static DRIVER_ATTR_WO(remove);
 
 static struct attribute * netiucv_drv_attrs[] = {
 	&driver_attr_connection.attr,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index fc6d85f2b38d..462b82eb17a9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5800,8 +5800,8 @@ static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.restore = qeth_core_restore,
 };
 
-static ssize_t qeth_core_driver_group_store(struct device_driver *ddrv,
-					    const char *buf, size_t count)
+static ssize_t group_store(struct device_driver *ddrv, const char *buf,
+			   size_t count)
 {
 	int err;
 
@@ -5810,7 +5810,7 @@ static ssize_t qeth_core_driver_group_store(struct device_driver *ddrv,
 
 	return err ? err : count;
 }
-static DRIVER_ATTR(group, 0200, NULL, qeth_core_driver_group_store);
+static DRIVER_ATTR_WO(group);
 
 static struct attribute *qeth_drv_attrs[] = {
 	&driver_attr_group.attr,
-- 
2.13.1
