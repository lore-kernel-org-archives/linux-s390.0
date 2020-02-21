Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388340AbgBUIWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Feb 2020 03:22:39 -0500
Subject: Re: [PATCH v3 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-10-borntraeger@de.ibm.com>
 <1f0c2c5a-5964-dc34-73af-7b1776391276@redhat.com>
 <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <abcad458-ff2d-2ec0-6a3c-f4491336d743@redhat.com>
Date: Fri, 21 Feb 2020 09:22:28 +0100
MIME-Version: 1.0
In-Reply-To: <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

>>> +
>>> +		break;
>>> +	}
>>> +	case KVM_PV_DISABLE: {
>>> +		r = -EINVAL;
>>> +		if (!kvm_s390_pv_is_protected(kvm))
>>> +			break;
>>> +
>>> +		kvm_s390_cpus_from_pv(kvm, &cmd->rc, &cmd->rrc);
>>> +		r = kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
>>> +		if (!r)
>>> +			kvm_s390_pv_dealloc_vm(kvm);
>>
>> Hm, if destroy fails, the CPUs would already have been removed.
>>
>> Is there a way to make kvm_s390_pv_destroy_vm() never fail? The return
>> value is always ignored except here ... which looks wrong.
> 
> This should not fail. But if it does we should not free the memory that
> we donated to the ultravisor. We then do have a memory leak, but this is 
> necessary to keep the integrity of the host. 
> I will fix the other places to only call dealloc when destroy succeeded.
> 
> Same for VCPU destroy. If that fails I should not free arch.pv.stor_base
> will fix.

A comment would be nice, documenting exactly that.

>  */
>>>  int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
>>>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
>>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>>> new file mode 100644
>>> index 000000000000..67ea9a18ed8f
>>> --- /dev/null
>>> +++ b/arch/s390/kvm/pv.c
>>> @@ -0,0 +1,256 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Hosting Secure Execution virtual machines
>>> + *
>>> + * Copyright IBM Corp. 2019
>>> + *    Author(s): Janosch Frank <frankja@linux.ibm.com>
>>
>> I'd assume you're an author as well at this point ;)
> 
> I personally prefer to not have authors in files and after all
> I am just cleaning up so that Janosch can take care of QEMU.
> But I will at least fixup the Copyright year.

For me, that counts as co-author, but yeah, totally your decision :)

>>> +	*rc = uvcb.header.rc;
>>> +	*rrc = uvcb.header.rrc;
>>> +
>>> +	if (ret && ret != -EAGAIN)
>>> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
>>> +			     uvcb.gaddr, *rc, *rrc);
>>> +	return ret;
>>> +}
>>> +
>>> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>>> +		       unsigned long tweak, u16 *rc, u16 *rrc)
>>> +{
>>> +	u64 tw[2] = {tweak, 0};
>>
>> I have no idea what tweaks are in this context. So I have to trust you
>> guys on the implementation, because I don't understand it.
> 
> Its the crypto term. Basically similar idea like salt or nonce.

Understood. "offset"/"address" makes this clearer in this code -
although it will be used as a salt in HW.

> 
>>
>> Especially, why can't we simply have
>>
>> s/tweak/tweak/
> 
> ? 

Ignore, it was part of the process of me figuring out what's going on in
this code :)


-- 
Thanks,

David / dhildenb
