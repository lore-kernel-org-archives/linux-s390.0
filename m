Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727066AbfH2Nim (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Aug 2019 09:38:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7TDbiF0019638
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 09:38:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upeadbwnx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 29 Aug 2019 09:38:41 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 29 Aug 2019 14:38:39 +0100
Subject: Re: [PATCH v2] KVM: s390: Test for bad access register and size at
 the start of S390_MEM_OP
References: <20190829122517.31042-1-thuth@redhat.com>
 <20190829144013.322edb0a.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Aug 2019 15:38:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190829144013.322edb0a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <c403cd4b-8048-66ed-32f3-5098d4ee79e7@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 29.08.19 14:40, Cornelia Huck wrote:
> On Thu, 29 Aug 2019 14:25:17 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> If the KVM_S390_MEM_OP ioctl is called with an access register >= 16,
>> then there is certainly a bug in the calling userspace application.
>> We check for wrong access registers, but only if the vCPU was already
>> in the access register mode before (i.e. the SIE block has recorded
>> it). The check is also buried somewhere deep in the calling chain (in
>> the function ar_translation()), so this is somewhat hard to find.
>>
>> It's better to always report an error to the userspace in case this
>> field is set wrong, and it's safer in the KVM code if we block wrong
>> values here early instead of relying on a check somewhere deep down
>> the calling chain, so let's add another check to kvm_s390_guest_mem_op()
>> directly.
>>
>> We also should check that the "size" is non-zero here (thanks to Janosch
>> Frank for the hint!). If we do not check the size, we could call vmalloc()
>> with this 0 value, and this will cause a kernel warning.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>

I will add cc stable.

Thanks applied.
>> ---
>>  v2: Check mop->size to be non-zero
>>
>>  arch/s390/kvm/kvm-s390.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index f329dcb3f44c..49d7722229ae 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4255,7 +4255,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>>  	const u64 supported_flags = KVM_S390_MEMOP_F_INJECT_EXCEPTION
>>  				    | KVM_S390_MEMOP_F_CHECK_ONLY;
>>  
>> -	if (mop->flags & ~supported_flags)
>> +	if (mop->flags & ~supported_flags || mop->ar >= NUM_ACRS || !mop->size)
>>  		return -EINVAL;
>>  
>>  	if (mop->size > MEM_OP_MAX_SIZE)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
