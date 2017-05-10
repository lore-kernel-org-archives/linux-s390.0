From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 4/4] s390/qeth: add missing hash table initializations
Date: Wed, 10 May 2017 19:07:54 +0200
Message-ID: <20170510170754.53922-5-jwi@linux.vnet.ibm.com>
References: <20170510170754.53922-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170510170754.53922-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

commit 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
added new hash tables, but missed to initialize them.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 6c2146fc831a..d8df1e635163 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3044,6 +3044,8 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	rc = qeth_l3_create_device_attributes(&gdev->dev);
 	if (rc)
 		return rc;
+	hash_init(card->ip_htable);
+	hash_init(card->ip_mc_htable);
 	card->options.layer2 = 0;
 	card->info.hwtrap = 0;
 	return 0;
-- 
2.10.2
