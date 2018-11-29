Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 24/68] s390/ism: clear dmbe_mask bit before SMC IRQ handling
Date: Thu, 29 Nov 2018 00:55:15 -0500
Message-Id: <20181129055559.159228-24-sashal@kernel.org>
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ursula Braun <ubraun@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit 007b656851ed7f94ba0fa358ac3e5d7705da6846 ]

SMC-D stress workload showed connection stalls. Since the firmware
decides to skip raising an interrupt if the SBA DMBE mask bit is
still set, this SBA DMBE mask bit should be cleared before the
IRQ handling in the SMC code runs. Otherwise there are small windows
possible with missing interrupts for incoming data.
SMC-D currently does not care about the old value of the SBA DMBE
mask.

Acked-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c0631895154e..8684bcec8ff4 100644
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
2.17.1
