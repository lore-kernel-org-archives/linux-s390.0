Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3DC19F2C
	for <linux-s390@archiver.kernel.org>; Wed, 27 Jul 2022 04:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiG0Eff (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Jul 2022 00:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiG0Efd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Jul 2022 00:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CAAEBF57
        for <linux-s390@vger.kernel.org>; Tue, 26 Jul 2022 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658896531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Nhmdd76VxuZywcj4ABrLti2+JKOVAikxn2IN6L8acM=;
        b=dgRTNSxhuFkV7YNGzVBVDTQKwFbBAV/jaFluy71WagnQS8IaRLJYgs3CA1NRb7X7q6wk62
        1NwdA91oL99Ezay9+Yo8dKObFk17QPtPoW+oc9Kf0VJK6zDFh/6wRZaGg3e0bmZU3K/s5A
        miArsWOBOoUjN+rhqJcWAmcXvTrSQoo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-p39S6yEWOjS4g4tmwJP43w-1; Wed, 27 Jul 2022 00:35:29 -0400
X-MC-Unique: p39S6yEWOjS4g4tmwJP43w-1
Received: by mail-pf1-f197.google.com with SMTP id u14-20020a056a00098e00b0052b433b04d6so5494431pfg.12
        for <linux-s390@vger.kernel.org>; Tue, 26 Jul 2022 21:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Nhmdd76VxuZywcj4ABrLti2+JKOVAikxn2IN6L8acM=;
        b=1DUL7rZ/W5p4cLiKQzFm+hKSsBGwQhKPRM9b+N5YyEOZUywkLJoRX1RPZp/xQBuYTm
         Zr2TEh/tvnMsaqcjoi6hhstvCCgq9fJE70o5yHR9srmemCfI2mnejAXLTWr5vppTbsaj
         y14vt6nyP1Kd9G6G1rNgguUwh++oMxnVD3dFzXPy+eI3jn492qGkJUjxCKr57RJULrtZ
         7YIeaoBgM8awz0R11szbQ/XeGV2eSuMoirx12OvPTsrrARZsSbY4hfL/A+Lb4Dy50Be5
         9atqEB/mu4xlgEZ8P/eGZ+Wmc5xRTUI5ZuPCoVCtZW9oibb8lDj/lCeAb/z19jY2FYbs
         V/hg==
X-Gm-Message-State: AJIora+6zTthDVAuxLdKk4BejxM4N1HGzs8VgSj+XTv1docLajWXcdRO
        f37ArDB13XR2wq6bQZldMpHF/Hm8+HeU4qGkN0A56rVj7is+qdNDhWYYbsFv8GxqWc3AAkrq6C4
        MDJqZTCSFeLcEBkGJsQkj3A==
X-Received: by 2002:a17:90b:1d90:b0:1f2:5f47:ca6c with SMTP id pf16-20020a17090b1d9000b001f25f47ca6cmr2521228pjb.162.1658896528717;
        Tue, 26 Jul 2022 21:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sv66YMuYLn2D/TECwlGvVrDyp85rujIUbxh1LnRrYj8nx/VinuiyLNA/hwGDceqmYNtwAlaQ==
X-Received: by 2002:a17:90b:1d90:b0:1f2:5f47:ca6c with SMTP id pf16-20020a17090b1d9000b001f25f47ca6cmr2521196pjb.162.1658896528457;
        Tue, 26 Jul 2022 21:35:28 -0700 (PDT)
Received: from [10.72.12.96] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i17-20020a170902c95100b0016d9d729f0bsm2843421pla.135.2022.07.26.21.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 21:35:26 -0700 (PDT)
Message-ID: <7b33b166-785f-ef8a-153f-e0b1c3b7e23d@redhat.com>
Date:   Wed, 27 Jul 2022 12:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 22/42] virtio_ring: packed: introduce
 virtqueue_reinit_packed()
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
 <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-23-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/26 15:22, Xuan Zhuo 写道:
> Introduce a function to initialize vq without allocating new ring,
> desc_state, desc_extra.
>
> Subsequent patches will call this function after reset vq to
> reinitialize vq.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 00b18cf3b4d9..7d4c444b5a9d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1957,6 +1957,27 @@ static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
>   	vq->packed = *vring_packed;
>   }
>   
> +static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
> +{
> +	int size, i;
> +
> +	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
> +	memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes);
> +	memset(vq->packed.vring.desc, 0, vq->packed.ring_size_in_bytes);
> +
> +	size = sizeof(struct vring_desc_state_packed) * vq->packed.vring.num;
> +	memset(vq->packed.desc_state, 0, size);
> +
> +	size = sizeof(struct vring_desc_extra) * vq->packed.vring.num;
> +	memset(vq->packed.desc_extra, 0, size);
> +
> +	for (i = 0; i < vq->packed.vring.num - 1; i++)
> +		vq->packed.desc_extra[i].next = i + 1;
> +
> +	virtqueue_init(vq, vq->packed.vring.num);
> +	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> +}
> +
>   static struct virtqueue *vring_create_virtqueue_packed(
>   	unsigned int index,
>   	unsigned int num,

