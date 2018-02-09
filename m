From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 1/2] s390/qeth: fix underestimated count of buffer elements
Date: Fri,  9 Feb 2018 11:03:49 +0100
Message-ID: <20180209100350.60572-2-jwi@linux.vnet.ibm.com>
References: <20180209100350.60572-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180209100350.60572-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.vnet.ibm.com>

For a memory range/skb where the last byte falls onto a page boundary
(ie. 'end' is of the form xxx...xxx001), the PFN_UP() part of the
calculation currently doesn't round up to the next PFN due to an
off-by-one error.
Thus qeth believes that the skb occupies one page less than it
actually does, and may select a IO buffer that doesn't have enough spare
buffer elements to fit all of the skb's data.
HW detects this as a malformed buffer descriptor, and raises an
exception which then triggers device recovery.

Fixes: 2863c61334aa ("qeth: refactor calculation of SBALE count")
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index db42107bf2f5..c33fbc4c2e91 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -846,7 +846,7 @@ struct qeth_trap_id {
  */
 static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 {
-	return PFN_UP(end - 1) - PFN_DOWN(start);
+	return PFN_UP(end) - PFN_DOWN(start);
 }
 
 static inline int qeth_get_micros(void)
-- 
2.13.5
