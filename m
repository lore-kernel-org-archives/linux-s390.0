Return-Path: <SRS0=t9U+=QO=vger.kernel.org=netdev-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/7] s390/net: move pnet constants
Date: Thu,  7 Feb 2019 15:56:14 +0100
In-Reply-To: <20190207145620.92811-1-ubraun@linux.ibm.com>
References: <20190207145620.92811-1-ubraun@linux.ibm.com>
Message-Id: <20190207145620.92811-2-ubraun@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

There is no need to define these PNETID related constants in
the pnet.h file, since they are just used locally within pnet.c.
Just code cleanup, no functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 arch/s390/include/asm/pnet.h | 8 --------
 arch/s390/net/pnet.c         | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pnet.h b/arch/s390/include/asm/pnet.h
index 6e278584f8f1..5739276b458d 100644
--- a/arch/s390/include/asm/pnet.h
+++ b/arch/s390/include/asm/pnet.h
@@ -11,13 +11,5 @@
 #include <linux/device.h>
 #include <linux/types.h>
 
-#define PNETIDS_LEN		64	/* Total utility string length in bytes
-					 * to cover up to 4 PNETIDs of 16 bytes
-					 * for up to 4 device ports
-					 */
-#define MAX_PNETID_LEN		16	/* Max.length of a single port PNETID */
-#define MAX_PNETID_PORTS	(PNETIDS_LEN / MAX_PNETID_LEN)
-					/* Max. # of ports with a PNETID */
-
 int pnet_id_by_dev_port(struct device *dev, unsigned short port, u8 *pnetid);
 #endif /* _ASM_S390_PNET_H */
diff --git a/arch/s390/net/pnet.c b/arch/s390/net/pnet.c
index e22f1b10a6c7..9ecdbdf59781 100644
--- a/arch/s390/net/pnet.c
+++ b/arch/s390/net/pnet.c
@@ -13,6 +13,14 @@
 #include <asm/ccwdev.h>
 #include <asm/pnet.h>
 
+#define PNETIDS_LEN		64	/* Total utility string length in bytes
+					 * to cover up to 4 PNETIDs of 16 bytes
+					 * for up to 4 device ports
+					 */
+#define MAX_PNETID_LEN		16	/* Max.length of a single port PNETID */
+#define MAX_PNETID_PORTS	(PNETIDS_LEN / MAX_PNETID_LEN)
+					/* Max. # of ports with a PNETID */
+
 /*
  * Get the PNETIDs from a device.
  * s390 hardware supports the definition of a so-called Physical Network
-- 
2.16.4
