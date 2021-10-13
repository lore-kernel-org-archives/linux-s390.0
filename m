Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A19C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 05:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEC360FDC
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 05:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhJMF4w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhJMF4w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 01:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634104489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36TQyv1tkrVCD2OJe4MoRPXDFmMJ7xeIWgzS4AnZy0M=;
        b=ILKWxCo2ZEFdXcFUYc1Mg6c7bqLNRMZWiT45TufXCBrN1WcVUa7CwCuym8FDfr2ac4NNnJ
        E5V7Fiycn2UhmqSYi3sH0oodyO5Wl2jnFBPQ14SrT8dTlcBLdq4JTpjl7UP+u9hk3R5u/U
        0iK1Zuffxamgly4oG/zBSNbTT3wEd5M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354--6RkrWdePeCaXVZvMZWb2w-1; Wed, 13 Oct 2021 01:54:47 -0400
X-MC-Unique: -6RkrWdePeCaXVZvMZWb2w-1
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so1023609wrv.19
        for <linux-s390@vger.kernel.org>; Tue, 12 Oct 2021 22:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=36TQyv1tkrVCD2OJe4MoRPXDFmMJ7xeIWgzS4AnZy0M=;
        b=ofL6k70RVNrNMAebLfSGcvL4+iErR0VPh8tjADehIZWYhmp78am6WjPj3+2buySU49
         OfLNXQNDUGgnzRx1NtWAElJ9x3sbvsfUncdsvULbeDUguV4OagWjXnh/17XoMfHzWm4p
         MCyq0eINdt1Kl1CY/2HNyfaP3jomkdJk/5Go2TSVj5m86AphDrDnsNEFeitrE6cH5w6K
         BW7X1JsKBHpqOuOwPKkBfFSZYKcfKaRFjHRn9cREQyWBud7lWRImPUoTnw+Sc8np4CPs
         63P66B+4v0XyY+LhCgydi7jXyyBLU+bvmu3qfor+SLvgT84HA/bkWmAdHaeb4xt9y7hi
         GyPg==
X-Gm-Message-State: AOAM533NKF1FypZKQffx6Lkr/uQlazKe8acWXK0/hT2Z6O9DVHbfe53w
        do79iB3JuQlOnN8yuAwQS+ChB/R90ctV45Ob6M1MeiLw6sybjSzURwxodABsUiFcoaYfcceDwi4
        +bLXcj6r4UN5GQDimzDxr6vgsJOTWbp4CpGaiHP99D2CwpNWXDYH57GthiCQNtP76s0OBXQ==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr20148271wro.349.1634104486496;
        Tue, 12 Oct 2021 22:54:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQIFqCrJmKi0oQJI/PaFHFODSUXwJ9TiIIfLaI3R4IHzQMNI/aFl83PINtlnvXqS5rO7oQ/Q==
X-Received: by 2002:adf:ee8b:: with SMTP id b11mr20148239wro.349.1634104486179;
        Tue, 12 Oct 2021 22:54:46 -0700 (PDT)
Received: from thuth.remote.csb (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id r4sm699269wrz.58.2021.10.12.22.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:54:45 -0700 (PDT)
Subject: Re: [RFC PATCH v1 3/6] KVM: s390: Simplify SIGP Restart
To:     Eric Farman <farman@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20211008203112.1979843-1-farman@linux.ibm.com>
 <20211008203112.1979843-4-farman@linux.ibm.com>
 <e3b874c1-e220-5e23-bd67-ed08c261e425@de.ibm.com>
 <518fea79-1579-ee4a-c09b-ae4e70e32d96@redhat.com>
 <0e4bb561170a287cea4124e9da56dfc4bd4a0eab.camel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <d30c2f8b-73f1-5639-dbb4-2e70b5982c62@redhat.com>
Date:   Wed, 13 Oct 2021 07:54:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0e4bb561170a287cea4124e9da56dfc4bd4a0eab.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/10/2021 17.31, Eric Farman wrote:
> On Tue, 2021-10-12 at 17:23 +0200, Thomas Huth wrote:
>> On 11/10/2021 09.45, Christian Borntraeger wrote:
>>>
>>> Am 08.10.21 um 22:31 schrieb Eric Farman:
>>>> Now that we check for the STOP IRQ injection at the top of the
>>>> SIGP
>>>> handler (before the userspace/kernelspace check), we don't need
>>>> to do
>>>> it down here for the Restart order.
>>>>
>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>> ---
>>>>    arch/s390/kvm/sigp.c | 11 +----------
>>>>    1 file changed, 1 insertion(+), 10 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
>>>> index 6ca01bbc72cf..0c08927ca7c9 100644
>>>> --- a/arch/s390/kvm/sigp.c
>>>> +++ b/arch/s390/kvm/sigp.c
>>>> @@ -240,17 +240,8 @@ static int __sigp_sense_running(struct
>>>> kvm_vcpu *vcpu,
>>>>    static int __prepare_sigp_re_start(struct kvm_vcpu *vcpu,
>>>>                       struct kvm_vcpu *dst_vcpu, u8 order_code)
>>>>    {
>>>> -    struct kvm_s390_local_interrupt *li = &dst_vcpu-
>>>>> arch.local_int;
>>>>        /* handle (RE)START in user space */
>>>> -    int rc = -EOPNOTSUPP;
>>>> -
>>>> -    /* make sure we don't race with STOP irq injection */
>>>> -    spin_lock(&li->lock);
>>>> -    if (kvm_s390_is_stop_irq_pending(dst_vcpu))
>>>> -        rc = SIGP_CC_BUSY;
>>>> -    spin_unlock(&li->lock);
>>>> -
>>>> -    return rc;
>>>> +    return -EOPNOTSUPP;
>>>>    }
>>>>    static int __prepare_sigp_cpu_reset(struct kvm_vcpu *vcpu,
>>>>
>>>
>>> @thuth?
>>> Question is, does it make sense to merge patch 2 and 3 to make
>>> things more
>>> obvious?
>>
>> Maybe.
>>
>> Anyway: Would it make sense to remove __prepare_sigp_re_start()
>> completely
>> now and let __prepare_sigp_unknown() set the return code in the
>> "default:" case?
> 
> We could, but that would affect the SIGP START case which also uses the
> re_start routine. And if we're going down that path, we could remove
> (INITIAL) CPU RESET handled in __prepare_sigp_cpu_reset, which does the
> same thing (nothing). Not sure it buys us much, other than losing the
> details in the different counters of which SIGP orders are processed.

Ok, we likely shouldn't change the way of counting the SIGPs here...
So what about removing the almost empty function and simply do the "rc = 
-EOPNOTSUPP" right in the handle_sigp_dst() function? That's still the 
easiest way to read the code, I think. And we should do the same with the 
__prepare_sigp_cpu_reset() function (in a separate patch). Just my 0.02 € of 
course.

  Thomas

