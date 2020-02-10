Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgBJJeC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 04:34:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01A9UkLV070102
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 04:34:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1tncqnmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 10 Feb 2020 04:34:00 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 10 Feb 2020 09:33:58 -0000
Subject: Re: [PATCH 25/35] KVM: s390: protvirt: Only sync fmt4 registers
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-26-borntraeger@de.ibm.com>
 <cbb6ae42-5320-e6cf-214d-a81602a359cf@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 10 Feb 2020 10:33:53 +0100
MIME-Version: 1.0
In-Reply-To: <cbb6ae42-5320-e6cf-214d-a81602a359cf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4b676484-100d-694a-fcea-4ab2bd9411e2@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 09.02.20 16:50, Thomas Huth wrote:
> On 07/02/2020 12.39, Christian Borntraeger wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> A lot of the registers are controlled by the Ultravisor and never
>> visible to KVM. Also some registers are overlayed, like gbea is with
>> sidad, which might leak data to userspace.
>>
>> Hence we sync a minimal set of registers for both SIE formats and then
>> check and sync format 2 registers if necessary.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c | 116 ++++++++++++++++++++++++---------------
>>  1 file changed, 72 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index f995040102ea..7df48cc942fd 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -3447,9 +3447,11 @@ static void kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
>>  	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
>>  	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
>>  	vcpu->run->s.regs.fpc = 0;
>> -	vcpu->arch.sie_block->gbea = 1;
>> -	vcpu->arch.sie_block->pp = 0;
>> -	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>> +	if (!kvm_s390_pv_handle_cpu(vcpu)) {
>> +		vcpu->arch.sie_block->gbea = 1;
>> +		vcpu->arch.sie_block->pp = 0;
>> +		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>> +	}
> 
> Technically, this part is not about sync'ing but about reset ... worth
> to mention this in the patch description, too? (or maybe even move to
> the reset patch 34/35 or a new patch?)

Will move into a separate patch. 
> 
> And what about vcpu->arch.sie_block->todpr ? Should that be moved into
> the if-statement, too?

Yes, todpr is not accessible by the KVM and should go in here 


> 
>>  }
>>  
>>  static void kvm_arch_vcpu_ioctl_clear_reset(struct kvm_vcpu *vcpu)
>> @@ -4060,25 +4062,16 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>>  	return rc;
>>  }
>>  
>> -static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>> +static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  {
>>  	struct runtime_instr_cb *riccb;
>>  	struct gs_cb *gscb;
>>  
>> -	riccb = (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
>> -	gscb = (struct gs_cb *) &kvm_run->s.regs.gscb;
>>  	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
>>  	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
>> -		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
>> -	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
>> -		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
>> -		/* some control register changes require a tlb flush */
>> -		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
>> -	}
>> +	riccb = (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
>> +	gscb = (struct gs_cb *) &kvm_run->s.regs.gscb;
> 
> You could leave the riccb and gscb lines at the beginning to make the
> diff a little bit nicer.

ack.
> 
>>  	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
>> -		kvm_s390_set_cpu_timer(vcpu, kvm_run->s.regs.cputm);
>> -		vcpu->arch.sie_block->ckc = kvm_run->s.regs.ckc;
>>  		vcpu->arch.sie_block->todpr = kvm_run->s.regs.todpr;
>>  		vcpu->arch.sie_block->pp = kvm_run->s.regs.pp;
>>  		vcpu->arch.sie_block->gbea = kvm_run->s.regs.gbea;
>> @@ -4119,6 +4112,47 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
>>  		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
>>  	}
>> +	if (MACHINE_HAS_GS) {
>> +		preempt_disable();
>> +		__ctl_set_bit(2, 4);
>> +		if (current->thread.gs_cb) {
>> +			vcpu->arch.host_gscb = current->thread.gs_cb;
>> +			save_gs_cb(vcpu->arch.host_gscb);
>> +		}
>> +		if (vcpu->arch.gs_enabled) {
>> +			current->thread.gs_cb = (struct gs_cb *)
>> +						&vcpu->run->s.regs.gscb;
>> +			restore_gs_cb(current->thread.gs_cb);
>> +		}
>> +		preempt_enable();
>> +	}
>> +	/* SIE will load etoken directly from SDNX and therefore kvm_run */
>> +}
>> +
>> +static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>> +{
>> +	/*
>> +	 * at several places we have to modify our internal view to not do
>> +	 * things that are disallowed by the ultravisor. For example we must
>> +	 * not inject interrupts after specific exits (e.g. 112). We do this
>> +	 * by turning off the MIE bits of our PSW copy. To avoid getting
>> +	 * validity intercepts, we do only accept the condition code from
>> +	 * userspace.
>> +	 */
>> +	vcpu->arch.sie_block->gpsw.mask &= ~PSW_MASK_CC;
>> +	vcpu->arch.sie_block->gpsw.mask |= kvm_run->psw_mask & PSW_MASK_CC;
> 
> I think it would be cleaner to only do this for protected guests. You
> could combine it with the call to sync_regs_fmt2():
> 
> 	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm))) {
> 		sync_regs_fmt2(vcpu, kvm_run);
> 	} else {
> 		vcpu->arch.sie_block->gpsw.mask &= ~PSW_MASK_CC;
> 		vcpu->arch.sie_block->gpsw.mask |= kvm_run->psw_mask &
> 						   PSW_MASK_CC;
> 	}

I like that. 

[...]
>>  static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>> @@ -4161,12 +4203,9 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  	kvm_run->s.regs.cputm = kvm_s390_get_cpu_timer(vcpu);
>>  	kvm_run->s.regs.ckc = vcpu->arch.sie_block->ckc;
>>  	kvm_run->s.regs.todpr = vcpu->arch.sie_block->todpr;
> 
> TODPR handling has been move from sync_regs() to sync_regs_fmt2() ...
> should this here move from store_regs() to store_regs_fmt2(), too?

ack.
> 
> And maybe you should also not read the sie_block->gpsw.addr (and some of
> the control registers) field in store_regs() either, i.e. move the lines
> to store_regs_fmt2()?
> 
>> -	kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
>> -	kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
>>  	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
>>  	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
>>  	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
>> -	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>>  	save_access_regs(vcpu->run->s.regs.acrs);
>>  	restore_access_regs(vcpu->arch.host_acrs);
>>  	/* Save guest register state */
>> @@ -4175,19 +4214,8 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>  	/* Restore will be done lazily at return */
>>  	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
>>  	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
>> -	if (MACHINE_HAS_GS) {
>> -		__ctl_set_bit(2, 4);
>> -		if (vcpu->arch.gs_enabled)
>> -			save_gs_cb(current->thread.gs_cb);
>> -		preempt_disable();
>> -		current->thread.gs_cb = vcpu->arch.host_gscb;
>> -		restore_gs_cb(vcpu->arch.host_gscb);
>> -		preempt_enable();
>> -		if (!vcpu->arch.host_gscb)
>> -			__ctl_clear_bit(2, 4);
>> -		vcpu->arch.host_gscb = NULL;
>> -	}
>> -	/* SIE will save etoken directly into SDNX and therefore kvm_run */
>> +	if (likely(!kvm_s390_pv_is_protected(vcpu->kvm)))
>> +		store_regs_fmt2(vcpu, kvm_run);
>>  }
>>  
>>  int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>
> 
>  Thomas
> 
