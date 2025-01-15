Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0DE1D934C;
	Wed, 15 Jan 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970948; cv=none; b=VAml5bL/LTdshDZolNZlD3epBcT54p0Bg2lHk+jFEBiV48yV44j7EUu8Xd9qAXFFFZEgSGFJ58Dx3poL/JMIzz16HhgaKupniiYqSUrWTwxjMsKU5fznOqhNcMoCDbxY12o2IlHrTQED97gp88RHEZHBPhulmmQZy6d4/n5+U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970948; c=relaxed/simple;
	bh=apZrV6Cfv+ct32OZ59yXTMmHP/olwYgwfPwqmHxZUF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EX+Ms4J6P5wHB1XmNfC+4zY/zo7PthFzCFpxhraDAqSTXLLMmHu1Nuo+H2hQK5Y1YoiKRsnrXAnxbRw3/YtdZ1KkKPuXgXOQ4tUWK3Z2kEYDGJbMCSxDM2K3TuIC5WxYqPpLbN+iEh7I/wUgo+2yFNFpB7Y3gSVGTwDki+ZPlRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lfbbDj3K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lfbbDj3K"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX4vK022499;
	Wed, 15 Jan 2025 19:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SXHQ5gafw2hafsP/s
	bqTHR4KcTD0UjaOe3Ye2LqP9gU=; b=lfbbDj3KB7q1uh0ny8Axh2YSisZrjt/jk
	B6FwNH2cMWQTDiS6TTslFlMfm7K6ZCPrKvjx1NgIkFT+VKkt+0Y1x9odqHT/lehI
	eA5jKUksTE9sD0EbturfxbQ5eG0lef1qEcUF5BroQzNYJhMchnKooWP4S0DBmpN4
	mwbjRpVlBSRFKB8B44TxCN9A1Q9syLvATRijVrqFV8RRBa/ifZZ1s0ch8tUe3YSl
	QdHL/kaISP4ba8W/cy6hEine6Wogu7FtWN1jqmGvcj8fccR8ksjOad8bKyUNL8Is
	qs+llkGOyt/H8Fv4wiTX58KIyx446zLjXzP2jn8nwRXeKN8G+P7HA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FJf0dN006338;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbmy5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGm2ST004551;
	Wed, 15 Jan 2025 19:55:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ystcdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 19:55:31 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FJtSa551052806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 19:55:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09B620043;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAB732004D;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jan 2025 19:55:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 51FF4E0D92; Wed, 15 Jan 2025 20:55:27 +0100 (CET)
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
Subject: [RFC net-next 5/7] net/ism: Move ism_loopback to net/ism
Date: Wed, 15 Jan 2025 20:55:25 +0100
Message-ID: <20250115195527.2094320-6-wintera@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: OsdRV2HZLOyjQnv5Wl-kRMRglcENHe5a
X-Proofpoint-GUID: v9ewj9DO06AMUH2VoLBQbh2eVH7vyYZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150142

The first stage of ism_loopback was implemented as part of the
SMC module [1]. Now that we have the ism layer, provide
access to the ism_loopback device to all ism clients.

Move ism_loopback.* from net/smc to net/ism.
The following changes are required to ism_loopback.c:
- Change ism_lo_move_data() to no longer schedule an smcd receive tasklet,
but instead call ism_client->handle_irq().
Note: In this RFC patch ism_loppback is not fully generic.
  The smc-d client uses attached buffers, for moves without signalling.
  and not-attached buffers for moves with signalling.
  ism_lo_move_data() must not rely on that assumption.
  ism_lo_move_data() must be able to handle more than one ism client.

In addition the following changes are required to unify ism_loopback and
ism_vp:

In ism layer and ism_vpci:
ism_loopback is not backed by a pci device, so use dev instead of pdev in
ism_dev.

In smc-d:
in smcd_alloc_dev():
- use kernel memory instead of device memory for smcd_dev and smcd->conn.
        An alternative would be to ask device to alloc the memory.
- use different smcd_ops and max_dmbs for ism_vp and ism_loopback.
    A future patch can change smc-d to directly use ism_ops instead of
    smcd_ops.
- use ism dev_name instead of pci dev name for ism_evt_wq name
- allocate an event workqueue for ism_loopback, although it currently does
  not generate events.

