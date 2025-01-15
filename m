Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF61CF28B;
	Wed, 15 Jan 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970943; cv=none; b=Xu+9DoVGiNb0b7gSG2JKldR8nLtLLuivedBk7CWZgiSSJPAQUt35khLuTBppAypw1keeelIi58fqJwG1FMB2eiBqKr+pZQ7BBfnXjwUMVAX5xuvhHmNMrjIbV8HiDIK33yo3EkV9EeQqtKnXOD9UcpoHEG8jqQ65Lfi83NsxXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970943; c=relaxed/simple;
	bh=IVIqb1E2G21kFL300bjSUrvLdvaPerISTODAvx9ueQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dI+N9qAlb663LPDVLh7ovBuZKg/nDB8NR9PZFRoY6CbF9FCXi2RxEQ+Z8sKDLFQbAEkFOllnGEtnklMX5QmtD8KonjNt0USeZOG1obP0l6wRxJtYUk/431RkdOXiWnKk4jwWWhdZM0OfuYQwCHS7VDLNicP9+RE91WuRieKH+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rx2pLSO7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rx2pLSO7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX52H022820;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hQLKBEnKlzYzeuVGJ
	JMQR/qXty4CyBanDm5QwbDITX8=; b=Rx2pLSO7QNivE+JBhYVgIoYI/j4PH8DFj
	xyQtWPxZl2WqWQWSp5kxRg917u0mnSHsIqJCCjQcI7ESoHV5ssUrfgacgL/AQZQO
	PPy55GbS7A9KPL5dX0K9JMZO6XD0DlIaITBXOTwyxKkSkrPX0EP6cDw7gh56vg0M
	6GLaWK5w41+4t46hSWdcmTgahTdlm0E6885GKw/WnfrGscrQsKT5IrZGy1fqUsIO
	KHaSqPAOtZpKlU8Brfa5jB8cFdaJh5ZoNI2JRCuIuZMG1NR5B4Fm7YBY+252PIEL
	O27Wm0aST/HoEpvJT+dQoq0u5C8f5huhzh6b/Ez/81Rt9C29xCy8g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJtW3e006731;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHnm14017359;
	Wed, 15 Jan 2025 19:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fka42k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtSWn52887960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3D5E2004B;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D114820040;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 54E95E0D9C; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [RFC net-next 6/7] s390/ism: Define ismvp_dev
Date: Wed, 15 Jan 2025 20:55:26 +0100
Message-ID: <20250115195527.2094320-7-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115195527.2094320-1-wintera@linux.ibm.com>
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GrVmxLr8UM5Z2DvJFggJ7RckaQZlM8ra
X-Proofpoint-GUID: h8YN9VoysU9Cj_4KmwUWr3oh-KbI7SSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=846 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

Move the fields that are specific to the s390 ism_vpci driver
out of the generic ism_dev into a local ismvp_dev structure.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism.h     | 11 +++++
 drivers/s390/net/ism_drv.c | 87 +++++++++++++++++++++++---------------
 include/linux/ism.h        | 20 +++------
 3 files changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 0deca6d0e328..720a783ebf90 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -196,6 +196,17 @@ struct ism_sba {
 	u16 dmbe_mask[ISM_NR_DMBS];
 };
 
+struct ismvp_dev {
+	struct ism_dev ism;
+	struct ism_sba *sba;
+	dma_addr_t sba_dma_addr;
+	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
+
+	struct ism_eq *ieq;
+	dma_addr_t ieq_dma_addr;
+	int ieq_idx;
+};
+
 #define ISM_CREATE_REQ(dmb, idx, sf, offset)		\
 	((dmb) | (idx) << 24 | (sf) << 23 | (offset))
 
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index c0954d6dd9f5..c1fb65db504c 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -84,6 +84,7 @@ static int query_info(struct ism_dev *ism)
 
 static int register_sba(struct ism_dev *ism)
 {
+	struct ismvp_dev *ismvp;
 	union ism_reg_sba cmd;
 	dma_addr_t dma_handle;
 	struct ism_sba *sba;
@@ -103,14 +104,16 @@ static int register_sba(struct ism_dev *ism)
 		return -EIO;
 	}
 
-	ism->sba = sba;
-	ism->sba_dma_addr = dma_handle;
+	ismvp = container_of(ism, struct ismvp_dev, ism);
+	ismvp->sba = sba;
+	ismvp->sba_dma_addr = dma_handle;
 
 	return 0;
 }
 
 static int register_ieq(struct ism_dev *ism)
 {
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
 	union ism_reg_ieq cmd;
 	dma_addr_t dma_handle;
 	struct ism_eq *ieq;
@@ -131,18 +134,19 @@ static int register_ieq(struct ism_dev *ism)
 		return -EIO;
 	}
 
