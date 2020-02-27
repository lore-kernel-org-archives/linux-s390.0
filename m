Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729056AbgB0NYy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 08:24:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RDKcRO098341
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 08:24:53 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yden2f7sq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 08:24:53 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 27 Feb 2020 13:24:51 -0000
Subject: Re: [PATCH] KVM: s390: introduce module parameter kvm.use_gisa
References: <20200227091031.102993-1-mimu@linux.ibm.com>
 <c16f65a7-5711-96e2-1527-fa13eab9f5ca@de.ibm.com>
 <48bbf704-11c7-0f67-a5ca-ae2841faccde@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Feb 2020 14:24:46 +0100
MIME-Version: 1.0
In-Reply-To: <48bbf704-11c7-0f67-a5ca-ae2841faccde@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9195cc6d-a266-1c05-cba9-e434cd1bd0b7@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mimu@linux.ibm.com, frankja@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, david@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org



On 27.02.20 13:43, Michael Mueller wrote:
> 
> 
> On 27.02.20 13:27, Christian Borntraeger wrote:
>>
>>
>> On 27.02.20 10:10, Michael Mueller wrote:
>>> The boolean module parameter "kvm.use_gisa" controls if newly
>>> created guests will use the GISA facility if provided by the
>>> host system. The default is yes.
>>>
>>>    # cat /sys/module/kvm/parameters/use_gisa
>>>    Y
>>>
>>> The parameter can be changed on the fly.
>>>
>>>    # echo N > /sys/module/kvm/parameters/use_gisa
>>>
>>> Already running guests are not affected by this change.
>>>
>>> The kvm s390 debug feature shows if a guest is running with GISA.
>>>
>>>    # grep gisa /sys/kernel/debug/s390dbf/kvm-$pid/sprintf
>>>    00 01582725059:843303 3 - 08 00000000e119bc01  gisa 0x00000000c9ac2642 initialized
>>>    00 01582725059:903840 3 - 11 000000004391ee22  00[0000000000000000-0000000000000000]: AIV gisa format-1 enabled for cpu 000
>>>    ...
>>>    00 01582725059:916847 3 - 08 0000000094fff572  gisa 0x00000000c9ac2642 cleared
>>>
>>> In general, that value should not be changed as the GISA facility
>>> enhances interruption delivery performance.
>>>
>>> A reason to switch the GISA facility off might be a performance
>>> comparison run or debugging.
>>>
>>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>>
>> Looks good to me. Regarding the other comments, I think allowing for dynamic changes
>> and keeping use_gisa vs disable_gisa makes sense. So I would think that the patch
>> as is makes sense.
>>
>> The only question is: shall we set use_gisa to 0 when the machine does not support
>> it (e.g. VSIE?) and then also forbid setting it to 1? Could be overkill.
> 
> Then I would rename the parameter to "try_to_use_gisa" instead. (a joke ;) )
> 
> In that case we exit gisa_init() because of the missing AIV facility.
> 
> void kvm_s390_gisa_init(struct kvm *kvm)
> {
>         struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> 
> -->    if (!css_general_characteristics.aiv)
>                 return;
>         gi->origin = &kvm->arch.sie_page2->gisa;
>         gi->alert.mask = 0;
>     ...
> }
> 

I know. My point was more: "can we expose this". But this is probably overkill.
