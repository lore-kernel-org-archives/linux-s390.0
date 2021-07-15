Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294BC07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC41613BB
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 10:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhGOKEu (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 06:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231854AbhGOKEt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 06:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626343316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNbe1og/tc+798JHBvXCBvhqALKUF9irU9Aw/lDGGBk=;
        b=AA9UJbBXXG/H7ZWVt1w8GQSkzshktFB3DIOpb069el34MNPi5Ihf08WO05W8LRi5O9D40u
        tnX7+6oc+ELUewO3dnJo6KkOjUWkCMHsgTC61GxJqgSlmuaqYpnYGQc70wifzjvJF7UHRz
        xwqhwoCZq2f7OrnqEqdKdQznDBPUEQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-NJg_PI4DNwCmkDq1qJ5e7g-1; Thu, 15 Jul 2021 06:01:55 -0400
X-MC-Unique: NJg_PI4DNwCmkDq1qJ5e7g-1
Received: by mail-wr1-f72.google.com with SMTP id r11-20020a5d52cb0000b02901309f5e7298so3115930wrv.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 03:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CNbe1og/tc+798JHBvXCBvhqALKUF9irU9Aw/lDGGBk=;
        b=N1DATncLSiCBEyIrvzehsrgAghwN6my4UNV/KA/C/A4b/hmSX4BkJtdIY2xZ+mN5/q
         mprJt+EoroZy6jIzakAnbHvbcZaZZITZfjI8zUH0MXlOxHuSo+GSaFiK4O2Ta92MZW0V
         WpWlNi+tKMmw6Mh/XjvTPxSyMXoQ5tJXFE/miFOUMMMvXAbeW3jTRQ5V2k00EiNta3eT
         DAjsUA7YOKKVnnrheQh3m87NZjaxVXbI1KETaN+Zzth6LbQ4OqOfn4zYKnwKQw8YEyfV
         OVZxpjb/4JtRULFGg+G0Ik5fmmpx3th5Hs0w1mdzVcq9fzfcP4HrOcbFyCtmSCl3jW61
         hjyg==
X-Gm-Message-State: AOAM532ccucpzN+wyjphwVrFPHZViyTQpnY1mMQoVjayUiUvxEyk0+U/
        tspVOb8ZJicqHGbyLqjIkdPycBPTr+DFv3W54jmx0Ttj4wYlb/GaUzbF359a8A5fk6+67oAtuny
        Yuwi0zCrilN+ZqEWlFz9Zgw==
X-Received: by 2002:adf:f907:: with SMTP id b7mr4420266wrr.357.1626343314023;
        Thu, 15 Jul 2021 03:01:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCdk3gFlH7qR1OyRZRpfzhZ2RUgGdXu37nEgkGzBJryV1CwYLv6QTxt7ftew3Y5A11F14TUA==
X-Received: by 2002:adf:f907:: with SMTP id b7mr4420139wrr.357.1626343312969;
        Thu, 15 Jul 2021 03:01:52 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id l20sm4956850wmq.3.2021.07.15.03.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:01:52 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] s390x: KVM: accept STSI for CPU topology
 information
To:     Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <1626276343-22805-1-git-send-email-pmorel@linux.ibm.com>
 <1626276343-22805-2-git-send-email-pmorel@linux.ibm.com>
 <db788a8c-99a9-6d99-07ab-b49e953d91a2@redhat.com> <87fswfdiuu.fsf@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <57e57ba5-62ea-f1ff-0d83-5605d57be92d@redhat.com>
