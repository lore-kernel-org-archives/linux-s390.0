Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbgBRVTB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 16:19:01 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ILFAZq033071
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 16:18:59 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y87e72b3f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 18 Feb 2020 16:18:59 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Tue, 18 Feb 2020 21:18:57 -0000
Subject: Re: [PATCH v2.1] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-10-borntraeger@de.ibm.com>
 <20200218083946.44720-1-borntraeger@de.ibm.com>
 <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Feb 2020 22:18:48 +0100
MIME-Version: 1.0
In-Reply-To: <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f6bc712e-44b0-233e-886f-c72485ea13c3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 18.02.20 10:12, David Hildenbrand wrote:
> On 18.02.20 09:39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> This contains 3 main changes:
>> 1. changes in SIE control block handling for secure guests
>> 2. helper functions for create/destroy/unpack secure guests
>> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
>> machines
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>> 2->2.1  - combine CREATE/DESTROY CPU/VM into ENABLE DISABLE
>> 	- rework locking and check locks with lockdep
>> 	- I still have the PV_COMMAND_CPU in here for later use in
>> 	  the SET_IPL_PSW ioctl. If wanted I can move
> 
> I'd prefer to move, and eventually just turn this into a clean, separate
> ioctl without subcommands (e.g., if we'll only need a single subcommand
> in the near future). And it makes this patch a alittle easier to review
> ... :)
> 

Maybe the MP_STATE solution will work out. Then we can get rid of this.
will look into that when dealing with the other patch.

> [...]

> 
> Once we lock the VCPU, it cannot be running, right?

Right, while holding the vcpu->mutex, KVM_RUN is blocked. 

> 
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		mutex_lock(&vcpu->mutex);
>> +		r = kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
>> +		mutex_unlock(&vcpu->mutex);
>> +		if (r)
>> +			break;
>> +	}
> 
> Can this actually ever fail? If so, you would leave half-initialized
> state around. Warn and continue?
> 
> Especially, kvm_arch_vcpu_destroy() ignores any error from
> kvm_s390_pv_destroy_cpu() as well ...
> 
> IMHO, we should make kvm_s390_switch_from_pv() and
> kvm_s390_pv_destroy_cpu() never fail.

will answer this part tomorrow.

> 
>> +	return r;
>> +}
>> +
>> +static int kvm_s390_switch_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +	int i, r = 0;
>> +	u16 dummy;
>> +
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm) {
>> +		mutex_lock(&vcpu->mutex);
>> +		r = kvm_s390_pv_create_cpu(vcpu, rc, rrc);
>> +		mutex_unlock(&vcpu->mutex);
>> +		if (r)
>> +			break;
>> +	}
>> +	if (r)
>> +		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
>> +	return r;
>> +}
>> +
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
> 
> Why not factor out this check, it's common for all sucommands.

Unfortunately it is not common. Sometimes it has an "!" sometimes not.

> 
>> +
>> +		r = kvm_s390_pv_alloc_vm(kvm);
>> +		if (r)
>> +			break;
>> +
>> +		kvm_s390_vcpu_block_all(kvm);
> 
> As kvm_s390_vcpu_block_all() does not support nesting, this will not
> work as expected - sca_switch_to_extended() already blocks. Are the
> vcpu->locks not enough?

