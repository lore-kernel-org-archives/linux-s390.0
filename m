Return-Path: <linux-kernel-owner+w=401wt.eu-S1763624AbZBYP0e@vger.kernel.org>
Message-Id: <20090225150835.567940767@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 30/46] cio: device scan oom fallback.
Content-Disposition: inline; filename=129-cio-scan-oom.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Since some callers rely on for_each_subchannel_staged to not fail,
fall back to brute force scanning using get_subchannel_by_schid in
case of a oom situation.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/css.c |   31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -83,6 +83,25 @@ static int call_fn_unknown_sch(struct su
 	return rc;
 }
 
+static int call_fn_all_sch(struct subchannel_id schid, void *data)
+{
+	struct cb_data *cb = data;
+	struct subchannel *sch;
+	int rc = 0;
+
+	sch = get_subchannel_by_schid(schid);
+	if (sch) {
+		if (cb->fn_known_sch)
+			rc = cb->fn_known_sch(sch, cb->data);
+		put_device(&sch->dev);
+	} else {
+		if (cb->fn_unknown_sch)
+			rc = cb->fn_unknown_sch(schid, cb->data);
+	}
+
+	return rc;
+}
+
 int for_each_subchannel_staged(int (*fn_known)(struct subchannel *, void *),
 			       int (*fn_unknown)(struct subchannel_id,
 			       void *), void *data)
@@ -90,13 +109,17 @@ int for_each_subchannel_staged(int (*fn_
 	struct cb_data cb;
 	int rc;
 
-	cb.set = idset_sch_new();
-	if (!cb.set)
-		return -ENOMEM;
-	idset_fill(cb.set);
 	cb.data = data;
 	cb.fn_known_sch = fn_known;
 	cb.fn_unknown_sch = fn_unknown;
+
+	cb.set = idset_sch_new();
+	if (!cb.set)
+		/* fall back to brute force scanning in case of oom */
+		return for_each_subchannel(call_fn_all_sch, &cb);
+
+	idset_fill(cb.set);
+
 	/* Process registered subchannels. */
 	rc = bus_for_each_dev(&css_bus_type, NULL, &cb, call_fn_known_sch);
 	if (rc)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
