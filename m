Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729223AbgB0MDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 07:03:53 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RC0GxU097357
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 07:03:51 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydxrdub04-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 07:03:51 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Thu, 27 Feb 2020 12:03:50 -0000
Reply-To: mimu@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: introduce module parameter kvm.use_gisa
References: <20200227091031.102993-1-mimu@linux.ibm.com>
 <2ff28c9a-d6ae-4fe8-1660-5765fd3f3c41@redhat.com>
From: Michael Mueller <mimu@linux.ibm.com>
Date: Thu, 27 Feb 2020 13:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <2ff28c9a-d6ae-4fe8-1660-5765fd3f3c41@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <175aad02-9a30-6be0-a203-c696158168e1@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org



On 27.02.20 10:26, David Hildenbrand wrote:
> On 27.02.20 10:10, Michael Mueller wrote:
>> The boolean module parameter "kvm.use_gisa" controls if newly
>> created guests will use the GISA facility if provided by the
>> host system. The default is yes.
>>
>>    # cat /sys/module/kvm/parameters/use_gisa
>>    Y
>>
>> The parameter can be changed on the fly.
>>
>>    # echo N > /sys/module/kvm/parameters/use_gisa
>>
>> Already running guests are not affected by this change.
>>
>> The kvm s390 debug feature shows if a guest is running with GISA.
>>
>>    # grep gisa /sys/kernel/debug/s390dbf/kvm-$pid/sprintf
>>    00 01582725059:843303 3 - 08 00000000e119bc01  gisa 0x00000000c9ac2642 initialized
>>    00 01582725059:903840 3 - 11 000000004391ee22  00[0000000000000000-0000000000000000]: AIV gisa format-1 enabled for cpu 000
>>    ...
>>    00 01582725059:916847 3 - 08 0000000094fff572  gisa 0x00000000c9ac2642 cleared
>>
>> In general, that value should not be changed as the GISA facility
>> enhances interruption delivery performance.
>>
>> A reason to switch the GISA facility off might be a performance
>> comparison run or debugging.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index d7ff30e45589..5c2081488024 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -184,6 +184,11 @@ static u8 halt_poll_max_steal = 10;
>>   module_param(halt_poll_max_steal, byte, 0644);
>>   MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
>>   
>> +/* if set to true, the GISA will be initialized and used if available */
>> +static bool use_gisa  = true;
>> +module_param(use_gisa, bool, 0644);
>> +MODULE_PARM_DESC(use_gisa, "Use the GISA if the host supports it.");
>> +
>>   /*
>>    * For now we handle at most 16 double words as this is what the s390 base
>>    * kernel handles and stores in the prefix page. If we ever need to go beyond
>> @@ -2504,7 +2509,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>   	kvm->arch.use_skf = sclp.has_skey;
>>   	spin_lock_init(&kvm->arch.start_stop_lock);
>>   	kvm_s390_vsie_init(kvm);
>> -	kvm_s390_gisa_init(kvm);
>> +	if (use_gisa)
>> +		kvm_s390_gisa_init(kvm);
> 
> Looks sane to me. gi->origin will remain NULL and act like
> css_general_characteristics.aiv wouldn't be around.

right

> 
> I assume initializing the gib is fine, and having some guests use it and
> others not?

Is fine as well.

> 
> I do wonder if it would be even clearer/cleaner to not allow to change
> this property on the fly, and to also not init the gib if disabled.
> 
> If you want to perform performance tests, simply unload+reload KVM.

That would work if kvm is build as module but not in-kernel, then
a reboot would be required with kvm.use_gisa=Y/N

I tend to leave it as it is.

Thanks,
Michael

> 
