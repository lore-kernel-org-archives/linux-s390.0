Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbgBZKww (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 05:52:52 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QAo2SQ028566
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 05:52:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yde1v0k4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 05:52:48 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Feb 2020 10:52:32 -0000
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <20200225214822.3611-1-borntraeger@de.ibm.com>
 <20200226110144.4677ac60.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Feb 2020 11:52:25 +0100
MIME-Version: 1.0
In-Reply-To: <20200226110144.4677ac60.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9a098ba3-d52a-6b1a-8708-8e0707b6e6cc@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 26.02.20 11:01, Cornelia Huck wrote:
> On Tue, 25 Feb 2020 16:48:22 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This contains 3 main changes:
>> 1. changes in SIE control block handling for secure guests
>> 2. helper functions for create/destroy/unpack secure guests
>> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
>> machines
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h |  24 ++-
>>  arch/s390/include/asm/uv.h       |  69 ++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 209 +++++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  33 ++++
>>  arch/s390/kvm/pv.c               | 269 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h         |  31 ++++
>>  7 files changed, 633 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
> 
> (...)
> 
>> @@ -2165,6 +2168,160 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
>>  	return r;
>>  }
>>  
>> +static int kvm_s390_cpus_from_pv(struct kvm *kvm, u16 *rcp, u16 *rrcp)
>> +{
>> +	struct kvm_vcpu *vcpu;
>> +	u16 rc, rrc;
>> +	int ret = 0;
>> +	int i;
>> +
>> +	/*
>> +	 * We ignore failures and try to destroy as many CPUs as possible.
> 
> What is this 'destroying'? Is that really the right terminology? From a
> quick glance, I would expect something more in the vein of cpu
> unplugging, and I don't think that's what is happening here.

It is destroying the secure CPU at the ultravisor (its even the name of
the ultravisor call) so I think destroy fits nicely.

> 
> (I have obviously not yet read the whole thing, please give people some
> more time to review this huge patch.)
> 
>> +	 * At the same time we must not free the assigned resources when
>> +	 * this fails, as the ultravisor has still access to that memory.
>> +	 * So kvm_s390_pv_destroy_cpu can leave a "wanted" memory leak
>> +	 * behind.
>> +	 * We want to return the first failure rc and rrc, though.
>> +	 */
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		mutex_lock(&vcpu->mutex);
>> +		if (kvm_s390_pv_destroy_cpu(vcpu, &rc, &rrc) && !ret) {
>> +			*rcp = rc;
>> +			*rrcp = rrc;
>> +			ret = -EIO;
>> +		}
>> +		mutex_unlock(&vcpu->mutex);
>> +	}
>> +	return ret;
>> +}
>> +
>> +static int kvm_s390_cpus_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +	int i, r = 0;
>> +	u16 dummy;
>> +
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		mutex_lock(&vcpu->mutex);
>> +		r = kvm_s390_pv_create_cpu(vcpu, rc, rrc);
>> +		mutex_unlock(&vcpu->mutex);
>> +		if (r)
>> +			break;
>> +	}
>> +	if (r)
>> +		kvm_s390_cpus_from_pv(kvm, &dummy, &dummy);
> 
> This is a rather unlikely case, so we don't need to optimize this,
> right?

Right. All the error cases here are "should not happen"

> 
> Would rc/rrc from the rollback contain anything of interest if the
> create fails (that is, anything more interesting than what that
> function returns?

I think all rc/rrc from rollback would depend on the first error,
so this is what we return to userspace. 
Good thing is that we log all those in the debug feature so if anyone
wants to see the full things its there in /sys/kernel/debug/s390dbf/kvm-uv/sprintf
> 
> Similar comment for the 'create' as for the 'destroy' above. (Not
> trying to nitpick, just a bit confused.)
> 
> Or is that not the cpu that is created/destroyed, but something else?
> Sorry, just trying to understand where this is coming from.

Its the CPU instance in the ultravisor.
> 
>> +	return r;
>> +}
> 
> (...)
> 
> Will look at the remainder of the patch later, maybe I understand the
> stuff above better after that.
> 
