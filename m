Return-Path: <linux-kernel-owner+w=401wt.eu-S934715AbXJSRWb@vger.kernel.org>
Message-Id: <20071019171944.327229924@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/10] cio: Use to_channelpath() for device to channel path conversion.
Content-Disposition: inline; filename=003-cio-channelpath.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

We already have a macro for that, so let's use it consistently...

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -246,7 +246,7 @@ int chp_add_cmg_attr(struct channel_path
 static ssize_t chp_status_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct channel_path *chp = container_of(dev, struct channel_path, dev);
+	struct channel_path *chp = to_channelpath(dev);
 
 	if (!chp)
 		return 0;
@@ -258,7 +258,7 @@ static ssize_t chp_status_write(struct d
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct channel_path *cp = container_of(dev, struct channel_path, dev);
+	struct channel_path *cp = to_channelpath(dev);
 	char cmd[10];
 	int num_args;
 	int error;
@@ -286,7 +286,7 @@ static ssize_t chp_configure_show(struct
 	struct channel_path *cp;
 	int status;
 
-	cp = container_of(dev, struct channel_path, dev);
+	cp = to_channelpath(dev);
 	status = chp_info_get_status(cp->chpid);
 	if (status < 0)
 		return status;
@@ -308,7 +308,7 @@ static ssize_t chp_configure_write(struc
 		return -EINVAL;
 	if (val != 0 && val != 1)
 		return -EINVAL;
-	cp = container_of(dev, struct channel_path, dev);
+	cp = to_channelpath(dev);
 	chp_cfg_schedule(cp->chpid, val);
 	cfg_wait_idle();
 
@@ -320,7 +320,7 @@ static DEVICE_ATTR(configure, 0644, chp_
 static ssize_t chp_type_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
-	struct channel_path *chp = container_of(dev, struct channel_path, dev);
+	struct channel_path *chp = to_channelpath(dev);
 
 	if (!chp)
 		return 0;
@@ -374,7 +374,7 @@ static void chp_release(struct device *d
 {
 	struct channel_path *cp;
 
-	cp = container_of(dev, struct channel_path, dev);
+	cp = to_channelpath(dev);
 	kfree(cp);
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
