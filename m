Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24996 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729313AbgBJNDI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 08:03:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ACs9fN086564
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:03:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ucj3bet-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 08:03:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 13:03:01 -0000
Subject: Re: [PATCH 09/35] KVM: s390: protvirt: Add KVM api documentation
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-10-borntraeger@de.ibm.com>
 <f7089ad6-65d2-35fc-16fb-b94e968fd4e8@redhat.com>
 <aae6434d-de87-503d-de51-4cee52d375b9@de.ibm.com>
 <20200210135743.580d6eeb.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 14:02:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200210135743.580d6eeb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b4793919-0394-eb27-64ef-1500a03166b0@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 10.02.20 13:57, Cornelia Huck wrote:
> On Mon, 10 Feb 2020 13:26:35 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 08.02.20 15:57, Thomas Huth wrote:
>>> On 07/02/2020 12.39, Christian Borntraeger wrote:  
>>>> From: Janosch Frank <frankja@linux.ibm.com>
>>>>
>>>> Add documentation for KVM_CAP_S390_PROTECTED capability and the
>>>> KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  Documentation/virt/kvm/api.txt | 61 ++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 61 insertions(+)
> 
>>>> +4.125 KVM_S390_PV_COMMAND
>>>> +
>>>> +Capability: KVM_CAP_S390_PROTECTED
>>>> +Architectures: s390
>>>> +Type: vm ioctl
>>>> +Parameters: struct kvm_pv_cmd
>>>> +Returns: 0 on success, < 0 on error
>>>> +
>>>> +struct kvm_pv_cmd {
>>>> +	__u32	cmd;	/* Command to be executed */
>>>> +	__u16	rc;	/* Ultravisor return code */
>>>> +	__u16	rrc;	/* Ultravisor return reason code */
>>>> +	__u64	data;	/* Data or address */  
>>>
>>> That remindes me ... do we maybe want a "reserved" field in here for
>>> future extensions? Or is the "data" pointer enough?  
>>
>>
>> This is now:
>>
>> struct kvm_pv_cmd {
>>
>>         __u32 cmd;      /* Command to be executed */
>>         __u32 flags;    /* flags for future extensions. Must be 0 for now */
>>         __u64 data;     /* Data or address */
>>         __u64 reserved[2];
>> };
> 
> Ok, that is where you add this... but still, the question: are those
> fields only ever set by userspace, or could the kernel return things in
> the reserved fields in the future?

I will change the IOWR to make sure that we can have both directions.
> 
> Also, two 64 bit values seem a bit arbitrary... what about a data
> address + length construct instead? (Length might be a fixed value per
> flag?)

When you look at all the other examples we define those as reserved bytes
The idea is to have no semantics at all. Whenever we add a new flag we will
replace the reserved bytes with a new meaning.

e.g. see
struct kvm_s390_skeys {
        __u64 start_gfn;
        __u64 count;
        __u64 skeydata_addr;
        __u32 flags;
        __u32 reserved[9];
};

or

/* for KVM_S390_MEM_OP and KVM_S390_SIDA_OP */
struct kvm_s390_mem_op {
        /* in */
        __u64 gaddr;            /* the guest address */
        __u64 flags;            /* flags */
        __u32 size;             /* amount of bytes */
        __u32 op;               /* type of operation */
        __u64 buf;              /* buffer in userspace */
        __u8 ar;                /* the access register number */
        __u8 reserved21[3];     /* should be set to 0 */
        __u32 offset;           /* offset into the sida */
        __u8 reserved28[24];    /* should be set to 0 */
};
