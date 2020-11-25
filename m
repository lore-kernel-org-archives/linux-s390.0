Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgKYJIE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 04:08:04 -0500
Subject: Re: [PATCH] KVM: s390: track synchronous pfault events in kvm_stat
References: <20201125090658.38463-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <423b8979-84aa-7c0e-9980-dc3185b6c98a@redhat.com>
Date: Wed, 25 Nov 2020 10:07:57 +0100
MIME-Version: 1.0
In-Reply-To: <20201125090658.38463-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>

On 25.11.20 10:06, Christian Borntraeger wrote:
> Right now we do count pfault (pseudo page faults aka async page faults
> start and completion events). What we do not count is, if an async page
> fault would have been possible by the host, but it was disabled by the
> guest (e.g. interrupts off, pfault disabled, secure execution....).  Let
> us count those as well in the pfault_sync counter.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h | 1 +
>  arch/s390/kvm/kvm-s390.c         | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 463c24e26000..74f9a036bab2 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -459,6 +459,7 @@ struct kvm_vcpu_stat {
>  	u64 diagnose_308;
>  	u64 diagnose_500;
>  	u64 diagnose_other;
> +	u64 pfault_sync;
>  };
>  
>  #define PGM_OPERATION			0x01
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 282a13ece554..dbafd057ca6a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -60,6 +60,7 @@
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
>  	VCPU_STAT("userspace_handled", exit_userspace),
>  	VCPU_STAT("exit_null", exit_null),
> +	VCPU_STAT("pfault_sync", pfault_sync),
>  	VCPU_STAT("exit_validity", exit_validity),
>  	VCPU_STAT("exit_stop_request", exit_stop_request),
>  	VCPU_STAT("exit_external_request", exit_external_request),
> @@ -4109,6 +4110,7 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>  		current->thread.gmap_pfault = 0;
>  		if (kvm_arch_setup_async_pf(vcpu))
>  			return 0;
> +		vcpu->stat.pfault_sync++;
>  		return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
>  	}
>  	return vcpu_post_run_fault_in_sie(vcpu);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
