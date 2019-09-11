Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34069 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfIKPfC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Sep 2019 11:35:02 -0400
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] s390/qeth: fix spelling mistake "alocpool" -> "allocpool"
Date: Wed, 11 Sep 2019 16:35:00 +0100
Message-Id: <20190911153500.30836-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in QETH_CARD_TEXT text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a7868c8133ee..ab96b22db3fe 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -218,7 +218,7 @@ static int qeth_alloc_buffer_pool(struct qeth_card *card)
 	void *ptr;
 	int i, j;
 
-	QETH_CARD_TEXT(card, 5, "alocpool");
+	QETH_CARD_TEXT(card, 5, "allocpool");
 	for (i = 0; i < card->qdio.init_pool.buf_count; ++i) {
 		pool_entry = kzalloc(sizeof(*pool_entry), GFP_KERNEL);
 		if (!pool_entry) {
-- 
2.20.1
