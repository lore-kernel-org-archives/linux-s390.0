Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729681AbgEMHmr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 03:42:47 -0400
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net 1/2] s390/ism: fix error return code in ism_probe()
Date: Wed, 13 May 2020 09:42:29 +0200
Message-Id: <20200513074230.967-2-ubraun@linux.ibm.com>
In-Reply-To: <20200513074230.967-1-ubraun@linux.ibm.com>
References: <20200513074230.967-1-ubraun@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kgraul@linux.ibm.com, weiyongjun1@huawei.com, ubraun@linux.ibm.com

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c75112ee7b97..c7fade836d83 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -521,8 +521,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ism->smcd = smcd_alloc_dev(&pdev->dev, dev_name(&pdev->dev), &ism_ops,
 				   ISM_NR_DMBS);
-	if (!ism->smcd)
+	if (!ism->smcd) {
+		ret = -ENOMEM;
 		goto err_resource;
+	}
 
 	ism->smcd->priv = ism;
 	ret = ism_dev_init(ism);
-- 
2.17.1