Right, we would need to move the sca_switch out of this lock. On the other
hand the vcpu->locks should be sufficent for the host integrity (and also
for the secure guest integrity))
So I will just remove the block_all here and below.
> 
> [...]
> 
>> @@ -2558,10 +2735,16 @@ static void kvm_free_vcpus(struct kvm *kvm)
>>  
>>  void kvm_arch_destroy_vm(struct kvm *kvm)
>>  {
>> +	u16 rc, rrc;
>>  	kvm_free_vcpus(kvm);
>>  	sca_dispose(kvm);
>> -	debug_unregister(kvm->arch.dbf);
>>  	kvm_s390_gisa_destroy(kvm);
>> +	/* do not use the lock checking variant at tear-down */
>> +	if (kvm_s390_pv_handle(kvm)) {
> 
> kvm_s390_pv_is_protected ? I dislike using kvm_s390_pv_handle() when
> we're not interested in the handle.

Then I would need to take the kvm->mutex here. This is why I added
the comment. We are already at the last steps of killing the kvm
and the lock is not held. So the lockdep check would complain.
On the other hand grabbing kvm->lock is pointless as the kvm file
descriptor is already gone so the ioctls that we would protect against
cannot happen.


What about Improving the comment:

        /*
         * We are already at the end of life and kvm->lock is not taken.
         * This is ok as the file descriptor is closed by now and nobody
         * can mess with the pv state. To avoid lockdep_assert_held from
         * complaining we do not use kvm_s390_pv_is_protected.
         */

On the other hand This looks a bit too verbose.




[...]

>> +static inline u64 kvm_s390_pv_handle(struct kvm *kvm)
>> +{
>> +	return kvm->arch.pv.handle;
>> +}
> 
> Can we rename this to
> 
> kvm_s390_pv_get_handle()

ack.
> 
>> +
>> +static inline u64 kvm_s390_pv_handle_cpu(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu->arch.pv.handle;
>> +}
> 
> Can we rename this to kvm_s390_pv_cpu_get_handle() ? (so it doesn't look
> like the function will handle something)

ack. 

[...]
>> +int kvm_s390_pv_alloc_vm(struct kvm *kvm)
>> +{
>> +	unsigned long base = uv_info.guest_base_stor_len;
>> +	unsigned long virt = uv_info.guest_virt_var_stor_len;
>> +	unsigned long npages = 0, vlen = 0;
>> +	struct kvm_memory_slot *memslot;
>> +
>> +	kvm->arch.pv.stor_var = NULL;
>> +	kvm->arch.pv.stor_base = __get_free_pages(GFP_KERNEL, get_order(base));
>> +	if (!kvm->arch.pv.stor_base)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Calculate current guest storage for allocation of the
>> +	 * variable storage, which is based on the length in MB.
>> +	 *
>> +	 * Slots are sorted by GFN
>> +	 */
>> +	mutex_lock(&kvm->slots_lock);
>> +	memslot = kvm_memslots(kvm)->memslots;
>> +	npages = memslot->base_gfn + memslot->npages;
>> +	mutex_unlock(&kvm->slots_lock);
> 
> Are you blocking the addition of new memslots somehow?
> 

>> +int kvm_s390_pv_create_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>> +{
>> +	u16 drc, drrc;
>> +	int cc;
>> +
>> +	struct uv_cb_cgc uvcb = {
>> +		.header.cmd = UVC_CMD_CREATE_SEC_CONF,
>> +		.header.len = sizeof(uvcb)
>> +	};
>> +
>> +	if (kvm_s390_pv_handle(kvm))
> 
> Why is that necessary? We should only be called in PV mode.

It is not because the caller already checks. It was necessary in a previous version I guess.

[...]
>> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
>> +			      u16 *rrc)
>> +{
>> +	struct uv_cb_ssc uvcb = {
>> +		.header.cmd = UVC_CMD_SET_SEC_CONF_PARAMS,
>> +		.header.len = sizeof(uvcb),
>> +		.sec_header_origin = (u64)hdr,
>> +		.sec_header_len = length,
>> +		.guest_handle = kvm_s390_pv_handle(kvm),
>> +	};
>> +	int cc;
>> +
>> +	if (!kvm_s390_pv_handle(kvm))
> 
> Why is that necessary? We should only be called in PV mode.

ack


[...]

>> +struct kvm_s390_pv_sec_parm {
>> +	__u64	origin;
>> +	__u64	length;
> 
> tabs vs. spaces. (I'd use a single space like in kvm_s390_pv_unp below)

ack.
[...]
