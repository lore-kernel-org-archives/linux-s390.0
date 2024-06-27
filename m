Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE574C79;
	Thu, 27 Jun 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454419; cv=none; b=gTPyx0lbohl8t0d30XsaioUTucTGy/B0OvbnZPqLtT1pLqkJJl4tTvayJy0wHPTXXQT/d4c+NPhOSiOr75wBZnmuO3I0OuRHH8v2GT+rydBuIIOHbvJSmwwYrJchNLsG8wFeS8/C/nnbaQgmsw6cz7A8Qn4xRBeXSTcujlt1Ma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454419; c=relaxed/simple;
	bh=iWdJfn2nx0iyS1FBdS9+rEwbsfUNJyZwHcmZgyS91mY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Du4mXWzxsPdUAXo8J+0tsFRMymlgS49YCGk5uNs7PC58i8LS4sQUnsVVTucaeUPihy4QdchirbsAk4onzSGA2+Lz/GExjuH+k8PyXtc1wkdsSBJnqdudf19Sty7GO+MjP/07NBexkDG4q1694/7o2sirgsKVUwqHsKPIiOlqQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADX3+e7ynxmC5MgAA--.8383S2;
	Thu, 27 Jun 2024 10:13:26 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: wintera@linux.ibm.com,
	twinkler@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	bhelgaas@google.com
Cc: linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH v2] s390/ism: Add check for dma_set_max_seg_size in ism_probe()
Date: Thu, 27 Jun 2024 10:13:14 +0800
Message-Id: <20240627021314.2976443-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADX3+e7ynxmC5MgAA--.8383S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4rKry8CryUXr4kAr17trb_yoWDAFbEgw
	4xCF93tr47Kw4xKr4UGr4avrWq9r1vqr1rWFn7ta4ft34Uur1DX3srZF1rWr4Uua93AF47
	Ar1xJrWYkwn8ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

As the possible failure of the dma_set_max_seg_size(), we should better
check the return value of the dma_set_max_seg_size().

Fixes: b0da3498c587 ("PCI: Remove pci_set_dma_max_seg_size()")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v2:
- modified the patch according to suggestions;
- modified Fixes line according to suggestions.
---
 drivers/s390/net/ism_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..54f6638e889c 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -620,7 +620,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_resource;
 
 	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
-	dma_set_max_seg_size(&pdev->dev, SZ_1M);
+	ret = dma_set_max_seg_size(&pdev->dev, SZ_1M);
+	if (ret)
+		goto err_resource;
+
 	pci_set_master(pdev);
 
 	ret = ism_dev_init(ism);
-- 
2.25.1

