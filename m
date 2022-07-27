Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2602C3F6B0
	for <linux-s390@archiver.kernel.org>; Wed, 27 Jul 2022 03:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbiG0DFg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiG0DFf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Jul 2022 23:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4950465F7
        for <linux-s390@vger.kernel.org>; Tue, 26 Jul 2022 20:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658891132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPVjRi2laBOhHF0iGlxYnBot8C54I4jUPdsnzaNkbSA=;
        b=Ye9wPgH5MX7j6LrEmZfqvKjZEibKLJFSyJane9/shhX7Zy89gTS2XSbT9mzUcON734qkAW
        vl3FLu08aAF1MY3TM0s74XmPwUEWKPjEYZpNyhr6HM1qJFdQ654ldxhH8R7h6V8FQNtCgE
        tsTGwVcWDXQ/pJe65TcBTEHhq7l1YM4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-cvEYuFEmMdC2P-cBYc0LoQ-1; Tue, 26 Jul 2022 23:05:30 -0400
X-MC-Unique: cvEYuFEmMdC2P-cBYc0LoQ-1
Received: by mail-pg1-f198.google.com with SMTP id u64-20020a638543000000b00412b09eae15so7272412pgd.15
        for <linux-s390@vger.kernel.org>; Tue, 26 Jul 2022 20:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JPVjRi2laBOhHF0iGlxYnBot8C54I4jUPdsnzaNkbSA=;
        b=rlYddeSL5B8Pyk599GHe/wM8vt+Rekz7KQf26Tbi6j7hsMC30R7Lt187LiR8D5j4dm
         27KZmdRJbtYqMQuwagaZpOtyDw9PfREqJsOqK+CeKzeO5zlaHL2uwedlPlo7OWu6unJD
         ts0PQ015GStSzp0g33/9W73pl+gMI0xLCdB11/qAm74JNsbpKvmSlq5GJ/JskJrpvuIZ
         EAchxrkGYQuKhJMe5QGTmWzQ9wfPd2uSAgQA0GZZNolOd2SwiLyKPvekkiHhpdQm4h9V
         Yh/tHrJjuRap2JzyUlI4PI8ZZm03UHLxZqbjKM+2E21JziA4f9b/DvM824I3AmSnnczH
         6t0A==
X-Gm-Message-State: AJIora8R/n1MtqTkMiNdxkLhlOS1E1jgmnjTe/q3ymAYkCrczMAwid/w
        y27+nH0w4shaTaOPg0TnoAPNElr7IWuXzrelVehPT7J0C5HiJdDHDIp6HYXCio5AyTzAviWyWkC
        7dztNiZxvEeWyP++WkNrXew==
X-Received: by 2002:a63:8b43:0:b0:41a:668b:399a with SMTP id j64-20020a638b43000000b0041a668b399amr16859289pge.554.1658891129585;
        Tue, 26 Jul 2022 20:05:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uvlNVzsM47OO+owdTKGvivmzfNPlB+iaGP4TESyvpuwSsv3a453beLdZ4leUSPBNJBaopldw==
X-Received: by 2002:a63:8b43:0:b0:41a:668b:399a with SMTP id j64-20020a638b43000000b0041a668b399amr16859261pge.554.1658891129209;
        Tue, 26 Jul 2022 20:05:29 -0700 (PDT)
Received: from [10.72.13.38] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b0016c0c82e85csm12215069plb.75.2022.07.26.20.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 20:05:28 -0700 (PDT)
Message-ID: <0aa1a062-968b-370a-3a50-e0364914a7c4@redhat.com>
Date:   Wed, 27 Jul 2022 11:05:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 08/42] virtio_ring: split: __vring_new_virtqueue()
 accept struct vring_virtqueue_split
Content-Language: en-US
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        kangjie.xu@linux.alibaba.com
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-9-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-9-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/26 15:21, Xuan Zhuo 写道:
> __vring_new_virtqueue() instead accepts struct vring_virtqueue_split.
>
> The purpose of this is to pass more information into
> __vring_new_virtqueue() to make the code simpler and the structure
> cleaner.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4e54ed7ee7fb..4d65c437d968 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -205,7 +205,7 @@ struct vring_virtqueue {
>   };
>   
>   static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> -					       struct vring vring,
> +					       struct vring_virtqueue_split *vring_split,
>   					       struct virtio_device *vdev,
>   					       bool weak_barriers,
>   					       bool context,
> @@ -959,6 +959,7 @@ static struct virtqueue *vring_create_virtqueue_split(
>   	void (*callback)(struct virtqueue *),
>   	const char *name)
>   {
> +	struct vring_virtqueue_split vring_split = {};
>   	struct virtqueue *vq;
>   	void *queue = NULL;
>   	dma_addr_t dma_addr;
> @@ -994,10 +995,10 @@ static struct virtqueue *vring_create_virtqueue_split(
>   		return NULL;
>   
>   	queue_size_in_bytes = vring_size(num, vring_align);
> -	vring_init(&vring, num, queue, vring_align);
> +	vring_init(&vring_split.vring, num, queue, vring_align);
>   
> -	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> -				   notify, callback, name);
> +	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
> +				   context, notify, callback, name);
>   	if (!vq) {
>   		vring_free_queue(vdev, queue_size_in_bytes, queue,
>   				 dma_addr);
> @@ -2206,7 +2207,7 @@ EXPORT_SYMBOL_GPL(vring_interrupt);
>   
>   /* Only available for split ring */
>   static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> -					       struct vring vring,
> +					       struct vring_virtqueue_split *vring_split,
>   					       struct virtio_device *vdev,
>   					       bool weak_barriers,
>   					       bool context,
> @@ -2243,7 +2244,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	vq->split.queue_dma_addr = 0;
>   	vq->split.queue_size_in_bytes = 0;
>   
> -	vq->split.vring = vring;
> +	vq->split.vring = vring_split->vring;
>   	vq->split.avail_flags_shadow = 0;
>   	vq->split.avail_idx_shadow = 0;
>   
> @@ -2255,19 +2256,19 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   					vq->split.avail_flags_shadow);
>   	}
>   
> -	vq->split.desc_state = kmalloc_array(vring.num,
> +	vq->split.desc_state = kmalloc_array(vring_split->vring.num,
>   			sizeof(struct vring_desc_state_split), GFP_KERNEL);
>   	if (!vq->split.desc_state)
>   		goto err_state;
>   
> -	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
> +	vq->split.desc_extra = vring_alloc_desc_extra(vring_split->vring.num);
>   	if (!vq->split.desc_extra)
>   		goto err_extra;
>   
> -	memset(vq->split.desc_state, 0, vring.num *
> +	memset(vq->split.desc_state, 0, vring_split->vring.num *
>   			sizeof(struct vring_desc_state_split));
>   
> -	virtqueue_init(vq, vq->split.vring.num);
> +	virtqueue_init(vq, vring_split->vring.num);
>   
>   	spin_lock(&vdev->vqs_list_lock);
>   	list_add_tail(&vq->vq.list, &vdev->vqs);
> @@ -2317,14 +2318,14 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>   				      void (*callback)(struct virtqueue *vq),
>   				      const char *name)
>   {
> -	struct vring vring;
> +	struct vring_virtqueue_split vring_split = {};
>   
>   	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>   		return NULL;
>   
> -	vring_init(&vring, num, pages, vring_align);
> -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> -				     notify, callback, name);
> +	vring_init(&vring_split.vring, num, pages, vring_align);
> +	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
> +				     context, notify, callback, name);
>   }
>   EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>   

