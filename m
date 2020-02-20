Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728248AbgBTTom (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Feb 2020 14:44:42 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KJeCl9134791
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 14:44:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y93kgb9e8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 14:44:39 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 20 Feb 2020 19:44:38 -0000
Subject: Re: [PATCH v3 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200220104020.5343-1-borntraeger@de.ibm.com>
 <20200220104020.5343-10-borntraeger@de.ibm.com>
 <1f0c2c5a-5964-dc34-73af-7b1776391276@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 20 Feb 2020 20:44:30 +0100
MIME-Version: 1.0
In-Reply-To: <1f0c2c5a-5964-dc34-73af-7b1776391276@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>



On 20.02.20 14:02, David Hildenbrand wrote:
> 
>> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>> +{
>> +	int r = 0;
>> +	u16 dummy;
>> +	void __user *argp = (void __user *)cmd->data;
>> +
>> +	switch (cmd->cmd) {
>> +	case KVM_PV_ENABLE: {
>> +		r = -EINVAL;
>> +		if (kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = kvm_s390_pv_alloc_vm(kvm);
>> +		if (r)
>> +			break;
>> +
>> +		/* FMT 4 SIE needs esca */
>> +		r = sca_switch_to_extended(kvm);
>> +		if (r) {
>> +			kvm_s390_pv_dealloc_vm(kvm);
>> +			kvm_s390_vcpu_unblock_all(kvm);
> 
> You forgot to remove that.

ack.
> 
>> +			mutex_unlock(&kvm->lock);
> 
> That's certainly wrong as well.

ack.

> 
>> +			break;
>> +		}
>> +		r = kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
>> +		if (!r)
>> +			r = kvm_s390_cpus_to_pv(kvm, &cmd->rc, &cmd->rrc);
>> +		if (r)
>> +			kvm_s390_pv_destroy_vm(kvm, &dummy, &dummy);
> 
> Should there be a kvm_s390_pv_dealloc_vm() as well?

Hmm yes. But only if destroy does not fail...... see below.

> 
>> +
>> +		break;
>> +	}
>> +	case KVM_PV_DISABLE: {
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		kvm_s390_cpus_from_pv(kvm, &cmd->rc, &cmd->rrc);
>> +		r = kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
>> +		if (!r)
>> +			kvm_s390_pv_dealloc_vm(kvm);
> 
> Hm, if destroy fails, the CPUs would already have been removed.
> 
> Is there a way to make kvm_s390_pv_destroy_vm() never fail? The return
> value is always ignored except here ... which looks wrong.

This should not fail. But if it does we should not free the memory that
we donated to the ultravisor. We then do have a memory leak, but this is 
necessary to keep the integrity of the host. 
I will fix the other places to only call dealloc when destroy succeeded.

Same for VCPU destroy. If that fails I should not free arch.pv.stor_base
will fix.


> 
>> +		break;
>> +	}
> 
> [...]
> 
>> @@ -2558,10 +2724,21 @@ static void kvm_free_vcpus(struct kvm *kvm)
>>  
>>  void kvm_arch_destroy_vm(struct kvm *kvm)
>>  {
>> +	u16 rc, rrc;
>>  	kvm_free_vcpus(kvm);
>>  	sca_dispose(kvm);
>> -	debug_unregister(kvm->arch.dbf);
>>  	kvm_s390_gisa_destroy(kvm);
>> +	/*
>> +	 * We are already at the end of life and kvm->lock is not taken.
>> +	 * This is ok as the file descriptor is closed by now and nobody
>> +	 * can mess with the pv state. To avoid lockdep_assert_held from
>> +	 * complaining we do not use kvm_s390_pv_is_protected.
>> +	 */
>> +	if (kvm_s390_pv_get_handle(kvm)) {
> 
> I'd prefer something like kvm_s390_pv_is_protected_unlocked(), but I
> guess for these few use cases, this is fine.

yes lets leave it as is... :-)


> 
> 
>> +		kvm_s390_pv_destroy_vm(kvm, &rc, &rrc);
>> +		kvm_s390_pv_dealloc_vm(kvm);
>> +	}
>> +	debug_unregister(kvm->arch.dbf);
>>  	free_page((unsigned long)kvm->arch.sie_page2);
>>  	if (!kvm_is_ucontrol(kvm))
>>  		gmap_remove(kvm->arch.gmap);
>> @@ -2657,6 +2834,9 @@ static int sca_switch_to_extended(struct kvm *kvm)
>>  	unsigned int vcpu_idx;
>>  	u32 scaol, scaoh;
>>  
>> +	if (kvm->arch.use_esca)
>> +		return 0;
>> +
>>  	new_sca = alloc_pages_exact(sizeof(*new_sca), GFP_KERNEL|__GFP_ZERO);
>>  	if (!new_sca)
>>  		return -ENOMEM;
>> @@ -2908,6 +3088,7 @@ static void kvm_s390_vcpu_setup_model(struct kvm_vcpu *vcpu)
>>  static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>  {
>>  	int rc = 0;
>> +	u16 uvrc, uvrrc;
>>  
>>  	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
>>  						    CPUSTAT_SM |
>> @@ -2975,6 +3156,11 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>  
>>  	kvm_s390_vcpu_crypto_setup(vcpu);
>>  
>> +	mutex_lock(&vcpu->kvm->lock);
>> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
>> +		rc = kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
>> +	mutex_unlock(&vcpu->kvm->lock);
> 
> Do we have to cleanup anything? (e.g., cmma page) I *think*
> kvm_arch_vcpu_destroy() is not called when kvm_arch_vcpu_create() fails ...

Right we need to call kvm_s390_vcpu_unsetup_cmma. To me it looks like
this can be done unconditionally if rc!=0:

@@ -3156,8 +3158,11 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
        kvm_s390_vcpu_crypto_setup(vcpu);
 
        mutex_lock(&vcpu->kvm->lock);
-       if (kvm_s390_pv_is_protected(vcpu->kvm))
+       if (kvm_s390_pv_is_protected(vcpu->kvm)) {
                rc = kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);
+               if (rc)
+                       kvm_s390_vcpu_unsetup_cmma(vcpu);
+       }
        mutex_unlock(&vcpu->kvm->lock);
 
        return rc;


Everything else looks ok, no need to deallocate or so.

[...]

 */
>>  int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
>>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>> new file mode 100644
>> index 000000000000..67ea9a18ed8f
>> --- /dev/null
>> +++ b/arch/s390/kvm/pv.c
>> @@ -0,0 +1,256 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Hosting Secure Execution virtual machines
>> + *
>> + * Copyright IBM Corp. 2019
>> + *    Author(s): Janosch Frank <frankja@linux.ibm.com>
> 
> I'd assume you're an author as well at this point ;)

I personally prefer to not have authors in files and after all
I am just cleaning up so that Janosch can take care of QEMU.
But I will at least fixup the Copyright year.


> 
> [...]
> 
>> +
>> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>> +			      u16 *rrc)
>> +{
>> +	struct uv_cb_ssc uvcb = {
>> +		.header.cmd = UVC_CMD_SET_SEC_CONF_PARAMS,
>> +		.header.len = sizeof(uvcb),
>> +		.sec_header_origin = (u64)hdr,
>> +		.sec_header_len = length,
>> +		.guest_handle = kvm_s390_pv_get_handle(kvm),
>> +	};
>> +	int cc;
>> +
>> +	cc = uv_call(0, (u64)&uvcb);
> 
> int cc = ... could be done.
> 

ack. 
> 
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
>> +		     *rc, *rrc);
>> +	if (cc)
>> +		return -EINVAL;
>> +	return 0;
>> +}
>> +
>> +static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak[2],
>> +		      u16 *rc, u16 *rrc)
>> +{
>> +	struct uv_cb_unp uvcb = {
>> +		.header.cmd = UVC_CMD_UNPACK_IMG,
>> +		.header.len = sizeof(uvcb),
>> +		.guest_handle = kvm_s390_pv_get_handle(kvm),
>> +		.gaddr = addr,
>> +		.tweak[0] = tweak[0],
>> +		.tweak[1] = tweak[1],
>> +	};
>> +	int ret;
>> +
>> +	ret = gmap_make_secure(kvm->arch.gmap, addr, &uvcb);
> 
> ... similarly, with ret.


ack

> 
>> +	*rc = uvcb.header.rc;
>> +	*rrc = uvcb.header.rrc;
>> +
>> +	if (ret && ret != -EAGAIN)
>> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
>> +			     uvcb.gaddr, *rc, *rrc);
>> +	return ret;
>> +}
>> +
>> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>> +		       unsigned long tweak, u16 *rc, u16 *rrc)
>> +{
>> +	u64 tw[2] = {tweak, 0};
> 
> I have no idea what tweaks are in this context. So I have to trust you
> guys on the implementation, because I don't understand it.

Its the crypto term. Basically similar idea like salt or nonce.

> 
> Especially, why can't we simply have
> 
> s/tweak/tweak/

? 

> 
> offset = 0;
> 
> while (offset < size) {
> 	...
> 	ret = unpack_one(kvm, addr, tweak, offset, rc, rrc);
> 				    ^ no idea what tweak is
> 	...
> 	... offset +=  PAGE_SIZE;
> }
> 
> But maybe I am missing what the whole array is about.

Both values (the initial 64bit value and the address) form the 128 bit
tweak for the decryption. So the offset is actually part of the tweak.

So yes we could rewrite that using offset and not passing through an array
but tweak + offset as separate u64.

will check if this makes it any clearer
> 
>> +	int ret = 0;
>> +
>> +	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
>> +		return -EINVAL;
>> +
>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
>> +		     addr, size);
>> +
>> +	while (tw[1] < size) {

> +		ret = unpack_one(kvm, addr, tw, rc, rrc);
>> +		if (ret == -EAGAIN) {
>> +			cond_resched();
>> +			if (fatal_signal_pending(current))
>> +				break;
>> +			continue;
>> +		}
>> +		if (ret)
>> +			break;
>> +		addr += PAGE_SIZE;
>> +		tw[1] += PAGE_SIZE;
>> +	}
>> +	if (!ret)
>> +		KVM_UV_EVENT(kvm, 3, "%s", "PROTVIRT VM UNPACK: successful");
>> +	return ret;
>> +}
> 
> [...]
>> +enum pv_cmd_id {
>> +	KVM_PV_ENABLE,
>> +	KVM_PV_DISABLE,
>> +	KVM_PV_VM_SET_SEC_PARMS,
>> +	KVM_PV_VM_UNPACK,
>> +	KVM_PV_VM_VERIFY,
> 
> I wonder if we should just drop "_VM" from all of these ...