Date:   Thu, 15 Jul 2021 12:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87fswfdiuu.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15.07.21 11:30, Cornelia Huck wrote:
> On Thu, Jul 15 2021, David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.07.21 17:25, Pierre Morel wrote:
>>> STSI(15.1.x) gives information on the CPU configuration topology.
>>> Let's accept the interception of STSI with the function code 15 and
>>> let the userland part of the hypervisor handle it.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>    arch/s390/kvm/priv.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>>> index 9928f785c677..4ab5f8b7780e 100644
>>> --- a/arch/s390/kvm/priv.c
>>> +++ b/arch/s390/kvm/priv.c
>>> @@ -856,7 +856,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>    	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>>    		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>>    
>>> -	if (fc > 3) {
>>> +	if (fc > 3 && fc != 15) {
>>>    		kvm_s390_set_psw_cc(vcpu, 3);
>>>    		return 0;
>>>    	}
>>> @@ -893,6 +893,15 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>    			goto out_no_data;
>>>    		handle_stsi_3_2_2(vcpu, (void *) mem);
>>>    		break;
>>> +	case 15:
>>> +		if (sel1 != 1 || sel2 < 2 || sel2 > 6)
>>> +			goto out_no_data;
>>> +		if (vcpu->kvm->arch.user_stsi) {
>>> +			insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
>>> +			return -EREMOTE;
> 
> This bypasses the trace event further down.
> 
>>> +		}
>>> +		kvm_s390_set_psw_cc(vcpu, 3);
>>> +		return 0;
>>>    	}
>>>    	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>>>    		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>>>
>>
>> 1. Setting GPRS to 0
>>
>> I was wondering why we have the "vcpu->run->s.regs.gprs[0] = 0;"
>> for existing fc 1,2,3 in case we set cc=0.
>>
>> Looking at the doc, all I find is:
>>
>> "CC 0: Requested configuration-level number placed in
>> general register 0 or requested SYSIB informa-
>> tion stored"
>>
>> But I don't find where it states that we are supposed to set
>> general register 0 to 0. Wouldn't we also have to do it for
>> fc=15 or for none?
>>
>> If fc 1,2,3 and 15 are to be handled equally, I suggest the following:
>>
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 9928f785c677..6eb86fa58b0b 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -893,17 +893,23 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>                           goto out_no_data;
>>                   handle_stsi_3_2_2(vcpu, (void *) mem);
>>                   break;
>> +       case 15:
>> +               if (sel1 != 1 || sel2 < 2 || sel2 > 6)
>> +                       goto out_no_data;
>> +               break;
>>           }
>> -       if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>> -               memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>> -                      PAGE_SIZE);
>> -               rc = 0;
>> -       } else {
>> -               rc = write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
>> -       }
>> -       if (rc) {
>> -               rc = kvm_s390_inject_prog_cond(vcpu, rc);
>> -               goto out;
>> +       if (mem) {
>> +               if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>> +                       memcpy((void *)sida_origin(vcpu->arch.sie_block),
>> +                              (void *)mem, PAGE_SIZE);
>> +               } else {
>> +                       rc = write_guest(vcpu, operand2, ar, (void *)mem,
>> +                                        PAGE_SIZE);
>> +                       if (rc) {
>> +                               rc = kvm_s390_inject_prog_cond(vcpu, rc);
>> +                               goto out;
>> +                       }
>> +               }
>>           }
>>           if (vcpu->kvm->arch.user_stsi) {
>>                   insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
> 
> Something like that sounds good, the code is getting a bit convoluted.
> 
>>
>>
>> 2. maximum-MNest facility
>>
>> "
>> 1. If the maximum-MNest facility is installed and
>> selector 2 exceeds the nonzero model-depen-
>> dent maximum-selector-2 value."
>>
>> 2. If the maximum-MNest facility is not installed and
>> selector 2 is not specified as two.
>> "
>>
>> We will we be handling the presence/absence of the maximum-MNest facility
>> (for our guest?) in QEMU, corect?
>>
>> I do wonder if we should just let any fc=15 go to user space let the whole
>> sel1 / sel2 checking be handled there. I don't think it's a fast path after all.
>> But no strong opinion.
> 
> If that makes handling easier, I think it would be a good idea.
> 
>>
>> How do we identify availability of maximum-MNest facility?
>>
>>
>> 3. User space awareness
>>
>> How can user space identify that we actually forward these intercepts?
>> How can it enable them? The old KVM_CAP_S390_USER_STSI capability
>> is not sufficient.
> 
> Why do you think that it is not sufficient? USER_STSI basically says
> "you may get an exit that tells you about a buffer to fill in some more
> data for a stsi command, and we also tell you which call". If userspace
> does not know what to add for a certain call, it is free to just do
> nothing, and if it does not get some calls it would support, that should
> not be a problem, either?

If you migrate your VM from machine a to machine b, from kernel a to 
kernel b, and kernel b does not trigger exits to user space for fc=15, 
how could QEMU spot and catch the different capabilities to make sure 
the guest can continue using the feature?


-- 
Thanks,

David / dhildenb

