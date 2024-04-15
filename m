Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AC7823DA;
	Mon, 15 Apr 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186929; cv=none; b=O2CINnzTnnXD+xO7R+XQJk9bCOBBKf53eOuWdrYentMiPEh05UmdclyJUHNydIJc41oBdegKdaliSc+JI0VM5qw6rzeVAYvaR4b4l8x5tHEDwby5p4JyfQHHJVdwCqa0iysPUAnS9e0ecH1EvZt9XAg0TZadPJTnCnGiaDctCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186929; c=relaxed/simple;
	bh=TPjexoiFsBjnqLlyqEtdlJNJfLrpJiVzPEU2X4CDoC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVE9p7XK4XpMzSmvFLSOvGmOAHa6OvR40pDxXEJ5rAGHt18C+2g+jN2Zwz9xhj/+EhO38cRs4PXzKUpz0GXaXH4QlaN2ERN1/HL3DgbGB4oaws7KuGgqCkKHNUClB2PO29IyQ/b72wEx+GfPqVx3H+2CJ2NBET7D0hPBX1Tu1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LPXHA45q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LPXHA45q"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FB0nhX019528;
	Mon, 15 Apr 2024 13:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=giddZiK+rI9ZQavSINHyi7A5c22otTe9O7BfwKZVdIE=;
 b=LPXHA45qltHLcAHGF1F6SpJAXEofiF6c+r79faVOQnSdLgXXyDxDoc6HNKhqCIp4rWlX
 yaXaU+9vCz4yBUBirXbOhlDFYUMWPZUVKHTCiZiYip42HDgD2CO58CyKsXI5z3F0YqRV
 wUy5NDr5WTh7x5xLgSmiG7i1xXluGRcPiw6cnkwj0dXJr8toM8+AvznnqnQdCCTup5PO
 ySCDYFAIp7TB6+wqUgotgNttRnTTTtTJnmwj5HXzO0zVWVUhOb2ghW5D40rKOKoQRgCc
 ioglJb5Kii27XityTFDg9llYI1VLSL8jqhk0nimaCMn4RanolOMCMx68Qg2vwJWpiWZc eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhu9bw6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:15:19 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FDFIBD023844;
	Mon, 15 Apr 2024 13:15:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xfhu9bw6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:15:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43FBvwJU027308;
	Mon, 15 Apr 2024 13:15:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg4ryr52t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 13:15:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43FDFB8Y25428368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 13:15:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FDA62004B;
	Mon, 15 Apr 2024 13:15:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0534420040;
	Mon, 15 Apr 2024 13:15:11 +0000 (GMT)
Received: from dilbert5.boeblingen.de.ibm.com (unknown [9.155.208.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 13:15:10 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH net] s390/ism: Properly fix receive message buffer allocation
Date: Mon, 15 Apr 2024 15:15:07 +0200
Message-ID: <20240415131507.156931-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ntSPSftJ6PGbd4J55_R12gtEHj-KJVs
X-Proofpoint-GUID: XZQkbg4IDD2udM6-SMPJlIhkB8EiT_Fq
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
 definitions=2024-04-15_10,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxlogscore=766 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150086

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
Since ISM devices are available on arch s390, only, and on that arch all
DMA is coherent, there is no need to introduce and export some kind of
dma_sync_to_cpu() method to be called by the SMC-D protocol layer.

Analogously, replace dma_free_coherent by a two step dma_unmap_page,
then folio_put to free the receive buffer.

[1] https://lore.kernel.org/all/20221113163535.884299-1-hch@lst.de/

Fixes: c08004eede4b ("s390/ism: don't pass bogus GFP_ flags to dma_alloc_coherent")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

---

Hi all,

this is the next iteration (v3 so to speak) of the fix [2] whose v2 [3] was
picked - then reverted - while there was still one comment outstanding. Here the
last review comment is addressed and proper error checking is done after 
allocating the folio.

Please consider this complete patch for inclusion into the next 6.9 rc.

Thank you,
Gerd

[2] https://lore.kernel.org/all/20240328154144.272275-1-gbayer@linux.ibm.com/
[3] https://lore.kernel.org/all/20240405111606.1785928-1-gbayer@linux.ibm.com/

https://lore.kernel.org/all/20240405111222.1785248-1-gbayer@linux.ibm.com/
---
 drivers/s390/net/ism_drv.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 2c8e964425dc..43778b088ffa 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -292,13 +292,16 @@ static int ism_read_local_gid(struct ism_dev *ism)
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
+	struct folio *folio;
 	unsigned long bit;
+	int rc;
 
 	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
 		return -EINVAL;
@@ -315,14 +318,30 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
 		return -EINVAL;
 
-	dmb->cpu_addr = dma_alloc_coherent(&ism->pdev->dev, dmb->dmb_len,
-					   &dmb->dma_addr,
-					   GFP_KERNEL | __GFP_NOWARN |
-					   __GFP_NOMEMALLOC | __GFP_NORETRY);
-	if (!dmb->cpu_addr)
-		clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
+			    __GFP_NORETRY, get_order(dmb->dmb_len));
 
-	return dmb->cpu_addr ? 0 : -ENOMEM;
+	if (!folio) {
+		rc = -ENOMEM;
+		goto out_bit;
+	}
+
+	dmb->cpu_addr = folio_address(folio);
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

