Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbgBZNbr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 08:31:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QDUSSr050974
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 08:31:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcp8fkv6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 08:31:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 26 Feb 2020 13:31:43 -0000
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <20200225214822.3611-1-borntraeger@de.ibm.com>
 <20200226132640.36c32fd3.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Feb 2020 14:31:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200226132640.36c32fd3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <dcd80ccd-2d66-502f-62a1-3c794cfcde65@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com



On 26.02.20 13:26, Cornelia Huck wrote:
> On Tue, 25 Feb 2020 16:48:22 -0500
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
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
>>  arch/s390/include/asm/kvm_host.h |  24 ++-
>>  arch/s390/include/asm/uv.h       |  69 ++++++++
>>  arch/s390/kvm/Makefile           |   2 +-
>>  arch/s390/kvm/kvm-s390.c         | 209 +++++++++++++++++++++++-
>>  arch/s390/kvm/kvm-s390.h         |  33 ++++
>>  arch/s390/kvm/pv.c               | 269 +++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h         |  31 ++++
>>  7 files changed, 633 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/s390/kvm/pv.c
> 
> (...)
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
>> +		/*
>> +		 *  FMT 4 SIE needs esca. As we never switch back to bsca from
>> +		 *  esca, we need no cleanup in the error cases below
>> +		 */
>> +		r = sca_switch_to_extended(kvm);
>> +		if (r)
>> +			break;
>> +
>> +		r = kvm_s390_pv_init_vm(kvm, &cmd->rc, &cmd->rrc);
>> +		if (r)
>> +			break;
>> +
>> +		r = kvm_s390_cpus_to_pv(kvm, &cmd->rc, &cmd->rrc);
>> +		if (r)
>> +			kvm_s390_pv_deinit_vm(kvm, &dummy, &dummy);
>> +		break;
>> +	}
>> +	case KVM_PV_DISABLE: {
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = kvm_s390_cpus_from_pv(kvm, &cmd->rc, &cmd->rrc);
>> +		/*
>> +		 * If a CPU could not be destroyed, destroy VM will also fail.
>> +		 * There is no point in trying to destroy it. Instead return
>> +		 * the rc and rrc from the first CPU that failed destroying.
>> +		 */
>> +		if (r)
>> +			break;
>> +		r = kvm_s390_pv_deinit_vm(kvm, &cmd->rc, &cmd->rrc);
>> +		break;
>> +	}
> 
> IIUC, we may end up in an odd state in the failure case, because we
> might not be able to free up the donated memory, depending on what goes
> wrong. Can userspace do anything useful with the vm if that happens?

The protected VM is still there. Depending on how many CPUs are still
available the secure guest can still run or not. But this is really
fine, no strange things will happen.
> 
> Even more important, userspace cannot cause repeated donations by
> repeatedly calling this ioctl, right?

No, we keep the handle exactly to avoid userspace to not be able
to do disable/enable in a loop.

> 
>> +	case KVM_PV_SET_SEC_PARMS: {
>> +		struct kvm_s390_pv_sec_parm parms = {};
>> +		void *hdr;
>> +
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = -EFAULT;
>> +		if (copy_from_user(&parms, argp, sizeof(parms)))
>> +			break;
>> +
>> +		/* Currently restricted to 8KB */
>> +		r = -EINVAL;
>> +		if (parms.length > PAGE_SIZE * 2)
>> +			break;
>> +
>> +		r = -ENOMEM;
>> +		hdr = vmalloc(parms.length);
>> +		if (!hdr)
>> +			break;
>> +
>> +		r = -EFAULT;
>> +		if (!copy_from_user(hdr, (void __user *)parms.origin,
>> +				    parms.length))
>> +			r = kvm_s390_pv_set_sec_parms(kvm, hdr, parms.length,
>> +						      &cmd->rc, &cmd->rrc);
>> +
>> +		vfree(hdr);
>> +		break;
>> +	}
>> +	case KVM_PV_UNPACK: {
>> +		struct kvm_s390_pv_unp unp = {};
>> +
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = -EFAULT;
>> +		if (copy_from_user(&unp, argp, sizeof(unp)))
>> +			break;
>> +
>> +		r = kvm_s390_pv_unpack(kvm, unp.addr, unp.size, unp.tweak,
>> +				       &cmd->rc, &cmd->rrc);
>> +		break;
>> +	}
>> +	case KVM_PV_VERIFY: {
>> +		r = -EINVAL;
>> +		if (!kvm_s390_pv_is_protected(kvm))
>> +			break;
>> +
>> +		r = uv_cmd_nodata(kvm_s390_pv_get_handle(kvm),
>> +				  UVC_CMD_VERIFY_IMG, &cmd->rc, &cmd->rrc);
>> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT VERIFY: rc %x rrc %x", cmd->rc,
>> +			     cmd->rrc);
>> +		break;
>> +	}
>> +	default:
>> +		return -ENOTTY;
> 
> Nit: why not r = -ENOTTY, so you get a single exit point?

