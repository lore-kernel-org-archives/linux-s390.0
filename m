From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 06/11] qeth: Use *_dec_not_zero instead of *_add_unless
Date: Wed, 27 Jul 2011 11:47:45 +0200
Message-ID: <1311760070-21532-6-git-send-email-sven@narfation.org>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311760070-21532-1-git-send-email-sven@narfation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sven Eckelmann <sven@narfation.org>, Ursula Braun <ursula.braun@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

atomic_dec_not_zero is defined for each architecture through
<linux/atomic.h> to provide the functionality of
atomic_add_unless(x, -1, 0).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Cc: Ursula Braun <ursula.braun@de.ibm.com>
Cc: Frank Blaschka <blaschka@linux.vnet.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/net/qeth_core_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4550573..56ceed2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2765,7 +2765,7 @@ void qeth_queue_input_buffer(struct qeth_card *card, int index)
 			atomic_set(&card->force_alloc_skb, 3);
 			count = newcount;
 		} else {
-			atomic_add_unless(&card->force_alloc_skb, -1, 0);
+			atomic_dec_not_zero(&card->force_alloc_skb);
 		}
 
 		/*
-- 
1.7.5.4
