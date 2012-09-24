From: frank.blaschka@de.ibm.com
Subject: [patch 2/5] [PATCH] lcs: ensure proper ccw setup
Date: Mon, 24 Sep 2012 16:24:24 +0200
Message-ID: <20120924142501.136612532@de.ibm.com>
References: <20120924142422.001953152@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=601-lcs-ccw-memset.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Make sure that all ccws used for writing are initialized with
zeros - especially since the last ccw contains a TIC for which
the unused fields have to be zeros.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/lcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index a3adf4b..2ca0f1d 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -282,7 +282,7 @@ lcs_setup_write_ccws(struct lcs_card *card)
 
 	LCS_DBF_TEXT(3, setup, "iwritccw");
 	/* Setup write ccws. */
-	memset(card->write.ccws, 0, sizeof(struct ccw1) * LCS_NUM_BUFFS + 1);
+	memset(card->write.ccws, 0, sizeof(struct ccw1) * (LCS_NUM_BUFFS + 1));
 	for (cnt = 0; cnt < LCS_NUM_BUFFS; cnt++) {
 		card->write.ccws[cnt].cmd_code = LCS_CCW_WRITE;
 		card->write.ccws[cnt].count = 0;
-- 
1.7.11.7
