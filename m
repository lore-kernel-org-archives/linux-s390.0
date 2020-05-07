Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:3885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEGJjO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 May 2020 05:39:14 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] s390/ism: fix error return code in ism_probe()
Date: Thu, 7 May 2020 09:43:07 +0000
Message-ID: <20200507094307.14102-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>

Fix to return negative error code -ENOMEM from the smcd_alloc_dev()
error handling case instead of 0, as done elsewhere in this function.

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
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
