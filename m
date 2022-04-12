Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDADC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 02:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbiDLC4E (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbiDLC4D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 22:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F1228E29
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 19:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649732026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6Gk+PoKhwefvMstrrWueNlGg+EH3BPUAhekn6Cxf1E=;
        b=KpBwJsAFsxaE5t9OOSwsSEob+mfWDAy1ry1W+hHaUQRH8QeHE+hdS39MWh6FdacW537P3v
        oKzu9LBaDTtZetx3/VOdIv21kTbycqRSWFNwEdWoMOcspzRII71sDXukjtdKPhSYvFXFzE
        Wp9tazyGy0f7uVvT81uxsf6mMBOhvuY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-9BI6WF_sOk63L17Vs18j5Q-1; Mon, 11 Apr 2022 22:53:37 -0400
X-MC-Unique: 9BI6WF_sOk63L17Vs18j5Q-1
Received: by mail-pf1-f197.google.com with SMTP id j17-20020a62b611000000b004fa6338bd77so10647418pff.10
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 19:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I6Gk+PoKhwefvMstrrWueNlGg+EH3BPUAhekn6Cxf1E=;
        b=wbrd/hCR0q67+LSh/KudpRvW4F0KsVuczTyDOanypLOw1S8A1NPEtn4HwRAYDETu7w
         EiFv9y2WXguh/Ou1cFaHBXCsO7un6qbgC5TMo/UM2XIIF+1/4FGFoL9tk7w6kwpHWBGj
         7UJz9T3dJFoRxqGa7SwroVv2wJ8FXGNv4kKzcr8f089Au2SemwDQI6tdj3pNEAnBCxHt
         Ai91o6Ld4J2QPwWiSw+DRzl0tfvYxR3xVWYVapaOezVYjXSYxEN1ZWmeu5RhNNrD8OrG
         hY4Q5aDKRfSooQ1O20s4KlZF5hY8cr0SuThZsGNRQ0l6+RwzuFGUSxnCC8n0rMDNUUTk
         KPAQ==
X-Gm-Message-State: AOAM532YpKZPdJs44dCOv7nkjTnp8X2ljNYd81zm7mG3uMIkNXQhtJwb
        198/ot5mMNqhbOkCrLzQhzWPK7yKf0eRFY3YaRl3fIp0sHU6zUoRiLar0OdKkaOWi8uk9krkViB
        LpsBcOvI5wRb4Bpy3OCD/cg==
X-Received: by 2002:a63:6286:0:b0:39d:94b2:fbc0 with SMTP id w128-20020a636286000000b0039d94b2fbc0mr996911pgb.439.1649732016631;
        Mon, 11 Apr 2022 19:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj9451Dz8Id3VkVV78O8W6jxJ5RgF2YxbCU8kZmbBeEtMyuWRJome1nhMw4/Xpk0k7lbQNPw==
X-Received: by 2002:a63:6286:0:b0:39d:94b2:fbc0 with SMTP id w128-20020a636286000000b0039d94b2fbc0mr996881pgb.439.1649732016356;
        Mon, 11 Apr 2022 19:53:36 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id np8-20020a17090b4c4800b001c70aeab380sm812652pjb.41.2022.04.11.19.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 19:53:35 -0700 (PDT)
Message-ID: <e9f76bff-c842-3dae-644e-0b7005d3f1fd@redhat.com>
Date:   Tue, 12 Apr 2022 10:53:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 04/32] virtio_ring: remove the arg vq of
 vring_alloc_desc_extra()
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
 <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-5-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> The parameter vq of vring_alloc_desc_extra() is useless. This patch
> removes this parameter.
>
> Subsequent patches will call this function to avoid passing useless
> arguments.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f1807f6b06a5..cb6010750a94 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1636,8 +1636,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
>   	return NULL;
>   }
>   
> -static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *vq,
> -						       unsigned int num)
> +static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>   {
>   	struct vring_desc_extra *desc_extra;
>   	unsigned int i;
> @@ -1755,7 +1754,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>   	/* Put everything in free lists. */
>   	vq->free_head = 0;
>   
> -	vq->packed.desc_extra = vring_alloc_desc_extra(vq, num);
> +	vq->packed.desc_extra = vring_alloc_desc_extra(num);
>   	if (!vq->packed.desc_extra)
>   		goto err_desc_extra;
>   
> @@ -2233,7 +2232,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>   	if (!vq->split.desc_state)
>   		goto err_state;
>   
> -	vq->split.desc_extra = vring_alloc_desc_extra(vq, vring.num);
> +	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
>   	if (!vq->split.desc_extra)
>   		goto err_extra;
>   

