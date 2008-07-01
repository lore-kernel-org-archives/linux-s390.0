Return-Path: <linux-kernel-owner+w=401wt.eu-S1757116AbYGAMun@vger.kernel.org>
Message-Id: <20080701124958.879664180@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/14] cio: Repair chpid event handling.
Content-Disposition: inline; filename=125-cio-chpid-event.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Passing the affected chpid in chp_event() worked only by
chance since chpid is the first element in res_acc_data.
Make it work properly by generalizing res_acc_data as
chp_link and always passing around a properly filled out
chp_link structure in chp_event().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chp.c    |    6 ++---
 drivers/s390/cio/chp.h    |    4 +--
 drivers/s390/cio/chsc.c   |   55 +++++++++++++++++++++++++---------------------
 drivers/s390/cio/css.h    |    3 +-
 drivers/s390/cio/device.c |   11 ++++-----
 5 files changed, 43 insertions(+), 36 deletions(-)

Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -525,7 +525,7 @@ static void chp_process_crw(struct crw *
 	}
 }
 
-int chp_ssd_get_mask(struct chsc_ssd_info *ssd, struct res_acc_data *data)
+int chp_ssd_get_mask(struct chsc_ssd_info *ssd, struct chp_link *link)
 {
 	int i;
 	int mask;
@@ -534,10 +534,10 @@ int chp_ssd_get_mask(struct chsc_ssd_inf
 		mask = 0x80 >> i;
 		if (!(ssd->path_mask & mask))
 			continue;
-		if (!chp_id_is_equal(&ssd->chpid[i], &data->chpid))
+		if (!chp_id_is_equal(&ssd->chpid[i], &link->chpid))
 			continue;
 		if ((ssd->fla_valid_mask & mask) &&
-		    ((ssd->fla[i] & data->fla_mask) != data->fla))
+		    ((ssd->fla[i] & link->fla_mask) != link->fla))
 			continue;
 		return mask;
 	}
Index: quilt-2.6/drivers/s390/cio/chp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.h
+++ quilt-2.6/drivers/s390/cio/chp.h
@@ -24,7 +24,7 @@
 #define CHP_VARY_ON 2
 #define CHP_VARY_OFF 3
 