Link: https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/ [1]

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism.h     |   6 +-
 drivers/s390/net/ism_drv.c |  31 ++-
 include/linux/ism.h        |  59 +++++
 include/net/smc.h          |   4 +-
 net/ism/Kconfig            |  13 ++
 net/ism/Makefile           |   1 +
 net/ism/ism_loopback.c     | 366 +++++++++++++++++++++++++++++++
 net/ism/ism_loopback.h     |  59 +++++
 net/ism/ism_main.c         |  11 +-
 net/smc/Kconfig            |  13 --
 net/smc/Makefile           |   1 -
 net/smc/af_smc.c           |  12 +-
 net/smc/smc_ism.c          | 108 +++++++---
 net/smc/smc_loopback.c     | 427 -------------------------------------
 net/smc/smc_loopback.h     |  60 ------
 15 files changed, 606 insertions(+), 565 deletions(-)
 create mode 100644 net/ism/ism_loopback.c
 create mode 100644 net/ism/ism_loopback.h
 delete mode 100644 net/smc/smc_loopback.c
 delete mode 100644 net/smc/smc_loopback.h

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 61cf10334170..0deca6d0e328 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -202,7 +202,7 @@ struct ism_sba {
 static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
 				  unsigned long offset, unsigned long len)
 {
-	struct zpci_dev *zdev = to_zpci(ism->pdev);
+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 2, 8);
 
 	while (len > 0) {
@@ -216,7 +216,7 @@ static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
 static inline void __ism_write_cmd(struct ism_dev *ism, void *data,
 				   unsigned long offset, unsigned long len)
 {
-	struct zpci_dev *zdev = to_zpci(ism->pdev);
+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 2, len);
 
 	if (len)
@@ -226,7 +226,7 @@ static inline void __ism_write_cmd(struct ism_dev *ism, void *data,
 static inline int __ism_move(struct ism_dev *ism, u64 dmb_req, void *data,
 			     unsigned int size)
 {
-	struct zpci_dev *zdev = to_zpci(ism->pdev);
+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, size);
 
 	return __zpci_store_block(data, req, dmb_req);
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index ab70debbdd9d..c0954d6dd9f5 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -88,7 +88,7 @@ static int register_sba(struct ism_dev *ism)
 	dma_addr_t dma_handle;
 	struct ism_sba *sba;
 
-	sba = dma_alloc_coherent(&ism->pdev->dev, PAGE_SIZE, &dma_handle,
+	sba = dma_alloc_coherent(ism->dev.parent, PAGE_SIZE, &dma_handle,
 				 GFP_KERNEL);
 	if (!sba)
 		return -ENOMEM;
@@ -99,7 +99,7 @@ static int register_sba(struct ism_dev *ism)
 	cmd.request.sba = dma_handle;
 
 	if (ism_cmd(ism, &cmd)) {
-		dma_free_coherent(&ism->pdev->dev, PAGE_SIZE, sba, dma_handle);
+		dma_free_coherent(ism->dev.parent, PAGE_SIZE, sba, dma_handle);
 		return -EIO;
 	}
 
@@ -115,7 +115,7 @@ static int register_ieq(struct ism_dev *ism)
 	dma_addr_t dma_handle;
 	struct ism_eq *ieq;
 
-	ieq = dma_alloc_coherent(&ism->pdev->dev, PAGE_SIZE, &dma_handle,
+	ieq = dma_alloc_coherent(ism->dev.parent, PAGE_SIZE, &dma_handle,
 				 GFP_KERNEL);
 	if (!ieq)
 		return -ENOMEM;
@@ -127,7 +127,7 @@ static int register_ieq(struct ism_dev *ism)
 	cmd.request.len = sizeof(*ieq);
 
 	if (ism_cmd(ism, &cmd)) {
-		dma_free_coherent(&ism->pdev->dev, PAGE_SIZE, ieq, dma_handle);
+		dma_free_coherent(ism->dev.parent, PAGE_SIZE, ieq, dma_handle);
 		return -EIO;
 	}
 
@@ -149,7 +149,7 @@ static int unregister_sba(struct ism_dev *ism)
 	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
-	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
+	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
 			  ism->sba, ism->sba_dma_addr);
 
 	ism->sba = NULL;
@@ -169,7 +169,7 @@ static int unregister_ieq(struct ism_dev *ism)
 	if (ret && ret != ISM_ERROR)
 		return -EIO;
 
-	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
+	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
 			  ism->ieq, ism->ieq_dma_addr);
 
 	ism->ieq = NULL;
@@ -216,7 +216,7 @@ static int ism_query_rgid(struct ism_dev *ism, uuid_t *rgid, u32 vid_valid,
 static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 {
 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
-	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
+	dma_unmap_page(ism->dev.parent, dmb->dma_addr, dmb->dmb_len,
 		       DMA_FROM_DEVICE);
 	folio_put(virt_to_folio(dmb->cpu_addr));
 }
@@ -227,7 +227,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	unsigned long bit;
 	int rc;
 
-	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
+	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(ism->dev.parent))
 		return -EINVAL;
 
 	if (!dmb->sba_idx) {
@@ -251,10 +251,10 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
 	}
 
 	dmb->cpu_addr = folio_address(folio);
-	dmb->dma_addr = dma_map_page(&ism->pdev->dev,
+	dmb->dma_addr = dma_map_page(ism->dev.parent,
 				     virt_to_page(dmb->cpu_addr), 0,
 				     dmb->dmb_len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
+	if (dma_mapping_error(ism->dev.parent, dmb->dma_addr)) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
@@ -419,10 +419,7 @@ static int ism_supports_v2(void)
 
 static u16 ism_get_chid(struct ism_dev *ism)
 {
-	if (!ism || !ism->pdev)
-		return 0;
-
-	return to_zpci(ism->pdev)->pchid;
+	return to_zpci(to_pci_dev(ism->dev.parent))->pchid;
 }
 
 static void ism_handle_event(struct ism_dev *ism)
@@ -499,7 +496,7 @@ static const struct ism_ops ism_vp_ops = {
 
 static int ism_dev_init(struct ism_dev *ism)
 {
-	struct pci_dev *pdev = ism->pdev;
+	struct pci_dev *pdev = to_pci_dev(ism->dev.parent);
 	int ret;
 
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
@@ -565,7 +562,6 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	spin_lock_init(&ism->lock);
 	dev_set_drvdata(&pdev->dev, ism);
-	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
 	device_initialize(&ism->dev);
 	dev_set_name(&ism->dev, dev_name(&pdev->dev));
@@ -603,14 +599,13 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
 
 	return ret;
 }
 
 static void ism_dev_exit(struct ism_dev *ism)
 {
-	struct pci_dev *pdev = ism->pdev;
+	struct pci_dev *pdev = to_pci_dev(ism->dev.parent);
 	unsigned long flags;
 	int i;
 
diff --git a/include/linux/ism.h b/include/linux/ism.h
index bc165d077071..929a1f275419 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -144,6 +144,9 @@ int  ism_unregister_client(struct ism_client *client);
  *	identified by dmb_tok and idx. If signal flag (sf) then signal
  *	the remote peer that data has arrived in this dmb.
  *
+ * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
+ *	Unregister an ism_dmb buffer
+ *
  * int (*supports_v2)(void);
  *
  * u16 (*get_chid)(struct ism_dev *dev);
@@ -218,12 +221,63 @@ struct ism_ops {
 	int (*reset_vlan_required)(struct ism_dev *dev);
 	int (*signal_event)(struct ism_dev *dev, uuid_t *rgid,
 			    u32 trigger_irq, u32 event_code, u64 info);
+/* no copy option
+ * --------------
+ */
+	/**
+	 * support_dmb_nocopy() - does this device provide no-copy option?
+	 * @dev: ism device
+	 *
+	 * In addition to using move_data(), a sender device can provide a
+	 * kernel address + length, that represents a target dmb
+	 * (like MMIO). If a sender writes into such a ghost-send-buffer
+	 * (= at this kernel address) the data will automatically
+	 * immediately appear in the target dmb, even without calling
+	 * move_data().
+	 * Note that this is NOT related to the MSG_ZEROCOPY socket flag.
+	 *
+	 * Either all 3 function pointers for support_dmb_nocopy(),
+	 * attach_dmb() and detach_dmb() are defined, or all of them must
+	 * be NULL.
+	 *
+	 * Return: non-zero, if no-copy is supported.
+	 */
+	int (*support_dmb_nocopy)(struct ism_dev *dev);
+	/**
+	 * attach_dmb() - attach local memory to a remote dmb
+	 * @dev: Local sending ism device
+	 * @dmb: all other parameters are passed in the form of a
+	 *	 dmb struct
+	 *	 TODO: (THIS IS CONFUSING, should be changed)
+	 *  dmb_tok: (in) Token of the remote dmb, we want to attach to
+	 *  cpu_addr: (out) MMIO address
+	 *  dma_addr: (out) MMIO address (if applicable, invalid otherwise)
+	 *  dmb_len: (out) length of local MMIO region,
+	 *           equal to length of remote DMB.
+	 *  sba_idx: (out) index of remote dmb (NOT HELPFUL, should be removed)
+	 *
+	 * Provides a memory address to the sender that can be used to
+	 * directly write into the remote dmb.
+	 *
+	 * Return: Zero upon success, Error code otherwise
+	 */
+	int (*attach_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
+	/**
+	 * detach_dmb() - Detach the ghost buffer from a remote dmb
+	 * @dev: ism device
+	 * @token: dmb token of the remote dmb
+	 * Return: Zero upon success, Error code otherwise
+	 */
+	int (*detach_dmb)(struct ism_dev *dev, u64 token);
 };
 
 /* Unless we gain unexpected popularity, this limit should hold for a while */
 #define MAX_CLIENTS		8
 #define NO_CLIENT		0xff		/* must be >= MAX_CLIENTS */
 #define ISM_NR_DMBS		1920
+/* Defined fabric id / CHID for all loopback devices: */
+#define ISM_LO_RESERVED_CHID	0xFFFF
+#define ISM_LO_MAX_DMBS		5000
 
 struct ism_dev {
 	const struct ism_ops *ops;
@@ -259,6 +313,11 @@ static inline void ism_set_priv(struct ism_dev *dev, struct ism_client *client,
 	dev->priv[client->id] = priv;
 }
 
+static inline struct device *ism_get_dev(struct ism_dev *ism)
+{
+	return &ism->dev;
+}
+
 #define ISM_RESERVED_VLANID	0x1FFF
 #define ISM_ERROR	0xFFFF
 
diff --git a/include/net/smc.h b/include/net/smc.h
index 91aab1d44166..7a96ed2ae20c 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -63,8 +63,8 @@ struct smcd_ops {
 
 struct smcd_dev {
 	const struct smcd_ops *ops;
-	void *priv;
-	void *client;
+	struct ism_dev *ism;
+	struct ism_client *client;
 	struct list_head list;
 	spinlock_t lock;
 	struct smc_connection **conn;
diff --git a/net/ism/Kconfig b/net/ism/Kconfig
index 4329489cc1e9..ac7a9ba7c792 100644
--- a/net/ism/Kconfig
+++ b/net/ism/Kconfig
@@ -12,3 +12,16 @@ config ISM
 
 	  To compile as a module choose M. The module name is ism.
 	  If unsure, choose N.
+
+config ISM_LO
+	bool "intra-OS shortcut with loopback-ism"
+	depends on ISM
+	default n
+	help
+	  ISM_LO enables the creation of an Emulated-ISM device named
+	  loopback-ism which can be used for transferring data
+	  when communication occurs within the same OS. This helps in
+	  convenient testing of ISM clients, since loopback-ism is
+	  independent of architecture or hardware.
+
+	  if unsure, say N.
diff --git a/net/ism/Makefile b/net/ism/Makefile
index b752baf72003..5e7c51845862 100644
--- a/net/ism/Makefile
+++ b/net/ism/Makefile
@@ -5,3 +5,4 @@
 
 ism-y += ism_main.o
 obj-$(CONFIG_ISM) += ism.o
+ism-$(CONFIG_ISM_LO) += ism_loopback.o
\ No newline at end of file
diff --git a/net/ism/ism_loopback.c b/net/ism/ism_loopback.c
new file mode 100644
index 000000000000..47e5ef355dd7
--- /dev/null
+++ b/net/ism/ism_loopback.c
@@ -0,0 +1,366 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Functions for loopback-ism device.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/ism.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "ism_loopback.h"
+
+#define ISM_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
+#define ISM_LO_SUPPORT_NOCOPY	0x1
+#define ISM_DMA_ADDR_INVALID	(~(dma_addr_t)0)
+
+static const char ism_lo_dev_name[] = "loopback-ism";
+/* global loopback device */
+static struct ism_lo_dev *lo_dev;
+
+static int ism_lo_query_rgid(struct ism_dev *ism, uuid_t *rgid,
+			     u32 vid_valid, u32 vid)
+{
+	/* rgid should be the same as lgid; vlan is not supported */
+	if (!vid_valid && uuid_equal(rgid, &ism->gid))
+		return 0;
+	return -ENETUNREACH;
+}
+
+static int ism_lo_register_dmb(struct ism_dev *ism, struct ism_dmb *dmb,
+			       struct ism_client *client)
+{
+	struct ism_lo_dmb_node *dmb_node, *tmp_node;
+	struct ism_lo_dev *ldev;
+	unsigned long flags;
+	int sba_idx, rc;
+
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+	sba_idx = dmb->sba_idx;
+	/* check space for new dmb */
+	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, ISM_LO_MAX_DMBS) {
+		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
+			break;
+	}
+	if (sba_idx == ISM_LO_MAX_DMBS)
+		return -ENOSPC;
+
+	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
+	if (!dmb_node) {
+		rc = -ENOMEM;
+		goto err_bit;
+	}
+
+	dmb_node->sba_idx = sba_idx;
+	dmb_node->len = dmb->dmb_len;
+	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
+				     __GFP_NOWARN | __GFP_NORETRY |
+				     __GFP_NOMEMALLOC);
+	if (!dmb_node->cpu_addr) {
+		rc = -ENOMEM;
+		goto err_node;
+	}
+	dmb_node->dma_addr = ISM_DMA_ADDR_INVALID;
+	refcount_set(&dmb_node->refcnt, 1);
+
+again:
+	/* add new dmb into hash table */
+	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
+	write_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
+		if (tmp_node->token == dmb_node->token) {
+			write_unlock_bh(&ldev->dmb_ht_lock);
+			goto again;
+		}
+	}
+	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
+	write_unlock_bh(&ldev->dmb_ht_lock);
+	atomic_inc(&ldev->dmb_cnt);
+
+	dmb->sba_idx = dmb_node->sba_idx;
+	dmb->dmb_tok = dmb_node->token;
+	dmb->cpu_addr = dmb_node->cpu_addr;
+	dmb->dma_addr = dmb_node->dma_addr;
+	dmb->dmb_len = dmb_node->len;
+
+	spin_lock_irqsave(&ism->lock, flags);
+	ism->sba_client_arr[sba_idx] = client->id;
+	spin_unlock_irqrestore(&ism->lock, flags);
+
+	return 0;
+
+err_node:
+	kfree(dmb_node);
+err_bit:
+	clear_bit(sba_idx, ldev->sba_idx_mask);
+	return rc;
+}
+
+static void __ism_lo_unregister_dmb(struct ism_lo_dev *ldev,
+				    struct ism_lo_dmb_node *dmb_node)
+{
+	/* remove dmb from hash table */
+	write_lock_bh(&ldev->dmb_ht_lock);
+	hash_del(&dmb_node->list);
+	write_unlock_bh(&ldev->dmb_ht_lock);
+
+	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
+	kvfree(dmb_node->cpu_addr);
+	kfree(dmb_node);
+
+	if (atomic_dec_and_test(&ldev->dmb_cnt))
+		wake_up(&ldev->ldev_release);
+}
+
+static int ism_lo_unregister_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
+{
+	struct ism_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct ism_lo_dev *ldev;
+	unsigned long flags;
+
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+
+	/* find dmb from hash table */
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+	if (!dmb_node)
+		return -EINVAL;
+
+	if (refcount_dec_and_test(&dmb_node->refcnt)) {
+		spin_lock_irqsave(&ism->lock, flags);
+		ism->sba_client_arr[dmb_node->sba_idx] = NO_CLIENT;
+		spin_unlock_irqrestore(&ism->lock, flags);
+
+		__ism_lo_unregister_dmb(ldev, dmb_node);
+	}
+	return 0;
+}
+
+static int ism_lo_support_dmb_nocopy(struct ism_dev *ism)
+{
+	return ISM_LO_SUPPORT_NOCOPY;
+}
+
+static int ism_lo_attach_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
+{
+	struct ism_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct ism_lo_dev *ldev;
+
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
+		if (tmp_node->token == dmb->dmb_tok) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	if (!refcount_inc_not_zero(&dmb_node->refcnt))
+		/* the dmb is being unregistered, but has
+		 * not been removed from the hash table.
+		 */
+		return -EINVAL;
+
+	/* provide dmb information */
+	dmb->sba_idx = dmb_node->sba_idx;
+	dmb->dmb_tok = dmb_node->token;
+	dmb->cpu_addr = dmb_node->cpu_addr;
+	dmb->dma_addr = dmb_node->dma_addr;
+	dmb->dmb_len = dmb_node->len;
+	return 0;
+}
+
+static int ism_lo_detach_dmb(struct ism_dev *ism, u64 token)
+{
+	struct ism_lo_dmb_node *dmb_node = NULL, *tmp_node;
+	struct ism_lo_dev *ldev;
+
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+
+	/* find dmb_node according to dmb->dmb_tok */
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
+		if (tmp_node->token == token) {
+			dmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!dmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	if (refcount_dec_and_test(&dmb_node->refcnt))
+		__ism_lo_unregister_dmb(ldev, dmb_node);
+	return 0;
+}
+
+static int ism_lo_move_data(struct ism_dev *ism, u64 dmb_tok,
+			    unsigned int idx, bool sf, unsigned int offset,
+			    void *data, unsigned int size)
+{
+	struct ism_lo_dmb_node *rmb_node = NULL, *tmp_node;
+	struct ism_lo_dev *ldev;
+	u16 s_mask;
+	u8 client_id;
+	u32 sba_idx;
+
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+
+	if (!sf)
+		/* since sndbuf is merged with peer DMB, there is
+		 * no need to copy data from sndbuf to peer DMB.
+		 */
+		return 0;
+
+	read_lock_bh(&ldev->dmb_ht_lock);
+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
+		if (tmp_node->token == dmb_tok) {
+			rmb_node = tmp_node;
+			break;
+		}
+	}
+	if (!rmb_node) {
+		read_unlock_bh(&ldev->dmb_ht_lock);
+		return -EINVAL;
+	}
+	// So why copy the data now?? SMC usecase? Data buffer is attached,
+	// rw-pointer are not attached?
+	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
+	sba_idx = rmb_node->sba_idx;
+	read_unlock_bh(&ldev->dmb_ht_lock);
+
+	spin_lock(&ism->lock);
+	client_id = ism->sba_client_arr[sba_idx];
+	s_mask = ror16(0x1000, idx);
+	if (likely(client_id != NO_CLIENT && ism->subs[client_id]))
+		ism->subs[client_id]->handle_irq(ism, sba_idx, s_mask);
+	spin_unlock(&ism->lock);
+
+	return 0;
+}
+
+static int ism_lo_supports_v2(void)
+{
+	return ISM_LO_V2_CAPABLE;
+}
+
+static u16 ism_lo_get_chid(struct ism_dev *ism)
+{
+	return ISM_LO_RESERVED_CHID;
+}
+
+static const struct ism_ops ism_lo_ops = {
+	.query_remote_gid = ism_lo_query_rgid,
+	.register_dmb = ism_lo_register_dmb,
+	.unregister_dmb = ism_lo_unregister_dmb,
+	.support_dmb_nocopy = ism_lo_support_dmb_nocopy,
+	.attach_dmb = ism_lo_attach_dmb,
+	.detach_dmb = ism_lo_detach_dmb,
+	.add_vlan_id = NULL,
+	.del_vlan_id = NULL,
+	.set_vlan_required = NULL,
+	.reset_vlan_required = NULL,
+	.signal_event = NULL,
+	.move_data = ism_lo_move_data,
+	.supports_v2 = ism_lo_supports_v2,
+	.get_chid = ism_lo_get_chid,
+};
+
+static void ism_lo_dev_init(struct ism_lo_dev *ldev)
+{
+	rwlock_init(&ldev->dmb_ht_lock);
+	hash_init(ldev->dmb_ht);
+	atomic_set(&ldev->dmb_cnt, 0);
+	init_waitqueue_head(&ldev->ldev_release);
+}
+
+static void ism_lo_dev_exit(struct ism_lo_dev *ldev)
+{
+	ism_dev_unregister(&ldev->ism);
+	if (atomic_read(&ldev->dmb_cnt))
+		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
+}
+
+static void ism_lo_dev_release(struct device *dev)
+{
+	struct ism_dev *ism;
+	struct ism_lo_dev *ldev;
+
+	ism = container_of(dev, struct ism_dev, dev);
+	ldev = container_of(ism, struct ism_lo_dev, ism);
+
+	kfree(ldev);
+}
+
+static int ism_lo_dev_probe(void)
+{
+	struct ism_lo_dev *ldev;
+	struct ism_dev *ism;
+
+	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
+	if (!ldev)
+		return -ENOMEM;
+
+	ism_lo_dev_init(ldev);
+	ism = &ldev->ism;
+	uuid_gen(&ism->gid);
+	ism->ops = &ism_lo_ops;
+
+	ism->sba_client_arr = kzalloc(ISM_LO_MAX_DMBS, GFP_KERNEL);
+	if (!ism->sba_client_arr)
+		return -ENOMEM;
+	memset(ism->sba_client_arr, NO_CLIENT, ISM_LO_MAX_DMBS);
+
+	ism->dev.parent = NULL;
+	ism->dev.release = ism_lo_dev_release;
+	device_initialize(&ism->dev);
+	dev_set_name(&ism->dev, ism_lo_dev_name);
+	// No device_add() for loopback?
+
+	ism_dev_register(ism);
+	lo_dev = ldev;
+	return 0;
+}
+
+static void ism_lo_dev_remove(void)
+{
+	if (!lo_dev)
+		return;
+
+	ism_lo_dev_exit(lo_dev);
+	put_device(&lo_dev->dev); /* device_initialize in ism_lo_dev_probe */
+	//Missing anyhow?:
+	lo_dev = NULL;
+}
+
+int ism_loopback_init(void)
+{
+	return ism_lo_dev_probe();
+}
+
+void ism_loopback_exit(void)
+{
+	ism_lo_dev_remove();
+}
diff --git a/net/ism/ism_loopback.h b/net/ism/ism_loopback.h
new file mode 100644
index 000000000000..b1484b032d11
--- /dev/null
+++ b/net/ism/ism_loopback.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  loopback-ism device structure definitions.
+ *
+ *  Copyright (c) 2024, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#ifndef _ISM_LOOPBACK_H
+#define _ISM_LOOPBACK_H
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hashtable.h>
+#include <linux/ism.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#if IS_ENABLED(CONFIG_ISM_LO)
+#define ISM_LO_DMBS_HASH_BITS	12
+
+struct ism_lo_dmb_node {
+	struct hlist_node list;
+	u64 token;
+	u32 len;
+	u32 sba_idx;
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+	refcount_t refcnt;
+};
+
+struct ism_lo_dev {
+	struct ism_dev ism;
+	struct device dev;
+	atomic_t dmb_cnt;
+	rwlock_t dmb_ht_lock;
+	DECLARE_BITMAP(sba_idx_mask, ISM_LO_MAX_DMBS);
+	DECLARE_HASHTABLE(dmb_ht, ISM_LO_DMBS_HASH_BITS);
+	wait_queue_head_t ldev_release;
+};
+
+int ism_loopback_init(void);
+void ism_loopback_exit(void);
+#else
+static inline int ism_loopback_init(void)
+{
+	return 0;
+}
+
+static inline void ism_loopback_exit(void)
+{
+}
+#endif
+
+#endif /* _ISM_LOOPBACK_H */
diff --git a/net/ism/ism_main.c b/net/ism/ism_main.c
index 268408dbd691..13edccff45ea 100644
--- a/net/ism/ism_main.c
+++ b/net/ism/ism_main.c
@@ -14,6 +14,8 @@
 #include <linux/err.h>
 #include <linux/ism.h>
 
+#include "ism_loopback.h"
+
 MODULE_DESCRIPTION("Internal Shared Memory class");
 MODULE_LICENSE("GPL");
 
@@ -148,14 +150,21 @@ EXPORT_SYMBOL_GPL(ism_dev_unregister);
 
 static int __init ism_init(void)
 {
+	int rc;
+
 	memset(clients, 0, sizeof(clients));
 	max_client = 0;
 
-	return 0;
+	rc = ism_loopback_init();
+	if (rc)
+		pr_err("%s: ism_loopback_init fails with %d\n", __func__, rc);
+
+	return rc;
 }
 
 static void __exit ism_exit(void)
 {
+	ism_loopback_exit();
 }
 
 module_init(ism_init);
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index ba5e6a2dd2fd..746be3996768 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -20,16 +20,3 @@ config SMC_DIAG
 	  smcss.
 
 	  if unsure, say Y.
-
-config SMC_LO
-	bool "SMC intra-OS shortcut with loopback-ism"
-	depends on SMC
-	default n
-	help
-	  SMC_LO enables the creation of an Emulated-ISM device named
-	  loopback-ism in SMC and makes use of it for transferring data
-	  when communication occurs within the same OS. This helps in
-	  convenient testing of SMC-D since loopback-ism is independent
-	  of architecture or hardware.
-
-	  if unsure, say N.
diff --git a/net/smc/Makefile b/net/smc/Makefile
index 60f1c87d5212..0e754cbc38f9 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -6,4 +6,3 @@ smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
 smc-y += smc_tracepoint.o smc_inet.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
-smc-$(CONFIG_SMC_LO) += smc_loopback.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9e6c69d18581..b80cae1940e1 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,7 +53,6 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
-#include "smc_loopback.h"
 #include "smc_inet.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
@@ -3560,16 +3559,10 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
-	rc = smc_loopback_init();
-	if (rc) {
-		pr_err("%s: smc_loopback_init fails with %d\n", __func__, rc);
-		goto out_ib;
-	}
-
 	rc = tcp_register_ulp(&smc_ulp_ops);
 	if (rc) {
 		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
-		goto out_lo;
+		goto out_ib;
 	}
 	rc = smc_inet_init();
 	if (rc) {
@@ -3580,8 +3573,6 @@ static int __init smc_init(void)
 	return 0;
 out_ulp:
 	tcp_unregister_ulp(&smc_ulp_ops);
-out_lo:
-	smc_loopback_exit();
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3620,7 +3611,6 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
-	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index a49da16bafd5..22c1cfb2ad09 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -302,7 +302,7 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
 	int use_cnt = 0;
 	void *nlh;
 
-	ism = smcd->priv;
+	ism = smcd->ism;
 	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &smc_gen_nl_family, NLM_F_MULTI,
 			  SMC_NETLINK_GET_DEV_SMCD);
@@ -453,23 +453,24 @@ static void smc_ism_event_work(struct work_struct *work)
 	kfree(wrk);
 }
 
-static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
-				       const struct smcd_ops *ops, int max_dmbs)
+static struct smcd_dev *smcd_alloc_dev(const char *name,
+				       const struct smcd_ops *ops,
+				       int max_dmbs)
 {
 	struct smcd_dev *smcd;
 
-	smcd = devm_kzalloc(parent, sizeof(*smcd), GFP_KERNEL);
+	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
 	if (!smcd)
 		return NULL;
-	smcd->conn = devm_kcalloc(parent, max_dmbs,
-				  sizeof(struct smc_connection *), GFP_KERNEL);
+	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
+			     GFP_KERNEL);
 	if (!smcd->conn)
-		return NULL;
+		goto free_smcd;
 
 	smcd->event_wq = alloc_ordered_workqueue("ism_evt_wq-%s)",
 						 WQ_MEM_RECLAIM, name);
 	if (!smcd->event_wq)
-		return NULL;
+		goto free_conn;
 
 	smcd->ops = ops;
 
@@ -479,12 +480,18 @@ static struct smcd_dev *smcd_alloc_dev(struct device *parent, const char *name,
 	INIT_LIST_HEAD(&smcd->lgr_list);
 	init_waitqueue_head(&smcd->lgrs_deleted);
 	return smcd;
+
+free_conn:
+	kfree(smcd->conn);
+free_smcd:
+	kfree(smcd);
+	return NULL;
 }
 
 static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 			   u32 vid_valid, u32 vid)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 	uuid_t ism_rgid;
 
 	copy_to_ismgid(&ism_rgid, rgid);
@@ -494,42 +501,42 @@ static int smcd_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
 static int smcd_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
 			     void *client)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->register_dmb(ism, dmb, (struct ism_client *)client);
 }
 
 static int smcd_unregister_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->unregister_dmb(ism, dmb);
 }
 
 static int smcd_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->add_vlan_id(ism, vlan_id);
 }
 
 static int smcd_del_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->del_vlan_id(ism, vlan_id);
 }
 
 static int smcd_set_vlan_required(struct smcd_dev *smcd)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->set_vlan_required(ism);
 }
 
 static int smcd_reset_vlan_required(struct smcd_dev *smcd)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->reset_vlan_required(ism);
 }
