Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbgGNOYf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:24:35 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/10] s390/qeth: only init the isolation mode when necessary
Date: Tue, 14 Jul 2020 16:22:58 +0200
Message-Id: <20200714142305.29297-4-jwi@linux.ibm.com>
In-Reply-To: <20200714142305.29297-1-jwi@linux.ibm.com>
References: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

A newly initialized device defaults to ISOLATION_MODE_NONE, don't bother
with programming this a second time.

Then remove the OSD/OSX check, it's already done in the sysfs path
whenever the user actually changes the configuration.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 7d51be6665cc..514795c5eaad 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4663,8 +4663,7 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback)
 
 	QETH_CARD_TEXT(card, 4, "setactlo");
 
-	if ((IS_OSD(card) || IS_OSX(card)) &&
-	    qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
+	if (qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
 		rc = qeth_setadpparms_set_access_ctrl(card,
 			card->options.isolation, fallback);
 		if (rc) {
@@ -5347,9 +5346,11 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	    (card->info.hwtrap && qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM)))
 		card->info.hwtrap = 0;
 
-	rc = qeth_set_access_ctrl_online(card, 0);
-	if (rc)
-		goto out;
+	if (card->options.isolation != ISOLATION_MODE_NONE) {
+		rc = qeth_set_access_ctrl_online(card, 0);
+		if (rc)
+			goto out;
+	}
 
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
-- 
2.17.1
