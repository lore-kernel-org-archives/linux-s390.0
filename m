Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9F224EA;
	Mon, 20 Jan 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354774; cv=none; b=iIlutqCRORsylhmBaTSriWf2xtCvnF/req8+j5LrDCSELh5QKGFcQLPYj/zh2ZPgLaJwDAMl/j1uDWTX7la26eyxoOU0UfNJNR/4C9bcF1D9ZhJeGcHa44dF19K7Mc+HBuxgWwjaf7R8kfAusv7CfaPSH3s+Qh3bGB4+zJMerOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354774; c=relaxed/simple;
	bh=+rzRrW49d+0vzw/VJh7mnnjkzGfoWccTrLWlfvt8hIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iagcig+c8bhI/oEBZN6l6gBZPrUfKsuV2xR8SoRxsYfRfbdoSVEToh1U4PXCpKUJsAx7IuQ3KRaN9m2D87llSFdV0MCiVXNcIn+K3RAu8YfS1n5GaE+bMxhZwAsDFLx9mNcT4XyA8wh8BRiW2TjPhhuQZzvqdM8Dhh9jzpOGzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GbRo1uVj; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GbRo1uVj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737354762; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0baVSBDATuTdOibmyOakU1h20UHdaWrS82DlyHLtn0M=;
	b=GbRo1uVjePScuDiKNseIfj8VNQqdc2W3XeTrN3nJM1uqTJ20hlgzXmdTVgdsXyi9XJj1ggEv+5gcOhEfE+924KKzgf+EOMj9pfoQC/YFRYGwscFcvjGdGd5+t8LhxODZqf5vNZAPsnCjJYi7V5N+mnU1oqI+cqKMDAYd65RA4U0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WNwoTCF_1737354761 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 14:32:41 +0800
Date: Mon, 20 Jan 2025 14:32:41 +0800
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
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
Message-ID: <20250120063241.GM89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-5-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115195527.2094320-5-wintera@linux.ibm.com>