-	ism->ieq = ieq;
-	ism->ieq_idx = -1;
-	ism->ieq_dma_addr = dma_handle;
+	ismvp->ieq = ieq;
+	ismvp->ieq_idx = -1;
+	ismvp->ieq_dma_addr = dma_handle;
 
 	return 0;
 }
 
 static int unregister_sba(struct ism_dev *ism)
 {
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
 	int ret;
 
-	if (!ism->sba)
+	if (!ismvp->sba)
 		return 0;
 
 	ret = ism_cmd_simple(ism, ISM_UNREG_SBA);
@@ -150,19 +154,20 @@ static int unregister_sba(struct ism_dev *ism)
 		return -EIO;
 
 	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
-			  ism->sba, ism->sba_dma_addr);
+			  ismvp->sba, ismvp->sba_dma_addr);
 
-	ism->sba = NULL;
-	ism->sba_dma_addr = 0;
+	ismvp->sba = NULL;
+	ismvp->sba_dma_addr = 0;
 
 	return 0;
 }
 
 static int unregister_ieq(struct ism_dev *ism)
 {
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
 	int ret;
 
-	if (!ism->ieq)
+	if (!ismvp->ieq)
 		return 0;
 
 	ret = ism_cmd_simple(ism, ISM_UNREG_IEQ);
@@ -170,10 +175,10 @@ static int unregister_ieq(struct ism_dev *ism)
 		return -EIO;
 
 	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
-			  ism->ieq, ism->ieq_dma_addr);
+			  ismvp->ieq, ismvp->ieq_dma_addr);
 
-	ism->ieq = NULL;
-	ism->ieq_dma_addr = 0;
+	ismvp->ieq = NULL;
+	ismvp->ieq_dma_addr = 0;
 
 	return 0;
 }
@@ -215,7 +220,9 @@ static int ism_query_rgid(struct ism_dev *ism, uuid_t *rgid, u32 vid_valid,
 
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
-	clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
+
+	clear_bit(dmb->sba_idx, ismvp->sba_bitmap);
 	dma_unmap_page(ism->dev.parent, dmb->dma_addr, dmb->dmb_len,
 		       DMA_FROM_DEVICE);
 	folio_put(virt_to_folio(dmb->cpu_addr));
@@ -223,6 +230,7 @@ static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 
 static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
 	struct folio *folio;
 	unsigned long bit;
 	int rc;
@@ -231,7 +239,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 		return -EINVAL;
 
 	if (!dmb->sba_idx) {
-		bit = find_next_zero_bit(ism->sba_bitmap, ISM_NR_DMBS,
+		bit = find_next_zero_bit(ismvp->sba_bitmap, ISM_NR_DMBS,
 					 ISM_DMB_BIT_OFFSET);
 		if (bit == ISM_NR_DMBS)
 			return -ENOSPC;
@@ -239,7 +247,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 		dmb->sba_idx = bit;
 	}
 	if (dmb->sba_idx < ISM_DMB_BIT_OFFSET ||
-	    test_and_set_bit(dmb->sba_idx, ism->sba_bitmap))
+	    test_and_set_bit(dmb->sba_idx, ismvp->sba_bitmap))
 		return -EINVAL;
 
 	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
@@ -264,7 +272,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 out_free:
 	kfree(dmb->cpu_addr);
 out_bit:
-	clear_bit(dmb->sba_idx, ism->sba_bitmap);
+	clear_bit(dmb->sba_idx, ismvp->sba_bitmap);
 	return rc;
 }
 
