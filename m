Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgA3NCb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 08:02:31 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UD0Job108522
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 08:02:29 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xubctceb4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 08:02:29 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 30 Jan 2020 13:02:28 -0000
Subject: Re: [PATCH v9 1/6] KVM: s390: do not clobber registers during guest
 reset/store status
References: <20200130123434.68129-1-frankja@linux.ibm.com>
 <20200130123434.68129-2-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 30 Jan 2020 14:02:22 +0100
MIME-Version: 1.0
In-Reply-To: <20200130123434.68129-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <10a0c2ad-ce56-cd2e-2ffc-dc55a3c27bc8@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org



On 30.01.20 13:34, Janosch Frank wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The initial CPU reset clobbers the userspace fpc and the store status
> ioctl clobbers the guest acrs + fpr.  As these calls are only done via
> ioctl (and not via vcpu_run), no CPU context is loaded, so we can (and
> must) act directly on the sync regs, not on the thread context.
> 
> Cc: stable@kernel.org
> Fixes: e1788bb995be ("KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load")
> Fixes: 31d8b8d41a7e ("KVM: s390: handle access registers in the run ioctl not in vcpu_put/load")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c059b86aacd4..328dee666b24 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2824,8 +2824,7 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
>  					CR14_UNUSED_33 |
>  					CR14_EXTERNAL_DAMAGE_SUBMASK;
> -	/* make sure the new fpc will be lazily loaded */
> -	save_fpu_regs();
> +	vcpu->run->s.regs.fpc = 0;


>  	current->thread.fpu.fpc = 0;

this needs to go out here as well.

>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> @@ -4343,7 +4342,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  	switch (ioctl) {
>  	case KVM_S390_STORE_STATUS:
>  		idx = srcu_read_lock(&vcpu->kvm->srcu);
> -		r = kvm_s390_vcpu_store_status(vcpu, arg);
> +		r = kvm_s390_store_status_unloaded(vcpu, arg);
>  		srcu_read_unlock(&vcpu->kvm->srcu, idx);
>  		break;
>  	case KVM_S390_SET_INITIAL_PSW: {
> 
