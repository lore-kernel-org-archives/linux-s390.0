Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728454AbgB0Jrp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Feb 2020 04:47:45 -0500
Date: Thu, 27 Feb 2020 10:47:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] KVM: s390: introduce module parameter kvm.use_gisa
Message-ID: <20200227104731.17166768.cohuck@redhat.com>
In-Reply-To: <20200227091031.102993-1-mimu@linux.ibm.com>
References: <20200227091031.102993-1-mimu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Mueller <mimu@linux.ibm.com>
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, kvm@vger.kernel.org, david@redhat.com, thuth@redhat.com, linux-s390@vger.kernel.org

On Thu, 27 Feb 2020 10:10:31 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

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

Maybe log something as well if it is off due to this kernel parameter?

> 
> In general, that value should not be changed as the GISA facility
> enhances interruption delivery performance.
> 
> A reason to switch the GISA facility off might be a performance
> comparison run or debugging.
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
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

I probably would have inverted the logic (i.e. introduce a disable_gisa
parameter that is off by default), as you want KVM to use the gisa,
except in special circumstances.

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

I assume we're fine with no gisa but a gib (i.e. doesn't hurt?)

>  	KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
>  
>  	return 0;
