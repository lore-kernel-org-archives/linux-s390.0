Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADDC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Jul 2022 03:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGDDrr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Jul 2022 23:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiGDDrq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Jul 2022 23:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA966308
        for <linux-s390@vger.kernel.org>; Sun,  3 Jul 2022 20:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656906464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
        b=PBE4QMNNI0M/8LlN62bMqbOEl7LajpLJLO5Ur/m6yb1qveGNYnptNc5rTBuAUBQ3q3ILEw
        p0pK7yA797kZ1EpBBjfInICTDMDD1aZvhGvJ0ify/D92YIBbdmUF6v4ap3FgPXVkhlyu+u
        w+6UzeQxE3L8927Dlo2eXXiBbfGH4CU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-caiTS1QzPmapdAX3mr_ONQ-1; Sun, 03 Jul 2022 23:47:43 -0400
X-MC-Unique: caiTS1QzPmapdAX3mr_ONQ-1
Received: by mail-pf1-f197.google.com with SMTP id 138-20020a621890000000b00527c88db25fso2122999pfy.12
        for <linux-s390@vger.kernel.org>; Sun, 03 Jul 2022 20:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
        b=wrZyQKEB4CS9HPGDL2powZq9tGQXou4uSzBVaqlvfA5AMofVt4ML33XHW+2R7mVe87
         H1WRHaCvOxQKcTlspDw7DJ641IZUJ5vBrEVKCI1WttrqxEamlpSMZeNL6eNQSeD9KAiu
         HS5FPbtfIjOFaGM3cM8yGHFZT8A9u0wl5hGYYnLd7DJhLOv6Xwyjj7OzmIkobc0PZ0VN
         UI98t+dwNDiO1QZLVU9Bx1Up8oLoKlBrYHP0akAbo2jQztN5gGe1/LM/0mdKn1fy3Pnv
         evcttz9VnAtEFPE6o1NoPUbEW1yD45t2cHX18Q0xM8R0Nca7lzjyu3SqLqG1uyFs58qO
         husQ==
X-Gm-Message-State: AJIora8uEEAq2Khj4jArebO6xL1u/bfKfbo9dj2xKMssGDxX6peuawTY
        T5Aoy8Hpmkbhr0IxkFyY1LHd70CzEsl9Rw5TW0rkg8l/Pux4E2G2m0t9EXNmPdon57acMe2mjR2
        +vVP1n7U8VdAuIPgFbcacsg==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id ay7-20020a1709028b8700b0016905e543demr33751357plb.8.1656906461958;
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urar+tEFxn2OYR0nSzN1qR/6pFNL30ksJWbHZrPH1ZYknebpnFXj10hmhcTKfVqx002oRx8A==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id ay7-20020a1709028b8700b0016905e543demr33751314plb.8.1656906461703;
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090a7c4b00b001eee8998f2esm8701227pjl.17.2022.07.03.20.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Message-ID: <2fdff856-cddf-1235-8078-312de94600c7@redhat.com>
Date:   Mon, 4 Jul 2022 11:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
Content-Language: en-US
From:   Jason Wang <jasowang@redhat.com>
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
 <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
In-Reply-To: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


在 2022/7/1 17:36, Jason Wang 写道:
>
> 在 2022/7/1 14:31, Michael S. Tsirkin 写道:
>> On Wed, Jun 29, 2022 at 02:56:41PM +0800, Xuan Zhuo wrote:
>>> This patch allows the new introduced
>>> __virtqueue_break()/__virtqueue_unbreak() to break/unbreak the
>>> virtqueue.
>>>
>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> I wonder how this interacts with the hardening patches.
>> Jason?
>
>
> Consider we've marked it as broken, I think we don't need to care 
> about the hardening in this series. Just make it work without hardening.
>
> And I will handle vq reset when rework the IRQ hardening.
>
> Thanks


Rethink of this, I think Xuan's code should be fine. We know we will 
have another rework.

Thanks


>
>
>>
>>> ---
>>>   drivers/virtio/virtio_ring.c | 24 ++++++++++++++++++++++++
>>>   include/linux/virtio.h       |  3 +++
>>>   2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio_ring.c 
>>> b/drivers/virtio/virtio_ring.c
>>> index 5ec43607cc15..7b02be7fce67 100644
>>> --- a/drivers/virtio/virtio_ring.c
>>> +++ b/drivers/virtio/virtio_ring.c
>>> @@ -2744,6 +2744,30 @@ unsigned int virtqueue_get_vring_size(struct 
>>> virtqueue *_vq)
>>>   }
>>>   EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>>>   +/*
>>> + * This function should only be called by the core, not directly by 
>>> the driver.
>>> + */
>>> +void __virtqueue_break(struct virtqueue *_vq)
>>> +{
>>> +    struct vring_virtqueue *vq = to_vvq(_vq);
>>> +
>>> +    /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>>> +    WRITE_ONCE(vq->broken, true);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__virtqueue_break);
>>> +
>>> +/*
>>> + * This function should only be called by the core, not directly by 
>>> the driver.
>>> + */
>>> +void __virtqueue_unbreak(struct virtqueue *_vq)
>>> +{
>>> +    struct vring_virtqueue *vq = to_vvq(_vq);
>>> +
>>> +    /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>>> +    WRITE_ONCE(vq->broken, false);
>>> +}
>> I don't think these "Pairs" comments have any value.
>>
>>
>>> +EXPORT_SYMBOL_GPL(__virtqueue_unbreak);
>>> +
>>>   bool virtqueue_is_broken(struct virtqueue *_vq)
>>>   {
>>>       struct vring_virtqueue *vq = to_vvq(_vq);
>>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>>> index 1272566adec6..dc474a0d48d1 100644
>>> --- a/include/linux/virtio.h
>>> +++ b/include/linux/virtio.h
>>> @@ -138,6 +138,9 @@ bool is_virtio_device(struct device *dev);
>>>   void virtio_break_device(struct virtio_device *dev);
>>>   void __virtio_unbreak_device(struct virtio_device *dev);
>>>   +void __virtqueue_break(struct virtqueue *_vq);
>>> +void __virtqueue_unbreak(struct virtqueue *_vq);
>>> +
>>>   void virtio_config_changed(struct virtio_device *dev);
>>>   #ifdef CONFIG_PM_SLEEP
>>>   int virtio_device_freeze(struct virtio_device *dev);
>>> -- 
>>> 2.31.0

