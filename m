Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 61/81] s390/qeth: release cmd buffer in error paths
Date: Thu, 28 Feb 2019 10:07:53 -0500
Message-Id: <20190228150813.10256-61-sashal@kernel.org>
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 5065b2dd3e5f9247a6c9d67974bc0472bf561b9d ]

Whenever we fail before/while starting an IO, make sure to release the
IO buffer. Usually qeth_irq() would do this for us, but if the IO
doesn't even start we obviously won't get an interrupt for it either.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0c9a5250dd93f..623ddda5d2ba8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -568,6 +568,7 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -1129,6 +1130,8 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		rc = qeth_get_problem(card, cdev, irb);
 		if (rc) {
 			card->read_or_write_problem = 1;
+			if (iob)
+				qeth_release_buffer(iob->channel, iob);
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
@@ -1811,6 +1814,7 @@ static int qeth_idx_activate_get_answer(struct qeth_card *card,
 		QETH_DBF_MESSAGE(2, "Error2 in activating channel rc=%d\n", rc);
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -1880,6 +1884,7 @@ static int qeth_idx_activate_channel(struct qeth_card *card,
 			rc);
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		atomic_set(&channel->irq_pending, 0);
+		qeth_release_buffer(channel, iob);
 		wake_up(&card->wait_q);
 		return rc;
 	}
@@ -2060,6 +2065,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	}
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
+		qeth_release_buffer(channel, iob);
 		return -ENOMEM;
 	}
 	reply->callback = reply_cb;
-- 
2.19.1
