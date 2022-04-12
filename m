Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9BC4332F
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 03:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344986AbiDLDpE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiDLDpD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 23:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C752E08A
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 20:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649734964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/OsiNJ9A/eOeLohaa+XnOAzDTM4dK3oraaYOkfTH1I=;
        b=Dew50VFpMTJZvW4Y/77ndZDBMolOMm3zuArHEzmtLF214aWQ8vG9W+TvEs7SqXyh+BFniL
        pYZkmBhtOo7Z4/H6JM1GX/Wgk6k53XHDVjo8QUsNI9MzKK4vB/nj9AIIgNUs1dME8+eFc7
        W4MVmWBjDOqiIPWNSsNxJITbsmCvC9Q=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-2EswoL6XNO-Xd0NYRxgAIw-1; Mon, 11 Apr 2022 23:42:43 -0400
X-MC-Unique: 2EswoL6XNO-Xd0NYRxgAIw-1
Received: by mail-pg1-f198.google.com with SMTP id 199-20020a6307d0000000b0039d99823fafso258590pgh.8
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 20:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e/OsiNJ9A/eOeLohaa+XnOAzDTM4dK3oraaYOkfTH1I=;
        b=P29g2Nc5DT+sjtEH7oPuMPLioCngNPeykvTzF7lD1hXn/7ztr9D/+M+ENynXEvbhM8
         secE6nam+5cAisfqruEOGvm93hjm1sfkHRa8wO5ZgMWpJ0ArgCSM8T40BTGQvXTG6cll
         Mvj8MtfBnA7aurmjsNOWgF2ngafxgisvMivPT9cTDzoYd2dmz3xFTQVqqLdDd3vJy2Gs
         brlivUQNLJWVqNNjRLA3zJNjZjF3JdHqFRwJDEfpUkXm9ewR7OlfxiluoLWJLPzwpK8t
         jIVXECR9eZjmNXLjcsv4WJHwBt8oIj8M0b8+VP3b3Zqi/HsjSJkaHnkGeYd1P/iQY+Bz
         h+Lg==
X-Gm-Message-State: AOAM531mtIggNOPKnWoxXcJpi2EWEH2ioMYSJxLYW4BcTXHB/JwMwCa9
        vpNnPShmIBsghBjzhH1/40BPxVfREHWaKMAs0bp101FP+mYKSlKsdyMcMli3aIly3G47C/7BtyX
        5e+gROqoV6YM8YIL4b6uFnA==
X-Received: by 2002:a17:902:d641:b0:158:7b09:a597 with SMTP id y1-20020a170902d64100b001587b09a597mr1464278plh.38.1649734962142;
        Mon, 11 Apr 2022 20:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMq3ocoOmI2KUnRkjYaMPOtPHjUJwi0YEpLw+I2/CAUycWFX4s/+dC2J75Q6+K+XriTggTwA==
X-Received: by 2002:a17:902:d641:b0:158:7b09:a597 with SMTP id y1-20020a170902d64100b001587b09a597mr1464238plh.38.1649734961868;
        Mon, 11 Apr 2022 20:42:41 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm1090853pgj.52.2022.04.11.20.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 20:42:41 -0700 (PDT)
Message-ID: <f91435e4-6559-c0c9-2b37-92084c88dee2@redhat.com>
Date:   Tue, 12 Apr 2022 11:42:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 09/32] virtio_ring: split: extract the logic of vq init
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-10-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-10-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Separate the logic of initializing vq, and subsequent patches will call
> it separately.
>
> The feature of this part is that it does not depend on the information
> passed by the upper layer and can be called repeatedly.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 68 ++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 083f2992ba0d..874f878087a3 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -916,6 +916,43 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> +static void vring_virtqueue_init_split(struct vring_virtqueue *vq,
> +				       struct virtio_device *vdev,
> +				       bool own_ring)
> +{
> +	vq->packed_ring = false;
> +	vq->vq.num_free = vq->split.vring.num;
> +	vq->we_own_ring = own_ring;
> +	vq->broken = false;
> +	vq->last_used_idx = 0;
> +	vq->event_triggered = false;
> +	vq->num_added = 0;
> +	vq->use_dma_api = vring_use_dma_api(vdev);
> +#ifdef DEBUG
> +	vq->in_use = false;
> +	vq->last_add_time_valid = false;
> +#endif
> +
> +	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +
> +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> +		vq->weak_barriers = false;
> +
> +	vq->split.avail_flags_shadow = 0;
> +	vq->split.avail_idx_shadow = 0;
> +
> +	/* No callback?  Tell other side not to bother us. */
> +	if (!vq->vq.callback) {
> +		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
> +					vq->split.avail_flags_shadow);
> +	}
> +
> +	/* Put everything in free lists. */
> +	vq->free_head = 0;


It's not clear what kind of initialization that we want to do here. E.g 
it mixes split specific setups with some general setups which is kind of 
duplication of vring_virtqueue_init_packed().

I wonder if it's better to only do split specific setups here and have a 
common helper to do the setup that is irrelevant to ring layout.

Thanks


> +}
> +
>   static void vring_virtqueue_attach_split(struct vring_virtqueue *vq,
>   					 struct vring vring,
>   					 struct vring_desc_state_split *desc_state,
> @@ -2249,42 +2286,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	if (!vq)
>   		return NULL;
>   
> -	vq->packed_ring = false;
>   	vq->vq.callback = callback;
>   	vq->vq.vdev = vdev;
>   	vq->vq.name = name;
> -	vq->vq.num_free = vring.num;
>   	vq->vq.index = index;
> -	vq->we_own_ring = false;
>   	vq->notify = notify;
>   	vq->weak_barriers = weak_barriers;
> -	vq->broken = false;
> -	vq->last_used_idx = 0;
> -	vq->event_triggered = false;
> -	vq->num_added = 0;
> -	vq->use_dma_api = vring_use_dma_api(vdev);
> -#ifdef DEBUG
> -	vq->in_use = false;
> -	vq->last_add_time_valid = false;
> -#endif
>   
>   	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>   		!context;
> -	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> -
> -	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> -		vq->weak_barriers = false;
> -
> -	vq->split.avail_flags_shadow = 0;
> -	vq->split.avail_idx_shadow = 0;
> -
> -	/* No callback?  Tell other side not to bother us. */
> -	if (!callback) {
> -		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
> -					vq->split.avail_flags_shadow);
> -	}
>   
>   	err = vring_alloc_state_extra_split(vring.num, &state, &extra);
>   	if (err) {
> @@ -2293,9 +2303,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	}
>   
>   	vring_virtqueue_attach_split(vq, vring, state, extra);
> -
> -	/* Put everything in free lists. */
> -	vq->free_head = 0;
> +	vring_virtqueue_init_split(vq, vdev, false);
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);

