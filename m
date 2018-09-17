From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/15] s390/qeth: check size of required HW header cache object
Date: Mon, 17 Sep 2018 17:36:01 +0200
Message-ID: <20180917153609.94628-8-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When qeth_add_hw_header() falls back to the header cache, ensure that
the requested length doesn't exceed the object size.

For current usage this is a no-brainer, but TSO transmission will
introduce protocol headers of varying length.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index eaf01dc62e91..79ebe8a5687b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/log2.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/mii.h>
@@ -3844,6 +3845,8 @@ int qeth_hdr_chk_and_bounce(struct sk_buff *skb, struct qeth_hdr **hdr, int len)
 }
 EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
 
+#define QETH_HDR_CACHE_OBJ_SIZE		(sizeof(struct qeth_hdr) + ETH_HLEN)
+
 /**
  * qeth_add_hw_header() - add a HW header to an skb.
  * @skb: skb that the HW header should be added to.
@@ -3918,6 +3921,8 @@ int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 		return hdr_len;
 	}
 	/* fall back */
+	if (hdr_len + proto_len > QETH_HDR_CACHE_OBJ_SIZE)
+		return -E2BIG;
 	*hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
 	if (!*hdr)
 		return -ENOMEM;
@@ -6661,8 +6666,10 @@ static int __init qeth_core_init(void)
 	rc = PTR_ERR_OR_ZERO(qeth_core_root_dev);
 	if (rc)
 		goto register_err;
-	qeth_core_header_cache = kmem_cache_create("qeth_hdr",
-			sizeof(struct qeth_hdr) + ETH_HLEN, 64, 0, NULL);
+	qeth_core_header_cache =
+		kmem_cache_create("qeth_hdr", QETH_HDR_CACHE_OBJ_SIZE,
+				  roundup_pow_of_two(QETH_HDR_CACHE_OBJ_SIZE),
+				  0, NULL);
 	if (!qeth_core_header_cache) {
 		rc = -ENOMEM;
 		goto slab_err;
-- 
2.16.4
