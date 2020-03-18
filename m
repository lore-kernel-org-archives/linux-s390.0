Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/11] s390/qeth: don't report hard-coded driver version
Date: Wed, 18 Mar 2020 13:54:52 +0100
In-Reply-To: <20200318125455.5838-1-jwi@linux.ibm.com>
References: <20200318125455.5838-1-jwi@linux.ibm.com>
Message-Id: <20200318125455.5838-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Leon Romanovsky <leonro@mellanox.com>

Versions are meaningless for an in-kernel driver.
Instead use the UTS_RELEASE that is set by ethtool_get_drvinfo().

Cc: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index 5cfa371b7426..31e019085fc3 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -153,7 +153,6 @@ static void qeth_get_drvinfo(struct net_device *dev,
 
 	strlcpy(info->driver, IS_LAYER2(card) ? "qeth_l2" : "qeth_l3",
 		sizeof(info->driver));
-	strlcpy(info->version, "1.0", sizeof(info->version));
 	strlcpy(info->fw_version, card->info.mcl_level,
 		sizeof(info->fw_version));
 	snprintf(info->bus_info, sizeof(info->bus_info), "%s/%s/%s",
-- 
2.17.1
