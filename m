Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74033C07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 07:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D21761CAA
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 07:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhGGH3l (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 03:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhGGH3k (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 03:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625642820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uGQVNsdhqGpbhjnmA9wt9C+nuF+WZ2jtK2PCyQyMaTw=;
        b=dZ+h8Yrc0nuwtsI+sQGsb4uOwiiuohe1uU5AVE0Jm7rSuITt0z4cfUczFnSGx//Jg/3kRP
        H4cladGi5CTNeP1pdzKnR6aSIt6kfIZLBewtjtTiTgb9RmV0n/eAcr7sEhPo9kTgs6hnD4
        XEZ8tA2p1u+Lgh8W5DO0dWt70uqziF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-JZhtEa-kOzu1SsbkYCY91A-1; Wed, 07 Jul 2021 03:26:59 -0400
X-MC-Unique: JZhtEa-kOzu1SsbkYCY91A-1
Received: by mail-wm1-f71.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so601000wmh.9
        for <linux-s390@vger.kernel.org>; Wed, 07 Jul 2021 00:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uGQVNsdhqGpbhjnmA9wt9C+nuF+WZ2jtK2PCyQyMaTw=;
        b=uOj8x0wuJTcHeOQRXe8H6Ts6ZDqP3dXxRJHSfV4b72h3l/gYFsO9MQ1BXPdcGfc/Qw
         8BiPl0HjTk1LSYrKMOxLivqhFzdf0SsFLx4tB62+qLYi7t60FTsd91ApaJiUWEo++bU/
         7IRCGT8FxBz/KbrLMBtdatqftcu0c7RgbwmqAdPQslI6W6I8TDmUVCXp9lwiC2zxYVKZ
         /uabRK7xPc2POMNfN/L4rhYr7vx1hhklbMaNzT58ickKF40NE7EoVTCi3h1arfEvojPW
         kmVjCiceES/9W+N9CF4mbLhqGg/e6XpXNl9pOT733ifchVb6Cd90fSdnjptWkYTmVNqo
         6DUw==
X-Gm-Message-State: AOAM530MI/TZdRwvjq28cQ1jjcBUy6A+H4/rmclSJwMq19HZs2xLPXYE
        rccxXHQoR0UcotvOy/502UwiwAjchPcCfZQr2dBPmMJnZTtajpSN0DFWha7doZBuckY8vmfp1qp
        hO0iAET5DJVpm6X8bIfldww==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr26182438wrt.132.1625642817924;
        Wed, 07 Jul 2021 00:26:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXzjDOByijfL4qxxu9KcSZ+lwMlHGRoG/CutlyDuR3ettXOe6oHRButoxNujMzOd/reUvdrg==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr26182419wrt.132.1625642817687;
        Wed, 07 Jul 2021 00:26:57 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23579.dip0.t-ipconnect.de. [79.242.53.121])
        by smtp.gmail.com with ESMTPSA id 12sm5657418wme.28.2021.07.07.00.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:26:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: Enable specification exception interpretation
To:     Janis Schoetterl-Glausch <scgl@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "open list:KERNEL VIRTUAL MACHINE for s390 (KVM/s390)" 
        <kvm@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210706114714.3936825-1-scgl@linux.ibm.com>
 <87k0m3hd7h.fsf@redhat.com> <194128c1-8886-5b8b-2249-5ec58b8e7adb@de.ibm.com>
 <be78ce5d-92e4-36bd-aa28-e32db0342a44@redhat.com>
 <45690e80-5c7c-1e11-99d5-c0d1482755ad@de.ibm.com>
 <c7d61761-3426-6e44-99a8-7aa9e1cad5b6@redhat.com>
 <8318ce18-65ea-8b4d-4df1-9f9ba79f2bb7@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ba9069e5-04ed-4172-71fd-c029ba7f9f63@redhat.com>
Date:   Wed, 7 Jul 2021 09:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8318ce18-65ea-8b4d-4df1-9f9ba79f2bb7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.07.21 17:27, Janis Schoetterl-Glausch wrote:
> On 7/6/21 5:16 PM, David Hildenbrand wrote:
>> On 06.07.21 14:02, Christian Borntraeger wrote:
>>>
>>>
>>> On 06.07.21 13:59, David Hildenbrand wrote:
>>>> On 06.07.21 13:56, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 06.07.21 13:52, Cornelia Huck wrote:
>>>>>> On Tue, Jul 06 2021, Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>>>>>>
>>>>>>> When this feature is enabled the hardware is free to interpret
>>>>>>> specification exceptions generated by the guest, instead of causing
>>>>>>> program interruption interceptions.
>>>>>>>
>>>>>>> This benefits (test) programs that generate a lot of specification
>>>>>>> exceptions (roughly 4x increase in exceptions/sec).
>>>>>>>
>>>>>>> Interceptions will occur as before if ICTL_PINT is set,
>>>>>>> i.e. if guest debug is enabled.
>>>>>>>
>>>>>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>>>>>> ---
>>>>>>> I'll additionally send kvm-unit-tests for testing this feature.
>>>>>>>
>>>>>>>      arch/s390/include/asm/kvm_host.h | 1 +
>>>>>>>      arch/s390/kvm/kvm-s390.c         | 2 ++
>>>>>>>      arch/s390/kvm/vsie.c             | 2 ++
>>>>>>>      3 files changed, 5 insertions(+)
>>>>>>
>>>>>> (...)
>>>>>>
>>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>>> index b655a7d82bf0..aadd589a3755 100644
>>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>>> @@ -3200,6 +3200,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>>>>>>              vcpu->arch.sie_block->ecb |= ECB_SRSI;
>>>>>>>          if (test_kvm_facility(vcpu->kvm, 73))
>>>>>>>              vcpu->arch.sie_block->ecb |= ECB_TE;
>>>>>>> +    if (!kvm_is_ucontrol(vcpu->kvm))
>>>>>>> +        vcpu->arch.sie_block->ecb |= ECB_SPECI;
>>>>>>
>>>>>> Does this exist for any hardware version (i.e. not guarded by a cpu
>>>>>> feature?)
>>>>>
>>>>> Not for all hardware versions, but also no indication. The architecture
>>>>> says that the HW is free to do this or not. (which makes the vsie code
>>>>> simpler).
>>>>
>>>> I remember the architecture said at some point to never set undefined bits - and this bit is undefined on older HW generations. I might be wrong, though.
>>>
>>> I can confirm that this bit will be ignored on older machines. The notion of
>>> never setting undefined bits comes from "you never know what this bit will
>>> change in future machines". Now we know :-)
>>
>> Well, okay then :)
>>
>> So the plan for vSIE is to always keep it disabled? IIUC, one could similarly always forward the bit of set.
> 
> The bit does get copied for vSIE.

... and I missed that hunk :)

LGTM then

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

