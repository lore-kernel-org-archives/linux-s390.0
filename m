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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15399C07E9C
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 12:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25D6620DC
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 12:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhGFMGS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:06:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242409AbhGFMCe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 08:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625572795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uW+E9jScNZ5agh1jL2MsJyyJ0npRr318JrpawlDgYKM=;
        b=GF1mC7uCBZnNzh96WqufvL/F+t/2rhzn82Y2RIz0hLnxzaSO7lFYSnkL7YMziy6EWJ5PVT
        Y7AFqTP0ZmXGs0rxbo1ayMccKaBOjcRy39/a+eqX4PyxVo/HJG6eCpwGrR8IbeVTY8hSir
        FNsQB59tlOvtu7kvQ+yChFkUf8H709o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-Yi14OPNrPdGenn4eSGxfig-1; Tue, 06 Jul 2021 07:59:54 -0400
X-MC-Unique: Yi14OPNrPdGenn4eSGxfig-1
Received: by mail-wr1-f71.google.com with SMTP id h15-20020adffd4f0000b0290137e68ed637so322906wrs.22
        for <linux-s390@vger.kernel.org>; Tue, 06 Jul 2021 04:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uW+E9jScNZ5agh1jL2MsJyyJ0npRr318JrpawlDgYKM=;
        b=hdZc8L25SsOoxZx5KwOwrk05vDVFpcp58pYMXPdUDyp595WkrMiuw5LIzsulLQXWXV
         Qw92bZoq2GPW4gYXGfBjM84kr6pO0plokRk4vFetOqLqEwsi8pNefcKQUXbCW9pzbBuW
         TNu48FQRNiVxEfWrYGrUPZXxWVOvMo2PwouRqhfFne12e9Ez1gKC28WItNEQLXTQjC+r
         xEVJFABSsqcrALIl3iY/CSuIqPPZssZNgw+XAiQfxLPoiIkwCzZSF2h1Y3OnKcDA5LIO
         SYJtnxcvcJz0YvmZ9mpT1JD+Z7L68YWcw+IObd+vAXtYHd2CSnDt2JHuByd26qJucxsA
         AP0w==
X-Gm-Message-State: AOAM532x8HtXiJHJeHqMiQNk0+1eSfBVb3M2iXQQsmHgul4+PDTKdFm2
        EBawPiDhfaO/KvaKOMHnI2asGuEy5+fnoxhQ3B3ThvePF0o2CBLIkxSa5NIUj1mP85AJgTs5chG
        DoqQFpQaQokb7EYeR2Ss+9w==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr21254998wrw.155.1625572793086;
        Tue, 06 Jul 2021 04:59:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2u4QcVp8Z//R1GNAmE7RUOVZhrVIPxFfJvCNi9/yctbFPEoASdoc9aUnMXgr/0BSKnUccmw==
X-Received: by 2002:a5d:69c9:: with SMTP id s9mr21254984wrw.155.1625572792939;
        Tue, 06 Jul 2021 04:59:52 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id h13sm5700227wrs.68.2021.07.06.04.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 04:59:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: s390: Enable specification exception interpretation
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <be78ce5d-92e4-36bd-aa28-e32db0342a44@redhat.com>
Date:   Tue, 6 Jul 2021 13:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <194128c1-8886-5b8b-2249-5ec58b8e7adb@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 06.07.21 13:56, Christian Borntraeger wrote:
> 
> 
> On 06.07.21 13:52, Cornelia Huck wrote:
>> On Tue, Jul 06 2021, Janis Schoetterl-Glausch <scgl@linux.ibm.com> wrote:
>>
>>> When this feature is enabled the hardware is free to interpret
>>> specification exceptions generated by the guest, instead of causing
>>> program interruption interceptions.
>>>
>>> This benefits (test) programs that generate a lot of specification
>>> exceptions (roughly 4x increase in exceptions/sec).
>>>
>>> Interceptions will occur as before if ICTL_PINT is set,
>>> i.e. if guest debug is enabled.
>>>
>>> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
>>> ---
>>> I'll additionally send kvm-unit-tests for testing this feature.
>>>
>>>    arch/s390/include/asm/kvm_host.h | 1 +
>>>    arch/s390/kvm/kvm-s390.c         | 2 ++
>>>    arch/s390/kvm/vsie.c             | 2 ++
>>>    3 files changed, 5 insertions(+)
>>
>> (...)
>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index b655a7d82bf0..aadd589a3755 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3200,6 +3200,8 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>>    		vcpu->arch.sie_block->ecb |= ECB_SRSI;
>>>    	if (test_kvm_facility(vcpu->kvm, 73))
>>>    		vcpu->arch.sie_block->ecb |= ECB_TE;
>>> +	if (!kvm_is_ucontrol(vcpu->kvm))
>>> +		vcpu->arch.sie_block->ecb |= ECB_SPECI;
>>
>> Does this exist for any hardware version (i.e. not guarded by a cpu
>> feature?)
> 
> Not for all hardware versions, but also no indication. The architecture
> says that the HW is free to do this or not. (which makes the vsie code
> simpler).

I remember the architecture said at some point to never set undefined 
bits - and this bit is undefined on older HW generations. I might be 
wrong, though.

(I though HW learned the lesson to always use proper feature indications 
along with new features)


-- 
Thanks,

David / dhildenb

