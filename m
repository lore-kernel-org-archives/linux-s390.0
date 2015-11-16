Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH] s390: Delete unnecessary checks before the function call
 "debug_unregister"
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <5649E4F5.5060604@users.sourceforge.net>
Date: Mon, 16 Nov 2015 15:15:17 +0100
MIME-Version: 1.0
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Tuchscherer <ingo.tuchscherer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Nov 2015 14:45:40 +0100

The debug_unregister() function performs also input parameter validation.
Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/cio/chsc_sch.c      | 3 +--
 drivers/s390/cio/cio.c           | 9 +++------
 drivers/s390/cio/qdio_debug.c    | 6 ++----
 drivers/s390/crypto/zcrypt_api.c | 6 ++----
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 213159d..378c571 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -185,8 +185,7 @@ static int __init chsc_init_dbfs(void)
 	debug_set_level(chsc_debug_log_id, 2);
 	return 0;
 out:
-	if (chsc_debug_msg_id)
-		debug_unregister(chsc_debug_msg_id);
+	debug_unregister(chsc_debug_msg_id);
 	return -ENOMEM;
 }
 
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index e0d0295..2d18205 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -76,12 +76,9 @@ static int __init cio_debug_init(void)
 	return 0;
 
 out_unregister:
-	if (cio_debug_msg_id)
-		debug_unregister(cio_debug_msg_id);
-	if (cio_debug_trace_id)
-		debug_unregister(cio_debug_trace_id);
-	if (cio_debug_crw_id)
-		debug_unregister(cio_debug_crw_id);
+	debug_unregister(cio_debug_msg_id);
+	debug_unregister(cio_debug_trace_id);
+	debug_unregister(cio_debug_crw_id);
 	return -1;
 }
 
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index f1f3baa..b6fc147 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -366,8 +366,6 @@ void qdio_debug_exit(void)
 {
 	qdio_clear_dbf_list();
 	debugfs_remove(debugfs_root);
-	if (qdio_dbf_setup)
-		debug_unregister(qdio_dbf_setup);
-	if (qdio_dbf_error)
-		debug_unregister(qdio_dbf_error);
+	debug_unregister(qdio_dbf_setup);
+	debug_unregister(qdio_dbf_error);
 }
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 9f8fa42..5d3d04c 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1428,10 +1428,8 @@ int __init zcrypt_debug_init(void)
 void zcrypt_debug_exit(void)
 {
 	debugfs_remove(debugfs_root);
-	if (zcrypt_dbf_common)
-		debug_unregister(zcrypt_dbf_common);
-	if (zcrypt_dbf_devices)
-		debug_unregister(zcrypt_dbf_devices);
+	debug_unregister(zcrypt_dbf_common);
+	debug_unregister(zcrypt_dbf_devices);
 }
 
 /**
-- 
2.6.2
