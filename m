Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfIDHqp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Sep 2019 03:46:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x847bJsq121555
        for <linux-s390@vger.kernel.org>; Wed, 4 Sep 2019 03:46:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ut88w1w1c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 04 Sep 2019 03:46:43 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 4 Sep 2019 08:46:41 +0100
Subject: Re: [PATCH] KVM: s390: Disallow invalid bits in kvm_valid_regs and
 kvm_dirty_regs
References: <20190904071308.25683-1-thuth@redhat.com>
 <3b1666ee-0b7f-a775-3622-5ca7f938aeb0@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 4 Sep 2019 09:46:36 +0200
MIME-Version: 1.0
In-Reply-To: <3b1666ee-0b7f-a775-3622-5ca7f938aeb0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0d09984f-7fb5-4af6-b90c-e9dc726e1a0a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 04.09.19 09:33, Janosch Frank wrote:
> On 9/4/19 9:13 AM, Thomas Huth wrote:
>> If unknown bits are set in kvm_valid_regs or kvm_dirty_regs, this
>> clearly indicates that something went wrong in the KVM userspace
>> application. The x86 variant of KVM already contains a check for
>> bad bits (and the corresponding kselftest checks this), so let's
>> do the same on s390x now, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> I think it would make sense to split the kvm changes from the test.

Yes, this would allow to backport the non-kselftest part if necessary.

With that 
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
>> ---
>>  arch/s390/include/uapi/asm/kvm.h              |  6 ++++
>>  arch/s390/kvm/kvm-s390.c                      |  4 +++
>>  .../selftests/kvm/s390x/sync_regs_test.c      | 30 +++++++++++++++++++
>>  3 files changed, 40 insertions(+)
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
>> diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> index bbc93094519b..d5290b4ad636 100644
>> --- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> +++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
>> @@ -85,6 +85,36 @@ int main(int argc, char *argv[])
>>  
>>  	run = vcpu_state(vm, VCPU_ID);
>>  
>> +	/* Request reading invalid register set from VCPU. */
>> +	run->kvm_valid_regs = INVALID_SYNC_FIELD;
>> +	rv = _vcpu_run(vm, VCPU_ID);
>> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
>> +		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
>> +		    rv);
>> +	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
>> +
>> +	run->kvm_valid_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
>> +	rv = _vcpu_run(vm, VCPU_ID);
>> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
>> +		    "Invalid kvm_valid_regs did not cause expected KVM_RUN error: %d\n",
>> +		    rv);
>> +	vcpu_state(vm, VCPU_ID)->kvm_valid_regs = 0;
>> +
>> +	/* Request setting invalid register set into VCPU. */
>> +	run->kvm_dirty_regs = INVALID_SYNC_FIELD;
>> +	rv = _vcpu_run(vm, VCPU_ID);
>> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
>> +		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
>> +		    rv);
>> +	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
>> +
>> +	run->kvm_dirty_regs = INVALID_SYNC_FIELD | TEST_SYNC_FIELDS;
>> +	rv = _vcpu_run(vm, VCPU_ID);
>> +	TEST_ASSERT(rv < 0 && errno == EINVAL,
>> +		    "Invalid kvm_dirty_regs did not cause expected KVM_RUN error: %d\n",
>> +		    rv);
>> +	vcpu_state(vm, VCPU_ID)->kvm_dirty_regs = 0;
>> +
>>  	/* Request and verify all valid register sets. */
>>  	run->kvm_valid_regs = TEST_SYNC_FIELDS;
>>  	rv = _vcpu_run(vm, VCPU_ID);
>>
> 
> 
