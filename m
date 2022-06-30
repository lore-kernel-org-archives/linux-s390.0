Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD0CCA47B
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 06:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiF3Gj3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbiF3GjZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 02:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 497652F667
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 23:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656571163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pJ9PIxLLsVzCuVJJtdE0cxnl/Cjc0vCs0BsaA2nNYcE=;
        b=TNNrSJTOZQYjZsv36hTEYZJPqKF4mpbbauDByfQylHs3Wb/2OjmpDX9tv4UKCzdLqpv2sT
        4zzzEm+aH8nQUqhq+A/u6wuaHA1vQwRopXZ4htilDl7/NlkP8einMf6dxxAAWhf6XDsTpo
        rJezdjHB+ZLKesVzzGB3RXPrGCjMc0Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-rDf-eZX0M0S9mNPMMut5dg-1; Thu, 30 Jun 2022 02:39:21 -0400
X-MC-Unique: rDf-eZX0M0S9mNPMMut5dg-1
Received: by mail-lf1-f72.google.com with SMTP id f29-20020a19dc5d000000b004811c8d1918so5042304lfj.2
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 23:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJ9PIxLLsVzCuVJJtdE0cxnl/Cjc0vCs0BsaA2nNYcE=;
        b=am5Px/BC2HCJc+3MzWJDrFgIfnUOIsxFlwje71Xxg8baQMbFe7ysuh5KmlkTh4iqNL
         xGrCpyUCXCaUXJ/qc5aoZyq8TWNd/p5qlxV6XpH3ZAkAB48NyyoYN4lUFrpyamkoXfIt
         aMrtuuPT9nxxrgn+rAucaLrY/q4GO52IAc3z/TzC2VFUwr1Ks0QV3VYF1D1Q4DecqhuN
         zuPLx9OCwDLpMmUxzt/YFzlBwAqd+ylzELhb2pDfRBWXecb9arkJ/qdQStjyFSwAnkvs
         2yBAYNaJ4cEzYPmpKCv37rbIjJo2a4wiZdOsQMhT2csN4Eoe6iXWREOj8AnJGK14zmTU
         yFaw==
X-Gm-Message-State: AJIora/RKwNelWIaj8otMR3Ppbv+7Kdn0rC4SsM0d+jsRcfNjqn7JQNB
        5RFeQPNZ2KvGvrCUAyCgE6w8hi9Zqz+3aXrj6CNgbx4gM+QM0TyCquUCSePUbDRilPVGIfPkL54
        PKa8IaQ9Kov7ekI2HHEoxeB//aFVKqTe8o2B/GQ==
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr4440387lfa.124.1656571159890;
        Wed, 29 Jun 2022 23:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqG3rBVpPZppnWzT9+UoAeK5eCUmyrl/4NUFplfIBffY69P4EaE37IkoiuXbBcVcsUA6aouX0dtgCqbLTS49I=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr4440343lfa.124.1656571159618; Wed, 29
 Jun 2022 23:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com> <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Jun 2022 14:39:08 +0800
Message-ID: <CACGkMEuM3rZwQ8dKUQovwpf+JVvp53SY=2ANVeKw746e3o0_xg@mail.gmail.com>
Subject: Re: [PATCH v11 02/40] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
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
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        kangjie.xu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 29, 2022 at 2:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> reset can be divided into the following four steps (example):
>  1. transport: notify the device to reset the queue
>  2. vring:     recycle the buffer submitted
>  3. vring:     reset/resize the vring (may re-alloc)
>  4. transport: mmap vring to device, and enable the queue
>
> In order to support queue reset, add two callbacks(reset_vq,
> enable_reset_vq) in struct virtio_config_ops to implement steps 1 and 4.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_config.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b47c2e7ed0ee..ded51b0d4823 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -78,6 +78,16 @@ struct virtio_shm_region {
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   * @get_shm_region: get a shared memory region based on the index.
> + * @reset_vq: reset a queue individually (optional).
> + *     vq: the virtqueue
> + *     Returns 0 on success or error status
> + *     reset_vq will guarantee that the callbacks are disabled and synchronized.
> + *     Except for the callback, the caller should guarantee that the vring is
> + *     not accessed by any functions of virtqueue.
> + * @enable_reset_vq: enable a reset queue
> + *     vq: the virtqueue
> + *     Returns 0 on success or error status
> + *     If reset_vq is set, then enable_reset_vq must also be set.
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> @@ -104,6 +114,8 @@ struct virtio_config_ops {
>                         int index);
>         bool (*get_shm_region)(struct virtio_device *vdev,
>                                struct virtio_shm_region *region, u8 id);
> +       int (*reset_vq)(struct virtqueue *vq);
> +       int (*enable_reset_vq)(struct virtqueue *vq);

I wonder if a single op with a boolean parameter is sufficient here.

Thanks

>  };
>
>  /* If driver didn't advertise the feature, it will never appear. */
> --
> 2.31.0
>

