Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF733C4321E
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 08:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbiDLIZi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Apr 2022 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357584AbiDLHkb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 03:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC3C731228
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649747764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WVzkj+bZmYlT5FAR8tqeVhbuQLiJC56RxAwusezhQ84=;
        b=K3srpP9L5r2x/5fGatD694fIb1LqoD11vqeJR3iIDG8KV3J/PM9Y1R7wGJZ5jiARY1cJR0
        OWfkL0ho4lCqd7sCYOSzoKmgtrRYW/BSMiiQeJNKF5URHXao42IbaasqPDqRC8/I0GHTDi
        20aPbUsfBED5n1uwpEGDY/NI2pYEhOI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-EoNaOFHTN2qBzCTntz55ww-1; Tue, 12 Apr 2022 03:16:00 -0400
X-MC-Unique: EoNaOFHTN2qBzCTntz55ww-1
Received: by mail-pj1-f69.google.com with SMTP id r15-20020a17090a4dcf00b001cb7ea0b0bdso1092512pjl.1
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 00:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WVzkj+bZmYlT5FAR8tqeVhbuQLiJC56RxAwusezhQ84=;
        b=zx1IpAhbNODYbeAlD1lA1tAj3pxk5c5nXm95IrmXNgwblGOZIhn6TY68jGdVS3iPuE
         YHlLqMJYd2H/xyNktRuNTaF6C6cqDTvqTFnA1Wyqz20OJOC7IyA+bnH6Ao90pzgz3WP9
         QU9YlYl6rZPUju5JAO+RlAgfSv7388azIIW7WDYdtFqUGsmP1Uzsak3iO+O9EqTGx2S3
         piulIINQF2B4uriIeN7xG6Bqbn3fcRfaX4m077FnYrXDYOi60u/oDSzlhTGkhqUBTtK3
         ET6rQlU9tAgPgqJabUfN4afes7raGpENuSN3/D719f4pw98c/6Zbt/G2bfnh74MUaMog
         xo+A==
X-Gm-Message-State: AOAM5325m83IKTk8TPKgP+UQJPN3z8dnkkCDYGahEU5GZ7WQMabALfg0
        Nywy+0POJ4kQFacN//RBJ49gKAt+hkhtlCWWJ8JCSbf2MzPaNeJ1KYbxqDyWmj5gEMJt/EB475y
        Pg1XHbJeuI1ANdjNgCKZl4g==
X-Received: by 2002:a17:902:6b89:b0:154:623c:9517 with SMTP id p9-20020a1709026b8900b00154623c9517mr35687028plk.45.1649747759850;
        Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7Spm6ydmB4c+gNo+WzpTpSsuGx/B9P8qij+KvJBZZhrNiJwtOL5scK9AARgGePEjvxDGr1g==
X-Received: by 2002:a17:902:6b89:b0:154:623c:9517 with SMTP id p9-20020a1709026b8900b00154623c9517mr35687003plk.45.1649747759617;
        Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
Received: from [10.72.14.5] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b001c7ecaf9e13sm1705890pjy.35.2022.04.12.00.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:15:59 -0700 (PDT)
Message-ID: <ccd0fd5d-389a-70e9-ae48-406514e383d6@redhat.com>
Date:   Tue, 12 Apr 2022 15:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v9 27/32] virtio: add helper virtio_find_vqs_ctx_size()
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
 <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220406034346.74409-28-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/4/6 上午11:43, Xuan Zhuo 写道:
> Introduce helper virtio_find_vqs_ctx_size() to call find_vqs and specify
> the maximum size of each vq ring.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/virtio_config.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 0f7def7ddfd2..22e29c926946 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -235,6 +235,18 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>   				      ctx, desc);
>   }
>   
> +static inline
> +int virtio_find_vqs_ctx_size(struct virtio_device *vdev, u32 nvqs,
> +				 struct virtqueue *vqs[],
> +				 vq_callback_t *callbacks[],
> +				 const char * const names[],
> +				 u32 sizes[],
> +				 const bool *ctx, struct irq_affinity *desc)
> +{
> +	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, sizes,
> +				      ctx, desc);
> +}
> +
>   /**
>    * virtio_device_ready - enable vq use in probe function
>    * @vdev: the device