can do.

> 
>> +	}
>> +	return r;
>> +}
>> +
>>  long kvm_arch_vm_ioctl(struct file *filp,
>>  		       unsigned int ioctl, unsigned long arg)
>>  {
>> @@ -2262,6 +2419,27 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>  		mutex_unlock(&kvm->slots_lock);
>>  		break;
>>  	}
>> +	case KVM_S390_PV_COMMAND: {
>> +		struct kvm_pv_cmd args;
>> +
>> +		r = 0;
>> +		if (!is_prot_virt_host()) {
>> +			r = -EINVAL;
>> +			break;
>> +		}
>> +		if (copy_from_user(&args, argp, sizeof(args))) {
>> +			r = -EFAULT;
>> +			break;
>> +		}
> 
> The api states that args.flags must be 0... better enforce that?


yes
@@ -2431,6 +2431,10 @@ long kvm_arch_vm_ioctl(struct file *filp,
                        r = -EFAULT;
                        break;
                }
+               if (args.flags) {
+                       r = -EINVAL;
+                       break;
+               }
                mutex_lock(&kvm->lock);
                r = kvm_s390_handle_pv(kvm, &args);
                mutex_unlock(&kvm->lock);



> 
>> +		mutex_lock(&kvm->lock);
>> +		r = kvm_s390_handle_pv(kvm, &args);
>> +		mutex_unlock(&kvm->lock);
>> +		if (copy_to_user(argp, &args, sizeof(args))) {
>> +			r = -EFAULT;
>> +			break;
>> +		}
>> +		break;
>> +	}
>>  	default:
>>  		r = -ENOTTY;
>>  	}
> 
> (...)
> 
>> @@ -2558,10 +2741,19 @@ static void kvm_free_vcpus(struct kvm *kvm)
>>  
>>  void kvm_arch_destroy_vm(struct kvm *kvm)
>>  {
>> +	u16 rc, rrc;
> 
> Nit: missing empty line.

ack.

> 
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
>> +	if (kvm_s390_pv_get_handle(kvm))
>> +		kvm_s390_pv_deinit_vm(kvm, &rc, &rrc);
>> +	debug_unregister(kvm->arch.dbf);
>>  	free_page((unsigned long)kvm->arch.sie_page2);
>>  	if (!kvm_is_ucontrol(kvm))
>>  		gmap_remove(kvm->arch.gmap);
> 
> (...)
> 
>> @@ -4540,6 +4744,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
>>  	if (mem->guest_phys_addr + mem->memory_size > kvm->arch.mem_limit)
>>  		return -EINVAL;
>>  
>> +	/* When we are protected we should not change the memory slots */
> 
> s/protected/protected,/

ack.

> 
>> +	if (kvm_s390_pv_is_protected(kvm))
>> +		return -EINVAL;
>>  	return 0;
>>  }
>>  
> 
> (...)
> 
>> +static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
>> +{
>> +	unsigned long base = uv_info.guest_base_stor_len;
>> +	unsigned long virt = uv_info.guest_virt_var_stor_len;
> 
> base_len and virt_len? Makes the code below less confusing.

this makes some lines longer than 80 for no obvious benefit. I think I will keep
the names.


> 
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
>> +
>> +	kvm->arch.pv.guest_len = npages * PAGE_SIZE;
>> +
>> +	/* Allocate variable storage */
>> +	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
>> +	vlen += uv_info.guest_virt_base_stor_len;
>> +	kvm->arch.pv.stor_var = vzalloc(vlen);
>> +	if (!kvm->arch.pv.stor_var)
>> +		goto out_err;
>> +	return 0;
>> +
>> +out_err:
>> +	kvm_s390_pv_dealloc_vm(kvm);
>> +	return -ENOMEM;
>> +}
>> +
>> +/* this should not fail, but if it does we must not free the donated memory */
> 
> s/does/does,/

ack
