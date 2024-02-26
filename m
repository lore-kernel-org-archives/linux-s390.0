Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8191CFA7
	for <linux-s390@vger.kernel.org>; Mon, 26 Feb 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948884; cv=none; b=frfIJ5ESKcEgH6Fpwm60ilnFiTo7aUiE68yJZzoYNX2vwhD76grR5qWCtSnX4ZgIJGsrUuZqMOyh4Td0cQzU8tLuE5WTxDagWU4jpTGSo7alQd9ZtENl5p4fa/HU2/R9uC4eVwm5vHC9z8F6eMeTK4mQLII5/nIdtvpn2O4TuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948884; c=relaxed/simple;
	bh=McK19Af6v3/N9WZommqpK9FjHi7QTXWoLvcSzpl2fM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkwUcd8+cFe2bL2Qr7cvrWqiQrZqrltIRfb+LM3nfraPzrBxsRli0JaS3zjhZ/9l282IqBZKvvFcoB37JPNdjw8K7THStsTUZHknx2J8cq7hG+dmsPSNmzLRjgKCGjwm7jYtN4iS0KRFvHIRGszPG8Ha0tyzELexfrwJtVik/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDBY0ehh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDBY0ehh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708948882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DyeN0/v3Twa5tvJQeLijSKNNUSSy/wGzF7QtN0/eqpw=;
	b=NDBY0ehhxVIqm5a29tm2Y4Ko95NxO7qathMBkGawgT5tYf5gL5UxW9aRNB6qx94FXSx4MX
	QA0hQKvK0RWHAUL9b1fkru5lFh/pw16NL6jPrVmVJbYekyHwNW84vNysZXv1+ujGHwtOTN
	kRnO6gPrQr8WWirxXiDTwPsh3IzXnTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Tf6mearHPn2JU95I4x2snQ-1; Mon, 26 Feb 2024 07:01:20 -0500
X-MC-Unique: Tf6mearHPn2JU95I4x2snQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d8d785b08so2134089f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 26 Feb 2024 04:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708948879; x=1709553679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyeN0/v3Twa5tvJQeLijSKNNUSSy/wGzF7QtN0/eqpw=;
        b=V7JKSSdVTZpqT/CEiBzxU1g0cYqtuhqwLOrNC7KG/f7KJ4HHJDM/rfMmntlat+sH31
         77nUWkduyJwID612qTCBJ27QQR96dCjFVqZXTxkquxLi0KHDAqoqADZjXu4UcBezJAgn
         kwgGDRh9M7maz3nKlkzNmspWd0ar7TC27y81xVA0077TrdycQUGM+oRHMp/Z2884kBOs
         W70VF1eKv8kWtthVViNXbjTrkP3X5M3VErK0pC590OIUmkp4ITwV6wiZSuvaBwtnyejD
         F3XMXlTboU19oFHkxJ5F4eXpCcTu380l9hT56cfbNctDMDhIQ5NQDG9OdGVhkYRmtt6i
         i8bA==
X-Forwarded-Encrypted: i=1; AJvYcCUsIbG3PpCbZHWXNjyaUOTj9CEM51nsxvdOk52T/JjNsx48XEvQVlB88/1Xfz/gUr4EHm0YSuokEpY9VoQqt4WkEYlzqfaOu/6xNg==
X-Gm-Message-State: AOJu0YygGJMqd6SpIexv3x/6YrBZntW71eIMjQMdYwAKnxbXnP6Cvxdw
	oGveix3Ylckljft2x+VBhNu4YlIn3pKrWd60ju2vW6xYwQzQ+EM1C9Q4tFO1JXkDa/r36VP6mG7
	AwuFhCyztSD2iw0AKpkUkRPdmsI1GwwXZIhfjX7LUz1gNFZTWbAoDdYLMK58=
X-Received: by 2002:adf:e881:0:b0:33d:274b:ffc7 with SMTP id d1-20020adfe881000000b0033d274bffc7mr4670782wrm.46.1708948879460;
        Mon, 26 Feb 2024 04:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmw2nH00Gg5CHekKCTF2ikOOQiJRkDg5Ib7rHCH7wj7zLUrW0UuriacBhFnUFAp0SN/RV5Gw==
X-Received: by 2002:adf:e881:0:b0:33d:274b:ffc7 with SMTP id d1-20020adfe881000000b0033d274bffc7mr4670765wrm.46.1708948879088;
        Mon, 26 Feb 2024 04:01:19 -0800 (PST)
