Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbfLRPch (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Dec 2019 10:32:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIFSLMk036323
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:37 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wye06msgf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 18 Dec 2019 10:32:37 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 18 Dec 2019 15:32:35 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] s390/qeth: fix promiscuous mode after reset
Date: Wed, 18 Dec 2019 16:32:27 +0100
In-Reply-To: <20191218153228.29908-1-jwi@linux.ibm.com>
References: <20191218153228.29908-1-jwi@linux.ibm.com>
Message-Id: <20191218153228.29908-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When managing the promiscuous mode during an RX modeset, qeth caches the
current HW state to avoid repeated programming of the same state on each
modeset.

But while tearing down a device, we forget to clear the cached state. So
when the device is later set online again, the initial RX modeset
doesn't program the promiscuous mode since we believe it is already
enabled.
Fix this by clearing the cached state in the tear-down path.

Note that for the SBP variant of promiscuous mode, this accidentally
works right now because we unconditionally restore the SBP role while
re-initializing.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 1 +
 drivers/s390/net/qeth_l2_sys.c  | 3 ++-
 drivers/s390/net/qeth_l3_main.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 9086bc04fa6b..8c95e6019bac 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -295,6 +295,7 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 
 	flush_workqueue(card->event_wq);
 	card->info.mac_bits &= ~QETH_LAYER2_MAC_REGISTERED;
+	card->info.promisc_mode = 0;
 }
 
 static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index f70c7aac2dcc..7fa325cf6f8d 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -262,7 +262,8 @@ void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 		return;
 
 	mutex_lock(&card->sbp_lock);
-	if (card->options.sbp.role != QETH_SBP_ROLE_NONE) {
+	if (!card->options.sbp.reflect_promisc &&
+	    card->options.sbp.role != QETH_SBP_ROLE_NONE) {
 		/* Conditional to avoid spurious error messages */
 		qeth_bridgeport_setrole(card, card->options.sbp.role);
 		/* Let the callback function refresh the stored role value. */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 27126330a4b0..04e301de376f 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1314,6 +1314,7 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	}
 
 	flush_workqueue(card->event_wq);
+	card->info.promisc_mode = 0;
 }
 
 static void qeth_l3_set_promisc_mode(struct qeth_card *card)
-- 
2.17.1
