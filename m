Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF22C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 21 Jul 2022 09:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiGUJPL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiGUJPK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 21 Jul 2022 05:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AB8FD54
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658394906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flUzKdjZ1/4EDqBKjfAvMc1rxeEdG1DoytUK7fLquSo=;
        b=MBOHHdf5KzLQmiU0Lx+bXk0OS9jxUSXy2IZYHXjUKo9/+8X+IOO/zDpqctsAIwKnZ54bTW
        E4CHxjliwE/ipaeYGeR0LWxLxG6zd0tZCeylzOVgEjb8nA52OIXW7lJeRZ6moofNzET2Ag
        qHqJpN7Y526oWjlmLoamUAS2xtmmYI8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-TJM7Cl1gNm2r81xhfYxhVg-1; Thu, 21 Jul 2022 05:15:04 -0400
X-MC-Unique: TJM7Cl1gNm2r81xhfYxhVg-1
Received: by mail-pj1-f71.google.com with SMTP id o6-20020a17090a4b4600b001f2335370e4so442433pjl.7
        for <linux-s390@vger.kernel.org>; Thu, 21 Jul 2022 02:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=flUzKdjZ1/4EDqBKjfAvMc1rxeEdG1DoytUK7fLquSo=;
        b=6DaIZAG1xU8HUwiQ6SPjWLGFhsRV0mJIlFl9rJwMy5P7O4t1mIwha3aDRqmxn2pTZt
         RO0vQa03Lh7gb3V4hZaCQEFrU6M7GPbUgv9g1vr211f/ZGrYp+GdAYHk0SDFba8VYpui
         D4YV/5jyOePxjdqv3wzIyapUA0+gEHNG0CgO6evILT6p4FcpzVAzHPkkP/TQdf5YaBCG
         GhKYSXbVF/8eeaUJxBfm8/NK7tQb4Dqf5qMqgq7QhWmy9MLQPV3W6wMILR4Xwdh1dG/S
         1RPWzWRsXKspv0yvRp0yz/fqvNqo7GZys0gE6vhfiGplbPykX9HTWEJZHvAVwRGF7405
         3Nng==
X-Gm-Message-State: AJIora/Wq4ob1Gq0pATu+Bm/VAY2VTuIQBG+SO1dGyJOldQCa0/Dj4x8
        pVoqYR4jivLt2uDqsMj4uTtLJw4JWkfLRXp81kS8rTG97ru6xlBn0bnxJCIKCELMZIhvn8X0VNT
        iI5nplbwuzkgoFOERHiMdLA==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id u6-20020a634546000000b0041a5e8f508amr8003826pgk.419.1658394903090;
        Thu, 21 Jul 2022 02:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tUZ8W3Hy81eneplKjYeb4+YqIJ3cluF804ujXcDkWSb197c5rqPxj5tPxNoDGDy9bc1IdWeQ==
X-Received: by 2002:a63:4546:0:b0:41a:5e8f:508a with SMTP id u6-20020a634546000000b0041a5e8f508amr8003791pgk.419.1658394902799;
        Thu, 21 Jul 2022 02:15:02 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e80c00b0016a11b7472csm1139255plg.166.2022.07.21.02.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:15:02 -0700 (PDT)
Message-ID: <74fb1fe4-87ce-eb24-e4a0-d81164c80f3c@redhat.com>
Date:   Thu, 21 Jul 2022 17:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 27/40] virtio_pci: struct virtio_pci_common_cfg add
 queue_reset
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
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-28-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/20 11:04, Xuan Zhuo 写道:
> Add queue_reset in virtio_pci_common_cfg.
>
>   https://github.com/oasis-tcs/virtio-spec/issues/124
>   https://github.com/oasis-tcs/virtio-spec/issues/139
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/virtio_pci_modern.h | 2 +-
>   include/uapi/linux/virtio_pci.h   | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 41f5a018bd94..05123b9a606f 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -9,7 +9,7 @@ struct virtio_pci_modern_common_cfg {
>   	struct virtio_pci_common_cfg cfg;
>   
>   	__le16 queue_notify_data;	/* read-write */
> -	__le16 padding;
> +	__le16 queue_reset;		/* read-write */
>   };
>   
>   struct virtio_pci_modern_device {
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index f5981a874481..f703afc7ad31 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -203,6 +203,7 @@ struct virtio_pci_cfg_cap {
>   #define VIRTIO_PCI_COMMON_Q_USEDLO	48
>   #define VIRTIO_PCI_COMMON_Q_USEDHI	52
>   #define VIRTIO_PCI_COMMON_Q_NDATA	56
> +#define VIRTIO_PCI_COMMON_Q_RESET	58
>   
>   #endif /* VIRTIO_PCI_NO_MODERN */
>   

