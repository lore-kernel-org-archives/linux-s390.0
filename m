From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/5] Revert "s390/qeth: use Read device to query hypervisor for MAC"
Date: Fri, 29 Jun 2018 19:45:50 +0200
Message-ID: <20180629174554.53718-2-jwi@linux.ibm.com>
References: <20180629174554.53718-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180629174554.53718-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This reverts commit b7493e91c11a757cf0f8ab26989642ee4bb2c642.

On its own, querying RDEV for a MAC address works fine. But when upgrading
from a qeth that previously queried DDEV on a z/VM NIC (ie. any kernel with
commit ec61bd2fd2a2), the RDEV query now returns a _different_ MAC address
than the DDEV query.

If the NIC is configured with MACPROTECT, z/VM apparently requires us to
use the MAC that was initially returned (on DDEV) and registered. So after
upgrading to a kernel that uses RDEV, the SETVMAC registration cmd for the
new MAC address fails and we end up with a non-operabel interface.

To avoid regressions on upgrade, switch back to using DDEV for the MAC
address query. The downgrade path (first RDEV, later DDEV) is fine, in this
case both queries return the same MAC address.

Fixes: b7493e91c11a ("s390/qeth: use Read device to query hypervisor for MAC")
Reported-by: Michal Kubecek <mkubecek@suse.com>
Tested-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8e1474f1ffac..9d9182ed8ac4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4834,7 +4834,7 @@ int qeth_vm_request_mac(struct qeth_card *card)
 		goto out;
 	}
 
-	ccw_device_get_id(CARD_RDEV(card), &id);
+	ccw_device_get_id(CARD_DDEV(card), &id);
 	request->resp_buf_len = sizeof(*response);
 	request->resp_version = DIAG26C_VERSION2;
 	request->op_code = DIAG26C_GET_MAC;
-- 
2.16.4
