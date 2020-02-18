Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgBRI5j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 03:57:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01I8safI118834
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 03:57:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6dq6vg1e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 03:57:37 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 08:57:35 -0000
Subject: Re: [PATCH v2 25/42] KVM: s390: protvirt: disallow one_reg
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-26-borntraeger@de.ibm.com>
 <031b7db2-c255-e32d-782d-d4769dcb6ee8@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 09:57:27 +0100
MIME-Version: 1.0
In-Reply-To: <031b7db2-c255-e32d-782d-d4769dcb6ee8@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <9efa7a3f-bcf6-1775-e35b-05c9666b13b8@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 18.02.20 09:40, David Hildenbrand wrote:
> On 14.02.20 23:26, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
> 
> "KVM: s390: protvirt: disallow KVM_GET_ONE_REG/KVM_SET_ONE_REG"
> 
>>
>> A lot of the registers are controlled by the Ultravisor and never
>> visible to KVM. Some fields in the sie control block are overlayed, like
>> gbea. As no known userspace uses the ONE_REG interface on s390 if sync
>> regs are available, no functionality is lost if it is disabled for
>> protected guests.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 6 ++++--
>>  arch/s390/kvm/kvm-s390.c       | 3 +++
>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index cb58714fe60d..a82166e5f7d9 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -2117,7 +2117,8 @@ Errors:
>>  
>>    ======   ============================================================
>>    ENOENT   no such register
>> -  EINVAL   invalid register ID, or no such register
>> +  EINVAL   invalid register ID, or no such register, ONE_REG forbidden
>> +           for protected guests (s390)
> 
> "invalid register ID, no such register, or used with VMs in protected
> virtualization mode on s390" ?

ack.
> 
>>    EPERM    (arm64) register access not allowed before vcpu finalization
>>    ======   ============================================================
>>  
>> @@ -2552,7 +2553,8 @@ Errors include:
>>  
>>    ======== ============================================================
>>    ENOENT   no such register
>> -  EINVAL   invalid register ID, or no such register
>> +  EINVAL   invalid register ID, or no such register, ONE_REG forbidden
>> +           for protected guests (s390)
> 
> dito

ack
> 
>>    EPERM    (arm64) register access not allowed before vcpu finalization
>>    ======== ============================================================
>>  
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 8db82aaf1275..d20a7fa9d480 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4638,6 +4638,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  	case KVM_SET_ONE_REG:
>>  	case KVM_GET_ONE_REG: {
>>  		struct kvm_one_reg reg;
>> +		r = -EINVAL;
>> +		if (kvm_s390_pv_is_protected(vcpu->kvm))
>> +			break;
> 
> I assume races will be dealt with in your next series.

yes. This is running  under vcpu_mutex and we will hold that lock when doing 
the gear shift.

> 
>>  		r = -EFAULT;
>>  		if (copy_from_user(&reg, argp, sizeof(reg)))
>>  			break;
>>
> 
> With the two nits fixed
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
