Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 076/192] s390/ism: ignore some errors during deregistration
Date: Wed, 27 Mar 2019 14:08:28 -0400
Message-Id: <20190327181025.13507-76-sashal@kernel.org>
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sebastian Ott <sebott@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.ibm.com>

[ Upstream commit 0ff06c44efeede4acd068847d3bf8cf894b6c664 ]

Prior to dma unmap/free operations the ism driver tries to ensure
that the memory is no longer accessed by the HW. When errors
during deregistration of memory regions from the HW occur the ism
driver will not unmap/free this memory.

When we receive notification from the hypervisor that a PCI function
has been detached we can no longer access the device and would never
unmap/free these memory regions which led to complaints by the DMA
debug API.

Treat this kind of errors during the deregistration of memory regions
from the HW as success since it is already ensured that the memory
is no longer accessed by HW.

Reported-by: Karsten Graul <kgraul@linux.ibm.com>
Reported-by: Hans Wippel <hwippel@linux.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ism_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 8684bcec8ff4..00cc96341411 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -141,10 +141,13 @@ static int register_ieq(struct ism_dev *ism)
 
 static int unregister_sba(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->sba)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_SBA))
+	ret = ism_cmd_simple(ism, ISM_UNREG_SBA);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -158,10 +161,13 @@ static int unregister_sba(struct ism_dev *ism)
 
 static int unregister_ieq(struct ism_dev *ism)
 {
+	int ret;
+
 	if (!ism->ieq)
 		return 0;
 
-	if (ism_cmd_simple(ism, ISM_UNREG_IEQ))
+	ret = ism_cmd_simple(ism, ISM_UNREG_IEQ);
+	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
 	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
@@ -288,7 +294,7 @@ static int ism_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
 	cmd.request.dmb_tok = dmb->dmb_tok;
 
 	ret = ism_cmd(ism, &cmd);
-	if (ret)
+	if (ret && ret != ISM_ERROR)
 		goto out;
 
 	ism_free_dmb(ism, dmb);
-- 
2.19.1
