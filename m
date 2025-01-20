Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3CC2E0;
	Mon, 20 Jan 2025 03:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737345339; cv=none; b=LisZ+h3QHEb8gvHI/d6wSVQ+V412vt3y8pKdvKc4r8avSq3ERmdFN6miFtZhvkORL6t9nfzJBC4zyv2AqAEfVYle6fu1NxtuLqt2G/AK8kMEv52Qea1qB6HyLIJnt30BsNFj7f8cgq2oLJ8xO//bdE5OUUyMcsMhoTlOGrhjYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737345339; c=relaxed/simple;
	bh=lQhyAM3fw3B0o34xXDtr+c0/7XfdDUtXBNapTpm8VcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO1c/IDUV/zLhf/JYKqqdN4dS8tAnjaz+D9xaARB2G29uOkmmTKpqRKgrT7FjoQPerGbnJoSB5TGdFF6s/TTNS2hNqqEBPOsZlS81aoLOrnU+zRDIDyJByjQH8CJS6OGepT1KJHD5GrigCO9lsgQ9w6UcCS9yyT1sag1Z0XBSVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xxA8EMt3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xxA8EMt3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737345326; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=l6w2p0z4u6KOr5GAF2QwMpo9BkgfPZzuAH0um8OPxqs=;
	b=xxA8EMt36yQ4I7pNMPLHhM0MIyiy2g3106wCIMzVKRF4es/WoDQsofC16Iq0g0IS6wCxwDL4I5TomEcVmkCl4EFGTZ87mpl/twU6cwbOUrED6M/uQu8qe8WJbxlsmzi8NjCA4azXio+KYOaIhTCVCdzPRB2SXJdsMbx7NBLIxjc=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNvQ6jO_1737345325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 11:55:25 +0800
Date: Mon, 20 Jan 2025 11:55:25 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 5/7] net/ism: Move ism_loopback to net/ism
Message-ID: <20250120035525.GK89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-6-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115195527.2094320-6-wintera@linux.ibm.com>

