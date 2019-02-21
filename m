Return-Path: <SRS0=K4f4=Q4=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 2/6] s390/net: convert pnetids to ascii
Date: Thu, 21 Feb 2019 13:00:59 +0100
In-Reply-To: <20190221120103.10866-1-ubraun@linux.ibm.com>
References: <20190221120103.10866-1-ubraun@linux.ibm.com>
Message-Id: <20190221120103.10866-3-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, kgraul@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.ibm.com>

Pnetids are retrieved from the underlying hardware as EBCDIC. This patch
converts pnetids to ASCII.

Signed-off-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 arch/s390/net/pnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/net/pnet.c b/arch/s390/net/pnet.c
index 9ecdbdf59781..79211bec0fc8 100644
--- a/arch/s390/net/pnet.c
+++ b/arch/s390/net/pnet.c
@@ -12,6 +12,7 @@
 #include <asm/ccwgroup.h>
 #include <asm/ccwdev.h>
 #include <asm/pnet.h>
+#include <asm/ebcdic.h>
 
 #define PNETIDS_LEN		64	/* Total utility string length in bytes
 					 * to cover up to 4 PNETIDs of 16 bytes
@@ -48,6 +49,7 @@ static int pnet_ids_by_device(struct device *dev, u8 *pnetids)
 		if (!util_str)
 			return -ENOMEM;
 		memcpy(pnetids, util_str, PNETIDS_LEN);
+		EBCASC(pnetids, PNETIDS_LEN);
 		kfree(util_str);
 		return 0;
 	}
@@ -55,6 +57,7 @@ static int pnet_ids_by_device(struct device *dev, u8 *pnetids)
 		struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 
 		memcpy(pnetids, zdev->util_str, sizeof(zdev->util_str));
+		EBCASC(pnetids, sizeof(zdev->util_str));
 		return 0;
 	}
 	return -EOPNOTSUPP;
-- 
2.16.4