@@ -424,15 +432,16 @@ static u16 ism_get_chid(struct ism_dev *ism)
 
 static void ism_handle_event(struct ism_dev *ism)
 {
+	struct ismvp_dev *ismvp = container_of(ism, struct ismvp_dev, ism);
 	struct ism_event *entry;
 	struct ism_client *clt;
 	int i;
 
-	while ((ism->ieq_idx + 1) != READ_ONCE(ism->ieq->header.idx)) {
-		if (++(ism->ieq_idx) == ARRAY_SIZE(ism->ieq->entry))
-			ism->ieq_idx = 0;
+	while ((ismvp->ieq_idx + 1) != READ_ONCE(ismvp->ieq->header.idx)) {
+		if (++ismvp->ieq_idx == ARRAY_SIZE(ismvp->ieq->entry))
+			ismvp->ieq_idx = 0;
 
-		entry = &ism->ieq->entry[ism->ieq_idx];
+		entry = &ismvp->ieq->entry[ismvp->ieq_idx];
 		debug_event(ism_debug_info, 2, entry, sizeof(*entry));
 		for (i = 0; i < MAX_CLIENTS; ++i) {
 			clt = ism->subs[i];
@@ -445,16 +454,19 @@ static void ism_handle_event(struct ism_dev *ism)
 static irqreturn_t ism_handle_irq(int irq, void *data)
 {
 	struct ism_dev *ism = data;
+	struct ismvp_dev *ismvp;
 	unsigned long bit, end;
 	unsigned long *bv;
 	u16 dmbemask;
 	u8 client_id;
 
-	bv = (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
-	end = sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
+	ismvp = container_of(ism, struct ismvp_dev, ism);
+
+	bv = (void *)&ismvp->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
+	end = sizeof(ismvp->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;
 
 	spin_lock(&ism->lock);
-	ism->sba->s = 0;
+	ismvp->sba->s = 0;
 	barrier();
 	for (bit = 0;;) {
 		bit = find_next_bit_inv(bv, end, bit);
@@ -462,8 +474,8 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 			break;
 
 		clear_bit_inv(bit, bv);
-		dmbemask = ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET];
-		ism->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
+		dmbemask = ismvp->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET];
+		ismvp->sba->dmbe_mask[bit + ISM_DMB_BIT_OFFSET] = 0;
 		barrier();
 		client_id = ism->sba_client_arr[bit];
 		if (unlikely(client_id == NO_CLIENT || !ism->subs[client_id]))
@@ -471,8 +483,8 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 		ism->subs[client_id]->handle_irq(ism, bit + ISM_DMB_BIT_OFFSET, dmbemask);
 	}
 
-	if (ism->sba->e) {
-		ism->sba->e = 0;
+	if (ismvp->sba->e) {
+		ismvp->sba->e = 0;
 		barrier();
 		ism_handle_event(ism);
 	}
@@ -480,7 +492,7 @@ static irqreturn_t ism_handle_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static const struct ism_ops ism_vp_ops = {
+static const struct ism_ops ismvp_ops = {
 	.query_remote_gid = ism_query_rgid,
 	.register_dmb = ism_register_dmb,
 	.unregister_dmb = ism_unregister_dmb,
@@ -531,7 +543,7 @@ static int ism_dev_init(struct ism_dev *ism)
 	else
 		ism_v2_capable = false;
 
-	ism->ops = &ism_vp_ops;
+	ism->ops = &ismvp_ops;
 
 	ism_dev_register(ism);
 	query_info(ism);
@@ -553,12 +565,14 @@ static int ism_dev_init(struct ism_dev *ism)
 
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct ismvp_dev *ismvp;
 	struct ism_dev *ism;
 	int ret;
 
-	ism = kzalloc(sizeof(*ism), GFP_KERNEL);
-	if (!ism)
+	ismvp = kzalloc(sizeof(*ismvp), GFP_KERNEL);
+	if (!ismvp)
 		return -ENOMEM;
+	ism = &ismvp->ism;
 
 	spin_lock_init(&ism->lock);
 	dev_set_drvdata(&pdev->dev, ism);
@@ -599,6 +613,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
+	kfree(ismvp);
 
 	return ret;
 }
@@ -627,7 +642,11 @@ static void ism_dev_exit(struct ism_dev *ism)
 
 static void ism_remove(struct pci_dev *pdev)
 {
-	struct ism_dev *ism = dev_get_drvdata(&pdev->dev);
+	struct ismvp_dev *ismvp;
+	struct ism_dev *ism;
+
+	ism = dev_get_drvdata(&pdev->dev);
+	ismvp = container_of(ism, struct ismvp_dev, ism);
 
 	ism_dev_exit(ism);
 
@@ -635,7 +654,7 @@ static void ism_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	kfree(ismvp);
 }
 
 static struct pci_driver ism_driver = {
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 929a1f275419..f28238fb5d74 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -281,24 +281,18 @@ struct ism_ops {
 
 struct ism_dev {
 	const struct ism_ops *ops;
-	spinlock_t lock; /* protects the ism device */
 	struct list_head list;
-	struct pci_dev *pdev;
-
-	struct ism_sba *sba;
-	dma_addr_t sba_dma_addr;
-	DECLARE_BITMAP(sba_bitmap, ISM_NR_DMBS);
-	u8 *sba_client_arr;	/* entries are indices into 'clients' array */
-	void *priv[MAX_CLIENTS];
-
-	struct ism_eq *ieq;
-	dma_addr_t ieq_dma_addr;
-
 	struct device dev;
 	uuid_t gid;
-	int ieq_idx;
 
+	/* get this lock before accessing any of the fields below */
+	spinlock_t lock;
+	/* indexed by dmb idx; entries are indices into priv and subs arrays: */
+	u8 *sba_client_arr;
+	/* Sparse array of all ISM clients */
 	struct ism_client *subs[MAX_CLIENTS];
+	/* priv pointer per client; for client usage only */
+	void *priv[MAX_CLIENTS];
 };
 
 int ism_dev_register(struct ism_dev *ism);
-- 
2.45.2