Received: from redhat.com ([109.253.193.52])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b0033cf80ad6f5sm8024176wrs.60.2024.02.26.04.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:01:18 -0800 (PST)
Date: Mon, 26 Feb 2024 07:01:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-um@lists.infradead.org, netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH vhost v2 19/19] virtio_net: sq support premapped mode
Message-ID: <20240226070030-mutt-send-email-mst@kernel.org>
References: <20240223082726.52915-1-xuanzhuo@linux.alibaba.com>
 <20240223082726.52915-20-xuanzhuo@linux.alibaba.com>
 <20240225032330-mutt-send-email-mst@kernel.org>
 <1708939451.7601678-3-xuanzhuo@linux.alibaba.com>
 <20240226063843-mutt-send-email-mst@kernel.org>
 <1708947680.4503584-3-xuanzhuo@linux.alibaba.com>
 <20240226065746-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226065746-mutt-send-email-mst@kernel.org>

On Mon, Feb 26, 2024 at 07:00:09AM -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 26, 2024 at 07:41:20PM +0800, Xuan Zhuo wrote:
> > On Mon, 26 Feb 2024 06:39:51 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Feb 26, 2024 at 05:24:11PM +0800, Xuan Zhuo wrote:
> > > > On Sun, 25 Feb 2024 03:38:48 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Fri, Feb 23, 2024 at 04:27:26PM +0800, Xuan Zhuo wrote:
> > > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > > So the send queue must support premapped mode.
> > > > > >
> > > > > > cmd:
> > > > > >     sh samples/pktgen/pktgen_sample01_simple.sh -i eth0 \
> > > > > >         -s 16 -d 10.0.0.128 -m 00:16:3e:2c:c8:2e -n 0 -p 100
> > > > > > CPU:
> > > > > >     Intel(R) Xeon(R) Platinum 8369B CPU @ 2.70GHz
> > > > > >
> > > > > > Machine:
> > > > > >     ecs.g7.2xlarge(Aliyun)
> > > > > >
> > > > > > before:              1600010.00
> > > > > > after(no-premapped): 1599966.00
> > > > > > after(premapped):    1600014.00
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > > >  drivers/net/virtio_net.c | 136 +++++++++++++++++++++++++++++++++++++--
> > > > > >  1 file changed, 132 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > index 7715bb7032ec..b83ef6afc4fb 100644
> > > > > > --- a/drivers/net/virtio_net.c
> > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > @@ -146,6 +146,25 @@ struct virtnet_rq_dma {
> > > > > >  	u16 need_sync;
> > > > > >  };
> > > > > >
> > > > > > +struct virtnet_sq_dma {
> > > > > > +	union {
> > > > > > +		struct virtnet_sq_dma *next;
> > > > > > +		void *data;
> > > > > > +	};
> > > > > > +
> > > > > > +	u32 num;
> > > > > > +
> > > > > > +	dma_addr_t addr[MAX_SKB_FRAGS + 2];
> > > > > > +	u32 len[MAX_SKB_FRAGS + 2];
> > > > > > +};
> > > > > > +
> > > > > > +struct virtnet_sq_dma_head {
> > > > > > +	/* record for kfree */
> > > > > > +	void *p;
> > > > > > +
> > > > > > +	struct virtnet_sq_dma *free;
> > > > > > +};
> > > > > > +
> > > > > >  /* Internal representation of a send virtqueue */
> > > > > >  struct send_queue {
> > > > > >  	/* Virtqueue associated with this send _queue */
> > > > > > @@ -165,6 +184,8 @@ struct send_queue {
> > > > > >
> > > > > >  	/* Record whether sq is in reset state. */
> > > > > >  	bool reset;
> > > > > > +
> > > > > > +	struct virtnet_sq_dma_head dmainfo;
> > > > > >  };
> > > > > >
> > > > > >  /* Internal representation of a receive virtqueue */
> > > > > > @@ -368,6 +389,95 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
> > > > > >  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
> > > > > >  }
> > > > > >
> > > > > > +static struct virtnet_sq_dma *virtnet_sq_unmap(struct send_queue *sq, void **data)
> > > > > > +{
> > > > > > +	struct virtnet_sq_dma *d;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	d = *data;
> > > > > > +	*data = d->data;
> > > > > > +
> > > > > > +	for (i = 0; i < d->num; ++i)
> > > > > > +		virtqueue_dma_unmap_page_attrs(sq->vq, d->addr[i], d->len[i],
> > > > > > +					       DMA_TO_DEVICE, 0);
> > > > > > +
> > > > > > +	d->next = sq->dmainfo.free;
> > > > > > +	sq->dmainfo.free = d;
> > > > > > +
> > > > > > +	return d;
> > > > > > +}
> > > > > > +
> > > > > > +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq,
> > > > > > +						int nents, void *data)
> > > > > > +{
> > > > > > +	struct virtnet_sq_dma *d;
> > > > > > +	struct scatterlist *sg;
> > > > > > +	int i;
> > > > > > +
> > > > > > +	if (!sq->dmainfo.free)
> > > > > > +		return NULL;
> > > > > > +
> > > > > > +	d = sq->dmainfo.free;
> > > > > > +	sq->dmainfo.free = d->next;
> > > > > > +
> > > > > > +	for_each_sg(sq->sg, sg, nents, i) {
> > > > > > +		if (virtqueue_dma_map_sg_attrs(sq->vq, sg, DMA_TO_DEVICE, 0))
> > > > > > +			goto err;
> > > > > > +
> > > > > > +		d->addr[i] = sg->dma_address;
> > > > > > +		d->len[i] = sg->length;
> > > > > > +	}
> > > > > > +
> > > > > > +	d->data = data;
> > > > > > +	d->num = i;
> > > > > > +	return d;
> > > > > > +
> > > > > > +err:
> > > > > > +	d->num = i;
> > > > > > +	virtnet_sq_unmap(sq, (void **)&d);
> > > > > > +	return NULL;
> > > > > > +}
> > > > >
> > > > >
> > > > > Do I see a reimplementation of linux/llist.h here?
> > > > >
> > > > >
> > > > > > +
> > > > > > +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (sq->vq->premapped) {
> > > > > > +		data = virtnet_sq_map_sg(sq, num, data);
> > > > > > +		if (!data)
> > > > > > +			return -ENOMEM;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
> > > > > > +	if (ret && sq->vq->premapped)
> > > > > > +		virtnet_sq_unmap(sq, &data);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> > > > >
> > > > > Mate? The popular south african drink?
> > > > >
> > > > > > +{
> > > > > > +	struct virtnet_sq_dma *d;
> > > > > > +	int num, i;
> > > > > > +
> > > > > > +	num = virtqueue_get_vring_size(sq->vq);
> > > > > > +
> > > > > > +	sq->dmainfo.free = kcalloc(num, sizeof(*sq->dmainfo.free), GFP_KERNEL);
> > > > > > +	if (!sq->dmainfo.free)
> > > > > > +		return -ENOMEM;
> > > > >
> > > > >
> > > > > This could be quite a bit of memory for a large queue.  And for a bunch
> > > > > of common cases where unmap is a nop (e.g. iommu pt) this does nothing
> > > > > useful at all.  And also, this does nothing useful if PLATFORM_ACCESS is off
> > > > > which is super common.
> > > > >
> > > > > A while ago I proposed:
> > > > > - extend DMA APIs so one can query whether unmap is a nop
> > > >
> > > >
> > > > We may have trouble for this.
> > > >
> > > > dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
> > > > 		size_t offset, size_t size, enum dma_data_direction dir,
> > > > 		unsigned long attrs)
> > > > {
> > > > 	const struct dma_map_ops *ops = get_dma_ops(dev);
> > > > 	dma_addr_t addr;
> > > >
> > > > 	BUG_ON(!valid_dma_direction(dir));
> > > >
> > > > 	if (WARN_ON_ONCE(!dev->dma_mask))
> > > > 		return DMA_MAPPING_ERROR;
> > > >
> > > > 	if (dma_map_direct(dev, ops) ||
> > > > 	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
> > > > 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
> > > > 	else
> > > > 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
> > > > 	kmsan_handle_dma(page, offset, size, dir);
> > > > 	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
> > > >
> > > > 	return addr;
> > > > }
> > > >
> > > > arch_dma_map_page_direct will check the dma address.
> > > > So we can not judge by the API in advance.
> > > >
> > > > Thanks.
> > >
> > > So if dma_map_direct is false we'll still waste some memory.
> > > So be it.
> > 
> > arch_dma_map_page_direct default is marco (false), just for powerpc
> > it is a function. So I think we can skip it.
> > 
> > If the dma_map_direct is false, I think should save the dma info.
> > 
> > Thanks.
> 
> 
> Would already be an improvement.
> But can we have better names?
> 
> I'd prefer:
> 
> dma_can_skip_unmap
> dma_can_skip_sync
> 
> Because we do not know for sure if it's direct unless
> we have the page.

we might need to add these callbacks to dma ops too, I think
with iommu pt that is the case and it is pretty common,
right?

> -- 
> MST

