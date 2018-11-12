From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/1] s390/ism: clear dmbe_mask bit before SMC IRQ handling
Date: Mon, 12 Nov 2018 17:06:12 +0100
Message-ID: <20181112160612.31936-1-ubraun@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

SMC-D stress workload showed connection stalls. Since the firmware
decides to skip raising an interrupt if the SBA DMBE mask bit is
still set, this SBA DMBE mask bit should be cleared before the
IRQ handling in the SMC code runs. Otherwise there are small windows
possible with missing interrupts for incoming data.
SMC-D currently does not care about the old value of the SBA DMBE
mask.

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index f96ec68af2e5..dcbf5c857743 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -415,9 +415,9 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 			break;
 
 		clear_bit_inv(bit, bv);
+		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 		barrier();
 		smcd_handle_irq(ism->smcd, bit + ISM_DMB_BIT_OFFSET);
-		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 	}
 
 	if (ism->sba->e) {
-- 
2.16.4
