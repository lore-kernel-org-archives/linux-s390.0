Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbfIDJLj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 05:11:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x849AUP8134727
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 05:11:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2utad6022s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 05:11:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 4 Sep 2019 10:11:25 +0100
Subject: Re: [PATCH v2 1/2] KVM: s390: Disallow invalid bits in kvm_valid_regs
 and kvm_dirty_regs
References: <20190904085200.29021-1-thuth@redhat.com>
 <20190904085200.29021-2-thuth@redhat.com>
 <b34a237f-77a5-2939-624d-0240451f2976@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Sep 2019 11:11:22 +0200
MIME-Version: 1.0
In-Reply-To: <b34a237f-77a5-2939-624d-0240451f2976@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <8f48d9dd-1464-75aa-2011-b15adc5a4eab@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 04.09.19 11:05, David Hildenbrand wrote:
> On 04.09.19 10:51, Thomas Huth wrote:
>> If unknown bits are set in kvm_valid_regs or kvm_dirty_regs, this
>> clearly indicates that something went wrong in the KVM userspace
>> application. The x86 variant of KVM already contains a check for
>> bad bits, so let's do the same on s390x now, too.
>>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  arch/s390/include/uapi/asm/kvm.h | 6 ++++++
>>  arch/s390/kvm/kvm-s390.c         | 4 ++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>> index 47104e5b47fd..436ec7636927 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -231,6 +231,12 @@ struct kvm_guest_debug_arch {
>>  #define KVM_SYNC_GSCB   (1UL << 9)
>>  #define KVM_SYNC_BPBC   (1UL << 10)
>>  #define KVM_SYNC_ETOKEN (1UL << 11)
>> +
>> +#define KVM_SYNC_S390_VALID_FIELDS \
>> +	(KVM_SYNC_PREFIX | KVM_SYNC_GPRS | KVM_SYNC_ACRS | KVM_SYNC_CRS | \
>> +	 KVM_SYNC_ARCH0 | KVM_SYNC_PFAULT | KVM_SYNC_VRS | KVM_SYNC_RICCB | \
>> +	 KVM_SYNC_FPRS | KVM_SYNC_GSCB | KVM_SYNC_BPBC | KVM_SYNC_ETOKEN)
>> +
> 
> We didn't care about the S390 for the actual flags, why care now?

I think it makes sense to have the interface as defined as possible. If for some
reason userspace sets a wrong bit this would be undetected. If we at a later point
in time use that bit this would resultin strange problems.
> 
> 
>>  /* length and alignment of the sdnx as a power of two */
>>  #define SDNXC 8
>>  #define SDNXL (1UL << SDNXC)
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 49d7722229ae..a7d7dedfe527 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3998,6 +3998,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  	if (kvm_run->immediate_exit)
>>  		return -EINTR;
>>  
>> +	if (kvm_run->kvm_valid_regs & ~KVM_SYNC_S390_VALID_FIELDS ||
>> +	    kvm_run->kvm_dirty_regs & ~KVM_SYNC_S390_VALID_FIELDS)
>> +		return -EINVAL;
>> +
>>  	vcpu_load(vcpu);
>>  
>>  	if (guestdbg_exit_pending(vcpu)) {
>>
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
