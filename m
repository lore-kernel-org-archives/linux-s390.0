Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C718C43334
	for <linux-s390@archiver.kernel.org>; Thu, 30 Jun 2022 06:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiF3GgC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiF3GgB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jun 2022 02:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D41E42DA93
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656570959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njLH7GFfaOXROEX4o3ayXFUqakNk2re9lthQMqB92Q8=;
        b=bSM/DPPRPHwp54h7xAmOXAj2REfpV7UnyHN3XsruA/IWWvjNGfCKZCG1j1k4ksKFNSfdx6
        zAj+7N24pPwuKDqb943ZGM3sSZOh7l7FXl0Lh1UbpF84jEf0AvjZPMQUmYNmD8fAtAwfNs
        0LZmcyDqZVtmltWKC+0TbteHAAnUlWI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-5An-a-XSMd2_C8bVMGk58g-1; Thu, 30 Jun 2022 02:35:54 -0400
X-MC-Unique: 5An-a-XSMd2_C8bVMGk58g-1
Received: by mail-lj1-f197.google.com with SMTP id g25-20020a2e9e59000000b0025baf0470feso2408166ljk.8
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 23:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njLH7GFfaOXROEX4o3ayXFUqakNk2re9lthQMqB92Q8=;
        b=VN2BjJ0B0nGVhPKZ+H2KRHNFzPy/FBGbDgXSDkKNKUIW0Koaac5gWfhAoiOqAc+ufp
         ukIvkXECp3f4dtwhBr9mWt4+eddl1AT/nkKEsBDGc8IyDHsPyEKYk7+orggvSppFnsEK
         TQQzfeX8YB+M76eaVY1OxJiZ6CaZAJCyKp47TcgE9JTidQt+7yxo9vRCkv5HzVqEDz4K
         kfYV+tWPzDyTAbOgEp4aj3nX9uZAOarhaj584gmZpJHsnFlVhqjxp/CaK+Jlb7VJlBSK
         bQVERLuooC5c6WUGpSS6D2/JWnnkOOEvuF3EIRoVfSRgGFGCEKh4IiEgpuczObDcuGl7
         bhjA==
X-Gm-Message-State: AJIora+nGEDtI3jV5NCELs7lQVEdLBfsIkVrefU94aooN5jrS7oAIvvG
        WU0CTU8P8Yt2wqabjaNsS6BEr2L//3Khj3l30NgUmKuRoh1WlacKIMiqhhXDXknReLO0DJi8bye
        ZEkqq7RT6fco8g+lFZugJlbxLRZc8JnsAd97Thg==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id bp13-20020a056512158d00b0047f718c28b5mr4745079lfb.397.1656570950067;
        Wed, 29 Jun 2022 23:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJKVtY+Zl0/40XEr/wn6beDS0TB6Ve6wa1Oo7+BpbGVCUvzB09kLNntuaMrZWqNzwTBjf08mKnZiCH+Ir+mBo=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr4745069lfb.397.1656570949818; Wed, 29
 Jun 2022 23:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com> <20220629065656.54420-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Jun 2022 14:35:38 +0800
Message-ID: <CACGkMEuWK5i4pyvzN306v2ijstFQQbuspNCcNRJrw0kskvcozg@mail.gmail.com>
Subject: Re: [PATCH v11 01/40] virtio: add helper virtqueue_get_vring_max_size()
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
> Record the maximum queue num supported by the device.
>
> virtio-net can display the maximum (supported by hardware) ring size in
> ethtool -g eth0.
>
> When the subsequent patch implements vring reset, it can judge whether
> the ring size passed by the driver is legal based on this.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c             |  1 +
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  2 ++
>  drivers/remoteproc/remoteproc_virtio.c   |  2 ++
>  drivers/s390/virtio/virtio_ccw.c         |  3 +++
>  drivers/virtio/virtio_mmio.c             |  2 ++
>  drivers/virtio/virtio_pci_legacy.c       |  2 ++
>  drivers/virtio/virtio_pci_modern.c       |  2 ++
>  drivers/virtio/virtio_ring.c             | 14 ++++++++++++++
>  drivers/virtio/virtio_vdpa.c             |  2 ++
>  include/linux/virtio.h                   |  2 ++
>  10 files changed, 32 insertions(+)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 82ff3785bf69..e719af8bdf56 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -958,6 +958,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>                 goto error_create;
>         }
>         vq->priv = info;
> +       vq->num_max = num;
>         num = virtqueue_get_vring_size(vq);
>
>         if (vu_dev->protocol_features &
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 38800e86ed8a..1ae3c56b66b0 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -959,6 +959,8 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>                         goto error;
>                 }
>
> +               vq->num_max = vring->num;
> +
>                 vqs[i] = vq;
>                 vring->vq = vq;
>                 vq->priv = vring;
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d43d74733f0a..0f7706e23eb9 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -125,6 +125,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> +       vq->num_max = num;
> +
>         rvring->vq = vq;
>         vq->priv = rvring;
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 161d3b141f0d..6b86d0280d6b 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -530,6 +530,9 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>                 err = -ENOMEM;
>                 goto out_err;
>         }
> +
> +       vq->num_max = info->num;
> +
>         /* it may have been reduced */
>         info->num = virtqueue_get_vring_size(vq);
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 083ff1eb743d..a20d5a6b5819 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -403,6 +403,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>                 goto error_new_virtqueue;
>         }
>
> +       vq->num_max = num;
> +
>         /* Activate the queue */
>         writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
>         if (vm_dev->version == 1) {
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index a5e5721145c7..2257f1b3d8ae 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -135,6 +135,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         if (!vq)
>                 return ERR_PTR(-ENOMEM);
>
> +       vq->num_max = num;
> +
>         q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
>         if (q_pfn >> 32) {
>                 dev_err(&vp_dev->pci_dev->dev,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 623906b4996c..e7e0b8c850f6 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -218,6 +218,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         if (!vq)
>                 return ERR_PTR(-ENOMEM);
>
> +       vq->num_max = num;
> +
>         /* activate the queue */
>         vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
>         vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..4cac600856ad 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2385,6 +2385,20 @@ void vring_transport_features(struct virtio_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vring_transport_features);
>
> +/**
> + * virtqueue_get_vring_max_size - return the max size of the virtqueue's vring
> + * @_vq: the struct virtqueue containing the vring of interest.
> + *
> + * Returns the max size of the vring.
> + *
> + * Unlike other operations, this need not be serialized.
> + */
> +unsigned int virtqueue_get_vring_max_size(struct virtqueue *_vq)
> +{
> +       return _vq->num_max;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_vring_max_size);
> +
>  /**
>   * virtqueue_get_vring_size - return the size of the virtqueue's vring
>   * @_vq: the struct virtqueue containing the vring of interest.
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index c40f7deb6b5a..9670cc79371d 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -183,6 +183,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>                 goto error_new_virtqueue;
>         }
>
> +       vq->num_max = max_num;
> +
>         /* Setup virtqueue callback */
>         cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
>         cb.private = info;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d8fdf170637c..a82620032e43 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -31,6 +31,7 @@ struct virtqueue {
>         struct virtio_device *vdev;
>         unsigned int index;
>         unsigned int num_free;
> +       unsigned int num_max;

A question, since we export virtqueue to drivers, this means they can
access vq->num_max directly.

So we probably don't need a helper here.

Thanks

>         void *priv;
>  };
>
> @@ -80,6 +81,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>
> +unsigned int virtqueue_get_vring_max_size(struct virtqueue *vq);
>  unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>
>  bool virtqueue_is_broken(struct virtqueue *vq);
> --
> 2.31.0
>

