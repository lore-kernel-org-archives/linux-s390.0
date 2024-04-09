Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5E12DD84;
	Tue,  9 Apr 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662699; cv=none; b=HwsHK3cdbkox0YqopcklEyHspZdNPrzJlWL2EdLhcZsFqz7vbyqYkOIxysqJYd6i/a61Yfovi+JJ95nPGJ2Das3U1u68ZBLLPAdbxmjlz82jE0gK2tq3UAKxuMmoCJYqczTLn2dDAn1qPudXMby85jQW37Ugdm+pZBQpyPrPIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662699; c=relaxed/simple;
	bh=6vC1mJ5GazGW7BDjWM1xiZUkKNPwSg2Bb5ytJgiXO+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uzmc8xzAYyOuBx1Ziv5L7EUKP1+Dx8zFwBq/YuNOySmsi2fzJeKYvlalaiVrcJxJipFq3nlLrjWD1T5aEkWQslI43vAR3eChxJqwiYfC0f2W/uhWGr3pfxf+NAlI0ZJCXRv+29N3GD2zmoIuHtYtLst1rxuR9sZl8o3iKOVgUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aVb5VoWC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aVb5VoWC"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439B1N6N030724;
	Tue, 9 Apr 2024 11:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=2yuqS5Khw7084zEnbbKJBNp9GQR5WjpgzXBBu/4s3kA=;
 b=aVb5VoWCYMFNuUDiStBJ4bbN+KZLP5pOP26H9cQP1htDKJg8qnIt9nuImcop7sQ1g4tv
 DhKNr4Fne2++flqU8L/bhof8tic7hfraToZgGF6Jr97WHIt8dBzvITea48yN8aF12Szu
 CW88hD/8Ejj/CYlE/OH5gBIWs7tgRd7C+FMgj20l5g5M5s+op36zJqABFyM3yKyu9sv9
 RhfOEvpmG9Eb3KFSxRaR6hBItJYoFEgY0oy6WtbcLBtBCljYQRvvvkG3kNIfaGB0US4w
 p5VK4Qfbg6bpeXepsAjJsgtDI7tFNfGqMqL5IcnaXWchINFrtdQkQ2s+uCE70xmXq43/ sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd2nsg8u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 11:38:03 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439Bc2vQ023253;
	Tue, 9 Apr 2024 11:38:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd2nsg8u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 11:38:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 439A4boL021515;
	Tue, 9 Apr 2024 11:38:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbjxknmww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 11:38:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 439BbuaT16908656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 11:37:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ABA42004D;
	Tue,  9 Apr 2024 11:37:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30A2220043;
	Tue,  9 Apr 2024 11:37:56 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 11:37:56 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, pasic@linux.ibm.com,
        schnelle@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH net] Revert "s390/ism: fix receive message buffer allocation"
Date: Tue,  9 Apr 2024 13:37:53 +0200
Message-ID: <20240409113753.2181368-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ih4EjGBrz3HQRV4aRx3BJBmsd9AaJ37J
X-Proofpoint-ORIG-GUID: FWlATgMz-U1Pm9dHBEzHkK0XLFkr_vDf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404090074

This reverts commit 58effa3476536215530c9ec4910ffc981613b413.
Review was not finished on this patch. So it's not ready for
upstreaming.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---

Hi,

this is broken for a little while already and I'd rather have the full 
solution properly reviewed and acked in one patch. So please do not upstream
this yet.

Thank you,
Gerd

 drivers/s390/net/ism_drv.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index affb05521e14..2c8e964425dc 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -14,8 +14,6 @@
 #include <linux/err.h>
 #include <linux/ctype.h>
 #include <linux/processor.h>
-#include <linux/dma-mapping.h>
-#include <linux/mm.h>
 
 #include "ism.h"
 
@@ -294,15 +292,13 @@ static int ism_read_local_gid(struct ism_dev *ism)
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
-	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
-		       DMA_FROM_DEVICE);
-	folio_put(virt_to_folio(dmb->cpu_addr));
+	dma_free_coherent(&ism->pdev->dev, dmb->dmb_len,
+			  dmb->cpu_addr, dmb->dma_addr);
 }
 
 static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	unsigned long bit;
-	int rc;
 
 	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
 		return -EINVAL;
@@ -319,30 +315,14 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
 		return -EINVAL;
 
-	dmb->cpu_addr =
-		folio_address(folio_alloc(GFP_KERNEL | __GFP_NOWARN |
-					  __GFP_NOMEMALLOC | __GFP_NORETRY,
-					  get_order(dmb->dmb_len)));
+	dmb->cpu_addr = dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
+					   &dmb->dma_addr,
+					   GFP_KERNEL | __GFP_NOWARN |
+					   __GFP_NOMEMALLOC | __GFP_NORETRY);
+	if (!dmb->cpu_addr)
+		clear_bit(dmb->sba_idx, ism->sba_bitmap);
 
-	if (!dmb->cpu_addr) {
-		rc = -ENOMEM;
-		goto out_bit;
-	}
-	dmb->dma_addr = dma_map_page(&ism->pdev->dev,
-				     virt_to_page(dmb->cpu_addr), 0,
-				     dmb->dmb_len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
-		rc = -ENOMEM;
-		goto out_free;
-	}
-
-	return 0;
-
-out_free:
-	kfree(dmb->cpu_addr);
-out_bit:
-	clear_bit(dmb->sba_idx, ism->sba_bitmap);
-	return rc;
+	return dmb->cpu_addr ? 0 : -ENOMEM;
 }
 
 int ism_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,

base-commit: b46f4eaa4f0ec38909fb0072eea3aeddb32f954e
-- 
2.44.0

