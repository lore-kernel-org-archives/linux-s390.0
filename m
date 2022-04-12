Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FC5C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 08:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiDLIRT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357232AbiDLHjx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 03:39:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9F22C16
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649747648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KfEewUd/P7rD+GfgzNOJ3/+yQH5JQRsFMgr1fgMrBA=;
        b=SxzM1iIQlLsKCtcPk6iewCWOa3Yk2TCb2ozhb7r3v0P4l/G7lgVBfB2gETsreEfMG2grq4
        rmFd5oR7wRKemLaNcXYkyzYGuHB8LIu0pl97LuxhkXTNnxEAFS97Zq+tvW/8+0K8aDrMCg
        polM3olx1qAV9lUucNH48IondlqZQ+M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-5ZU9F9L-NmyAefN0OXwYKQ-1; Tue, 12 Apr 2022 03:14:06 -0400
X-MC-Unique: 5ZU9F9L-NmyAefN0OXwYKQ-1
Received: by mail-pj1-f71.google.com with SMTP id i8-20020a17090a2a0800b001cb5c76ea21so4706276pjd.2
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+KfEewUd/P7rD+GfgzNOJ3/+yQH5JQRsFMgr1fgMrBA=;
        b=Canx/cGKgykySeZYT9+T7gzPMmHDm0fZu1n9Rn24LRXz65D3bgkgiA1LHC+dqfBn3f
         6JTJALNDoAyX6GQzU+m/qJlyWZ/izSH+0pPMp7AAkTTF2N9cLveLN5WDWU58cmrnlfsD
         gNbZRPRlfocwR9M/zOIeVLaaTn+9olPrQfT5OFsP/iGT56XwEU6eALev73Omt1g9+qxl
         cFRGPTyZx4Bdye8DMG/hK7l3ju3MMlq/Hz1k9gWr23QzAySbpI32FqHVDEfh6IA20YE2
         bwydHaLCOf/TJui5LngZVzh8Hc9H/Q5UXwbQ9YleA1OPgP0KhcPdkcbHpjDn+uH/AQ15
         amJw==
X-Gm-Message-State: AOAM533+AYc9yL8mzdfSO+MtF3lf77+FzI0EDskZ6McEnF+dZYzqL9rq
        ZFW7sUe5zh/uvfkWZLBBn3CdfPO/WamFu+fKmHLPhrZWrBHlkCNoHo90UXxt0a0VOE3huMwR5rI
        blzgwzx7HuFIyLLtfrQNd0Q==
X-Received: by 2002:a63:9203:0:b0:386:3b37:76b5 with SMTP id o3-20020a639203000000b003863b3776b5mr30232802pgd.234.1649747645335;
        Tue, 12 Apr 2022 00:14:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz8tuQLUzxBTFiELPnVmPwK4HkOQmo42dCUGoCnnoQX1nf1+7XyvUkjmkIVepPIYWlERR4oQ==
X-Received: by 2002:a63:9203:0:b0:386:3b37:76b5 with SMTP id o3-20020a639203000000b003863b3776b5mr30232780pgd.234.1649747645115;
        Tue, 12 Apr 2022 00:14:05 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm39492179pfj.152.2022.04.12.00.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:14:04 -0700 (PDT)
Message-ID: <e8298f3d-dd58-8031-606f-f0fb061a7c95@redhat.com>
Date:   Tue, 12 Apr 2022 15:13:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 26/32] virtio_mmio: support the arg sizes of find_vqs()
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
 <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-27-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Virtio MMIO support the new parameter sizes of find_vqs().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


>   drivers/virtio/virtio_mmio.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 9d5a674bdeec..51cf51764a92 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -347,7 +347,7 @@ static void vm_del_vqs(struct virtio_device *vdev)
>   
>   static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>   				  void (*callback)(struct virtqueue *vq),
> -				  const char *name, bool ctx)
> +				  const char *name, u32 size, bool ctx)
>   {
>   	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>   	struct virtio_mmio_vq_info *info;
> @@ -382,8 +382,11 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>   		goto error_new_virtqueue;
>   	}
>   
> +	if (!size || size > num)
> +		size = num;
> +
>   	/* Create the vring */
> -	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> +	vq = vring_create_virtqueue(index, size, VIRTIO_MMIO_VRING_ALIGN, vdev,
>   				 true, true, ctx, vm_notify, callback, name);
>   	if (!vq) {
>   		err = -ENOMEM;
> @@ -484,6 +487,7 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   		}
>   
>   		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> +				     sizes ? sizes[i] : 0,
>   				     ctx ? ctx[i] : false);
>   		if (IS_ERR(vqs[i])) {
>   			vm_del_vqs(vdev);

