Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729317AbgBQPAn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:00:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEvfUC059147
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:00:42 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dp89rff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:00:42 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 15:00:40 -0000
Subject: Re: [PATCH v2 20/42] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-21-borntraeger@de.ibm.com>
 <ad84934a-3d18-d56e-5658-1d8b8292f6b3@redhat.com>
 <d16b7ba2-38fc-5128-bd40-587d96e7936f@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 16:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <d16b7ba2-38fc-5128-bd40-587d96e7936f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f98d702f-1e71-c051-6bd0-efb639658822@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>



On 17.02.20 15:47, Janosch Frank wrote:
> On 2/17/20 12:08 PM, David Hildenbrand wrote:
>>> @@ -4460,6 +4489,10 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu *vcpu,
>>>  
>>>  	switch (mop->op) {
>>>  	case KVM_S390_MEMOP_LOGICAL_READ:
>>> +		if (kvm_s390_pv_is_protected(vcpu->kvm)) {
>>> +			r = -EINVAL;
>>> +			break;
>>> +		}
>>
>> Could we have a possible race with disabling code, especially while
>> concurrently freeing? (sorry if I ask again, there was just a flood of
>> emails)

see my other reply. Hopefully fixed soon.[...]

>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>> index 207915488502..0fdee1bc3798 100644
>>> --- a/include/uapi/linux/kvm.h
>>> +++ b/include/uapi/linux/kvm.h
>>> @@ -475,11 +475,15 @@ struct kvm_s390_mem_op {
>>>  	__u32 op;		/* type of operation */
>>>  	__u64 buf;		/* buffer in userspace */
>>>  	__u8 ar;		/* the access register number */
>>> -	__u8 reserved[31];	/* should be set to 0 */
>>> +	__u8 reserved21[3];	/* should be set to 0 */
>>> +	__u32 sida_offset;	/* offset into the sida */
>>> +	__u8 reserved28[24];	/* should be set to 0 */
>>>  };
>>
>> As discussed, I'd prefer an overlaying layout for the sida, as the ar
>> does not make any sense (correct me if I'm wrong :) )
> 
> That wouldn't work, because we still check mop->ar < 16 in
> kvm_s390_guest_mem_op(). Also we currently check mop contents twice
> because we overload mem_op() with the SIDA operations.
> 
> Using a separate IOCTL is cleaner...

I would rather use the current patch instead of adding a new ioctl.
