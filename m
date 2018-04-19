From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 6/6] s390/qeth: use Read device to query hypervisor for MAC
Date: Thu, 19 Apr 2018 12:52:11 +0200
Message-ID: <20180419105211.83935-7-jwi@linux.ibm.com>
References: <20180419105211.83935-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419105211.83935-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

For z/VM NICs, qeth needs to consider which of the three CCW devices in
an MPC group it uses for requesting a managed MAC address.

On the Base device, the hypervisor returns a default MAC which is
pre-assigned when creating the NIC (this MAC is also returned by the
READ MAC primitive). Querying any other device results in the allocation
of an additional MAC address.

For consistency with READ MAC and to avoid using up more addresses than
necessary, it is preferable to use the NIC's default MAC. So switch the
the diag26c over to using a NIC's Read device, which should always be
identical to the Base device.

Fixes: ec61bd2fd2a2 ("s390/qeth: use diag26c to get MAC address on L2")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9b22d5d496ae..dffd820731f2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4835,7 +4835,7 @@ int qeth_vm_request_mac(struct qeth_card *card)
 		goto out;
 	}
 
-	ccw_device_get_id(CARD_DDEV(card), &id);
+	ccw_device_get_id(CARD_RDEV(card), &id);
 	request->resp_buf_len = sizeof(*response);
 	request->resp_version = DIAG26C_VERSION2;
 	request->op_code = DIAG26C_GET_MAC;
-- 
2.13.5
