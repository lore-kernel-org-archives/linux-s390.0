Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728897AbgBQMKO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 07:10:14 -0500
Subject: Re: [PATCH v2 09/42] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-10-borntraeger@de.ibm.com>
 <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
 <f70b97fe-fbaf-2e5a-cc7d-a7529a8943f4@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
Date: Mon, 17 Feb 2020 13:09:58 +0100
MIME-Version: 1.0
In-Reply-To: <f70b97fe-fbaf-2e5a-cc7d-a7529a8943f4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 17.02.20 13:04, Christian Borntraeger wrote:
> 
> 
> On 17.02.20 11:56, David Hildenbrand wrote:
>> [...]
>>>  
>>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>>> +{
>>> +	int r = 0;
>>> +	void __user *argp = (void __user *)cmd->data;
>>> +
>>> +	switch (cmd->cmd) {
>>> +	case KVM_PV_VM_CREATE: {
>>> +		r = -EINVAL;
>>> +		if (kvm_s390_pv_is_protected(kvm))
>>> +			break;
>>
>> Isn't this racy? I think there has to be a way to make sure the PV state
>> can't change. Is there any and I am missing something obvious? (is
>> suspect we need the kvm->lock)
> 
> 
> Yes, kvm->lock around kvm_s390_handle_pv is safer.
> 
> Something like

Yes. Probably a lockdep_assert_held() inside kvm_s390_pv_is_protected()
would make sense to catch other races.
[...]

>>
>> With an explicit KVM_PV_VCPU_CREATE, this does not belong here. When
>> hotplugging CPUs, user space has to do that manually. But as I said
>> already, this user space API could be improved. (below)
> 
> With your proposed API this would stay.

Yes

[...]
>>
>>
>> Can we please discuss why we can't
>>
>> - Get rid of KVM_S390_PV_COMMAND_VCPU
>> - Do the allocation in KVM_PV_VM_CREATE
>> - Rename KVM_PV_VM_CREATE -> KVM_PV_ENABLE
>> - Rename KVM_PV_VM_DESTROY -> KVM_PV_DISABLE
>>
>> This user space API is unnecessary complicated and confusing.
> 
> I will have a look if this is feasible.
> 

Okay, thanks!

-- 
Thanks,

David / dhildenb
