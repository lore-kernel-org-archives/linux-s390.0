Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 06/14] s390/qeth: use atomic_dec_not_zero()
Date: Mon, 30 Jan 2017 19:47:23 +0100
Message-Id: <20170130184723.18186-1-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
List-ID: <linux-s390.vger.kernel.org>

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 315d8a2..9595b90 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3278,7 +3278,7 @@ void qeth_queue_input_buffer(struct qeth_card *card, int index)
 			atomic_set(&card->force_alloc_skb, 3);
 			count = newcount;
 		} else {
-			atomic_add_unless(&card->force_alloc_skb, -1, 0);
+			atomic_dec_not_zero(&card->force_alloc_skb);
 		}
 
 		if (!count) {
-- 
2.9.3
