Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173DC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiCIHwi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCIHwg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 02:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0890315E6FC
        for <linux-s390@vger.kernel.org>; Tue,  8 Mar 2022 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646812297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8EooiEDUIiNqsLqksX/5gFpvlfrwnXfbsnSG7xyKFRM=;
        b=WbLjoaHEUmFA517eiWLah8J7TamEmzDw7yrH4elF2S9aBwXPYeObr20kb3Ja2UbVhWiQpK
        Y7fmpYpvoB32m8Exaggq79+kdi4HNShMiB14xL5PK/VF0KfpTb/l+UDaOdZSIHx0XtRlEq
        VuAg8LrJ2h4ZvaWEIndeD6w77dvOR8I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-9rwpz47jPhWY0ULAfg_kPQ-1; Wed, 09 Mar 2022 02:51:35 -0500
X-MC-Unique: 9rwpz47jPhWY0ULAfg_kPQ-1
Received: by mail-pj1-f69.google.com with SMTP id p8-20020a17090a74c800b001bf257861efso3300086pjl.6
        for <linux-s390@vger.kernel.org>; Tue, 08 Mar 2022 23:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8EooiEDUIiNqsLqksX/5gFpvlfrwnXfbsnSG7xyKFRM=;
        b=lsHlBCLNLhUq18r/6m8n6gEe+BX1v/I6QNNNT89YoLBMYFv7kZitEWin+mqfYeYnpT
         GHZ7LpnHP43Se74IakgKlf4N3NsDLPWfThfhuUwMROqrGhfGUus6zdeiJfPdjoXb2lSg
         yplerX2pDh/WsDRalnStTFMLRX6Dyj579IvvpwUnqP2zuZC/gVexMP9gnk+BhHpwFHcZ
         IRIt4bVm/O+PPbYtk0sFlnLalwbUWP3jDVs+TRbHwXiGRA+YcM/78lN3nStqpWxu9w8R
         QRT993Bw4bI6f9BqzkZxOcVoArpSZa061lTw9GPwqoSrXBBU0WwoIzEzPJ4Mh1bKxDak
         p1Og==
X-Gm-Message-State: AOAM532mc/RbaX2Th+jpX+XxmUCLZaAex3LEO+/Max21KsszULWMcKAd
        MuNR2ORVnceuvGYuEksCfTzoN8L6XzM9Mtg+B9f9hKa1ls0V2MA6uRrJAc3tdAfizDjj6+31l+Y
        sGbmd3PDJBoov99hOmpHodA==
X-Received: by 2002:a05:6a00:1aca:b0:4e1:a2b6:5b9 with SMTP id f10-20020a056a001aca00b004e1a2b605b9mr22032665pfv.4.1646812294737;
        Tue, 08 Mar 2022 23:51:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7Di4SBo0vIcLZV8aD0YrzixtPGak4ozbl1xizUy139HXfoBpN9nPz+x4ygNPWdbKEaJoHaw==
X-Received: by 2002:a05:6a00:1aca:b0:4e1:a2b6:5b9 with SMTP id f10-20020a056a001aca00b004e1a2b605b9mr22032623pfv.4.1646812294417;
        Tue, 08 Mar 2022 23:51:34 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s16-20020a63ff50000000b003650ee901e1sm1468074pgk.68.2022.03.08.23.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 23:51:33 -0800 (PST)
Message-ID: <aa24df8c-787a-0db5-7b16-60adcb86ab0c@redhat.com>
Date:   Wed, 9 Mar 2022 15:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 08/26] virtio_ring: extract the logic of freeing vring
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
 <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-9-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/3/8 下午8:35, Xuan Zhuo 写道:
> Introduce vring_free() to free the vring of vq.
>
> Prevent double free by setting vq->reset.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_ring.c | 25 ++++++++++++++++++++-----
>   include/linux/virtio.h       |  8 ++++++++
>   2 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index b5a9bf4f45b3..e0422c04c903 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2442,14 +2442,10 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>   }
>   EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>   
> -void vring_del_virtqueue(struct virtqueue *_vq)
> +static void __vring_free(struct virtqueue *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);
>   
> -	spin_lock(&vq->vq.vdev->vqs_list_lock);
> -	list_del(&_vq->list);
> -	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> -
>   	if (vq->we_own_ring) {
>   		if (vq->packed_ring) {
>   			vring_free_queue(vq->vq.vdev,
> @@ -2480,6 +2476,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>   		kfree(vq->split.desc_state);
>   		kfree(vq->split.desc_extra);
>   	}
> +}
> +
> +static void vring_free(struct virtqueue *vq)
> +{
> +	__vring_free(vq);
> +	vq->reset = VIRTIO_VQ_RESET_STEP_VRING_RELEASE;
> +}
> +
> +void vring_del_virtqueue(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	spin_lock(&vq->vq.vdev->vqs_list_lock);
> +	list_del(&_vq->list);
> +	spin_unlock(&vq->vq.vdev->vqs_list_lock);
> +
> +	if (_vq->reset != VIRTIO_VQ_RESET_STEP_VRING_RELEASE)
> +		__vring_free(_vq);
> +
>   	kfree(vq);
>   }
>   EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d59adc4be068..e3714e6db330 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -10,6 +10,13 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/gfp.h>
>   
> +enum virtio_vq_reset_step {
> +	VIRTIO_VQ_RESET_STEP_NONE,
> +	VIRTIO_VQ_RESET_STEP_DEVICE,
> +	VIRTIO_VQ_RESET_STEP_VRING_RELEASE,
> +	VIRTIO_VQ_RESET_STEP_VRING_ATTACH,
> +};


This part looks not related to the subject.

And it needs detail documentation on this.

But I wonder how useful it is, anyway we can check the reset status via 
transport specific way and in the future we may want to do more than 
just resizing (e.g PASID).

Thanks


> +
>   /**
>    * virtqueue - a queue to register buffers for sending or receiving.
>    * @list: the chain of virtqueues for this device
> @@ -33,6 +40,7 @@ struct virtqueue {
>   	unsigned int num_free;
>   	unsigned int num_max;
>   	void *priv;
> +	enum virtio_vq_reset_step reset;
>   };
>   
>   int virtqueue_add_outbuf(struct virtqueue *vq,

