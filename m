Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED65C4332F
	for <linux-s390@archiver.kernel.org>; Thu, 10 Mar 2022 13:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiCJNFj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242270AbiCJNFi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 08:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4796314ACB8
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646917476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bdyc38wZ2iH9r3WKn+t93MmqB7rhoqJHCNg2E4+WN7U=;
        b=SpEFkZV/zuSBLNW8fJmhMLfrDvIjSwHymuv1ZMoL918rp13XovnL7A5lI9zLVaARMwDDnj
        XkRR7Xo6BCX11czI383MreDHa6TLGpqNouK2l1tP5aovX8BNlZrk6qojnFbtcyQPB2Vtbw
        VX6B22kxhOVzZ7hUJTHa+f7qpP5LT4M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-i2OXtMYrOFOPyWygkVot3Q-1; Thu, 10 Mar 2022 08:04:35 -0500
X-MC-Unique: i2OXtMYrOFOPyWygkVot3Q-1
Received: by mail-wr1-f71.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so1670387wri.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Mar 2022 05:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdyc38wZ2iH9r3WKn+t93MmqB7rhoqJHCNg2E4+WN7U=;
        b=nvrQ6IRqXHYj95Xleflmri2yJO8tvB7aa5POVIfFPSOBJUrGhrI2MtIhxYF2klNGGA
         Dm1ojvDoS4/sCTCVzhRxH4ZxjSkyNR3REGgZSokyqrMqQsaNLzi5U4DAhirjkjGd9je+
         zRjYiVeclG4GqjD4vQOP/tjE3x9rn2fAPv+OAZG3/ZKg/r3Uc6SL7fYrlbrQHG03tC2K
         B3TgNLQHf7jAjwcp5omEmFV7eOvfcfHS70n2NOBtHSkCoN5PacynXgO81O6XzPx8JX3O
         yQZL+DWZWrh9uW/7Do2oENhSkc+B2LpH92a95eyCi54cgkCF6KJeCMGQOYagssphwkmh
         eshA==
X-Gm-Message-State: AOAM530MSruDGRmgSa2ByYufgZ1kZy/pbqYwbecCTfcFEL2mSOwXmh9b
        gpOmDk0Sgt6S1zm6+6N1r5830RYB0tAGUS1+S5ulIJyzLWxy3h+EHUGIXvDA67cypl2JWtUaMnW
        /BHdtyVLsO54FAQErymOYjA==
X-Received: by 2002:adf:de8b:0:b0:203:7a51:9cd2 with SMTP id w11-20020adfde8b000000b002037a519cd2mr3317892wrl.596.1646917473921;
        Thu, 10 Mar 2022 05:04:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFfnvrAlCV1H1HX6YvfASjcXGHtL+mw46jnJLY1T+Nd4lSI9nkDqnoZvkqahCBW9kDpy9wvg==
X-Received: by 2002:adf:de8b:0:b0:203:7a51:9cd2 with SMTP id w11-20020adfde8b000000b002037a519cd2mr3317878wrl.596.1646917473640;
        Thu, 10 Mar 2022 05:04:33 -0800 (PST)
Received: from redhat.com ([2.53.27.107])
        by smtp.gmail.com with ESMTPSA id u10-20020adfa18a000000b001f04c24afe7sm4182953wru.41.2022.03.10.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:04:32 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:04:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Message-ID: <20220310080212-mutt-send-email-mst@kernel.org>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
 <20220310015418-mutt-send-email-mst@kernel.org>
 <1646896623.3794115-2-xuanzhuo@linux.alibaba.com>
 <20220310025930-mutt-send-email-mst@kernel.org>
 <1646900056.7775025-1-xuanzhuo@linux.alibaba.com>
 <20220310071335-mutt-send-email-mst@kernel.org>
 <1646915610.3936472-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646915610.3936472-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 10, 2022 at 08:33:30PM +0800, Xuan Zhuo wrote:
