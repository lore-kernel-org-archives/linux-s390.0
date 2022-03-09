Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1661C433EF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 07:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiCIH6s (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiCIH5h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 02:57:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23EB5167F93
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646812566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXuB3B5jDtB5OBhHstqyNyrujXVHiDK4qma1A4MbOm0=;
        b=Bs2vgeoFTJeiA/Xv0iuZS7ktCfeWz5pkq9DTEI/3kWiuGaJOdADr+rP8TEpthNbOckMqeA
        7RMwDNXz+XeZZ4+PueVMa1wV6MRuA98JKSM0gypBZw30kbrpU3IIvjxRKLYjDWRABTzx0T
        l+/KcVTsTTwyQ1ja8deHNn29mA3WlLo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-F01p-vJ0MZCo3FXC6oNDUg-1; Wed, 09 Mar 2022 02:56:05 -0500
X-MC-Unique: F01p-vJ0MZCo3FXC6oNDUg-1
Received: by mail-pj1-f70.google.com with SMTP id e14-20020a17090a684e00b001bf09ac2385so1123588pjm.1
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 23:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nXuB3B5jDtB5OBhHstqyNyrujXVHiDK4qma1A4MbOm0=;
        b=L/BWPV0YMPRfC+Fr79sUrFDdQ1gevTLgOWHOYsWFjsP1+wWQq9Lw63zA78+BOL4TuO
         2MLTIhu49HJUYpRe0F30PbluR+D+q4booHGOoO1kQE34zT5rMuzxbZ5YC2I0Rwd57zyY
         PfOTrMY9SAKT313Uungm108+FPrnvgU0fcfXYRJn7zVbkdX8S49cxznQrJuS4ZPg4h3K
         POxlKyQw7gef6K2MfAkoeYuHH805CdPqmtTfA6zcnDhfd4t0NV9X1kn+832FcTA651et
         3Bt+SjIb9zr3xvFWybbl7fv9oov0YHkMbycNb4HB4z0EWRGKzO+ALH/PGw55oqKDZTa5
         4lPw==
X-Gm-Message-State: AOAM530pQMDAle9uir7+XsvGw6FmZpiZgHizmE4fqE6ctGCDr5+Lw+G/
        nGgueaVM4N35cDaaFGJ7CIERC0jIGQp15cn2DDE9L2T0ZGijDRc0T92KiwLzrvothSCPEAlm+hA
        4PVF+tyNg6zmDBwb0tG8A+Q==
X-Received: by 2002:a17:903:32c4:b0:151:c6ae:e24b with SMTP id i4-20020a17090332c400b00151c6aee24bmr22112783plr.85.1646812563886;
        Tue, 08 Mar 2022 23:56:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybDKg7kAlq7E11Ti35K1Cy6HiZbN5h1MuN+e0cBpBT9cOyctGw5IATTQsVpIPtETRU/6u7tg==
X-Received: by 2002:a17:903:32c4:b0:151:c6ae:e24b with SMTP id i4-20020a17090332c400b00151c6aee24bmr22112759plr.85.1646812563582;
        Tue, 08 Mar 2022 23:56:03 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bd10-20020a056a00278a00b004f6fe0f4cbasm1395974pfb.101.2022.03.08.23.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 23:56:03 -0800 (PST)
Message-ID: <512de020-b36e-8473-69c8-8b3925fbb6c1@redhat.com>
Date:   Wed, 9 Mar 2022 15:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
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
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/3/8 下午8:35, Xuan Zhuo 写道:
> virtio ring supports reset.
>
> Queue reset is divided into several stages.
>
> 1. notify device queue reset
> 2. vring release
> 3. attach new vring
> 4. notify device queue re-enable
>
> After the first step is completed, the vring reset operation can be
> performed. If the newly set vring num does not change, then just reset
> the vq related value.
>
> Otherwise, the vring will be released and the vring will be reallocated.
> And the vring will be attached to the vq. If this process fails, the
> function will exit, and the state of the vq will be the vring release
> state. You can call this function again to reallocate the vring.
>
> In addition, vring_align, may_reduce_num are necessary for reallocating
> vring, so they are retained when creating vq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e0422c04c903..148fb1fd3d5a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -158,6 +158,12 @@ struct vring_virtqueue {
>   			/* DMA address and size information */
>   			dma_addr_t queue_dma_addr;
>   			size_t queue_size_in_bytes;
> +
> +			/* The parameters for creating vrings are reserved for
> +			 * creating new vrings when enabling reset queue.
> +			 */
> +			u32 vring_align;
> +			bool may_reduce_num;
>   		} split;
>   
>   		/* Available for packed ring */
> @@ -217,6 +223,12 @@ struct vring_virtqueue {
>   #endif
>   };
>   
> +static void vring_free(struct virtqueue *vq);
> +static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
> +					 struct virtio_device *vdev);
> +static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
> +					  struct virtio_device *vdev,
> +					  struct vring vring);
>   
>   /*
>    * Helpers.
> @@ -1012,6 +1024,8 @@ static struct virtqueue *vring_create_virtqueue_split(
>   		return NULL;
>   	}
>   
> +	to_vvq(vq)->split.vring_align = vring_align;
> +	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
>   	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
>   	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
>   	to_vvq(vq)->we_own_ring = true;
> @@ -1019,6 +1033,59 @@ static struct virtqueue *vring_create_virtqueue_split(
>   	return vq;
>   }
>   
> +static int virtqueue_reset_vring_split(struct virtqueue *_vq, u32 num)
> +{


So what this function does is to resize the virtqueue actually, I 
suggest to rename it as virtqueue_resize_split().


> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = _vq->vdev;
> +	struct vring_split vring;
> +	int err;
> +
> +	if (num > _vq->num_max)
> +		return -E2BIG;
> +
> +	switch (vq->vq.reset) {
> +	case VIRTIO_VQ_RESET_STEP_NONE:
> +		return -ENOENT;
> +
> +	case VIRTIO_VQ_RESET_STEP_VRING_ATTACH:
> +	case VIRTIO_VQ_RESET_STEP_DEVICE:
> +		if (vq->split.vring.num == num || !num)
> +			break;
> +
> +		vring_free(_vq);
> +
> +		fallthrough;
> +
> +	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
> +		if (!num)
> +			num = vq->split.vring.num;
> +
> +		err = vring_create_vring_split(&vring, vdev,
> +					       vq->split.vring_align,
> +					       vq->weak_barriers,
> +					       vq->split.may_reduce_num, num);
> +		if (err)
> +			return -ENOMEM;


We'd better need a safe fallback here like:

If we can't allocate new memory, we can keep using the current one. 
Otherwise an ethtool -G fail may make the device not usable.

This could be done by not freeing the old vring and virtqueue states 
until new is allocated.


> +
> +		err = __vring_virtqueue_attach_split(vq, vdev, vring.vring);
> +		if (err) {
> +			vring_free_queue(vdev, vring.queue_size_in_bytes,
> +					 vring.queue,
> +					 vring.dma_addr);
> +			return -ENOMEM;
> +		}
> +
> +		vq->split.queue_dma_addr = vring.dma_addr;
> +		vq->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> +	}
> +
> +	__vring_virtqueue_init_split(vq, vdev);
> +	vq->we_own_ring = true;


This seems wrong, we have the transport (rproc/mlxtbf) that allocate the 
vring by themselves. I think we need to fail the resize for we_own_ring 
== false.

Thanks



> +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
> +
> +	return 0;
> +}
> +
>   
>   /*
>    * Packed ring specific functions - *_packed().
> @@ -2317,6 +2384,8 @@ static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
>   static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
>   					 struct virtio_device *vdev)
>   {
> +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_NONE;
> +
>   	vq->packed_ring = false;
>   	vq->we_own_ring = false;
>   	vq->broken = false;

