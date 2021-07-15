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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4AFC07E96
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0733C61289
	for <linux-s390@archiver.kernel.org>; Thu, 15 Jul 2021 10:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbhGOKWD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Jul 2021 06:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236097AbhGOKWD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Jul 2021 06:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626344349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jR3KatBcxlwAczrw0rLoEvpazGUbKf9pmoFJLQuH08=;
        b=hJcOzfw4Uc6mnvT7mbhqGxxSlFjgGXMmQj40x+WzuM/BEzWMr1uqvlVQ6vl/gvfgtIr9aQ
        tYI3kknM1MIy9ilIkzGPFQ6JgP6/Dzoh/F7kVd5dOAn75LGFVjLffblI2z70U1jG796gR9
        WiT4DXtZ+0CzuiH4N9lLfmdfC46Pm9c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-0sGjX9jJMDOdZxlDU34nwg-1; Thu, 15 Jul 2021 06:19:08 -0400
X-MC-Unique: 0sGjX9jJMDOdZxlDU34nwg-1
Received: by mail-wm1-f71.google.com with SMTP id j141-20020a1c23930000b0290212502cb19aso1607774wmj.0
        for <linux-s390@vger.kernel.org>; Thu, 15 Jul 2021 03:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6jR3KatBcxlwAczrw0rLoEvpazGUbKf9pmoFJLQuH08=;
        b=CR0VSNPc6r64AKRoOnVUYVjx7BbA38+Gl6obEwt/0xo654h3U8L8617TJNTDwOd+1o
         S018p7qJazS7pezA6PYpi5KRxsEVFPNbWvB36Gj2kHYVEV4joCYkA66h9pqU9flRmH19
         bpsfmQoMKme3zAvvUTouzbJ+hFzqd6kfuVh8Dz/z2if1XRSot2z+tP8ZlGyjg57fSuxV
         9B+eADpAsRI+RNwQCN1pIOWqYprXv+apYnkpjRKxHbJs6ct+0thue9kDhus3s868YJUG
         BCkU4pAr3LFHDuU1u24O1AlCN4xaNWayTyDIw1z1e0lkJHZXH5Yt3PBb8ye9qSQuY9Ln
         gzWg==
X-Gm-Message-State: AOAM530J4mtyOmmggYCc2IvHHUE4SqVScJOuxuptui3EQaxz3aYNp0+Z
        qM9zohU8f8NndG3wK6cShSKkd0KdPhujdqJG+o3WYwyqoK3zwtJkOQCSr+qlIIj/Lt809BSLiK4
        k3rsov/3AgDDEuYY8HqNKRg==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr9485717wmp.70.1626344347233;
        Thu, 15 Jul 2021 03:19:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqXICUptfAgs1WskQT2LaAUeMs+Xb4YQ4yPO/1HzO2Dls4HXB4OKgIbN58GfpKWRrhRZIiNQ==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr9485687wmp.70.1626344346955;
        Thu, 15 Jul 2021 03:19:06 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23bb3.dip0.t-ipconnect.de. [79.242.59.179])
        by smtp.gmail.com with ESMTPSA id g18sm4556914wmk.37.2021.07.15.03.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:19:06 -0700 (PDT)
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
 <57e57ba5-62ea-f1ff-0d83-5605d57be92d@redhat.com> <87czrjdgrd.fsf@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6df8a43f-ddba-75ef-0aa7-f873bb8e0032@redhat.com>
Date:   Thu, 15 Jul 2021 12:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87czrjdgrd.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 15.07.21 12:16, Cornelia Huck wrote:
> On Thu, Jul 15 2021, David Hildenbrand <david@redhat.com> wrote:
> 
>> On 15.07.21 11:30, Cornelia Huck wrote:
>>> On Thu, Jul 15 2021, David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 14.07.21 17:25, Pierre Morel wrote:
>>>>> STSI(15.1.x) gives information on the CPU configuration topology.
>>>>> Let's accept the interception of STSI with the function code 15 and
>>>>> let the userland part of the hypervisor handle it.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>     arch/s390/kvm/priv.c | 11 ++++++++++-
>>>>>     1 file changed, 10 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>>>>> index 9928f785c677..4ab5f8b7780e 100644
>>>>> --- a/arch/s390/kvm/priv.c
>>>>> +++ b/arch/s390/kvm/priv.c
>>>>> @@ -856,7 +856,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>>>     	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>>>>     		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>>>>     
>>>>> -	if (fc > 3) {
>>>>> +	if (fc > 3 && fc != 15) {
>>>>>     		kvm_s390_set_psw_cc(vcpu, 3);
>>>>>     		return 0;
>>>>>     	}
>>>>> @@ -893,6 +893,15 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>>>>     			goto out_no_data;
>>>>>     		handle_stsi_3_2_2(vcpu, (void *) mem);
>>>>>     		break;
>>>>> +	case 15:
>>>>> +		if (sel1 != 1 || sel2 < 2 || sel2 > 6)
>>>>> +			goto out_no_data;
>>>>> +		if (vcpu->kvm->arch.user_stsi) {
>>>>> +			insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
>>>>> +			return -EREMOTE;
>>>
>>> This bypasses the trace event further down.
>>>
>>>>> +		}
>>>>> +		kvm_s390_set_psw_cc(vcpu, 3);
>>>>> +		return 0;
>>>>>     	}
>>>>>     	if (kvm_s390_pv_cpu_is_protected(vcpu)) {
>>>>>     		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
>>>> 3. User space awareness
>>>>
>>>> How can user space identify that we actually forward these intercepts?
>>>> How can it enable them? The old KVM_CAP_S390_USER_STSI capability
>>>> is not sufficient.
>>>
>>> Why do you think that it is not sufficient? USER_STSI basically says
>>> "you may get an exit that tells you about a buffer to fill in some more
>>> data for a stsi command, and we also tell you which call". If userspace
>>> does not know what to add for a certain call, it is free to just do
>>> nothing, and if it does not get some calls it would support, that should
>>> not be a problem, either?
>>
>> If you migrate your VM from machine a to machine b, from kernel a to
>> kernel b, and kernel b does not trigger exits to user space for fc=15,
>> how could QEMU spot and catch the different capabilities to make sure
>> the guest can continue using the feature?
> 
> Wouldn't that imply that the USER_STSI feature, in the function-agnostic
> way it is documented, was broken from the start?

Likely. We should have forwarded everything to user space most probably 
and not try being smart in the kernel.

> 
> Hm. Maybe we need some kind of facility where userspace can query the
> kernel and gets a list of the stsi subcodes it may get exits for, and
> possibly fail to start the migration. Having a new capability to be
> enabled for every new subcode feels like overkill. I don't think we can
> pass a payload ("enable these subfunctions") to a cap.

Maybe a new capability that forwards everything to user space when 
enabled, and lets user space handle errors.

Or a specialized one only to unlock fc=15.

-- 
Thanks,

David / dhildenb