@@ -537,7 +544,7 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
 static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
 			   u32 trigger_irq, u32 event_code, u64 info)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 	uuid_t ism_rgid;
 
 	copy_to_ismgid(&ism_rgid, rgid);
@@ -549,7 +556,7 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 		     bool sf, unsigned int offset, void *data,
 		     unsigned int size)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->move_data(ism, dmb_tok, idx, sf, offset, data, size);
 }
@@ -562,23 +569,21 @@ static int smcd_supports_v2(void)
 static void smcd_get_local_gid(struct smcd_dev *smcd,
 			       struct smcd_gid *smcd_gid)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	copy_to_smcdgid(smcd_gid, &ism->gid);
 }
 
 static u16 smcd_get_chid(struct smcd_dev *smcd)
 {
-	struct ism_dev *ism = smcd->priv;
+	struct ism_dev *ism = smcd->ism;
 
 	return ism->ops->get_chid(ism);
 }
 
 static inline struct device *smcd_get_dev(struct smcd_dev *dev)
 {
-	struct ism_dev *ism = dev->priv;
-
-	return &ism->dev;
+	return ism_get_dev(dev->ism);
 }
 
 static const struct smcd_ops ism_smcd_ops = {
@@ -597,22 +602,65 @@ static const struct smcd_ops ism_smcd_ops = {
 	.get_dev = smcd_get_dev,
 };
 
+static inline int smcd_support_dmb_nocopy(struct smcd_dev *smcd)
+{
+	struct ism_dev *ism = smcd->ism;
+
+	return ism->ops->support_dmb_nocopy(ism);
+}
+
+static inline int smcd_attach_dmb(struct smcd_dev *smcd,
+				  struct ism_dmb *dmb)
+{
+	struct ism_dev *ism = smcd->ism;
+
+	return ism->ops->attach_dmb(ism, dmb);
+}
+
+static inline int smcd_detach_dmb(struct smcd_dev *smcd, u64 token)
+{
+	struct ism_dev *ism = smcd->ism;
+
+	return ism->ops->detach_dmb(ism, token);
+}
+
+static const struct smcd_ops lo_ops = {
+	.query_remote_gid = smcd_query_rgid,
+	.register_dmb = smcd_register_dmb,
+	.unregister_dmb = smcd_unregister_dmb,
+	.support_dmb_nocopy = smcd_support_dmb_nocopy,
+	.attach_dmb = smcd_attach_dmb,
+	.detach_dmb = smcd_detach_dmb,
+	.move_data = smcd_move,
+	.supports_v2 = smcd_supports_v2,
+	.get_local_gid = smcd_get_local_gid,
+	.get_chid = smcd_get_chid,
+	.get_dev = smcd_get_dev,
+};
+
 static void smcd_register_dev(struct ism_dev *ism)
 {
-	const struct smcd_ops *ops = &ism_smcd_ops;
+	const struct smcd_ops *ops;
 	struct smcd_dev *smcd, *fentry;
+	int max_dmbs;
 
-	if (!ops)
-		return;
+	if (ism->ops->get_chid(ism) == ISM_LO_RESERVED_CHID) {
+		max_dmbs = ISM_LO_MAX_DMBS;
+		ops = &lo_ops;
+	} else {
+		max_dmbs = ISM_NR_DMBS;
+		ops = &ism_smcd_ops;
+	}
 
-	smcd = smcd_alloc_dev(&ism->pdev->dev, dev_name(&ism->pdev->dev), ops,
-			      ISM_NR_DMBS);
+	smcd = smcd_alloc_dev(dev_name(&ism->dev), ops, max_dmbs);
 	if (!smcd)
 		return;
-	smcd->priv = ism;
+
+	smcd->ism = ism;
 	smcd->client = &smc_ism_client;
 	ism_set_priv(ism, &smc_ism_client, smcd);
-	if (smc_pnetid_by_dev_port(&ism->pdev->dev, 0, smcd->pnetid))
+
+	if (smc_pnetid_by_dev_port(ism->dev.parent, 0, smcd->pnetid))
 		smc_pnetid_by_table_smcd(smcd);
 
 	if (ism->ops->supports_v2())
@@ -653,6 +701,8 @@ static void smcd_unregister_dev(struct ism_dev *ism)
 	list_del_init(&smcd->list);
 	mutex_unlock(&smcd_dev_list.mutex);
 	destroy_workqueue(smcd->event_wq);
+	kfree(smcd->conn);
+	kfree(smcd);
 }
 
 /* SMCD Device event handler. Called from ISM device interrupt handler.
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
deleted file mode 100644
index c4020653ae20..000000000000
--- a/net/smc/smc_loopback.c
+++ /dev/null
@@ -1,427 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  Shared Memory Communications Direct over loopback-ism device.
- *
- *  Functions for loopback-ism device.
- *
- *  Copyright (c) 2024, Alibaba Inc.
- *
- *  Author: Wen Gu <guwen@linux.alibaba.com>
- *          Tony Lu <tonylu@linux.alibaba.com>
- *
- */
-
-#include <linux/device.h>
-#include <linux/types.h>
-#include <net/smc.h>
-
-#include "smc_cdc.h"
-#include "smc_ism.h"
-#include "smc_loopback.h"
-
-#define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
-#define SMC_LO_SUPPORT_NOCOPY	0x1
-#define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
-
-static const char smc_lo_dev_name[] = "loopback-ism";
-static struct smc_lo_dev *lo_dev;
-
-static void smc_lo_generate_ids(struct smc_lo_dev *ldev)
-{
-	struct smcd_gid *lgid = &ldev->local_gid;
-	uuid_t uuid;
-
-	uuid_gen(&uuid);
-	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
-	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
-	       sizeof(lgid->gid_ext));
-
-	ldev->chid = SMC_LO_RESERVED_CHID;
-}
-
-static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
-			     u32 vid_valid, u32 vid)
-{
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	/* rgid should be the same as lgid */
-	if (!ldev || rgid->gid != ldev->local_gid.gid ||
-	    rgid->gid_ext != ldev->local_gid.gid_ext)
-		return -ENETUNREACH;
-	return 0;
-}
-
-static int smc_lo_register_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb,
-			       void *client_priv)
-{
-	struct smc_lo_dmb_node *dmb_node, *tmp_node;
-	struct smc_lo_dev *ldev = smcd->priv;
-	int sba_idx, rc;
-
-	/* check space for new dmb */
-	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
-		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
-			break;
-	}
-	if (sba_idx == SMC_LO_MAX_DMBS)
-		return -ENOSPC;
-
-	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
-	if (!dmb_node) {
-		rc = -ENOMEM;
-		goto err_bit;
-	}
-
-	dmb_node->sba_idx = sba_idx;
-	dmb_node->len = dmb->dmb_len;
-	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
-				     __GFP_NOWARN | __GFP_NORETRY |
-				     __GFP_NOMEMALLOC);
-	if (!dmb_node->cpu_addr) {
-		rc = -ENOMEM;
-		goto err_node;
-	}
-	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
-	refcount_set(&dmb_node->refcnt, 1);
-
-again:
-	/* add new dmb into hash table */
-	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
-	write_lock_bh(&ldev->dmb_ht_lock);
-	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
-		if (tmp_node->token == dmb_node->token) {
-			write_unlock_bh(&ldev->dmb_ht_lock);
-			goto again;
-		}
-	}
-	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
-	write_unlock_bh(&ldev->dmb_ht_lock);
-	atomic_inc(&ldev->dmb_cnt);
-
-	dmb->sba_idx = dmb_node->sba_idx;
-	dmb->dmb_tok = dmb_node->token;
-	dmb->cpu_addr = dmb_node->cpu_addr;
-	dmb->dma_addr = dmb_node->dma_addr;
-	dmb->dmb_len = dmb_node->len;
-
-	return 0;
-
-err_node:
-	kfree(dmb_node);
-err_bit:
-	clear_bit(sba_idx, ldev->sba_idx_mask);
-	return rc;
-}
-
-static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
-				    struct smc_lo_dmb_node *dmb_node)
-{
-	/* remove dmb from hash table */
-	write_lock_bh(&ldev->dmb_ht_lock);
-	hash_del(&dmb_node->list);
-	write_unlock_bh(&ldev->dmb_ht_lock);
-
-	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kvfree(dmb_node->cpu_addr);
-	kfree(dmb_node);
-
-	if (atomic_dec_and_test(&ldev->dmb_cnt))
-		wake_up(&ldev->ldev_release);
-}
-
-static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
-{
-	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	/* find dmb from hash table */
-	read_lock_bh(&ldev->dmb_ht_lock);
-	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
-		if (tmp_node->token == dmb->dmb_tok) {
-			dmb_node = tmp_node;
-			break;
-		}
-	}
-	if (!dmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
-	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	if (refcount_dec_and_test(&dmb_node->refcnt))
-		__smc_lo_unregister_dmb(ldev, dmb_node);
-	return 0;
-}
-
-static int smc_lo_support_dmb_nocopy(struct smcd_dev *smcd)
-{
-	return SMC_LO_SUPPORT_NOCOPY;
-}
-
-static int smc_lo_attach_dmb(struct smcd_dev *smcd, struct ism_dmb *dmb)
-{
-	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	/* find dmb_node according to dmb->dmb_tok */
-	read_lock_bh(&ldev->dmb_ht_lock);
-	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
-		if (tmp_node->token == dmb->dmb_tok) {
-			dmb_node = tmp_node;
-			break;
-		}
-	}
-	if (!dmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
-	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	if (!refcount_inc_not_zero(&dmb_node->refcnt))
-		/* the dmb is being unregistered, but has
-		 * not been removed from the hash table.
-		 */
-		return -EINVAL;
-
-	/* provide dmb information */
-	dmb->sba_idx = dmb_node->sba_idx;
-	dmb->dmb_tok = dmb_node->token;
-	dmb->cpu_addr = dmb_node->cpu_addr;
-	dmb->dma_addr = dmb_node->dma_addr;
-	dmb->dmb_len = dmb_node->len;
-	return 0;
-}
-
-static int smc_lo_detach_dmb(struct smcd_dev *smcd, u64 token)
-{
-	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	/* find dmb_node according to dmb->dmb_tok */
-	read_lock_bh(&ldev->dmb_ht_lock);
-	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, token) {
-		if (tmp_node->token == token) {
-			dmb_node = tmp_node;
-			break;
-		}
-	}
-	if (!dmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
-	}
-	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	if (refcount_dec_and_test(&dmb_node->refcnt))
-		__smc_lo_unregister_dmb(ldev, dmb_node);
-	return 0;
-}
-
-static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
-			    unsigned int idx, bool sf, unsigned int offset,
-			    void *data, unsigned int size)
-{
-	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
-	struct smc_lo_dev *ldev = smcd->priv;
-	struct smc_connection *conn;
-
-	if (!sf)
-		/* since sndbuf is merged with peer DMB, there is
-		 * no need to copy data from sndbuf to peer DMB.
-		 */
-		return 0;
-
-	read_lock_bh(&ldev->dmb_ht_lock);
-	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
-		if (tmp_node->token == dmb_tok) {
-			rmb_node = tmp_node;
-			break;
-		}
-	}
-	if (!rmb_node) {
-		read_unlock_bh(&ldev->dmb_ht_lock);
-		return -EINVAL;
-	}
-	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
-	read_unlock_bh(&ldev->dmb_ht_lock);
-
-	conn = smcd->conn[rmb_node->sba_idx];
-	if (!conn || conn->killed)
-		return -EPIPE;
-	tasklet_schedule(&conn->rx_tsklet);
-	return 0;
-}
-
-static int smc_lo_supports_v2(void)
-{
-	return SMC_LO_V2_CAPABLE;
-}
-
-static void smc_lo_get_local_gid(struct smcd_dev *smcd,
-				 struct smcd_gid *smcd_gid)
-{
-	struct smc_lo_dev *ldev = smcd->priv;
-
-	smcd_gid->gid = ldev->local_gid.gid;
-	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
-}
-
-static u16 smc_lo_get_chid(struct smcd_dev *smcd)
-{
-	return ((struct smc_lo_dev *)smcd->priv)->chid;
-}
-
-static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
-{
-	return &((struct smc_lo_dev *)smcd->priv)->dev;
-}
-
-static const struct smcd_ops lo_ops = {
-	.query_remote_gid = smc_lo_query_rgid,
-	.register_dmb = smc_lo_register_dmb,
-	.unregister_dmb = smc_lo_unregister_dmb,
-	.support_dmb_nocopy = smc_lo_support_dmb_nocopy,
-	.attach_dmb = smc_lo_attach_dmb,
-	.detach_dmb = smc_lo_detach_dmb,
-	.add_vlan_id		= NULL,
-	.del_vlan_id		= NULL,
-	.set_vlan_required	= NULL,
-	.reset_vlan_required	= NULL,
-	.signal_event		= NULL,
-	.move_data = smc_lo_move_data,
-	.supports_v2 = smc_lo_supports_v2,
-	.get_local_gid = smc_lo_get_local_gid,
-	.get_chid = smc_lo_get_chid,
-	.get_dev = smc_lo_get_dev,
-};
-
-static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
-					  int max_dmbs)
-{
-	struct smcd_dev *smcd;
-
-	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
-	if (!smcd)
-		return NULL;
-
-	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
-			     GFP_KERNEL);
-	if (!smcd->conn)
-		goto out_smcd;
-
-	smcd->ops = ops;
-
-	spin_lock_init(&smcd->lock);
-	spin_lock_init(&smcd->lgr_lock);
-	INIT_LIST_HEAD(&smcd->vlan);
-	INIT_LIST_HEAD(&smcd->lgr_list);
-	init_waitqueue_head(&smcd->lgrs_deleted);
-	return smcd;
-
-out_smcd:
-	kfree(smcd);
-	return NULL;
-}
-
-static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
-{
-	struct smcd_dev *smcd;
-
-	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LO_MAX_DMBS);
-	if (!smcd)
-		return -ENOMEM;
-	ldev->smcd = smcd;
-	smcd->priv = ldev;
-	smc_ism_set_v2_capable();
-	mutex_lock(&smcd_dev_list.mutex);
-	list_add(&smcd->list, &smcd_dev_list.list);
-	mutex_unlock(&smcd_dev_list.mutex);
-	pr_warn_ratelimited("smc: adding smcd device %s\n",
-			    dev_name(&ldev->dev));
-	return 0;
-}
-
-static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
-{
-	struct smcd_dev *smcd = ldev->smcd;
-
-	pr_warn_ratelimited("smc: removing smcd device %s\n",
-			    dev_name(&ldev->dev));
-	smcd->going_away = 1;
-	smc_smcd_terminate_all(smcd);
-	mutex_lock(&smcd_dev_list.mutex);
-	list_del_init(&smcd->list);
-	mutex_unlock(&smcd_dev_list.mutex);
-	kfree(smcd->conn);
-	kfree(smcd);
-}
-
-static int smc_lo_dev_init(struct smc_lo_dev *ldev)
-{
-	smc_lo_generate_ids(ldev);
-	rwlock_init(&ldev->dmb_ht_lock);
-	hash_init(ldev->dmb_ht);
-	atomic_set(&ldev->dmb_cnt, 0);
-	init_waitqueue_head(&ldev->ldev_release);
-
-	return smcd_lo_register_dev(ldev);
-}
-
-static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
-{
-	smcd_lo_unregister_dev(ldev);
-	if (atomic_read(&ldev->dmb_cnt))
-		wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
-}
-
-static void smc_lo_dev_release(struct device *dev)
-{
-	struct smc_lo_dev *ldev =
-		container_of(dev, struct smc_lo_dev, dev);
-
-	kfree(ldev);
-}
-
-static int smc_lo_dev_probe(void)
-{
-	struct smc_lo_dev *ldev;
-	int ret;
-
-	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
-	if (!ldev)
-		return -ENOMEM;
-
-	ldev->dev.parent = NULL;
-	ldev->dev.release = smc_lo_dev_release;
-	device_initialize(&ldev->dev);
-	dev_set_name(&ldev->dev, smc_lo_dev_name);
-
-	ret = smc_lo_dev_init(ldev);
-	if (ret)
-		goto free_dev;
-
-	lo_dev = ldev; /* global loopback device */
-	return 0;
-
-free_dev:
-	put_device(&ldev->dev);
-	return ret;
-}
-
-static void smc_lo_dev_remove(void)
-{
-	if (!lo_dev)
-		return;
-
-	smc_lo_dev_exit(lo_dev);
-	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
-}
-
-int smc_loopback_init(void)
-{
-	return smc_lo_dev_probe();
-}
-
-void smc_loopback_exit(void)
-{
-	smc_lo_dev_remove();
-}
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
deleted file mode 100644
index 04dc6808d2e1..000000000000
--- a/net/smc/smc_loopback.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  Shared Memory Communications Direct over loopback-ism device.
- *
- *  SMC-D loopback-ism device structure definitions.
- *
- *  Copyright (c) 2024, Alibaba Inc.
- *
- *  Author: Wen Gu <guwen@linux.alibaba.com>
- *          Tony Lu <tonylu@linux.alibaba.com>
- *
- */
-
-#ifndef _SMC_LOOPBACK_H
-#define _SMC_LOOPBACK_H
-
-#include <linux/device.h>
-#include <net/smc.h>
-
-#if IS_ENABLED(CONFIG_SMC_LO)
-#define SMC_LO_MAX_DMBS		5000
-#define SMC_LO_DMBS_HASH_BITS	12
-#define SMC_LO_RESERVED_CHID	0xFFFF
-
-struct smc_lo_dmb_node {
-	struct hlist_node list;
-	u64 token;
-	u32 len;
-	u32 sba_idx;
-	void *cpu_addr;
-	dma_addr_t dma_addr;
-	refcount_t refcnt;
-};
-
-struct smc_lo_dev {
-	struct smcd_dev *smcd;
-	struct device dev;
-	u16 chid;
-	struct smcd_gid local_gid;
-	atomic_t dmb_cnt;
-	rwlock_t dmb_ht_lock;
-	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
-	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
-	wait_queue_head_t ldev_release;
-};
-
-int smc_loopback_init(void);
-void smc_loopback_exit(void);
-#else
-static inline int smc_loopback_init(void)
-{
-	return 0;
-}
-
-static inline void smc_loopback_exit(void)
-{
-}
-#endif
-
-#endif /* _SMC_LOOPBACK_H */
-- 
2.45.2

