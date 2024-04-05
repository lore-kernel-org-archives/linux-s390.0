Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BBE16C455;
	Fri,  5 Apr 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315781; cv=none; b=Pl+SyH5Ixf1SIwAb8O+bQSg1ULKbF+Qg9N5x/KuVaaR0CHBqKR2E8MoSjr7gUK+z5j5qgN7qykQIjNLk6Yr0baEcJCi9lM1UbaK70axRdG8vTGK16aXA3h4Qp5Xovh8oFkh6uQIsQHYPQclhJBGGczXK4BH2aeix/7mbLAyEuuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315781; c=relaxed/simple;
	bh=WZMtENGXdvFJ9qv+lMQx6/O9ZWqZ5ZTWI0gGOlj9A+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ns3iZ+dCAXZe0wRIpRExr0PiiI/l8F1+NmJ69qMMCqr10Ckks8A0v43DcuFw8m/s6POLC6EfttN0qwZkrJxcaw7+5993o8vIvdlCjjLhIrQH9RqxsCGCgpgVAIgiJ4bYFI4WGN3I307K40cNEMciz5HwGlZ3s6bucHP8bUyPgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lp4n6654; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lp4n6654"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435AW1Ym000702;
	Fri, 5 Apr 2024 11:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=0vIjhhw5+ITnPLAZX2x8gYmmNbs14HCZKP5g9TH1uP0=;
 b=Lp4n66546xHcavjcK2npsE0Z8HvYTiRa0X7zzkKJ+RyDPYC7O3azhlq/cHTazfqyHBAr
 9DSfI1kPurR6wgrPTc+BWxy+FIKNUUjktzrkYUM1sahvHNaTUo8IgJ+wgz6uYNAe77DT
 ZoF9gT01uobet3pAvj7E/pGDRBrL3MtvfJ6jRLuzJ2W+Hd6wOc/aWWiNWq58qw4TDa/y
 c1yMCaZrAPJoHSJEMiYiGSN2RuL51F0iDBkzMDM0MvR/jxue8llrl6raZAGktm2AHdq3
 fB/MsFbvzMxIYy8KA6nd4lYcYhbNHO+MAYjXNMfHGkhUfyaEGAnI5amP9BMJjKPkxFb5 dw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xaeakr896-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:16:15 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 435BGF32030479;
	Fri, 5 Apr 2024 11:16:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xaeakr890-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:16:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4359Q5sU031066;
	Fri, 5 Apr 2024 11:16:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x9epxt5x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:16:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 435BG8On49086806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Apr 2024 11:16:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3F02004D;
	Fri,  5 Apr 2024 11:16:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4412B2004F;
	Fri,  5 Apr 2024 11:16:08 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2024 11:16:08 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
        Christoph Hellwig <hch@lst.de>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH net v2] s390/ism: fix receive message buffer allocation
Date: Fri,  5 Apr 2024 13:16:06 +0200
Message-ID: <20240405111606.1785928-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8ez_jlHiYe4hYy3NkvgwnyYyREFT38k5
X-Proofpoint-GUID: BMN_pKOfbWqj3CquCureDYFxRHTuuxNI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=860
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050081

Since [1], dma_alloc_coherent() does not accept requests for GFP_COMP
anymore, even on archs that may be able to fulfill this. Functionality that
relied on the receive buffer being a compound page broke at that point:
The SMC-D protocol, that utilizes the ism device driver, passes receive
buffers to the splice processor in a struct splice_pipe_desc with a
single entry list of struct pages. As the buffer is no longer a compound
page, the splice processor now rejects requests to handle more than a
page worth of data.

Replace dma_alloc_coherent() and allocate a buffer with folio_alloc and
create a DMA map for it with dma_map_page(). Since only receive buffers
on ISM devices use DMA, qualify the mapping as FROM_DEVICE.
Since ISM devices are available on arch s390, only and on that arch all
DMA is coherent, there is no need to introduce and export some kind of
dma_sync_to_cpu() method to be called by the SMC-D protocol layer.

Analogously, replace dma_free_coherent by a two step dma_unmap_page,
then folio_put to free the receive buffer.

[1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/

Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to dma_alloc_coherent")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Sorry for the immediate resend - forgot to mark this for "net"

changelog:
v1->v2:
- replaced kmalloc/kfree with folio_alloc/folio_put
  as suggested.

---
 drivers/s390/net/ism_drv.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2c8e964425dc..affb05521e14 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/ctype.h>
 #include <linux/processor.h>
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
 
 #include "ism.h"
 
@@ -292,13 +294,15 @@ static int ism_read_local_gid(struct ism_dev *ism)
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
-	dma_free_coherent(&ism->pdev->dev, dmb->dmb_len,
-			  dmb->cpu_addr, dmb->dma_addr);
+	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
+		       DMA_FROM_DEVICE);
+	folio_put(virt_to_folio(dmb->cpu_addr));
 }
 
 static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	unsigned long bit;
+	int rc;
 
 	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
 		return -EINVAL;
@@ -315,14 +319,30 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
 		return -EINVAL;
 
-	dmb->cpu_addr = dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
-					   &dmb->dma_addr,
-					   GFP_KERNEL | __GFP_NOWARN |
-					   __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!dmb->cpu_addr)
-		clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	dmb->cpu_addr =
+		folio_address(folio_alloc(GFP_KERNEL | __GFP_NOWARN |
+					  __GFP_NOMEMALLOC | __GFP_NORETRY,
+					  get_order(dmb->dmb_len)));
 
-	return dmb->cpu_addr ? 0 : -ENOMEM;
+	if (!dmb->cpu_addr) {
+		rc = -ENOMEM;
+		goto out_bit;
+	}
+	dmb->dma_addr = dma_map_page(&ism->pdev->dev,
+				     virt_to_page(dmb->cpu_addr), 0,
+				     dmb->dmb_len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	kfree(dmb->cpu_addr);
+out_bit:
+	clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	return rc;
 }
 
 int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
-- 
2.44.0