On 2025-01-15 20:55:24, Alexandra Winter wrote:
>Note that in this RFC this patch is not complete, future versions
>of this patch need to contain comments for all ism_ops.
>Especially signal_event() and handle_event() need a good generic
>description.
>
>Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>---
> include/linux/ism.h | 115 ++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 105 insertions(+), 10 deletions(-)
>
>diff --git a/include/linux/ism.h b/include/linux/ism.h
>index 50975847248f..bc165d077071 100644
>--- a/include/linux/ism.h
>+++ b/include/linux/ism.h
>@@ -13,11 +13,26 @@
> #include <linux/workqueue.h>
> #include <linux/uuid.h>
> 
>-/* The remote peer rgid can use dmb_tok to write into this buffer. */
>+/*
>+ * DMB - Direct Memory Buffer
>+ * ==========================
>+ * An ism client provides an DMB as input buffer for a local receiving
>+ * ism device for exactly one (remote) sending ism device. Only this
>+ * sending device can send data into this DMB using move_data(). Sender
>+ * and receiver can be the same device.
>+ * TODO: Alignment and length rules (CPU and DMA). Device specific?
>+ */
> struct ism_dmb {
>+	/* dmb_tok - Token for this dmb
>+	 * Used by remote sender to address this dmb.
>+	 * Provided by ism fabric in register_dmb().
>+	 * Unique per ism fabric.
>+	 */
> 	u64 dmb_tok;
>+	/* rgid - GID of designated remote sending device */
> 	u64 rgid;
> 	u32 dmb_len;
>+	/* sba_idx - Index of this DMB on this receiving device */
> 	u32 sba_idx;
> 	u32 vlan_valid;
> 	u32 vlan_id;
>@@ -25,6 +40,8 @@ struct ism_dmb {
> 	dma_addr_t dma_addr;
> };
> 
>+/* ISM event structure (currently device type specific) */
>+// TODO: Define and describe generic event properties
> struct ism_event {
> 	u32 type;
> 	u32 code;
>@@ -33,38 +50,89 @@ struct ism_event {
> 	u64 info;
> };
> 
>+//TODO: use enum typedef
> #define ISM_EVENT_DMB	0
> #define ISM_EVENT_GID	1
> #define ISM_EVENT_SWR	2
> 
> struct ism_dev;
> 
>+/*
>+ * ISM clients
>+ * ===========
>+ * All ism clients have access to all ism devices
>+ * and must provide the following functions to be called by
>+ * ism device drivers:
>+ */
> struct ism_client {
>+	/* client name for logging and debugging purposes */
> 	const char *name;
>+	/**
>+	 *  add() - add an ism device
>+	 *  @dev: device that was added
>+	 *
>+	 * Will be called during ism_register_client() for all existing
>+	 * ism devices and whenever a new ism device is registered.
>+	 * *dev is valid until ism_client->remove() is called.
>+	 */
> 	void (*add)(struct ism_dev *dev);
>+	/**
>+	 * remove() - remove an ism device
>+	 * @dev: device to be removed
>+	 *
>+	 * Will be called whenever an ism device is unregistered.
>+	 * Before this call the device is already inactive: It will
>+	 * no longer call client handlers.
>+	 * The client must not access *dev after this call.
>+	 */
> 	void (*remove)(struct ism_dev *dev);
>+	/**
>+	 * handle_event() - Handle control information sent by device
>+	 * @dev: device reporting the event
>+	 * @event: ism event structure
>+	 */
> 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
>-	/* Parameter dmbemask contains a bit vector with updated DMBEs, if sent
>-	 * via ism_move_data(). Callback function must handle all active bits
>-	 * indicated by dmbemask.
>+	/**
>+	 * handle_irq() - Handle signalling of a DMB
>+	 * @dev: device owns the dmb
>+	 * @bit: sba_idx=idx of the ism_dmb that got signalled
>+	 *	TODO: Pass a priv pointer to ism_dmb instead of 'bit'(?)
>+	 * @dmbemask: ism signalling mask of the dmb
>+	 *
>+	 * Handle signalling of a dmb that was registered by this client
>+	 * for this device.
>+	 * The ism device can coalesce multiple signalling triggers into a
>+	 * single call of handle_irq(). dmbemask can be used to indicate
>+	 * different kinds of triggers.
> 	 */
> 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
>-	/* Private area - don't touch! */
>+	/* client index - provided by ism layer */
> 	u8 id;
> };
> 
> int ism_register_client(struct ism_client *client);
> int  ism_unregister_client(struct ism_client *client);
> 
>+//TODO: Pair descriptions with functions
>+/*
>+ * ISM devices
>+ * ===========
>+ */
> /* Mandatory operations for all ism devices:
>  * int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
>  *	                   u32 vid_valid, u32 vid);
>  *	Query whether remote GID rgid is reachable via this device and this
>  *	vlan id. Vlan id is only checked if vid_valid != 0.
>+ *	Returns 0 if remote gid is reachable.
>  *
>  * int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
>  *			    void *client);
>- *	Register an ism_dmb buffer for this device and this client.
>+ *	Allocate and register an ism_dmb buffer for this device and this client.
>+ *	The following fields of ism_dmb must be valid:
>+ *	rgid, dmb_len, vlan_*; Optionally:requested sba_idx (non-zero)
>+ *	Upon return the following fields will be valid: dmb_tok, sba_idx
>+ *		cpu_addr, dma_addr (if applicable)
>+ *	Returns zero on success
>  *
>  * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>  *	Unregister an ism_dmb buffer
>@@ -81,10 +149,15 @@ int  ism_unregister_client(struct ism_client *client);
>  * u16 (*get_chid)(struct ism_dev *dev);
>  *	Returns ism fabric identifier (channel id) of this device.
>  *	Only devices on the same ism fabric can communicate.
>- *	chid is unique per HW system, except for 0xFFFF, which denotes
>- *	an ism_loopback device that can only communicate with itself.
>- *	Use chid for fast negative checks, but only query_remote_gid()
>- *	can give a reliable positive answer.
>+ *	chid is unique per HW system. Use chid for fast negative checks,
>+ *	but only query_remote_gid() can give a reliable positive answer:
>+ *	Different chid: ism is not possible
>+ *	Same chid: ism traffic may be possible or not
>+ *		   (e.g. different HW systems)
>+ *	EXCEPTION: A value of 0xFFFF denotes an ism_loopback device
>+ *		that can only communicate with itself. Use GID or
>+ *		query_remote_gid()to determine whether sender and
>+ *		receiver use the same ism_loopback device.
>  *
>  * struct device* (*get_dev)(struct ism_dev *dev);
>  *
>@@ -109,6 +182,28 @@ struct ism_ops {
> 	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
> 			    struct ism_client *client);
> 	int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>+	/**
>+	 * move_data() - write into a remote dmb
>+	 * @dev: Local sending ism device
>+	 * @dmb_tok: Token of the remote dmb
>+	 * @idx: signalling index
>+	 * @sf: signalling flag;
>+	 *      if true, idx will be turned on at target ism interrupt mask
>+	 *      and target device will be signalled, if required.
>+	 * @offset: offset within target dmb
>+	 * @data: pointer to data to be sent
>+	 * @size: length of data to be sent
>+	 *
>+	 * Use dev to write data of size at offset into a remote dmb
>+	 * identified by dmb_tok. Data is moved synchronously, *data can
>+	 * be freed when this function returns.

When considering the API, I found this comment may be incorrect.

IIUC, in copy mode for PCI ISM devices, the CPU only tells the
device to perform a DMA copy. As a result, when this function returns,
the device may not have completed the DMA copy.

In zero-copy mode for loopback, the source and destination share the
same buffer. If the source rewrites the buffer, the destination may
encounter corrupted data. The source should only reuse the data after
the destination has finished reading it.

Best regards,
Dust

>+	 *
>+	 * If signalling flag (sf) is true, bit number idx bit will be
>+	 * turned on in the ism signalling mask, that belongs to the
>+	 * target dmb, and handle_irq() of the ism client that owns this
>+	 * dmb will be called, if required. The target device may chose to
>+	 * coalesce multiple signalling triggers.
>+	 */
> 	int (*move_data)(struct ism_dev *dev, u64 dmb_tok, unsigned int idx,
> 			 bool sf, unsigned int offset, void *data,
> 			 unsigned int size);
>-- 
>2.45.2
>
