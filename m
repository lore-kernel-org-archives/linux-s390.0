Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728398AbgAaLbw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 06:31:52 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VBOqVb107094
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 06:31:50 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvd6yv5ct-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 06:31:50 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 11:31:48 -0000
Subject: Re: [PATCH v10 2/6] KVM: s390: Cleanup initial cpu reset
References: <20200131100205.74720-1-frankja@linux.ibm.com>
 <20200131100205.74720-3-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 31 Jan 2020 12:31:44 +0100
MIME-Version: 1.0
In-Reply-To: <20200131100205.74720-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <5fc3f591-6272-2ba1-b98f-95009f865906@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 31.01.20 11:02, Janosch Frank wrote:
> The code seems to be quite old and uses lots of unneeded spaces for
> alignment, which doesn't really help with readability.
> 
> Let's:
> * Get rid of the extra spaces
> * Remove the ULs as they are not needed on 0s
> * Define constants for the CR 0 and 14 initial values
> * Use the sizeof of the gcr array to memset it to 0
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

applied.

> ---
>  arch/s390/include/asm/kvm_host.h |  5 +++++
>  arch/s390/kvm/kvm-s390.c         | 18 +++++++-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 02f4c21c57f6..73044545ecac 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -122,6 +122,11 @@ struct mcck_volatile_info {
>  	__u32 reserved;
>  };
>  
> +#define CR0_INITIAL_MASK (CR0_UNUSED_56 | CR0_INTERRUPT_KEY_SUBMASK | \
> +			  CR0_MEASUREMENT_ALERT_SUBMASK)
> +#define CR14_INITIAL_MASK (CR14_UNUSED_32 | CR14_UNUSED_33 | \
> +			   CR14_EXTERNAL_DAMAGE_SUBMASK)
> +
>  #define CPUSTAT_STOPPED    0x80000000
>  #define CPUSTAT_WAIT       0x10000000
>  #define CPUSTAT_ECALL_PEND 0x08000000
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 876802894b35..bb072866bd69 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2847,19 +2847,15 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
>  {
>  	/* this equals initial cpu reset in pop, but we don't switch to ESA */
> -	vcpu->arch.sie_block->gpsw.mask = 0UL;
> -	vcpu->arch.sie_block->gpsw.addr = 0UL;
> +	vcpu->arch.sie_block->gpsw.mask = 0;
> +	vcpu->arch.sie_block->gpsw.addr = 0;
>  	kvm_s390_set_prefix(vcpu, 0);
>  	kvm_s390_set_cpu_timer(vcpu, 0);
> -	vcpu->arch.sie_block->ckc       = 0UL;
> -	vcpu->arch.sie_block->todpr     = 0;
> -	memset(vcpu->arch.sie_block->gcr, 0, 16 * sizeof(__u64));
> -	vcpu->arch.sie_block->gcr[0]  = CR0_UNUSED_56 |
> -					CR0_INTERRUPT_KEY_SUBMASK |
> -					CR0_MEASUREMENT_ALERT_SUBMASK;
> -	vcpu->arch.sie_block->gcr[14] = CR14_UNUSED_32 |
> -					CR14_UNUSED_33 |
> -					CR14_EXTERNAL_DAMAGE_SUBMASK;
> +	vcpu->arch.sie_block->ckc = 0;
> +	vcpu->arch.sie_block->todpr = 0;
> +	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr));
> +	vcpu->arch.sie_block->gcr[0] = CR0_INITIAL_MASK;
> +	vcpu->arch.sie_block->gcr[14] = CR14_INITIAL_MASK;
>  	vcpu->run->s.regs.fpc = 0;
>  	vcpu->arch.sie_block->gbea = 1;
>  	vcpu->arch.sie_block->pp = 0;
> 
