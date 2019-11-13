Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727171AbfKMLel (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 06:34:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADBWWT8177648
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 06:34:39 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8ex2593a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 06:34:39 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 11:34:37 -0000
Subject: Re: [RFC 04/37] KVM: s390: protvirt: Add initial lifecycle handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-5-frankja@linux.ibm.com>
 <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 13 Nov 2019 12:34:34 +0100
MIME-Version: 1.0
In-Reply-To: <07705597-8e8f-28d4-f9a1-d3d5dc9a4555@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <40a5798c-fe66-f686-78f1-ff5cf076433f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 11/13/19 11:28 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> Let's add a KVM interface to create and destroy protected VMs.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
> [...]
>> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>> +		       unsigned long tweak)
>> +{
>> +	int i, rc = 0;
>> +	struct uv_cb_unp uvcb = {
>> +		.header.cmd = UVC_CMD_UNPACK_IMG,
>> +		.header.len = sizeof(uvcb),
>> +		.guest_handle = kvm_s390_pv_handle(kvm),
>> +		.tweak[0] = tweak
>> +	};
>> +
>> +	if (addr & ~PAGE_MASK || size & ~PAGE_MASK)
>> +		return -EINVAL;
> 
> Also check for size == 0 ?

Yep

> 
>> +
>> +
> 
> Remove one of the two empty lines, please.

Yep

> 
>> +	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
>> +		 addr, size);
>> +	for (i = 0; i < size / PAGE_SIZE; i++) {
>> +		uvcb.gaddr = addr + i * PAGE_SIZE;
>> +		uvcb.tweak[1] = i * PAGE_SIZE;
>> +retry:
>> +		rc = uv_call(0, (u64)&uvcb);
>> +		if (!rc)
>> +			continue;
>> +		/* If not yet mapped fault and retry */
>> +		if (uvcb.header.rc == 0x10a) {
>> +			rc = gmap_fault(kvm->arch.gmap, uvcb.gaddr,
>> +					FAULT_FLAG_WRITE);
>> +			if (rc)
>> +				return rc;
>> +			goto retry;
>> +		}
>> +		VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx rc %x rrc %x",
>> +			 uvcb.gaddr, uvcb.header.rc, uvcb.header.rrc);
>> +		break;
> 
> A break at the end of the for-loop ... that's really not what I'd expect.
> 
> Could you please invert the logic here, i.e.:
> 
>     if (uvcb.header.rc != 0x10a) {
>         VM_EVENT(...)
>         break;
>     }
>     rc = gmap_fault(...)
>     ...
> 
> I think you might even get rid of that ugly "goto", too, that way?

But without the goto we would increment i, no?
I'll try to find a solution, maybe using while, but then we need to
manage i incrementation.

> 
>> +	}
>> +	VM_EVENT(kvm, 3, "PROTVIRT VM UNPACK: finished with rc %x rrc %x",
>> +		 uvcb.header.rc, uvcb.header.rrc);
>> +	return rc;
>> +}
> 
>  Thomas
> 
