Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgB0M1S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 07:27:18 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RCLejN085940
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 07:27:17 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydq60u183-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 07:27:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 27 Feb 2020 12:27:15 -0000
Subject: Re: [PATCH] KVM: s390: introduce module parameter kvm.use_gisa
References: <20200227091031.102993-1-mimu@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 27 Feb 2020 13:27:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200227091031.102993-1-mimu@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c16f65a7-5711-96e2-1527-fa13eab9f5ca@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>, frankja@linux.vnet.ibm.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, david@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org



On 27.02.20 10:10, Michael Mueller wrote:
> The boolean module parameter "kvm.use_gisa" controls if newly
> created guests will use the GISA facility if provided by the
> host system. The default is yes.
> 
>   # cat /sys/module/kvm/parameters/use_gisa
>   Y
> 
> The parameter can be changed on the fly.
> 
>   # echo N > /sys/module/kvm/parameters/use_gisa
> 
> Already running guests are not affected by this change.
> 
> The kvm s390 debug feature shows if a guest is running with GISA.
> 
>   # grep gisa /sys/kernel/debug/s390dbf/kvm-$pid/sprintf
>   00 01582725059:843303 3 - 08 00000000e119bc01  gisa 0x00000000c9ac2642 initialized
>   00 01582725059:903840 3 - 11 000000004391ee22  00[0000000000000000-0000000000000000]: AIV gisa format-1 enabled for cpu 000
>   ...
>   00 01582725059:916847 3 - 08 0000000094fff572  gisa 0x00000000c9ac2642 cleared
> 
> In general, that value should not be changed as the GISA facility
> enhances interruption delivery performance.
> 
> A reason to switch the GISA facility off might be a performance
> comparison run or debugging.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>

Looks good to me. Regarding the other comments, I think allowing for dynamic changes
and keeping use_gisa vs disable_gisa makes sense. So I would think that the patch
as is makes sense.

The only question is: shall we set use_gisa to 0 when the machine does not support
it (e.g. VSIE?) and then also forbid setting it to 1? Could be overkill.


> ---
>  arch/s390/kvm/kvm-s390.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d7ff30e45589..5c2081488024 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -184,6 +184,11 @@ static u8 halt_poll_max_steal = 10;
>  module_param(halt_poll_max_steal, byte, 0644);
>  MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
>  
> +/* if set to true, the GISA will be initialized and used if available */
> +static bool use_gisa  = true;
> +module_param(use_gisa, bool, 0644);
> +MODULE_PARM_DESC(use_gisa, "Use the GISA if the host supports it.");
> +
>  /*
>   * For now we handle at most 16 double words as this is what the s390 base
>   * kernel handles and stores in the prefix page. If we ever need to go beyond
> @@ -2504,7 +2509,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  	kvm->arch.use_skf = sclp.has_skey;
>  	spin_lock_init(&kvm->arch.start_stop_lock);
>  	kvm_s390_vsie_init(kvm);
> -	kvm_s390_gisa_init(kvm);
> +	if (use_gisa)
> +		kvm_s390_gisa_init(kvm);
>  	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
>  
>  	return 0;
> 
