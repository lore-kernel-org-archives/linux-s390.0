Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7A5CCA482
	for <linux-s390@archiver.kernel.org>; Fri,  1 Jul 2022 09:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiGAJjw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiGAJjv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 05:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43CD73B544
        for <linux-s390@vger.kernel.org>; Fri,  1 Jul 2022 02:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656668390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
        b=Jjs7+iDfQTV9H9OOI6ArA2W59gJHqcpJNxNrK/Wn+58RDSrSaYho2TfU1w0V3iOlQT8X1j
        GeJbu114UDr4Dno2lmwrxyEuYDceOUn8O56S0IlDsa5PWJ6i+HZv6/fI/Zp3eQ24LCrUjA
        g+I6UMRkXzYstwz30XseA4eQuVa8an8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-SEeUrFVdPXOOPWxgbbtJJA-1; Fri, 01 Jul 2022 05:39:49 -0400
X-MC-Unique: SEeUrFVdPXOOPWxgbbtJJA-1
Received: by mail-pj1-f71.google.com with SMTP id em12-20020a17090b014c00b001ed493d4f0cso1131133pjb.4
        for <linux-s390@vger.kernel.org>; Fri, 01 Jul 2022 02:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1d79Stpus0q2yxaNU7MJkY6xfoyQBkCSEyRGquJaFl4=;
        b=Mo80ZSuBYpwdHAo92q2rJvxEkptlTkJVCioc9MC3x0i6dI6VUh9WJE5UQOo9MaQE1X
         cQQ6pwEf8hY8u1W9kVJmwH/TfC4FJZfvOVETEQNmJpwqnu1h+mFFQ94Fk8c7gfphclne
         Ja36Aq6uyiST+x04E8XgpZMJHTrEyXEQ2cQRJBWfHbuLSdd6Kx2F81jVSP51sI2QpmBu
         7oCv1GsTS7Msq6RQ1IAcTkI28YDTa2JqWZCfG4/LpmqvuD7aI6WxEr18JP/RML243x0F
         IF6SqCjQh1Zi+pdbhYdRt67NNTh9sDpJjMjlLwpS2jT9SfwwO9juzhHJEP4jPcX829C2
         cxuA==
X-Gm-Message-State: AJIora+SqKrJz7HITzYGL5dLFWpyt1E4RxhM4IDl0nQG4hVRYod6k4ki
        +KQJIwKs+iUYFpC8j8s360fKjxqTzXOQ5fWwj/OXNC9zkislUkCiQ5dNIly8KsM9ReBf6kFB6eT
        L8+UPO3gLRYf05uk3MQomCA==
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id u10-20020a63454a000000b00411bbffb079mr4669466pgk.507.1656668387171;
        Fri, 01 Jul 2022 02:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQXl0Mg32c6PANnbBYsi+TCYur6T2X1Z6vqtoZHDXDxtmKbFKHms2mPc6lxJgdRzWP3sExWg==
X-Received: by 2002:a63:454a:0:b0:411:bbff:b079 with SMTP id u10-20020a63454a000000b00411bbffb079mr4669428pgk.507.1656668386921;
        Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id jy18-20020a17090b325200b001e31803540fsm6079692pjb.6.2022.07.01.02.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:39:46 -0700 (PDT)
Message-ID: <494bcf3f-d42c-f05b-cbdb-d4ba834bd118@redhat.com>
Date:   Fri, 1 Jul 2022 17:39:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 28/40] virtio_pci: introduce helper to get/set queue
 reset
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
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220629065656.54420-29-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/6/29 14:56, Xuan Zhuo 写道:
> Introduce new helpers to implement queue reset and get queue reset
> status.
>
>   https://github.com/oasis-tcs/virtio-spec/issues/124
>   https://github.com/oasis-tcs/virtio-spec/issues/139
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_pci_modern_dev.c | 35 ++++++++++++++++++++++++++
>   include/linux/virtio_pci_modern.h      |  2 ++
>   2 files changed, 37 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index fa2a9445bb18..07415654247c 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -3,6 +3,7 @@
>   #include <linux/virtio_pci_modern.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/delay.h>
>   
>   /*
>    * vp_modern_map_capability - map a part of virtio pci capability
> @@ -474,6 +475,40 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
>   }
>   EXPORT_SYMBOL_GPL(vp_modern_set_status);
>   
> +/*
> + * vp_modern_get_queue_reset - get the queue reset status
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +	return vp_ioread16(&cfg->queue_reset);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
> +
> +/*
> + * vp_modern_set_queue_reset - reset the queue
> + * @mdev: the modern virtio-pci device
> + * @index: queue index
> + */
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
> +{
> +	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> +
> +	vp_iowrite16(index, &cfg->queue_select);
> +	vp_iowrite16(1, &cfg->queue_reset);
> +
> +	while (vp_ioread16(&cfg->queue_reset))
> +		msleep(1);
> +
> +	while (vp_ioread16(&cfg->queue_enable))
> +		msleep(1);
> +}
> +EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
> +
>   /*
>    * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
>    * @mdev: the modern virtio-pci device
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index beebc7a4a31d..ded01157f864 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -134,4 +134,6 @@ void __iomem * vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
>   				       u16 index, resource_size_t *pa);
>   int vp_modern_probe(struct virtio_pci_modern_device *mdev);
>   void vp_modern_remove(struct virtio_pci_modern_device *mdev);
> +int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
> +void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index);
>   #endif

