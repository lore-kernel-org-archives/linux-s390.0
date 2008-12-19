From: Roel Kluin <roel.kluin@gmail.com>
Date: Fri, 19 Dec 2008 22:30:50 +0000
Subject: [PATCH] lcs_start_kernel_thread(): handle kernel_thread failure
Message-Id: <494C209A.1030400@gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

kernel_thread may fail, notice this.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/s390/net/lcs.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 0825be8..3b6f287 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1736,14 +1736,27 @@ lcs_stopcard(struct lcs_card *card)
 static void
 lcs_start_kernel_thread(struct work_struct *work)
 {
+	int retval;
 	struct lcs_card *card = container_of(work, struct lcs_card, kernel_thread_starter);
 	LCS_DBF_TEXT(5, trace, "krnthrd");
-	if (lcs_do_start_thread(card, LCS_RECOVERY_THREAD))
-		kernel_thread(lcs_recovery, (void *) card, SIGCHLD);
+	if (lcs_do_start_thread(card, LCS_RECOVERY_THREAD)) {
+		retval = kernel_thread(lcs_recovery, card, SIGCHLD);
+		if (retval < 0) {
+			dev_err(&card->dev->dev,
+				"Creating LCS recovery thread failed.\n");
+			return;
+		}
+	}
 #ifdef CONFIG_IP_MULTICAST
-	if (lcs_do_start_thread(card, LCS_SET_MC_THREAD))
-		kernel_thread(lcs_register_mc_addresses,
-				(void *) card, SIGCHLD);
+	if (lcs_do_start_thread(card, LCS_SET_MC_THREAD)) {
+		retval = kernel_thread(lcs_register_mc_addresses, card,
+				SIGCHLD);
+		if (retval < 0) {
+			dev_err(&card->dev->dev,
+				"Creating LCS multicast address failed.\n");
+			return;
+		}
+	}
 #endif
 }
 
