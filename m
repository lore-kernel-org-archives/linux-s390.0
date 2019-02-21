Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 6/6] net/smc: allow PCI IDs as ib device names in the pnet table
Date: Thu, 21 Feb 2019 13:01:03 +0100
In-Reply-To: <20190221120103.10866-1-ubraun@linux.ibm.com>
References: <20190221120103.10866-1-ubraun@linux.ibm.com>
Message-Id: <20190221120103.10866-7-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

SMC-D devices are identified by their PCI IDs in the pnet table. In
order to make usage of the pnet table more consistent for users, this
patch adds this form of identification for ib devices as well.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_pnet.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 878f5c085444..25dfbe343e26 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -293,7 +293,9 @@ static struct smc_ib_device *smc_pnet_find_ib(char *ib_name)
 	spin_lock(&smc_ib_devices.lock);
 	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
 		if (!strncmp(ibdev->ibdev->name, ib_name,
-			     sizeof(ibdev->ibdev->name))) {
+			     sizeof(ibdev->ibdev->name)) ||
+		    !strncmp(dev_name(ibdev->ibdev->dev.parent), ib_name,
+			     IB_DEVICE_NAME_MAX - 1)) {
 			goto out;
 		}
 	}
@@ -394,7 +396,7 @@ static int smc_pnet_set_nla(struct sk_buff *msg,
 	}
 	if (pnetelem->smcibdev) {
 		if (nla_put_string(msg, SMC_PNETID_IBNAME,
-				   pnetelem->smcibdev->ibdev->name) ||
+			dev_name(pnetelem->smcibdev->ibdev->dev.parent)) ||
 		    nla_put_u8(msg, SMC_PNETID_IBPORT, pnetelem->ib_port))
 			return -1;
 	} else if (pnetelem->smcd_dev) {
-- 
2.16.4
