Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731492AbgBYSiF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 13:38:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PIZ1lp030559
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 13:38:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yax396gyk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2020 13:38:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 25 Feb 2020 18:38:02 -0000
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-19-borntraeger@de.ibm.com>
 <20200225181936.7f975394.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 25 Feb 2020 19:37:55 +0100
MIME-Version: 1.0
In-Reply-To: <20200225181936.7f975394.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <459c01d5-0a09-08be-f52f-16bdd64a22ad@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 25.02.20 18:19, Cornelia Huck wrote:
> On Mon, 24 Feb 2020 06:40:49 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Now that we can't access guest memory anymore, we have a dedicated
>> satellite block that's a bounce buffer for instruction data.
>>
>> We re-use the memop interface to copy the instruction data to / from
>> userspace. This lets us re-use a lot of QEMU code which used that
>> interface to make logical guest memory accesses which are not possible
>> anymore in protected mode anyway.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 11 +++++-
>>  arch/s390/kvm/kvm-s390.c         | 65 ++++++++++++++++++++++++++++----
>>  arch/s390/kvm/pv.c               | 11 ++++++
>>  include/uapi/linux/kvm.h         |  9 ++++-
>>  4 files changed, 85 insertions(+), 11 deletions(-)
>>
> 
> (...)
> 
>> @@ -4512,8 +4540,8 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>>  		if (!tmpbuf)
>>  			return -ENOMEM;
>>  	}
>> -
>> -	srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
>> +	if (kvm_s390_pv_cpu_is_protected(vcpu))
>> +		return -EINVAL;
> 
> Doesn't that leak tmpbuf (allocated right above)? Maybe just move that
> check up?

nice catch. Fixed.
