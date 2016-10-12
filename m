From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 3/3] s390/lcs: remove trailing space at end of dev_err message
Date: Wed, 12 Oct 2016 12:38:51 +0200
Message-ID: <684d55b5d05a64e1b360b1d436a14774aa78fff1.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
In-Reply-To: <cover.1476263985.git.ursula.braun@de.ibm.com>
References: <cover.1476263985.git.ursula.braun@de.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com> 

There is a trailing white space at the end of a dev_err
message that does nothing useful - remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
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
2.8.4