On 2025-01-15 20:55:25, Alexandra Winter wrote:
>The first stage of ism_loopback was implemented as part of the
>SMC module [1]. Now that we have the ism layer, provide
>access to the ism_loopback device to all ism clients.
>
>Move ism_loopback.* from net/smc to net/ism.
>The following changes are required to ism_loopback.c:
>- Change ism_lo_move_data() to no longer schedule an smcd receive tasklet,
>but instead call ism_client->handle_irq().
>Note: In this RFC patch ism_loppback is not fully generic.
>  The smc-d client uses attached buffers, for moves without signalling.
>  and not-attached buffers for moves with signalling.
>  ism_lo_move_data() must not rely on that assumption.
>  ism_lo_move_data() must be able to handle more than one ism client.
>
>In addition the following changes are required to unify ism_loopback and
>ism_vp:
>
>In ism layer and ism_vpci:
>ism_loopback is not backed by a pci device, so use dev instead of pdev in
>ism_dev.
>
>In smc-d:
>in smcd_alloc_dev():
>- use kernel memory instead of device memory for smcd_dev and smcd->conn.
>        An alternative would be to ask device to alloc the memory.
>- use different smcd_ops and max_dmbs for ism_vp and ism_loopback.
>    A future patch can change smc-d to directly use ism_ops instead of
>    smcd_ops.
>- use ism dev_name instead of pci dev name for ism_evt_wq name
>- allocate an event workqueue for ism_loopback, although it currently does
>  not generate events.
>
>Link: https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/ [1]
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> drivers/s390/net/ism.h     |   6 +-
> drivers/s390/net/ism_drv.c |  31 ++-
> include/linux/ism.h        |  59 +++++
> include/net/smc.h          |   4 +-
> net/ism/Kconfig            |  13 ++
> net/ism/Makefile           |   1 +
> net/ism/ism_loopback.c     | 366 +++++++++++++++++++++++++++++++
> net/ism/ism_loopback.h     |  59 +++++
> net/ism/ism_main.c         |  11 +-
> net/smc/Kconfig            |  13 --
> net/smc/Makefile           |   1 -
> net/smc/af_smc.c           |  12 +-
> net/smc/smc_ism.c          | 108 +++++++---
> net/smc/smc_loopback.c     | 427 -------------------------------------
> net/smc/smc_loopback.h     |  60 ------
> 15 files changed, 606 insertions(+), 565 deletions(-)
> create mode 100644 net/ism/ism_loopback.c
> create mode 100644 net/ism/ism_loopback.h
> delete mode 100644 net/smc/smc_loopback.c
> delete mode 100644 net/smc/smc_loopback.h
>
>diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
>index 61cf10334170..0deca6d0e328 100644
>--- a/drivers/s390/net/ism.h
>+++ b/drivers/s390/net/ism.h
>@@ -202,7 +202,7 @@ struct ism_sba {
> static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
> 				  unsigned long offset, unsigned long len)
> {
>-	struct zpci_dev *zdev = to_zpci(ism->pdev);
>+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
> 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 2, 8);
> 
> 	while (len > 0) {
>@@ -216,7 +216,7 @@ static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
> static inline void __ism_write_cmd(struct ism_dev *ism, void *data,
> 				   unsigned long offset, unsigned long len)
> {
>-	struct zpci_dev *zdev = to_zpci(ism->pdev);
>+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
> 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 2, len);
> 
> 	if (len)
>@@ -226,7 +226,7 @@ static inline void __ism_write_cmd(struct ism_dev *ism, void *data,
> static inline int __ism_move(struct ism_dev *ism, u64 dmb_req, void *data,
> 			     unsigned int size)
> {
>-	struct zpci_dev *zdev = to_zpci(ism->pdev);
>+	struct zpci_dev *zdev = to_zpci(to_pci_dev(ism->dev.parent));
> 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, size);
> 
> 	return __zpci_store_block(data, req, dmb_req);
>diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
>index ab70debbdd9d..c0954d6dd9f5 100644
>--- a/drivers/s390/net/ism_drv.c
>+++ b/drivers/s390/net/ism_drv.c
>@@ -88,7 +88,7 @@ static int register_sba(struct ism_dev *ism)
> 	dma_addr_t dma_handle;
> 	struct ism_sba *sba;
> 
>-	sba = dma_alloc_coherent(&ism->pdev->dev, PAGE_SIZE, &dma_handle,
>+	sba = dma_alloc_coherent(ism->dev.parent, PAGE_SIZE, &dma_handle,
> 				 GFP_KERNEL);
> 	if (!sba)
> 		return -ENOMEM;
>@@ -99,7 +99,7 @@ static int register_sba(struct ism_dev *ism)
> 	cmd.request.sba = dma_handle;
> 
> 	if (ism_cmd(ism, &cmd)) {
>-		dma_free_coherent(&ism->pdev->dev, PAGE_SIZE, sba, dma_handle);
>+		dma_free_coherent(ism->dev.parent, PAGE_SIZE, sba, dma_handle);
> 		return -EIO;
> 	}
> 
>@@ -115,7 +115,7 @@ static int register_ieq(struct ism_dev *ism)
> 	dma_addr_t dma_handle;
> 	struct ism_eq *ieq;
> 
>-	ieq = dma_alloc_coherent(&ism->pdev->dev, PAGE_SIZE, &dma_handle,
>+	ieq = dma_alloc_coherent(ism->dev.parent, PAGE_SIZE, &dma_handle,
> 				 GFP_KERNEL);
> 	if (!ieq)
> 		return -ENOMEM;
>@@ -127,7 +127,7 @@ static int register_ieq(struct ism_dev *ism)
> 	cmd.request.len = sizeof(*ieq);
> 
> 	if (ism_cmd(ism, &cmd)) {
>-		dma_free_coherent(&ism->pdev->dev, PAGE_SIZE, ieq, dma_handle);
>+		dma_free_coherent(ism->dev.parent, PAGE_SIZE, ieq, dma_handle);
> 		return -EIO;
> 	}
> 
>@@ -149,7 +149,7 @@ static int unregister_sba(struct ism_dev *ism)
> 	if (ret && ret != ISM_ERROR)
> 		return -EIO;
> 
>-	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
>+	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
> 			  ism->sba, ism->sba_dma_addr);
> 
> 	ism->sba = NULL;
>@@ -169,7 +169,7 @@ static int unregister_ieq(struct ism_dev *ism)
> 	if (ret && ret != ISM_ERROR)
> 		return -EIO;
> 
>-	dma_free_coherent(&ism->pdev->dev, PAGE_SIZE,
>+	dma_free_coherent(ism->dev.parent, PAGE_SIZE,
> 			  ism->ieq, ism->ieq_dma_addr);
> 
> 	ism->ieq = NULL;
>@@ -216,7 +216,7 @@ static int ism_query_rgid(struct ism_dev *ism, uuid_t *rgid, u32 vid_valid,
> static void ism_free_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> {
> 	clear_bit(dmb->sba_idx, ism->sba_bitmap);
>-	dma_unmap_page(&ism->pdev->dev, dmb->dma_addr, dmb->dmb_len,
>+	dma_unmap_page(ism->dev.parent, dmb->dma_addr, dmb->dmb_len,
> 		       DMA_FROM_DEVICE);
> 	folio_put(virt_to_folio(dmb->cpu_addr));
> }
>@@ -227,7 +227,7 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> 	unsigned long bit;
> 	int rc;
> 
>-	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(&ism->pdev->dev))
>+	if (PAGE_ALIGN(dmb->dmb_len) > dma_get_max_seg_size(ism->dev.parent))
> 		return -EINVAL;
> 
> 	if (!dmb->sba_idx) {
>@@ -251,10 +251,10 @@ static int ism_alloc_dmb(struct ism_dev *ism, struct ism_dmb *dmb)
> 	}
> 
> 	dmb->cpu_addr = folio_address(folio);
>-	dmb->dma_addr = dma_map_page(&ism->pdev->dev,
>+	dmb->dma_addr = dma_map_page(ism->dev.parent,
> 				     virt_to_page(dmb->cpu_addr), 0,
> 				     dmb->dmb_len, DMA_FROM_DEVICE);
>-	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
>+	if (dma_mapping_error(ism->dev.parent, dmb->dma_addr)) {
> 		rc = -ENOMEM;
> 		goto out_free;
> 	}
>@@ -419,10 +419,7 @@ static int ism_supports_v2(void)
> 
> static u16 ism_get_chid(struct ism_dev *ism)
> {
>-	if (!ism || !ism->pdev)
>-		return 0;
>-
>-	return to_zpci(ism->pdev)->pchid;
>+	return to_zpci(to_pci_dev(ism->dev.parent))->pchid;
> }
> 
> static void ism_handle_event(struct ism_dev *ism)
>@@ -499,7 +496,7 @@ static const struct ism_ops ism_vp_ops = {
> 
> static int ism_dev_init(struct ism_dev *ism)
> {
>-	struct pci_dev *pdev = ism->pdev;
>+	struct pci_dev *pdev = to_pci_dev(ism->dev.parent);
> 	int ret;
> 
> 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
>@@ -565,7 +562,6 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 
> 	spin_lock_init(&ism->lock);
> 	dev_set_drvdata(&pdev->dev, ism);
>-	ism->pdev = pdev;
> 	ism->dev.parent = &pdev->dev;
> 	device_initialize(&ism->dev);
> 	dev_set_name(&ism->dev, dev_name(&pdev->dev));
>@@ -603,14 +599,13 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 	device_del(&ism->dev);
> err_dev:
> 	dev_set_drvdata(&pdev->dev, NULL);
>-	kfree(ism);
> 
> 	return ret;
> }
> 
> static void ism_dev_exit(struct ism_dev *ism)
> {
>-	struct pci_dev *pdev = ism->pdev;
>+	struct pci_dev *pdev = to_pci_dev(ism->dev.parent);
> 	unsigned long flags;
> 	int i;
> 
>diff --git a/include/linux/ism.h b/include/linux/ism.h
>index bc165d077071..929a1f275419 100644
>--- a/include/linux/ism.h
>+++ b/include/linux/ism.h
>@@ -144,6 +144,9 @@ int  ism_unregister_client(struct ism_client *client);
>  *	identified by dmb_tok and idx. If signal flag (sf) then signal
>  *	the remote peer that data has arrived in this dmb.
>  *
>+ * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>+ *	Unregister an ism_dmb buffer
>+ *
>  * int (*supports_v2)(void);
>  *
>  * u16 (*get_chid)(struct ism_dev *dev);
>@@ -218,12 +221,63 @@ struct ism_ops {
> 	int (*reset_vlan_required)(struct ism_dev *dev);
> 	int (*signal_event)(struct ism_dev *dev, uuid_t *rgid,
> 			    u32 trigger_irq, u32 event_code, u64 info);
>+/* no copy option
>+ * --------------
>+ */
>+	/**
>+	 * support_dmb_nocopy() - does this device provide no-copy option?
>+	 * @dev: ism device
>+	 *
>+	 * In addition to using move_data(), a sender device can provide a
>+	 * kernel address + length, that represents a target dmb
>+	 * (like MMIO). If a sender writes into such a ghost-send-buffer
>+	 * (= at this kernel address) the data will automatically
>+	 * immediately appear in the target dmb, even without calling
>+	 * move_data().
>+	 * Note that this is NOT related to the MSG_ZEROCOPY socket flag.
>+	 *
>+	 * Either all 3 function pointers for support_dmb_nocopy(),
>+	 * attach_dmb() and detach_dmb() are defined, or all of them must
>+	 * be NULL.
>+	 *
>+	 * Return: non-zero, if no-copy is supported.
>+	 */
>+	int (*support_dmb_nocopy)(struct ism_dev *dev);
>+	/**
>+	 * attach_dmb() - attach local memory to a remote dmb
>+	 * @dev: Local sending ism device
>+	 * @dmb: all other parameters are passed in the form of a
>+	 *	 dmb struct
>+	 *	 TODO: (THIS IS CONFUSING, should be changed)

Agree.

>+	 *  dmb_tok: (in) Token of the remote dmb, we want to attach to
>+	 *  cpu_addr: (out) MMIO address
>+	 *  dma_addr: (out) MMIO address (if applicable, invalid otherwise)
>+	 *  dmb_len: (out) length of local MMIO region,
>+	 *           equal to length of remote DMB.
>+	 *  sba_idx: (out) index of remote dmb (NOT HELPFUL, should be removed)
>+	 *
>+	 * Provides a memory address to the sender that can be used to
>+	 * directly write into the remote dmb.
>+	 *
>+	 * Return: Zero upon success, Error code otherwise
>+	 */
>+	int (*attach_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>+	/**
>+	 * detach_dmb() - Detach the ghost buffer from a remote dmb
>+	 * @dev: ism device
>+	 * @token: dmb token of the remote dmb
>+	 * Return: Zero upon success, Error code otherwise
>+	 */
>+	int (*detach_dmb)(struct ism_dev *dev, u64 token);
> };
> 

...

>+
>+static int ism_lo_move_data(struct ism_dev *ism, u64 dmb_tok,
>+			    unsigned int idx, bool sf, unsigned int offset,
>+			    void *data, unsigned int size)
>+{
>+	struct ism_lo_dmb_node *rmb_node = NULL, *tmp_node;
>+	struct ism_lo_dev *ldev;
>+	u16 s_mask;
>+	u8 client_id;
>+	u32 sba_idx;
>+
>+	ldev = container_of(ism, struct ism_lo_dev, ism);
>+
>+	if (!sf)
>+		/* since sndbuf is merged with peer DMB, there is
>+		 * no need to copy data from sndbuf to peer DMB.
>+		 */
>+		return 0;
>+
>+	read_lock_bh(&ldev->dmb_ht_lock);
>+	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>+		if (tmp_node->token == dmb_tok) {
>+			rmb_node = tmp_node;
>+			break;
>+		}
>+	}
>+	if (!rmb_node) {
>+		read_unlock_bh(&ldev->dmb_ht_lock);
>+		return -EINVAL;
>+	}
>+	// So why copy the data now?? SMC usecase? Data buffer is attached,
>+	// rw-pointer are not attached?

I understand the confusion here. I have the same confusion the first time
I saw this.

This is actually the tricky part: it assumes the CDC will signal, while
the data will not. We need to copy the CDC, so the copy here only to the
CDC.

I think we should refine the move_data() API to make this clearer.

Best regards,
Dust

