Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5F13AA3C;
	Wed, 26 Jun 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389553; cv=none; b=emKf6so6U8AKKe0SSZ5wngeeDx789oAkHLjXQQXoZnZytSvzTF6UI8tawYdGSnhOiweRI7ExIdK4k5mR2kaovBNHmC7xRAPqOQdcOgzjOAQRDjIDHCL5mH74TTnOISqSvrl93ouBbU0Ac7l0cDFKpNyNcSTvCWpcUWA+jTXIsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389553; c=relaxed/simple;
	bh=fy3iUdoNHtg+RLT6e+nTyMyJr9ANx2SWP3ueVJDFAI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kNJ4IPWvEwsliSYrDNG47gucMt9KJFlcUHpPnHK+6dCJt//1qo/LJe2vvzF/JUDHBoVmFYPFDRTzIQIRlj1ywk9OPLE3Yu6D+G1x8GqdBeMHtXm1DdoLudsNR0hHQDDmH7yq9iJ0GFm8xxr+NcRfA11D1EZBC6N8Tqmj0/T7WyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAB3fuZhzXtmDb7eEg--.5980S2;
	Wed, 26 Jun 2024 16:12:24 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	ubraun@linux.ibm.com,
	sebott@linux.ibm.com
Cc: linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] s390/ism: Add check for dma_set_max_seg_size in ism_probe()
Date: Wed, 26 Jun 2024 16:12:15 +0800
Message-Id: <20240626081215.2824627-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3fuZhzXtmDb7eEg--.5980S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rZFW8CrW8Wr45KFy5CFg_yoWfAwc_Kw
	4xCF93JrnrKw4xtw4UKr4avrWq9r10qr18XFn7ta4ft34UGFnrX34DZF4rXr4Uua93AF47
	Crn7JrZYkwn5ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbHa0DUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), we should better
check the return value of the dma_set_max_seg_size().

Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared memory")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/s390/net/ism_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..9ddd093a0368 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -620,7 +620,9 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_resource;
 
 	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
-	dma_set_max_seg_size(&pdev->dev, SZ_1M);
+	ret = dma_set_max_seg_size(&pdev->dev, SZ_1M);
+	if (ret)
+		return ret;
 	pci_set_master(pdev);
 
 	ret = ism_dev_init(ism);
-- 
2.25.1

