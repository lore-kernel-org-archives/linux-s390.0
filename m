Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726225AbgBRJ2S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 04:28:18 -0500
Subject: Re: [PATCH v2 26/42] KVM: s390: protvirt: Do only reset registers
 that are accessible
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-27-borntraeger@de.ibm.com>
 <9b66eb07-9755-4afe-6837-6197acd5fa09@redhat.com>
 <1893c520-165d-6006-47cd-0e7498f39188@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <88acfaf1-b8d1-da77-79b1-52be912fd53b@redhat.com>
Date: Tue, 18 Feb 2020 10:28:08 +0100
MIME-Version: 1.0
In-Reply-To: <1893c520-165d-6006-47cd-0e7498f39188@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 18.02.20 10:20, Christian Borntraeger wrote:
> 
> 
> On 18.02.20 09:42, David Hildenbrand wrote:
>> On 14.02.20 23:26, Christian Borntraeger wrote:
>>> From: Janosch Frank <frankja@linux.ibm.com>
>>>
>>> For protected VMs the hypervisor can not access guest breaking event
>>> address, program parameter, bpbc and todpr. Do not reset those fields
>>> as the control block does not provide access to these fields.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>>  arch/s390/kvm/kvm-s390.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index d20a7fa9d480..5b551cc73540 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -3442,14 +3442,16 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>>  	kvm_s390_set_prefix(vcpu, 0);
>>>  	kvm_s390_set_cpu_timer(vcpu, 0);
>>>  	vcpu->arch.sie_block->ckc = 0;
>>> -	vcpu->arch.sie_block->todpr = 0;
>>>  	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
>>>  	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
>>>  	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
>>>  	vcpu->run->s.regs.fpc = 0;
>>> -	vcpu->arch.sie_block->gbea = 1;
>>> -	vcpu->arch.sie_block->pp = 0;
>>> -	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>>> +	if (!kvm_s390_pv_handle_cpu(vcpu)) {
>>
>> Shouldn't we instead check if the VM is in PV mode? (with changed
>> lifecycle handling). Easier to understand.
> 
> No. these ioctls are under the vcpu->mutex, so I am going to compare
> against the per cpu variant.
> 
> I will use kvm_s390_pv_cpu_is_protected instead to have the lockdep assertion.

That's what I meant!


-- 
Thanks,

David / dhildenb
