Return-Path: <linux-kernel-owner+w=401wt.eu-S1757353AbZCYAc4@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/61] s390: struct device - replace bus_id with dev_name(), dev_set_name()
Date: Tue, 24 Mar 2009 17:26:13 -0700
Message-Id: <1237940825-22904-9-git-send-email-gregkh@suse.de>
In-Reply-To: <20090325001659.GA22461@kroah.com>
References: <20090325001659.GA22461@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Kay Sievers <kay.sievers@vrfy.org>

Cc: schwidefsky@de.ibm.com
Cc: linux-s390@vger.kernel.org
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
---
 drivers/s390/net/qeth_l3_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 3d04920..0dcc036 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1038,7 +1038,7 @@ static int qeth_l3_setadapter_parms(struct qeth_card *card)
 	rc = qeth_query_setadapterparms(card);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s couldn't set adapter parameters: "
-			"0x%x\n", card->gdev->dev.bus_id, rc);
+			"0x%x\n", dev_name(&card->gdev->dev), rc);
 		return rc;
 	}
 	if (qeth_adp_supported(card, IPA_SETADP_ALTER_MAC_ADDRESS)) {
-- 
1.6.2
