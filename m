Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2FEC433F5
	for <linux-s390@archiver.kernel.org>; Wed,  9 Mar 2022 08:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiCIItv (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Mar 2022 03:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiCIItp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Mar 2022 03:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DB43127D42
        for <linux-s390@vger.kernel.org>; Wed,  9 Mar 2022 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646815726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TO8OA67xOJIVUQ+IzXv9BnLhNmwQiU+fyDz+FkJQweU=;
        b=N0diOB2qte6ztM8F9IvzkE2XJeytdm7qP4cpBVPB/c5SIXX7bfOXHJMQrzmBkfTkIce+Gn
        5idW/0+V0ecUoB46choNn9RwuuPt4OpRKxsg3KUJjqeN3D27Tj8h0XkcvUq2uas3sSPcrA
        GfDNd6f3icjZxZ7KI2eINpmfBJyiwIM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-VwV4hTHXPYSGSNDq2nKywA-1; Wed, 09 Mar 2022 03:48:43 -0500
X-MC-Unique: VwV4hTHXPYSGSNDq2nKywA-1
Received: by mail-pg1-f197.google.com with SMTP id bm16-20020a656e90000000b00372932b1d83so942890pgb.10
        for <linux-s390@vger.kernel.org>; Wed, 09 Mar 2022 00:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TO8OA67xOJIVUQ+IzXv9BnLhNmwQiU+fyDz+FkJQweU=;
        b=kQllMk4PMayuE+GjfDlGR71kdHc91kl+M8zJ3/HzNCJ+OupdylGaoZwv2nKL3HwDYj
         U67lQRsp9yWDU5QOyFyFZwv8d5tdf6oIlA2govYx1cqi353B+9+goY2Y+AhjWjODc8vS
         ZPEushnzhfm5RK0pjV/dmV34PfTz4vUqCeFI8Yxyosfs381qJ0xniTmt7HR9tWdyLIRs
         33yKvO3WlE/HyZt3s1U3brq4Uzy9MrOZD07KmHPo6hGYaAMBz8h24ueZFEqZOOHNCN+J
         9H06C2Jj/z3B5YgEYWOw6bph+kdRQHReg6fQDe3TfvKLWZQujyGM1M5SrGAINeNwezJU
         012Q==
X-Gm-Message-State: AOAM533MYwDoxyEs1h9WfhoGkUf1Eefv2gguAddOlvN+qcgbbiUqL7NO
        AxQeKxT+JtMvZAYBhDPHc5OTMc1KlbmO17G6AMuDv4dSJaCtB9hSyBXWTB/kI4C9be6kGm5Qg1O
        DdjyffqW0DWEmwLiDVLNXDA==
X-Received: by 2002:aa7:8882:0:b0:4df:7b9e:1ccb with SMTP id z2-20020aa78882000000b004df7b9e1ccbmr22312154pfe.41.1646815722236;
        Wed, 09 Mar 2022 00:48:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7/YbZyXIgHV6hqpeiO7757QCskmbcneG6gJIkE8+QzhmuMcmfZenCb/AE2A7PcyT+4y4qLw==
X-Received: by 2002:aa7:8882:0:b0:4df:7b9e:1ccb with SMTP id z2-20020aa78882000000b004df7b9e1ccbmr22312131pfe.41.1646815721958;
        Wed, 09 Mar 2022 00:48:41 -0800 (PST)
Received: from [10.72.12.183] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 142-20020a621894000000b004dfc714b076sm2024468pfy.11.2022.03.09.00.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:48:41 -0800 (PST)
Message-ID: <fda406d7-3ed9-7c62-0f26-4058a63e73a9@redhat.com>
Date:   Wed, 9 Mar 2022 16:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v7 14/26] virtio: add helper for queue reset
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
 <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220308123518.33800-15-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/3/8 下午8:35, Xuan Zhuo 写道:
> Add helper for virtio queue reset.
>
> * virtio_reset_vq(): reset a queue individually
> * virtio_enable_resetq(): enable a reset queue
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   include/linux/virtio_config.h | 40 +++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index d51906b1389f..0b81fbe17c85 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -230,6 +230,46 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>   				      desc);
>   }
>   
> +/**
> + * virtio_reset_vq - reset a queue individually
> + * @vq: the virtqueue
> + *
> + * returns 0 on success or error status
> + *
> + * The api process of reset under normal circumstances:
> + *	1. virtio_reset_vq()              - notify the device to reset the queue
> + *	2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
> + *	3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
> + *	4. virtio_enable_resetq()         - mmap vring to device, and enable the queue
> + *
> + * Caller should guarantee that the vring is not accessed by any functions
> + * of virtqueue.
> + */
> +static inline
> +int virtio_reset_vq(struct virtqueue *vq)
> +{


It looks to me the prefix "virtio" is used for the device specific 
operations.

I wonder if it's better to rename this as virtqueue_reste() and move it 
to virtio_ring.c?

Thanks


> +	if (!vq->vdev->config->reset_vq)
> +		return -ENOENT;
> +
> +	return vq->vdev->config->reset_vq(vq);
> +}
> +
> +/**
> + * virtio_enable_resetq - enable a reset queue
> + * @vq: the virtqueue
> + *
> + * returns 0 on success or error status
> + *
> + */
> +static inline
> +int virtio_enable_resetq(struct virtqueue *vq)
> +{
> +	if (!vq->vdev->config->enable_reset_vq)
> +		return -ENOENT;
> +
> +	return vq->vdev->config->enable_reset_vq(vq);
> +}
> +
>   /**
>    * virtio_device_ready - enable vq use in probe function
>    * @vdev: the device

