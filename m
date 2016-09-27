Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] s390/lcs: remove trailing space at end of dev_err message
Date: Tue, 27 Sep 2016 12:57:01 -0700
Message-Id: <20160927195701.15624-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ursula Braun <ubraun@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

There is a trailing white space at the end of a dev_err
message that does nothing useful - remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/s390/net/lcs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 251db0a..211b31d 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1888,7 +1888,7 @@ lcs_stop_device(struct net_device *dev)
 	rc = lcs_stopcard(card);
 	if (rc)
 		dev_err(&card->dev->dev,
-			" Shutting down the LCS device failed\n ");
+			" Shutting down the LCS device failed\n");
 	return rc;
 }
 
-- 
2.9.3
