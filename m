Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411AC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 05:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbiDLFwQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 01:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiDLFwP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 01:52:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6E522DA8C
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649742597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nfLWnPBAuMlm5r+UmbtTzmJcwM0c6Blxn5Idke/QAM=;
        b=BesQG/+zMgYVGv6tJ22Ckx2QQMhcq4cgFcWwTaJpri6mxw64qbfpX0oPPAg56c6goL2jaA
        t+qiP66hTnqGKZw98dw0HxdcNbKDeg0gnshz7YxDdwoK86moHHKUGQbsicbIF8I/Ni32hi
        7SSIigz7aGR3cDcpo/6zVGRCW37oVGw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-KhwAl5HlMLCCQXfqEuVbHg-1; Tue, 12 Apr 2022 01:49:56 -0400
X-MC-Unique: KhwAl5HlMLCCQXfqEuVbHg-1
Received: by mail-pj1-f71.google.com with SMTP id u11-20020a17090a890b00b001cbbe59b040so694156pjn.1
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 22:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+nfLWnPBAuMlm5r+UmbtTzmJcwM0c6Blxn5Idke/QAM=;
        b=gaqyFOSLvTQ0H+m+4AUXBemDMDfpDPd5c1U1qNjl3rJWai6EWedUztIvcIPwN5locA
         YJXwrr/VwCicqmM/ZpANpcgCpkF/PqoSp4pkBPlJqTbJXSC7pwmV1Rog21sOPdYDnEMl
         z7PAEW6ALPT812LDnld/90wlFGUxvP3Z5Wn+PrUd7EZNgU7qdicfTaKu1iVNfPD/kfKE
         U2s7dJPhpNxqwACJV7d9ZKr+CpkhjtGnhJ+Umqo6vsO+lmxC9Q/6PJzl9twPGG9eNW9j
         k2ft+EAZCRawu/VOXNPk0hUSrHtoh6iIU2J86cd62wrq2D4c4wIJJNKaBAs2wFxauXoD
         G0fA==
X-Gm-Message-State: AOAM533qm63ZQYCu6H0taT1lC/qeEF0Uzlj1a1ubcDXV5Wrv3HTL+mtj
        X16f52iIBRLewlHNnNyDbebmjQ1BVYV3B21PDGn4TxoGKzl1Uwt141jAe1S0UaQc5GX35Ue/zpP
        F0eFkiJkedOBZMXHPS1cx9g==
X-Received: by 2002:a17:90a:2b0f:b0:1cb:a3e5:413b with SMTP id x15-20020a17090a2b0f00b001cba3e5413bmr3111676pjc.115.1649742595571;
        Mon, 11 Apr 2022 22:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5M7w4regKv/6lTzZiCGXRv4gWijfltQwpzvyUhGLz6udlOo2qWGkxbBotpTg1IaFMoqyGeg==
X-Received: by 2002:a17:90a:2b0f:b0:1cb:a3e5:413b with SMTP id x15-20020a17090a2b0f00b001cba3e5413bmr3111650pjc.115.1649742595355;
        Mon, 11 Apr 2022 22:49:55 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b001c779e82af6sm1265782pjf.48.2022.04.11.22.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 22:49:54 -0700 (PDT)
Message-ID: <14ab2942-2141-cb1b-14be-35da1c9ee03d@redhat.com>
Date:   Tue, 12 Apr 2022 13:49:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 10/32] virtio_ring: split: introduce
 virtqueue_reinit_split()
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
 <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-11-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Introduce a function to initialize vq without allocating new ring,
> desc_state, desc_extra.
>
> Subsequent patches will call this function after reset vq to
> reinitialize vq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 874f878087a3..3dc6ace2ba7a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -953,6 +953,25 @@ static void vring_virtqueue_init_split(struct vring_virtqueue *vq,
>   	vq->free_head = 0;
>   }
>   
> +static void virtqueue_reinit_split(struct vring_virtqueue *vq)
> +{
> +	struct virtio_device *vdev = vq->vq.vdev;
> +	int size, i;
> +
> +	memset(vq->split.vring.desc, 0, vq->split.queue_size_in_bytes);
> +
> +	size = sizeof(struct vring_desc_state_split) * vq->split.vring.num;
> +	memset(vq->split.desc_state, 0, size);
> +
> +	size = sizeof(struct vring_desc_extra) * vq->split.vring.num;
> +	memset(vq->split.desc_extra, 0, size);
> +
> +	for (i = 0; i < vq->split.vring.num - 1; i++)
> +		vq->split.desc_extra[i].next = i + 1;
> +
> +	vring_virtqueue_init_split(vq, vdev, true);
> +}
> +
>   static void vring_virtqueue_attach_split(struct vring_virtqueue *vq,
>   					 struct vring vring,
>   					 struct vring_desc_state_split *desc_state,