-struct res_acc_data {
+struct chp_link {
 	struct chp_id chpid;
 	u32 fla_mask;
 	u16 fla;
@@ -60,5 +60,5 @@ int chp_new(struct chp_id chpid);
 void chp_cfg_schedule(struct chp_id chpid, int configure);
 void chp_cfg_cancel_deconfigure(struct chp_id chpid);
 int chp_info_get_status(struct chp_id chpid);
-int chp_ssd_get_mask(struct chsc_ssd_info *, struct res_acc_data *);
+int chp_ssd_get_mask(struct chsc_ssd_info *, struct chp_link *);
 #endif /* S390_CHP_H */
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -146,15 +146,18 @@ out_unreg:
 void chsc_chp_offline(struct chp_id chpid)
 {
 	char dbf_txt[15];
+	struct chp_link link;
 
 	sprintf(dbf_txt, "chpr%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (chp_get_status(chpid) <= 0)
 		return;
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
 	/* Wait until previous actions have settled. */
 	css_wait_for_slow_path();
-	for_each_subchannel_staged(s390_subchannel_remove_chpid, NULL, &chpid);
+	for_each_subchannel_staged(s390_subchannel_remove_chpid, NULL, &link);
 }
 
 static int s390_process_res_acc_new_sch(struct subchannel_id schid, void *data)
@@ -187,15 +190,15 @@ static int __s390_process_res_acc(struct
 	return 0;
 }
 
-static void s390_process_res_acc (struct res_acc_data *res_data)
+static void s390_process_res_acc(struct chp_link *link)
 {
 	char dbf_txt[15];
 
-	sprintf(dbf_txt, "accpr%x.%02x", res_data->chpid.cssid,
-		res_data->chpid.id);
+	sprintf(dbf_txt, "accpr%x.%02x", link->chpid.cssid,
+		link->chpid.id);
 	CIO_TRACE_EVENT( 2, dbf_txt);
-	if (res_data->fla != 0) {
-		sprintf(dbf_txt, "fla%x", res_data->fla);
+	if (link->fla != 0) {
+		sprintf(dbf_txt, "fla%x", link->fla);
 		CIO_TRACE_EVENT( 2, dbf_txt);
 	}
 	/* Wait until previous actions have settled. */
@@ -208,7 +211,7 @@ static void s390_process_res_acc (struct
 	 * will we have to do.
 	 */
 	for_each_subchannel_staged(__s390_process_res_acc,
-				   s390_process_res_acc_new_sch, res_data);
+				   s390_process_res_acc_new_sch, link);
 }
 
 static int
@@ -281,7 +284,7 @@ static void chsc_process_sei_link_incide
 
 static void chsc_process_sei_res_acc(struct chsc_sei_area *sei_area)
 {
-	struct res_acc_data res_data;
+	struct chp_link link;
 	struct chp_id chpid;
 	int status;
 
@@ -297,18 +300,18 @@ static void chsc_process_sei_res_acc(str
 		chp_new(chpid);
 	else if (!status)
 		return;
-	memset(&res_data, 0, sizeof(struct res_acc_data));
-	res_data.chpid = chpid;
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
 	if ((sei_area->vf & 0xc0) != 0) {
-		res_data.fla = sei_area->fla;
+		link.fla = sei_area->fla;
 		if ((sei_area->vf & 0xc0) == 0xc0)
 			/* full link address */
-			res_data.fla_mask = 0xffff;
+			link.fla_mask = 0xffff;
 		else
 			/* link address */
-			res_data.fla_mask = 0xff00;
+			link.fla_mask = 0xff00;
 	}
-	s390_process_res_acc(&res_data);
+	s390_process_res_acc(&link);
 }
 
 struct chp_config_data {
@@ -413,18 +416,18 @@ static void chsc_process_crw(struct crw 
 void chsc_chp_online(struct chp_id chpid)
 {
 	char dbf_txt[15];
-	struct res_acc_data res_data;
+	struct chp_link link;
 
 	sprintf(dbf_txt, "cadd%x.%02x", chpid.cssid, chpid.id);
 	CIO_TRACE_EVENT(2, dbf_txt);
 
 	if (chp_get_status(chpid) != 0) {
-		memset(&res_data, 0, sizeof(struct res_acc_data));
-		res_data.chpid = chpid;
+		memset(&link, 0, sizeof(struct chp_link));
+		link.chpid = chpid;
 		/* Wait until previous actions have settled. */
 		css_wait_for_slow_path();
 		for_each_subchannel_staged(__s390_process_res_acc, NULL,
-					   &res_data);
+					   &link);
 	}
 }
 
@@ -432,13 +435,13 @@ static void __s390_subchannel_vary_chpid
 					 struct chp_id chpid, int on)
 {
 	unsigned long flags;
-	struct res_acc_data res_data;
+	struct chp_link link;
 
-	memset(&res_data, 0, sizeof(struct res_acc_data));
-	res_data.chpid = chpid;
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
 	spin_lock_irqsave(sch->lock, flags);
 	if (sch->driver && sch->driver->chp_event)
-		sch->driver->chp_event(sch, &res_data,
+		sch->driver->chp_event(sch, &link,
 				       on ? CHP_VARY_ON : CHP_VARY_OFF);
 	spin_unlock_irqrestore(sch->lock, flags);
 }
@@ -479,6 +482,10 @@ __s390_vary_chpid_on(struct subchannel_i
  */
 int chsc_chp_vary(struct chp_id chpid, int on)
 {
+	struct chp_link link;
+
+	memset(&link, 0, sizeof(struct chp_link));
+	link.chpid = chpid;
 	/* Wait until previous actions have settled. */
 	css_wait_for_slow_path();
 	/*
@@ -487,10 +494,10 @@ int chsc_chp_vary(struct chp_id chpid, i
 
 	if (on)
 		for_each_subchannel_staged(s390_subchannel_vary_chpid_on,
-					   __s390_vary_chpid_on, &chpid);
+					   __s390_vary_chpid_on, &link);
 	else
 		for_each_subchannel_staged(s390_subchannel_vary_chpid_off,
-					   NULL, &chpid);
+					   NULL, &link);
 
 	return 0;
 }
Index: quilt-2.6/drivers/s390/cio/css.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.h
+++ quilt-2.6/drivers/s390/cio/css.h
@@ -59,6 +59,7 @@ struct pgid {
 } __attribute__ ((packed));
 
 struct subchannel;
+struct chp_link;
 /**
  * struct css_driver - device driver for subchannels
  * @owner: owning module
@@ -77,7 +78,7 @@ struct css_driver {
 	unsigned int subchannel_type;
 	struct device_driver drv;
 	void (*irq)(struct subchannel *);
-	int (*chp_event)(struct subchannel *, void *, int);
+	int (*chp_event)(struct subchannel *, struct chp_link *, int);
 	int (*sch_event)(struct subchannel *, int);
 	int (*probe)(struct subchannel *);
 	int (*remove)(struct subchannel *);
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -128,7 +128,8 @@ static int io_subchannel_probe(struct su
 static int io_subchannel_remove(struct subchannel *);
 static void io_subchannel_shutdown(struct subchannel *);
 static int io_subchannel_sch_event(struct subchannel *, int);
-static int io_subchannel_chp_event(struct subchannel *, void *, int);
+static int io_subchannel_chp_event(struct subchannel *, struct chp_link *,
+				   int);
 
 static struct css_driver io_subchannel_driver = {
 	.owner = THIS_MODULE,
@@ -1329,14 +1330,12 @@ static void io_subchannel_terminate_path
 
 }
 
-static int io_subchannel_chp_event(struct subchannel *sch, void *data,
-				   int event)
+static int io_subchannel_chp_event(struct subchannel *sch,
+				   struct chp_link *link, int event)
 {
 	int mask;
-	struct res_acc_data *res_data;
 
-	res_data = data;
-	mask = chp_ssd_get_mask(&sch->ssd_info, res_data);
+	mask = chp_ssd_get_mask(&sch->ssd_info, link);
 	if (!mask)
 		return 0;
 	switch (event) {

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
