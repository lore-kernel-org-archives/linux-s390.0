Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgBJNkY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 08:40:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ADe8OS093309
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:40:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u8072r7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:40:23 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 13:40:21 -0000
Subject: Re: [PATCH 31/35] KVM: s390: protvirt: Add UV debug trace
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-32-borntraeger@de.ibm.com>
 <20200210142229.41da20dd.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 14:40:16 +0100
MIME-Version: 1.0
In-Reply-To: <20200210142229.41da20dd.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <85947d75-2907-a985-2aa2-14478ecec227@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 10.02.20 14:22, Cornelia Huck wrote:
> On Fri,  7 Feb 2020 06:39:54 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Let's have some debug traces which stay around for longer than the
>> guest.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c |  9 ++++++++-
>>  arch/s390/kvm/kvm-s390.h |  9 +++++++++
>>  arch/s390/kvm/pv.c       | 20 +++++++++++++++++++-
>>  3 files changed, 36 insertions(+), 2 deletions(-)
> (...)
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> index a58f5106ba5f..da281d8dcc92 100644
>> --- a/arch/s390/kvm/pv.c
>> +++ b/arch/s390/kvm/pv.c
>> @@ -74,6 +74,8 @@ int kvm_s390_pv_destroy_vm(struct kvm *kvm)
>>  	atomic_set(&kvm->mm->context.is_protected, 0);
>>  	VM_EVENT(kvm, 3, "PROTVIRT DESTROY VM: rc %x rrc %x",
>>  		 ret >> 16, ret & 0x0000ffff);
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT DESTROY VM: rc %x rrc %x",
>> +		 ret >> 16, ret & 0x0000ffff);
>>  	return rc;
>>  }
>>  
>> @@ -89,6 +91,8 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu)
>>  
>>  		VCPU_EVENT(vcpu, 3, "PROTVIRT DESTROY VCPU: cpu %d rc %x rrc %x",
>>  			   vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);
> 
> I think these should drop the vcpu_id, as VCPU_EVENT already includes
> it (in the patch introducing them).

ack, this is patch 8.

> 
>> +		KVM_UV_EVENT(vcpu->kvm, 3, "PROTVIRT DESTROY VCPU: cpu %d rc %x rrc %x",
>> +			     vcpu->vcpu_id, ret >> 16, ret & 0x0000ffff);

>>  	}
>>  
>>  	free_pages(vcpu->arch.pv.stor_base,
> 
> Otherwise, looks good.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
