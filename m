Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60568C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  1 Jul 2022 09:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbiGAJgx (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiGAJgw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Jul 2022 05:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8E0874DC9
        for <linux-s390@vger.kernel.org>; Fri,  1 Jul 2022 02:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656668211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dN2Ed9BguDI5gyWO5SlL0rnKl20jgh9B0B8prvlwR0=;
        b=WBDAzqiBJzmQV0Qb8JICA/rd9aWQ087sq0CN6wpivBucy3lGUW15q4UlOznf3UezOJ7jGQ
        vVPXxQsPqjZ+MU0dk+FhM1eMlidhY7X+iVCCdOmH5ixOY0/QySkZZfUeToxSxqt6ancHHQ
        4Io3yfFFN8BhPlh9OFtDARWvGoumWPo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-lrodVgLuNMGJaSj_zWAUhA-1; Fri, 01 Jul 2022 05:36:49 -0400
X-MC-Unique: lrodVgLuNMGJaSj_zWAUhA-1
Received: by mail-pl1-f200.google.com with SMTP id z5-20020a170903018500b0016a561649abso1212918plg.12
        for <linux-s390@vger.kernel.org>; Fri, 01 Jul 2022 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3dN2Ed9BguDI5gyWO5SlL0rnKl20jgh9B0B8prvlwR0=;
        b=u5ysQkXq4ySBHnfst5mzucI9HqSLjXdzXWCvEjmRfPaVY8EGnlHriooXxHPppvdN6M
         uinTC/0gKtcB+Su+CJWaqpHhmbux3Fm3XwUdQyaZUCERXdTO/rX9lKqQcUVFCVY7m6M9
         aC4HH73f+rIfolPFB4a0/UqjNtslAgg47IXggtft0E7RyBtSptsgk0sDPSYXCuuG64aE
         JmE2uMErXY79mZ0zSHnfsVNGONlKnz7K3GSKH4RgOOLgFKuS28d4bzEBKpZyWEuRQk0E
         ipies4PY70DU8OB2k6oR4LAgR22BEVilHrgsR2yYdNKT6V/GrgDcQzH+DRO7sVFDnn+v
         5Ljw==
X-Gm-Message-State: AJIora95g+Th8f/vlS089Ycnnx5vZmU0GLB9SsSYYjXG53GRcvOOHXN5
        BKa8yrd5/3TSVBANlbDUGXb3pqOjSQ8bJVzns8BJEpDFd5XdlahDZrGAQJvHKLlkIBvvFM1s9VD
        UTCjgX0k0QUvtKoPSvn+ezA==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id j14-20020a170903024e00b0016b9fa241e5mr13769771plh.127.1656668208674;
        Fri, 01 Jul 2022 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s2tQyLCXMrbx9yXxpYY9TeU2uoF6cGR+tGI1XuAVQyHwDEpf0d8SFWt7v9pCDnMz5Bdj+bww==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id j14-20020a170903024e00b0016b9fa241e5mr13769722plh.127.1656668208349;
        Fri, 01 Jul 2022 02:36:48 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t129-20020a625f87000000b005259578e8fcsm11802013pfb.181.2022.07.01.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:36:47 -0700 (PDT)
Message-ID: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Date:   Fri, 1 Jul 2022 17:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     virtualization@lists.linux-foundation.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
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
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220701022950-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/1 14:31, Michael S. Tsirkin 写道:
> On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
>> This patch allows the new introduced
>> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
>> virtqueue.
>>
>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> I wonder how this interacts with the hardening patches.
> Jason?


Consider we've marked it as broken, I think we don't need to care about 
the hardening in this series. Just make it work without hardening.

And I will handle vq reset when rework the IRQ hardening.

Thanks


>
>> ---
>>   drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>>   include/linux/virtio.h       |  3 +++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 5ec43607cc15..7b02be7fce67 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>>   }
>>   EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>>   
>> +/*
>> + * This function should only be called by the core, not directly by the driver.
>> + */
>> +void __virtqueue_break(struct virtqueue *_vq)
>> +{
>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>> +
>> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>> +	WRITE_ONCE(vq->broken, true);
>> +}
>> +EXPORT_SYMBOL_GPL(__virtqueue_break);
>> +
>> +/*
>> + * This function should only be called by the core, not directly by the driver.
>> + */
>> +void __virtqueue_unbreak(struct virtqueue *_vq)
>> +{
>> +	struct vring_virtqueue *vq = to_vvq(_vq);
>> +
>> +	/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>> +	WRITE_ONCE(vq->broken, false);
>> +}
> I don't think these "Pairs" comments have any value.
>
>
>> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>> +
>>   bool virtqueue_is_broken(struct virtqueue *_vq)
>>   {
>>   	struct vring_virtqueue *vq = to_vvq(_vq);
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 1272566adec6..dc474a0d48d1 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>>   void virtio_break_device(struct virtio_device *dev);
>>   void __virtio_unbreak_device(struct virtio_device *dev);
>>   
>> +void __virtqueue_break(struct virtqueue *_vq);
>> +void __virtqueue_unbreak(struct virtqueue *_vq);
>> +
>>   void virtio_config_changed(struct virtio_device *dev);
>>   #ifdef CONFIG_PM_SLEEP
>>   int virtio_device_freeze(struct virtio_device *dev);
>> -- 
>> 2.31.0

