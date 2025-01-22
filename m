Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E282135A2;
	Wed, 22 Jan 2025 15:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558462; cv=none; b=r4Va2c5fQMveqof65U6gduN6eW5IunPFha5KNJNMhCuASqiGInabsgzh838gtIO52XCMJEdt8P5rLoWz0J3scPyjVxA6EJxl588DiZ0UjwdNxAFghLqp7CQpdpFMe8JhlMTspD5oR0omGT7yeYlY5ImTUxb+rb01wxwWkd/+yCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558462; c=relaxed/simple;
	bh=jC8nq1oJyXLYvRbWcdpjD2AHEBNNEvwkIoubAmNG58Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjcCYl4GxpH7CVAp4HuMbyyMW2S2ZUSjVvfFv2yvRfSsd5yA2qiQhVxN7PsMC4q86UbBiYwATTRuUllv74kHG6QRtHnYg4jga72qLCHA1yQqt8h0W/qJAv+M6YtG94fh4opqqYL7OM57bYXO+lmhXuD5c7FPWyJsGvztmIP+UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kYaUUiNF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kYaUUiNF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737558454; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=/by4m5u8o9/xj1WUzd3QP8chPkopT3L+hDR8WT1numI=;
	b=kYaUUiNFuOoMlENAUtg82u4J8Yc0QOfN4HnliGgEApasT4k3Gv9897Gz4HpqNdPtE83vhVZ/lVta7KqSZkmp1yxnDrsIiNI+7zqJG/nINAgDmUJO95OZd/lLhJJIeaLMdbLiNYQx7LrgNU4zK+DqB2Wf/ipobGdaN9PqptkS1zI=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WO8jkJT_1737558132 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Jan 2025 23:02:13 +0800
Date: Wed, 22 Jan 2025 23:02:12 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
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
	Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 4/7] net/ism: Add kernel-doc comments for ism
 functions
Message-ID: <20250122150212.GP89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250115195527.2094320-5-wintera@linux.ibm.com>
 <20250120063241.GM89233@linux.alibaba.com>
 <ab6bef6ce04c9ddcbf22a2d0b42180ca343839bf.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab6bef6ce04c9ddcbf22a2d0b42180ca343839bf.camel@linux.ibm.com>

