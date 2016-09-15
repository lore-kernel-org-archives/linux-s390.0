From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 2/7] s390/qeth: use ip_lock for hsuid configuration
Date: Thu, 15 Sep 2016 14:39:22 +0200
Message-ID: <20160915123927.86579-3-ubraun@linux.vnet.ibm.com>
References: <20160915123927.86579-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20160915123927.86579-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

qeth_l3_dev_hsuid_store() changes the ip hash table, which
requires the ip_lock.

Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 65645b1..0e00a5c 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -297,7 +297,9 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		addr->u.a6.pfxlen = 0;
 		addr->type = QETH_IP_TYPE_NORMAL;
 
+		spin_lock_bh(&card->ip_lock);
 		qeth_l3_delete_ip(card, addr);
+		spin_unlock_bh(&card->ip_lock);
 		kfree(addr);
 	}
 
@@ -329,7 +331,10 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 		addr->type = QETH_IP_TYPE_NORMAL;
 	} else
 		return -ENOMEM;
+
+	spin_lock_bh(&card->ip_lock);
 	qeth_l3_add_ip(card, addr);
+	spin_unlock_bh(&card->ip_lock);
 	kfree(addr);
 
 	return count;
-- 
2.8.4
