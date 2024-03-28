Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF85130E5E;
	Thu, 28 Mar 2024 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640536; cv=none; b=hqvYZPNg14Q22eCaCXD3xd/pZNRj8DLCJ5G+Jx64mv6bPPB8Q0wKpfd9d3nQ3VVuHEIRfUSWE+BSSX+OswX0UUbgotQd6ZGtUJFAbgrnUrGb5zqE0+kn/DsV7Jiu3gmbBhvs8GOvigBPBnxeghHgg6egBzgq2ZUFkqLSuqexQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640536; c=relaxed/simple;
	bh=uth9Af0P1r9+c/CKd6YirN6mU1fJBi0Wm0/5gSpdHII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pffoQycydF2P9rRG2ScQJrFtoDWihBeMgsPe1HZLy2lpohGYVh3noCYoOmbB76HQWTDMFP2gIK1MWrDoBdzKdOhFsv1rNs3eLIh98JcBoISAEpVBrZ9lMSru1cjF7pCcAgSRi0IK/QjMS6xBXLw8cMUQ73fsE1aZCmRrynBtAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A2bwLeDA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A2bwLeDA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42SFPDHl026396;
	Thu, 28 Mar 2024 15:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ehVBDuTk4Pl0tibhJJHYqqAVYUN6KlmjH3/AIxCqkhw=;
 b=A2bwLeDANlGv2YXMwJhvUVInxQQP/3Sl1rdMwMWuIDNc0LsD6l4He5AKRT3rX51n31CR
 nARMCWF2wLeGTYyhjpteDKM7EGcPVVfsIISBvUKfQAkCmxggaItpr+Ddpq42J39biFU1
 04Z6RONxUUOnaJKWkPGZJiEDtpCzmIKVNSxuRld0+0AjluxCMHqjN1lIyyPQ0AViGMLS
 TwiI7gphh95+55y9am/Rr3RpLCYSU4G1mgCUvMJAG/ZtWb5PK+MRL5Txau7j17r7A30K
 ZRsWjoG0j3NRITGK/WmDlHi8PgYFIPeKTRV9lnAjgrSMgl+sWis0ahEQk9xtE8VmeO2I vg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5ary83af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:13 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SFgCN8023041;
	Thu, 28 Mar 2024 15:42:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5ary83ab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42SEAXE8012975;
	Thu, 28 Mar 2024 15:42:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0xg9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 15:42:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42SFg5Vc30999180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 15:42:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57182004B;
	Thu, 28 Mar 2024 15:42:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F264720043;
	Thu, 28 Mar 2024 15:42:04 +0000 (GMT)
Received: from dilbert5.fritz.box (unknown [9.171.12.209])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Mar 2024 15:42:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH net 1/1] s390/ism: fix receive message buffer allocation
Date: Thu, 28 Mar 2024 16:41:44 +0100
Message-ID: <20240328154144.272275-2-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328154144.272275-1-gbayer@linux.ibm.com>
References: <20240328154144.272275-1-gbayer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fjFtrxuvbvfY-Wqx276JACrFWEgtiXZp
X-Proofpoint-ORIG-GUID: e-cfi3yA8Hpjy5iAe0p3FUoN-V4G2Xtw
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
 definitions=2024-03-28_15,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=648 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280108

Since [1], dma_alloc_coherent() does not accept requests for GFP_COMP
anymore, even on archs that may be able to fulfill this. Functionality that
relied on the receive buffer being a compound page broke at that point:
The SMC-D protocol, that utilizes the ism device driver, passes receive
buffers to the splice processor in a struct splice_pipe_desc with a
single entry list of struct pages. As the buffer is no longer a compound
page, the splice processor now rejects requests to handle more than a
page worth of data.

Replace dma_alloc_coherent() and allocate a buffer with kmalloc() then
create a DMA map for it with dma_map_page(). Since only receive buffers
on ISM devices use DMA, qualify the mapping as FROM_DEVICE.
Since ISM devices are available on arch s390, only and on that arch all
DMA is coherent, there is no need to introduce and export some kind of
dma_sync_to_cpu() method to be called by the SMC-D protocol layer.

Analogously, replace dma_free_coherent by a two step dma_unmap_page,
then kfree to free the receive buffer.

[1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/

Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to dma_alloc_coherent")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2c8e964425dc..25911b887e5e 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/ctype.h>
 #include <linux/processor.h>
+#include <linux/dma-direction.h>
+#include <linux/gfp_types.h>
 
 #include "ism.h"
 
@@ -292,13 +294,15 @@ static int ism_read_local_gid(struct ism_dev *ism)
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
-	dma_free_coherent(&ism->pdev->dev, dmb->dmb_len,
-			  dmb->cpu_addr, dmb->dma_addr);
+	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
+		       DMA_FROM_DEVICE);
+	kfree(dmb->cpu_addr);
 }
 
 static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	unsigned long bit;
+	int rc;
 
 	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
 		return -EINVAL;
@@ -315,14 +319,27 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
 		return -EINVAL;
 
-	dmb->cpu_addr = dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
-					   &dmb->dma_addr,
-					   GFP_KERNEL | __GFP_NOWARN |
-					   __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!dmb->cpu_addr)
-		clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	dmb->cpu_addr = kmalloc(dmb->dmb_len, GFP_KERNEL | __GFP_NOWARN |
+				__GFP_COMP | __GFP_NOMEMALLOC | __GFP_NORETRY);
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
 
-	return dmb->cpu_addr ? 0 : -ENOMEM;
+out_free:
+	kfree(dmb->cpu_addr);
+out_bit:
+	clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	return rc;
 }
 
 int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
-- 
2.44.0

