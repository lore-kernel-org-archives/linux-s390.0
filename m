Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2E5C43217
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbiDLD3a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 23:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344479AbiDLD3Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 23:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48CB52FFD5
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649734026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n3LHty2/qeNdZWq4XVW+rsoA0rPEGbU09m2IO66/YBI=;
        b=NENEpV2hQYAMEZz4mOTNvF3AswJQNOew0tHHLLr9/HItP+cPXm/9vwTxZc54vM+V1x8W0S
        62+6SJDf7nnnIOFUtX0zUMEm7l+MBSFo2TJ5wBGvo2knCYWebOTC9BI3qbkWm4kzAWoVmq
        oP50vGI6ielyyBDfVrJw4ogPLpOSQG8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-g3cCgoDaNmK8V0pzo7UDig-1; Mon, 11 Apr 2022 23:27:04 -0400
X-MC-Unique: g3cCgoDaNmK8V0pzo7UDig-1
Received: by mail-pf1-f198.google.com with SMTP id x68-20020a623147000000b004fd8d1ed04cso10680951pfx.23
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 20:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n3LHty2/qeNdZWq4XVW+rsoA0rPEGbU09m2IO66/YBI=;
        b=hzLNFp37F9ZhO0qavxpQIVDRu26kKIinD4jfPbQ1cNbRarB7i70sxcriBa58qMVv95
         c6ja8A2MEJXseYrMz0PjdgDSXKC31cJiOicbh6JfsONVrZ1znrL311k7IrOksUPneMfH
         wZk5TLJu9GN7s7mtzdiiU43zcI/E0OrqFk+fBDU9wW6pt3gVlG1xt70Ng+Qe2Mj4Grfw
         LCsJqLucvKQYCBlTkhE1fWoH+6oIKmu/+i3RiqTt0ocaEWdS78Bvs59KedlGOJTPZeZQ
         VUM2QztrJf/1iaM1OyqcNQlK8j/IcdXRcT1WfZ6+hZzCkPZSoKDjXjLw7Cy29Q/YRFQs
         197g==
X-Gm-Message-State: AOAM533zlU73nb66tiNbEsZmKtyqbxMaxw9OZ0wbyQOeWi0Unw3Q6Sd8
        5OaXDZCef5kmnMxkAs017ZF0bNTEFH9Y8VKwgpsP+81e1krb4R1F0ETRjKIlWGxDZrP8b6cmQvY
        Q4tWR+8w1Ivr/WKnRtXAy9A==
X-Received: by 2002:a17:902:b906:b0:158:3120:3b69 with SMTP id bf6-20020a170902b90600b0015831203b69mr15871765plb.33.1649734023784;
        Mon, 11 Apr 2022 20:27:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHffDSvLUs63LGZC/1Iz9azGV9n6QX71FL6tEjgzfXt6jW1mB2ZTmIC449SS9wxUEzJSvkig==
X-Received: by 2002:a17:902:b906:b0:158:3120:3b69 with SMTP id bf6-20020a170902b90600b0015831203b69mr15871735plb.33.1649734023529;
        Mon, 11 Apr 2022 20:27:03 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm872150pjh.39.2022.04.11.20.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 20:27:02 -0700 (PDT)
Message-ID: <927ee895-84ae-fb69-c9ed-9c1836ff1d03@redhat.com>
Date:   Tue, 12 Apr 2022 11:26:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 07/32] virtio_ring: split: extract the logic of alloc
 state and extra
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
 <20220406034346.74409-8-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-8-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Separate the logic of creating desc_state, desc_extra, and subsequent
> patches will call it independently.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 72d5ae063fa0..6de67439cb57 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -198,6 +198,7 @@ struct vring_virtqueue {
>   #endif
>   };
>   
> +static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>   
>   /*
>    * Helpers.
> @@ -915,6 +916,33 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> +static int vring_alloc_state_extra_split(u32 num,
> +					 struct vring_desc_state_split **desc_state,
> +					 struct vring_desc_extra **desc_extra)
> +{
> +	struct vring_desc_state_split *state;
> +	struct vring_desc_extra *extra;
> +
> +	state = kmalloc_array(num, sizeof(struct vring_desc_state_split), GFP_KERNEL);
> +	if (!state)
> +		goto err_state;
> +
> +	extra = vring_alloc_desc_extra(num);
> +	if (!extra)
> +		goto err_extra;
> +
> +	memset(state, 0, num * sizeof(struct vring_desc_state_split));
> +
> +	*desc_state = state;
> +	*desc_extra = extra;
> +	return 0;
> +
> +err_extra:
> +	kfree(state);
> +err_state:
> +	return -ENOMEM;
> +}
> +
>   static void *vring_alloc_queue_split(struct virtio_device *vdev,
>   				     dma_addr_t *dma_addr,
>   				     u32 *n,
> @@ -2196,7 +2224,10 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   					void (*callback)(struct virtqueue *),
>   					const char *name)
>   {
> +	struct vring_desc_state_split *state;
> +	struct vring_desc_extra *extra;
>   	struct vring_virtqueue *vq;
> +	int err;
>   
>   	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>   		return NULL;
> @@ -2246,30 +2277,22 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   					vq->split.avail_flags_shadow);
>   	}
>   
> -	vq->split.desc_state = kmalloc_array(vring.num,
> -			sizeof(struct vring_desc_state_split), GFP_KERNEL);
> -	if (!vq->split.desc_state)
> -		goto err_state;
> +	err = vring_alloc_state_extra_split(vring.num, &state, &extra);


Nit: we can pass e.g &vq->split.desc_state here to avoid extra temp 
variable and assignment.

Other looks good.

Thanks


> +	if (err) {
> +		kfree(vq);
> +		return NULL;
> +	}
>   
> -	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
> -	if (!vq->split.desc_extra)
> -		goto err_extra;
> +	vq->split.desc_state = state;
> +	vq->split.desc_extra = extra;
>   
>   	/* Put everything in free lists. */
>   	vq->free_head = 0;
> -	memset(vq->split.desc_state, 0, vring.num *
> -			sizeof(struct vring_desc_state_split));
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);
>   	spin_unlock(&vdev->vqs_list_lock);
>   	return &vq->vq;
> -
> -err_extra:
> -	kfree(vq->split.desc_state);
> -err_state:
> -	kfree(vq);
> -	return NULL;
>   }
>   EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
>   

