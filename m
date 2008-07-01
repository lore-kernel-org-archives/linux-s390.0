Return-Path: <linux-kernel-owner+w=401wt.eu-S1757961AbYGAMxT@vger.kernel.org>
Message-Id: <20080701124957.450356184@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/14] cio: Get rid of css_characteristics_avail.
Content-Disposition: inline; filename=120-cio-css-validity.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Checking for the validity of the css_*_characteristics is
superfluous since they stay 0 for non-successful scsc.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c  |    3 +--
 drivers/s390/cio/chsc.h |    1 -
 drivers/s390/cio/cmf.c  |    3 +--
 drivers/s390/cio/css.c  |   12 +++---------
 drivers/s390/cio/qdio.c |    3 ---
 5 files changed, 5 insertions(+), 17 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -415,8 +415,7 @@ int chp_new(struct chp_id chpid)
 		goto out_free;
 	}
 	/* Get channel-measurement characteristics. */
-	if (css_characteristics_avail && css_chsc_characteristics.scmc
-	    && css_chsc_characteristics.secm) {
+	if (css_chsc_characteristics.scmc && css_chsc_characteristics.secm) {
 		ret = chsc_get_channel_measurement_chars(chp);
 		if (ret)
 			goto out_free;
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h
+++ quilt-2.6/drivers/s390/cio/chsc.h
@@ -78,7 +78,6 @@ struct chsc_ssd_info {
 extern int chsc_get_ssd_info(struct subchannel_id schid,
 			     struct chsc_ssd_info *ssd);
 extern int chsc_determine_css_characteristics(void);
-extern int css_characteristics_avail;
 extern int chsc_alloc_sei_area(void);
 extern void chsc_free_sei_area(void);
 
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -1344,8 +1344,7 @@ static int __init init_cmf(void)
 	 * to basic mode.
 	 */
 	if (format == CMF_AUTODETECT) {
-		if (!css_characteristics_avail ||
-		    !css_general_characteristics.ext_mb) {
+		if (!css_general_characteristics.ext_mb) {
 			format = CMF_BASIC;
 		} else {
 			format = CMF_EXTENDED;
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -30,8 +30,6 @@ static int max_ssid = 0;
 
 struct channel_subsystem *channel_subsystems[__MAX_CSSID + 1];
 
-int css_characteristics_avail = 0;
-
 int
 for_each_subchannel(int(*fn)(struct subchannel_id, void *), void *data)
 {
@@ -611,7 +609,7 @@ __init_channel_subsystem(struct subchann
 static void __init
 css_generate_pgid(struct channel_subsystem *css, u32 tod_high)
 {
-	if (css_characteristics_avail && css_general_characteristics.mcss) {
+	if (css_general_characteristics.mcss) {
 		css->global_pgid.pgid_high.ext_cssid.version = 0x80;
 		css->global_pgid.pgid_high.ext_cssid.cssid = css->cssid;
 	} else {
@@ -748,8 +746,6 @@ init_channel_subsystem (void)
 	ret = chsc_determine_css_characteristics();
 	if (ret == -ENOMEM)
 		goto out; /* No need to continue. */
-	if (ret == 0)
-		css_characteristics_avail = 1;
 
 	ret = chsc_alloc_sei_area();
 	if (ret)
@@ -793,8 +789,7 @@ init_channel_subsystem (void)
 		ret = device_register(&css->device);
 		if (ret)
 			goto out_free_all;
-		if (css_characteristics_avail &&
-		    css_chsc_characteristics.secm) {
+		if (css_chsc_characteristics.secm) {
 			ret = device_create_file(&css->device,
 						 &dev_attr_cm_enable);
 			if (ret)
@@ -832,7 +827,7 @@ out_unregister:
 		i--;
 		css = channel_subsystems[i];
 		device_unregister(&css->pseudo_subchannel->dev);
-		if (css_characteristics_avail && css_chsc_characteristics.secm)
+		if (css_chsc_characteristics.secm)
 			device_remove_file(&css->device,
 					   &dev_attr_cm_enable);
 		device_unregister(&css->device);
@@ -956,4 +951,3 @@ subsys_initcall(init_channel_subsystem);
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(css_bus_type);
-EXPORT_SYMBOL_GPL(css_characteristics_avail);
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -2354,9 +2354,6 @@ tiqdio_check_chsc_availability(void)
 {
 	char dbf_text[15];
 
-	if (!css_characteristics_avail)
-		return -EIO;
-
 	/* Check for bit 41. */
 	if (!css_general_characteristics.aif) {
 		QDIO_PRINT_WARN("Adapter interruption facility not " \

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