On 2025-01-20 11:34:21, Niklas Schnelle wrote:
>On Mon, 2025-01-20 at 14:32 +0800, Dust Li wrote:
>> On 2025-01-15 20:55:24, Alexandra Winter wrote:
>> > Note that in this RFC this patch is not complete, future versions
>> > of this patch need to contain comments for all ism_ops.
>> > Especially signal_event() and handle_event() need a good generic
>> > description.
>> > 
>> > Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>> > ---
>> > include/linux/ism.h | 115 ++++++++++++++++++++++++++++++++++++++++----
>> > 1 file changed, 105 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/include/linux/ism.h b/include/linux/ism.h
>> > index 50975847248f..bc165d077071 100644
>> > --- a/include/linux/ism.h
>> > +++ b/include/linux/ism.h
>> > @@ -13,11 +13,26 @@
>> > #include <linux/workqueue.h>
>> > #include <linux/uuid.h>
>> > 
>> > -/* The remote peer rgid can use dmb_tok to write into this buffer. */
>> > +/*
>> > + * DMB - Direct Memory Buffer
>> > + * ==========================
>> > + * An ism client provides an DMB as input buffer for a local receiving
>> > + * ism device for exactly one (remote) sending ism device. Only this
>> > + * sending device can send data into this DMB using move_data(). Sender
>> > + * and receiver can be the same device.
>> > + * TODO: Alignment and length rules (CPU and DMA). Device specific?
>> > + */
>> > struct ism_dmb {
>> > +	/* dmb_tok - Token for this dmb
>> > +	 * Used by remote sender to address this dmb.
>> > +	 * Provided by ism fabric in register_dmb().
>> > +	 * Unique per ism fabric.
>> > +	 */
>> > 	u64 dmb_tok;
>> > +	/* rgid - GID of designated remote sending device */
>> > 	u64 rgid;
>> > 	u32 dmb_len;
>> > +	/* sba_idx - Index of this DMB on this receiving device */
>> > 	u32 sba_idx;
>> > 	u32 vlan_valid;
>> > 	u32 vlan_id;
>> > @@ -25,6 +40,8 @@ struct ism_dmb {
>> > 	dma_addr_t dma_addr;
>> > };
>> > 
>> > +/* ISM event structure (currently device type specific) */
>> > +// TODO: Define and describe generic event properties
>> > struct ism_event {
>> > 	u32 type;
>> > 	u32 code;
>> > @@ -33,38 +50,89 @@ struct ism_event {
>> > 	u64 info;
>> > };
>> > 
>> > +//TODO: use enum typedef
>> > #define ISM_EVENT_DMB	0
>> > #define ISM_EVENT_GID	1
>> > #define ISM_EVENT_SWR	2
>> > 
>> > struct ism_dev;
>> > 
>> > +/*
>> > + * ISM clients
>> > + * ===========
>> > + * All ism clients have access to all ism devices
>> > + * and must provide the following functions to be called by
>> > + * ism device drivers:
>> > + */
>> > struct ism_client {
>> > +	/* client name for logging and debugging purposes */
>> > 	const char *name;
>> > +	/**
>> > +	 *  add() - add an ism device
>> > +	 *  @dev: device that was added
>> > +	 *
>> > +	 * Will be called during ism_register_client() for all existing
>> > +	 * ism devices and whenever a new ism device is registered.
>> > +	 * *dev is valid until ism_client->remove() is called.
>> > +	 */
>> > 	void (*add)(struct ism_dev *dev);
>> > +	/**
>> > +	 * remove() - remove an ism device
>> > +	 * @dev: device to be removed
>> > +	 *
>> > +	 * Will be called whenever an ism device is unregistered.
>> > +	 * Before this call the device is already inactive: It will
>> > +	 * no longer call client handlers.
>> > +	 * The client must not access *dev after this call.
>> > +	 */
>> > 	void (*remove)(struct ism_dev *dev);
>> > +	/**
>> > +	 * handle_event() - Handle control information sent by device
>> > +	 * @dev: device reporting the event
>> > +	 * @event: ism event structure
>> > +	 */
>> > 	void (*handle_event)(struct ism_dev *dev, struct ism_event *event);
>> > -	/* Parameter dmbemask contains a bit vector with updated DMBEs, if sent
>> > -	 * via ism_move_data(). Callback function must handle all active bits
>> > -	 * indicated by dmbemask.
>> > +	/**
>> > +	 * handle_irq() - Handle signalling of a DMB
>> > +	 * @dev: device owns the dmb
>> > +	 * @bit: sba_idx=idx of the ism_dmb that got signalled
>> > +	 *	TODO: Pass a priv pointer to ism_dmb instead of 'bit'(?)
>> > +	 * @dmbemask: ism signalling mask of the dmb
>> > +	 *
>> > +	 * Handle signalling of a dmb that was registered by this client
>> > +	 * for this device.
>> > +	 * The ism device can coalesce multiple signalling triggers into a
>> > +	 * single call of handle_irq(). dmbemask can be used to indicate
>> > +	 * different kinds of triggers.
>> > 	 */
>> > 	void (*handle_irq)(struct ism_dev *dev, unsigned int bit, u16 dmbemask);
>> > -	/* Private area - don't touch! */
>> > +	/* client index - provided by ism layer */
>> > 	u8 id;
>> > };
>> > 
>> > int ism_register_client(struct ism_client *client);
>> > int  ism_unregister_client(struct ism_client *client);
>> > 
>> > +//TODO: Pair descriptions with functions
>> > +/*
>> > + * ISM devices
>> > + * ===========
>> > + */
>> > /* Mandatory operations for all ism devices:
>> >  * int (*query_remote_gid)(struct ism_dev *dev, uuid_t *rgid,
>> >  *	                   u32 vid_valid, u32 vid);
>> >  *	Query whether remote GID rgid is reachable via this device and this
>> >  *	vlan id. Vlan id is only checked if vid_valid != 0.
>> > + *	Returns 0 if remote gid is reachable.
>> >  *
>> >  * int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
>> >  *			    void *client);
>> > - *	Register an ism_dmb buffer for this device and this client.
>> > + *	Allocate and register an ism_dmb buffer for this device and this client.
>> > + *	The following fields of ism_dmb must be valid:
>> > + *	rgid, dmb_len, vlan_*; Optionally:requested sba_idx (non-zero)
>> > + *	Upon return the following fields will be valid: dmb_tok, sba_idx
>> > + *		cpu_addr, dma_addr (if applicable)
>> > + *	Returns zero on success
>> >  *
>> >  * int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>> >  *	Unregister an ism_dmb buffer
>> > @@ -81,10 +149,15 @@ int  ism_unregister_client(struct ism_client *client);
>> >  * u16 (*get_chid)(struct ism_dev *dev);
>> >  *	Returns ism fabric identifier (channel id) of this device.
>> >  *	Only devices on the same ism fabric can communicate.
>> > - *	chid is unique per HW system, except for 0xFFFF, which denotes
>> > - *	an ism_loopback device that can only communicate with itself.
>> > - *	Use chid for fast negative checks, but only query_remote_gid()
>> > - *	can give a reliable positive answer.
>> > + *	chid is unique per HW system. Use chid for fast negative checks,
>> > + *	but only query_remote_gid() can give a reliable positive answer:
>> > + *	Different chid: ism is not possible
>> > + *	Same chid: ism traffic may be possible or not
>> > + *		   (e.g. different HW systems)
>> > + *	EXCEPTION: A value of 0xFFFF denotes an ism_loopback device
>> > + *		that can only communicate with itself. Use GID or
>> > + *		query_remote_gid()to determine whether sender and
>> > + *		receiver use the same ism_loopback device.
>> >  *
>> >  * struct device* (*get_dev)(struct ism_dev *dev);
>> >  *
>> > @@ -109,6 +182,28 @@ struct ism_ops {
>> > 	int (*register_dmb)(struct ism_dev *dev, struct ism_dmb *dmb,
>> > 			    struct ism_client *client);
>> > 	int (*unregister_dmb)(struct ism_dev *dev, struct ism_dmb *dmb);
>> > +	/**
>> > +	 * move_data() - write into a remote dmb
>> > +	 * @dev: Local sending ism device
>> > +	 * @dmb_tok: Token of the remote dmb
>> > +	 * @idx: signalling index
>> > +	 * @sf: signalling flag;
>> > +	 *      if true, idx will be turned on at target ism interrupt mask
>> > +	 *      and target device will be signalled, if required.
>> > +	 * @offset: offset within target dmb
>> > +	 * @data: pointer to data to be sent
>> > +	 * @size: length of data to be sent
>> > +	 *
>> > +	 * Use dev to write data of size at offset into a remote dmb
>> > +	 * identified by dmb_tok. Data is moved synchronously, *data can
>> > +	 * be freed when this function returns.
>> 
>> When considering the API, I found this comment may be incorrect.
>> 
>> IIUC, in copy mode for PCI ISM devices, the CPU only tells the
>> device to perform a DMA copy. As a result, when this function returns,
>> the device may not have completed the DMA copy.
>
>For the s390 ISM device the statement is true. The move_data() function
>does a PCI Store Block instruction which is both the write on the
>sender side but also synchronously acts as the devices DMA write on the
>receiver side. So when the PCI Store Block instruction completes the
>data has been cache coherently written to the receiver DMB. And yes
>full synchronicity would be impossible with the posted writes of real
>PCIe.

Thank you guys for the detail explaination on s390! I throught it was
like normal PCI device. @Niklas, @Alexandra, @Julian


>
>That said when it comes to API design I think you have a great point
>here in that we need to decide if this synchronicity should be baked
>into the move_data() API. I think we instead want to only guarantee a
>weaker rule. That is the source buffer can be re-used after the move.
>This to me is also aligned with the word "move" here in that the data
>has been moved after the call not registered to be moved or such. This
>could be achieved with a real PCIe device by copying the data or by
>waiting on completion. If we ever get devices which need to wait on
>completion it may indeed be better to have a separate completion step
>in the API too. Then again I think the concept of having a single "move
>data" step is somewhat central to ISM and I'd hate to lose that
>simplicity.

Agree.

For SMC, it already handles zero-copy and copy modes differently. In
copy mode, the current API seems appropriate, but for zero-copy mode, we
may need to extend it.

Taking the loopback device as an example, SMC requires the move_data()
function to copy the CDC into the DMB. However, copying the data from
the source to the destination DMB is not necessary. Instead, it needs to
signal the peer that the data transfer is complete, so an API for
notification is required.

One solution might be to retain the move_data() function and introduce
something like a notify() API. Alternatively, if we don't want to extend
the API, we could use something like move_data(ismdev, data=NULL,
length=0, ..., signal=1).


>
>I've been thinking also about a possible copy mode in a virtio-ism.
>That could be useful if we wanted to use virtio-ism between memory
>partitioned guests, or if one wanted to transparently proxy virtio-ism
>over s390 ISM to span multiple KVM hosts. And I think such a mode could
>still work with a single "move data" step and I'd love to have that in
>any future virtio-ism spec.

I'm not opposed to that.

>
>> 
>> In zero-copy mode for loopback, the source and destination share the
>> same buffer. If the source rewrites the buffer, the destination may
>> encounter corrupted data. The source should only reuse the data after
>> the destination has finished reading it.
>
>I think there are two potential overwrite scenarios here.
>
>1. The sender re-uses the source data buffer i.e. the @data buffer of
>the move_data() call. On s390 ISM this is fine because the data was
>copied out and into the destination DMB during the call. This could
>typically become an issue if the device DMA reads directly from @data
>after the move_data() call completed.
>
>2. The sender does subsequent move_data() overwriting data in the
>destination DMB before the receiver has read the data. This can happen
>on s390 ISM too and needs to be prevented by DMB access rules.
>
>For the move_data() call I think that even in a "shared i.e. same page
>DMB" scenario move_data() must still do a copy out of the @data buffer
>into the shared DMB. Otherwise it really wouldn't "move" data and it
>would be a very weird API since @data is just a buffer not some kind of
>descriptor. In other words I think scenario 1 shouldn't be possible in
>either copy or shared DMB mode by the semantics of move_data().

For the shared DMB, I now agree with you. Perhaps we can keep the
move_data() behavior consistent with memcpy(3) or memmove(3) and leave
the usage to the upper layer.

Best regards,
Dust

