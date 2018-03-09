Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 08/12] s390/qeth: reset NAPI context during queue init
Date: Fri,  9 Mar 2018 18:12:59 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-9-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

init_qdio_queues() resets the Input Queue's overall QDIO state, and
positions the buffer cursor back to 0. So this is the obvious place to
also reset the queue's NAPI context (in contrast to doing it rather
randomly in the middle of the big set_online() path).
No functional change.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 ++--
 drivers/s390/net/qeth_l2_main.c   | 1 -
 drivers/s390/net/qeth_l3_main.c   | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8f427621e656..8c97ce2516bb 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2873,8 +2873,8 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "initqdqs");
 
 	/* inbound queue */
-	qdio_reset_buffers(card->qdio.in_q->qdio_bufs,
-			   QDIO_MAX_BUFFERS_PER_Q);
+	qdio_reset_buffers(card->qdio.in_q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
+	memset(&card->rx, 0, sizeof(struct qeth_rx));
 	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
 	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; ++i)
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 09768677222b..8f5babdccb42 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1087,7 +1087,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	qeth_l2_setup_bridgeport_attrs(card);
 
 	card->state = CARD_STATE_HARDSETUP;
-	memset(&card->rx, 0, sizeof(struct qeth_rx));
 	qeth_print_status_message(card);
 
 	/* softsetup */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index c302274bab22..17daf2047f7b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2898,7 +2898,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		card->info.hwtrap = 0;
 
 	card->state = CARD_STATE_HARDSETUP;
-	memset(&card->rx, 0, sizeof(struct qeth_rx));
 	qeth_print_status_message(card);
 
 	/* softsetup */
-- 
2.13.5