> On Thu, 10 Mar 2022 07:17:09 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Mar 10, 2022 at 04:14:16PM +0800, Xuan Zhuo wrote:
> > > On Thu, 10 Mar 2022 03:07:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Mar 10, 2022 at 03:17:03PM +0800, Xuan Zhuo wrote:
> > > > > On Thu, 10 Mar 2022 02:00:39 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Tue, Mar 08, 2022 at 08:35:01PM +0800, Xuan Zhuo wrote:
> > > > > > > virtio ring supports reset.
> > > > > > >
> > > > > > > Queue reset is divided into several stages.
> > > > > > >
> > > > > > > 1. notify device queue reset
> > > > > > > 2. vring release
> > > > > > > 3. attach new vring
> > > > > > > 4. notify device queue re-enable
> > > > > > >
> > > > > > > After the first step is completed, the vring reset operation can be
> > > > > > > performed. If the newly set vring num does not change, then just reset
> > > > > > > the vq related value.
> > > > > > >
> > > > > > > Otherwise, the vring will be released and the vring will be reallocated.
> > > > > > > And the vring will be attached to the vq. If this process fails, the
> > > > > > > function will exit, and the state of the vq will be the vring release
> > > > > > > state. You can call this function again to reallocate the vring.
> > > > > > >
> > > > > > > In addition, vring_align, may_reduce_num are necessary for reallocating
> > > > > > > vring, so they are retained when creating vq.
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
> > > > > > >  1 file changed, 69 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > > > index e0422c04c903..148fb1fd3d5a 100644
> > > > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > > > @@ -158,6 +158,12 @@ struct vring_virtqueue {
> > > > > > >  			/* DMA address and size information */
> > > > > > >  			dma_addr_t queue_dma_addr;
> > > > > > >  			size_t queue_size_in_bytes;
> > > > > > > +
> > > > > > > +			/* The parameters for creating vrings are reserved for
> > > > > > > +			 * creating new vrings when enabling reset queue.
> > > > > > > +			 */
> > > > > > > +			u32 vring_align;
> > > > > > > +			bool may_reduce_num;
> > > > > > >  		} split;
> > > > > > >
> > > > > > >  		/* Available for packed ring */
> > > > > > > @@ -217,6 +223,12 @@ struct vring_virtqueue {
> > > > > > >  #endif
> > > > > > >  };
> > > > > > >
> > > > > > > +static void vring_free(struct virtqueue *vq);
> > > > > > > +static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
> > > > > > > +					 struct virtio_device *vdev);
> > > > > > > +static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
> > > > > > > +					  struct virtio_device *vdev,
> > > > > > > +					  struct vring vring);
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Helpers.
> > > > > > > @@ -1012,6 +1024,8 @@ static struct virtqueue *vring_create_virtqueue_split(
> > > > > > >  		return NULL;
> > > > > > >  	}
> > > > > > >
> > > > > > > +	to_vvq(vq)->split.vring_align = vring_align;
> > > > > > > +	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
> > > > > > >  	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
> > > > > > >  	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> > > > > > >  	to_vvq(vq)->we_own_ring = true;
> > > > > > > @@ -1019,6 +1033,59 @@ static struct virtqueue *vring_create_virtqueue_split(
> > > > > > >  	return vq;
> > > > > > >  }
> > > > > > >
> > > > > > > +static int virtqueue_reset_vring_split(struct virtqueue *_vq, u32 num)
> > > > > > > +{
> > > > > > > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > > > > > > +	struct virtio_device *vdev = _vq->vdev;
> > > > > > > +	struct vring_split vring;
> > > > > > > +	int err;
> > > > > > > +
> > > > > > > +	if (num > _vq->num_max)
> > > > > > > +		return -E2BIG;
> > > > > > > +
> > > > > > > +	switch (vq->vq.reset) {
> > > > > > > +	case VIRTIO_VQ_RESET_STEP_NONE:
> > > > > > > +		return -ENOENT;
> > > > > > > +
> > > > > > > +	case VIRTIO_VQ_RESET_STEP_VRING_ATTACH:
> > > > > > > +	case VIRTIO_VQ_RESET_STEP_DEVICE:
> > > > > > > +		if (vq->split.vring.num == num || !num)
> > > > > > > +			break;
> > > > > > > +
> > > > > > > +		vring_free(_vq);
> > > > > > > +
> > > > > > > +		fallthrough;
> > > > > > > +
> > > > > > > +	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
> > > > > > > +		if (!num)
> > > > > > > +			num = vq->split.vring.num;
> > > > > > > +
> > > > > > > +		err = vring_create_vring_split(&vring, vdev,
> > > > > > > +					       vq->split.vring_align,
> > > > > > > +					       vq->weak_barriers,
> > > > > > > +					       vq->split.may_reduce_num, num);
> > > > > > > +		if (err)
> > > > > > > +			return -ENOMEM;
> > > > > > > +
> > > > > > > +		err = __vring_virtqueue_attach_split(vq, vdev, vring.vring);
> > > > > > > +		if (err) {
> > > > > > > +			vring_free_queue(vdev, vring.queue_size_in_bytes,
> > > > > > > +					 vring.queue,
> > > > > > > +					 vring.dma_addr);
> > > > > > > +			return -ENOMEM;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		vq->split.queue_dma_addr = vring.dma_addr;
> > > > > > > +		vq->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	__vring_virtqueue_init_split(vq, vdev);
> > > > > > > +	vq->we_own_ring = true;
> > > > > > > +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > I kind of dislike this state machine.
> > > > > >
> > > > > > Hacks like special-casing num = 0 to mean "reset" are especially
> > > > > > confusing.
> > > > >
> > > > > I'm removing it. I'll say in the function description that this function is
> > > > > currently only called when vq has been reset. I'm no longer checking it based on
> > > > > state.
> > > > >
> > > > > >
> > > > > > And as Jason points out, when we want a resize then yes this currently
> > > > > > implies reset but that is an implementation detail.
> > > > > >
> > > > > > There should be a way to just make these cases separate functions
> > > > > > and then use them to compose consistent external APIs.
> > > > >
> > > > > Yes, virtqueue_resize_split() is fine for ethtool -G.
> > > > >
> > > > > But in the case of AF_XDP, just execute reset to free the buffer. The name
> > > > > virtqueue_reset_vring_split() I think can cover both cases. Or we use two apis
> > > > > to handle both scenarios?
> > > > >
> > > > > Or can anyone think of a better name. ^_^
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > I'd say resize should be called resize and reset should be called reset.
> > >
> > >
> > > OK, I'll change it to resize here.
> > >
> > > But I want to know that when I implement virtio-net to support AF_XDP, its
> > > requirement is to release all submitted buffers. Then should I add a new api
> > > such as virtqueue_reset_vring()?
> >
> > Sounds like a reasonable name.
> >
> > > >
> > > > The big issue is a sane API for resize. Ideally it would resubmit
> > > > buffers which did not get used. Question is what to do
> > > > about buffers which don't fit (if ring has been downsized)?
> > > > Maybe a callback that will handle them?
> > > > And then what? Queue them up and readd later? Drop?
> > > > If we drop we should drop from the head not the tail ...
> > >
> > > It's a good idea, let's implement it later.
> > >
> > > Thanks.
> >
> > Well ... not sure how you are going to support resize
> > if you don't know what to do with buffers that were
> > in the ring.
> 
> The current solution is to call virtqueue_detach_unused_buf() to release buffers
> before resize ring.
> 
> Thanks.

This requires basically a richer api:
- stop
- detach
- resize
- start

with a callback you would just have a resize, and the fact
it resets internally becomes an implementation detail.

-- 
MST

