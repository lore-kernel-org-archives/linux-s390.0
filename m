Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/7] s390/qeth: allow manual recovery when device is SOFTSETUP
Date: Fri, 15 Feb 2019 19:22:25 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Once a qeth ccwgroup device is set online, it's also armed for internal
recovery. So allow for testing that code path via sysfs, regardless of
whether the interface is up or down.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 30f61608fa22..485a335669ba 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -316,7 +316,7 @@ static ssize_t qeth_dev_recover_store(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	if (card->state != CARD_STATE_UP)
+	if (!qeth_card_hw_is_reachable(card))
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
-- 
2.16.4
