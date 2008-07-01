Return-Path: <linux-kernel-owner+w=401wt.eu-S1758626AbYGAOHP@vger.kernel.org>
Message-Id: <20080701140624.096181346@de.ibm.com>
References: <20080701140551.168274793@de.ibm.com>
Date: Tue, 01 Jul 2008 16:05:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/5] cio: Export chsc_error_from_response().
Content-Disposition: inline; filename=200-nqdio-chsc.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: jang@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Make chsc_error_from_response() available to chsc callers outside
of chsc.c (namely qdio) to avoid duplicating error checking code.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |    9 ++++++++-
 drivers/s390/cio/chsc.h |    2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -27,7 +27,13 @@
 
 static void *sei_page;
 
-static int chsc_error_from_response(int response)
+/**
+ * chsc_error_from_response() - convert a chsc response to an error
+ * @response: chsc response code
+ *
+ * Returns an appropriate Linux error code for @response.
+ */
+int chsc_error_from_response(int response)
 {
 	switch (response) {
 	case 0x0001:
@@ -45,6 +51,7 @@ static int chsc_error_from_response(int 
 		return -EIO;
 	}
 }
+EXPORT_SYMBOL_GPL(chsc_error_from_response);
 
 struct chsc_ssd_area {
 	struct chsc_header request;
Index: quilt-2.6/drivers/s390/cio/chsc.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.h
+++ quilt-2.6/drivers/s390/cio/chsc.h
@@ -101,4 +101,6 @@ void chsc_chp_online(struct chp_id chpid
 void chsc_chp_offline(struct chp_id chpid);
 int chsc_get_channel_measurement_chars(struct channel_path *chp);
 
+int chsc_error_from_response(int response);
+
 #endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
