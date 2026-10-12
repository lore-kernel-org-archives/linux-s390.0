Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB944C33CA
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791827648; cv=none; b=ZxoJvZUq2P+edHhYOsx0iJfFUY7I1oMHZaTSwF2ohJ0cGttoWS9/GfON9rUxfC7qlJhaxRCmqu4KYA2l8cik/r5eCE5Mevp3/gD2oc3OU2ZglFft4VKtwKDI9G6JNg+JumLp/UYAGKYeEpoAge9jrkmRbyVSFmzKYj4ImZncVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791827648; c=relaxed/simple;
	bh=GqW6X0e8GvocLiHH7mCG3qie100xutSn9auqpT4X9dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzmwDF7fllO8laPC8mTHBy382oZbWcpCzd1JzgW5Bc/BmWBg+puYxflWlwXIL5Efz2lUZ8FvnhRgkh7W+5ebn/+XD/5a9RK47Q9295ZlvHOb2t2C9TzrHyo7TokZQfZj3AncykrmDo3/OI2c+LS34K6coX7yXBfoLwbj1LA/DgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqOw0EDG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqOw0EDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791827645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+wzE9hjVXrjnagvOmw5E4SmbdWss98OJxUZzJh677E=;
	b=LqOw0EDG7+n4nr3VFpdWnaYQvZYPOy0B3JU9A8QrMoj7ok0QMFFtyamL17KMO/Bit8O6Fn
	GRq9oTRK5MCyXS2HFl9AC+Wa3PdMdue7mok9I0P8FQpQ6p9Xbj4LgzbsCIvWkQYItCFQJg
	kd7tyC6Hn0bGRhQSg2IXulj5V8hhDK0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-kZ14yxcMPTyc-sfrmgAaVw-1; Mon,
 12 Oct 2026 17:53:59 +0000
X-MC-Unique: kZ14yxcMPTyc-sfrmgAaVw-1
X-Mimecast-MFC-AGG-ID: kZ14yxcMPTyc-sfrmgAaVw_1791827634
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69EBC184B389;
	Mon, 12 Oct 2026 17:53:54 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 10B36195608C;
	Mon, 12 Oct 2026 17:53:45 +0000 (UTC)
Message-ID: <26b2c514-de23-4c70-81c8-875f8e8c094a@redhat.com>
Date: Mon, 12 Oct 2026 19:53:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] KVM: Move architecture capability Kconfigs to
 header defines
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
 Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
 Nico Boehr <nrb@linux.ibm.com>,
 Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-3-seiden@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260930173441.66762-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 9/30/26 19:34, Steffen Eiden wrote:
> Historically, KVM feature opt-ins and callbacks were configured globally
> via Kconfig symbols (CONFIG_HAVE_KVM_* and CONFIG_KVM_*).

Not all of them - there are many __KVM_HAVE_* symbols already.  In 
particular now there's both KVM_MSI and __KVM_HAVE_MSI/__KVM_HAVE_MSIX 
(but the latter is dead, so I have sent a patch to remove it).

There are several remaining CONFIG_HAVE_KVM_ARCH_* Kconfig symbols as 
well.  That's okay, but it should be noted in the changelog that not all 
symbols were fixed.

Can you at least quickly provide a v2, that changes all symbols to 
__KVM_HAVE_<function-name> (and when not applicable __KVM_*, for example 
__KVM_HAVE_READONLY_MEM)?  I have already changed KVM_NO_MMIO to 
__KVM_NO_MMIO in kvm/queue.

Thanks,

Paolo

> Replace these global Kconfig options with architecture-specific opt-in
> defines in <asm/kvm_host.h> and standardize their naming by dropping the
> HAVE_ prefix:
>    - KVM_INVALID_WAKEUPS
>    - KVM_MSI			(formerly HAVE_KVM_MSI)
>    - KVM_NO_POLL			(formerly HAVE_KVM_NO_POLL)
>    - KVM_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
>    - KVM_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)
> 
> This allows each architecture and guest implementation to configure its
> supported capabilities independently in its kvm_host header and eliminates
> unnecessary fallback stubs across different KVM targets.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/arm64/include/asm/kvm_host.h     |  3 +++
>   arch/arm64/kvm/Kconfig                |  3 ---
>   arch/loongarch/include/asm/kvm_host.h |  2 ++
>   arch/loongarch/kvm/Kconfig            |  2 --
>   arch/mips/include/asm/kvm_host.h      |  1 +
>   arch/mips/kvm/Kconfig                 |  1 -
>   arch/powerpc/include/asm/kvm_host.h   |  3 +++
>   arch/powerpc/kvm/Kconfig              |  1 -
>   arch/riscv/include/asm/kvm_host.h     |  2 ++
>   arch/riscv/kvm/Kconfig                |  2 --
>   arch/s390/include/asm/kvm_host_s390.h |  3 +++
>   arch/s390/kvm/Kconfig                 |  2 --
>   arch/x86/include/asm/kvm_host.h       |  3 +++
>   arch/x86/kvm/Kconfig                  |  3 ---
>   include/linux/kvm_host.h              | 18 +++++++++++-------
>   virt/kvm/Kconfig                      | 15 ---------------
>   virt/kvm/kvm_main.c                   |  4 ++--
>   17 files changed, 30 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index cd9b9d2462f9..db002e5ac9d4 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -30,6 +30,9 @@
>   #include <asm/vncr_mapping.h>
>   
>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> +#define KVM_MSI
> +#define KVM_READONLY_MEM
> +#define KVM_VCPU_RUN_PID_CHANGE
>   
>   #define KVM_HALT_POLL_NS_DEFAULT 500000
>   
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 449154f9a485..7329124deb2f 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -28,12 +28,9 @@ menuconfig KVM
>   	select KVM_VFIO
>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
>   	select NEED_KVM_DIRTY_RING_WITH_BITMAP
> -	select HAVE_KVM_MSI
>   	select HAVE_KVM_IRQCHIP
>   	select HAVE_KVM_IRQ_ROUTING
>   	select HAVE_KVM_IRQ_BYPASS
> -	select HAVE_KVM_READONLY_MEM
> -	select HAVE_KVM_VCPU_RUN_PID_CHANGE
>   	select SCHED_INFO
>   	select GUEST_PERF_EVENTS if PERF_EVENTS
>   	select KVM_GUEST_MEMFD
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 65d91c3ce313..4cb370a8d09b 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -26,6 +26,8 @@
>   #include <asm/loongarch.h>
>   
>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> +#define KVM_MSI
> +#define KVM_READONLY_MEM
>   
>   /* Loongarch KVM register ids */
>   #define KVM_GET_IOC_CSR_IDX(id)		((id & KVM_CSR_IDX_MASK) >> LOONGARCH_REG_SHIFT)
> diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
> index 15da2d88c0c1..a427429a2b05 100644
> --- a/arch/loongarch/kvm/Kconfig
> +++ b/arch/loongarch/kvm/Kconfig
> @@ -23,8 +23,6 @@ config KVM
>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
>   	select HAVE_KVM_IRQ_ROUTING
>   	select HAVE_KVM_IRQCHIP
> -	select HAVE_KVM_MSI
> -	select HAVE_KVM_READONLY_MEM
>   	select KVM_COMMON
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>   	select KVM_GENERIC_HARDWARE_ENABLING
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
> index c14b10821817..8e484bb482ba 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -893,5 +893,6 @@ static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>   static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
>   
>   #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
> +#define KVM_READONLY_MEM
>   
>   #endif /* __MIPS_KVM_HOST_H__ */
> diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
> index b1b9a1d67758..c24b872afbcb 100644
> --- a/arch/mips/kvm/Kconfig
> +++ b/arch/mips/kvm/Kconfig
> @@ -24,7 +24,6 @@ config KVM
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>   	select KVM_MMIO
>   	select KVM_GENERIC_HARDWARE_ENABLING
> -	select HAVE_KVM_READONLY_MEM
>   	help
>   	  Support for hosting Guest kernels.
>   
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 2d139c807577..ad7c34e9b227 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -49,6 +49,9 @@
>   #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>   
>   #define __KVM_HAVE_ARCH_INTC_INITIALIZED
> +#ifdef CONFIG_KVM_MPIC
> +#define KVM_MSI
> +#endif
>   
>   #define KVM_HALT_POLL_NS_DEFAULT 10000	/* 10 us */
>   
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index b6bc2fc86dca..1fae2de8fa68 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -232,7 +232,6 @@ config KVM_MPIC
>   	depends on KVM && PPC_E500
>   	select HAVE_KVM_IRQCHIP
>   	select HAVE_KVM_IRQ_ROUTING
> -	select HAVE_KVM_MSI
>   	help
>   	  Enable support for emulating MPIC devices inside the
>   	  host kernel, rather than relying on userspace to emulate.
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index a30600579231..23b5560e97ba 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -47,6 +47,8 @@
>   #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
>   
>   #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +#define KVM_MSI
> +#define KVM_READONLY_MEM
>   
>   #define KVM_HAVE_MMU_RWLOCK
>   
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index ec2cee0a39e0..3cb4f8037300 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -22,8 +22,6 @@ config KVM
>   	depends on RISCV_SBI && MMU
>   	select HAVE_KVM_IRQCHIP
>   	select HAVE_KVM_IRQ_ROUTING
> -	select HAVE_KVM_MSI
> -	select HAVE_KVM_READONLY_MEM
>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
>   	select KVM_COMMON
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
> diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
> index 9519b8028b10..bd42c84b8b16 100644
> --- a/arch/s390/include/asm/kvm_host_s390.h
> +++ b/arch/s390/include/asm/kvm_host_s390.h
> @@ -34,6 +34,9 @@
>   
>   #define KVM_INTERNAL_MEM_SLOTS 1
>   
> +#define KVM_INVALID_WAKEUPS
> +#define KVM_NO_POLL
> +
>   #define KVM_S390_MANAGES_S390_GUEST 1
>   
>   /*
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 8d3ee17a1bcb..9045ae20fd89 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -25,8 +25,6 @@ config KVM
>   	select KVM_COMMON
>   	select HAVE_KVM_IRQCHIP
>   	select HAVE_KVM_IRQ_ROUTING
> -	select HAVE_KVM_INVALID_WAKEUPS
> -	select HAVE_KVM_NO_POLL
>   	select KVM_VFIO
>   	select VIRT_XFER_TO_GUEST_WORK
>   	select KVM_MMU_LOCKLESS_AGING
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e460073ff176..d8f6333de323 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -47,6 +47,9 @@
>   #define kvm_file_to_kvm_arch x86
>   
>   #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
> +#define KVM_MSI
> +#define KVM_NO_POLL
> +#define KVM_READONLY_MEM
>   
>   /*
>    * CONFIG_KVM_MAX_NR_VCPUS is defined iff CONFIG_KVM!=n, provide a dummy max if
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 538ed1e80332..294684b217bb 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -28,7 +28,6 @@ config KVM_X86
>   	select HAVE_KVM_DIRTY_RING_ACQ_REL
>   	select HAVE_KVM_IRQ_BYPASS
>   	select HAVE_KVM_IRQ_ROUTING
> -	select HAVE_KVM_READONLY_MEM
>   	select VHOST_TASK
>   	select KVM_ASYNC_PF
>   	select USER_RETURN_NOTIFIER
> @@ -37,9 +36,7 @@ config KVM_X86
>   	select PERF_EVENTS
>   	select GUEST_PERF_EVENTS
>   	select PERF_GUEST_MEDIATED_PMU
> -	select HAVE_KVM_MSI
>   	select HAVE_KVM_CPU_RELAX_INTERCEPT
> -	select HAVE_KVM_NO_POLL
>   	select VIRT_XFER_TO_GUEST_WORK
>   	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>   	select KVM_VFIO
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 160e3e64ec6d..a0e9cc55a6a4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -750,7 +750,11 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
>   #ifndef kvm_arch_has_readonly_mem
>   static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
>   {
> -	return IS_ENABLED(CONFIG_HAVE_KVM_READONLY_MEM);
> +#ifdef KVM_READONLY_MEM
> +	return true;
> +#else
> +	return false;
> +#endif
>   }
>   #endif
>   
> @@ -2486,7 +2490,7 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
>   				   struct kvm_kernel_irq_routing_entry *new);
>   #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>   
> -#ifdef CONFIG_HAVE_KVM_INVALID_WAKEUPS
> +#ifdef KVM_INVALID_WAKEUPS
>   /* If we wakeup during the poll time, was it a sucessful poll? */
>   static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
>   {
> @@ -2498,9 +2502,9 @@ static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
>   {
>   	return true;
>   }
> -#endif /* CONFIG_HAVE_KVM_INVALID_WAKEUPS */
> +#endif /* KVM_INVALID_WAKEUPS */
>   
> -#ifdef CONFIG_HAVE_KVM_NO_POLL
> +#ifdef KVM_NO_POLL
>   /* Callback that tells if we must not poll */
>   bool kvm_arch_no_poll(struct kvm_vcpu *vcpu);
>   #else
> @@ -2508,18 +2512,18 @@ static inline bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>   {
>   	return false;
>   }
> -#endif /* CONFIG_HAVE_KVM_NO_POLL */
> +#endif /* KVM_NO_POLL */
>   
>   void kvm_arch_guest_memory_reclaimed(struct kvm *kvm);
>   
> -#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
> +#ifdef KVM_VCPU_RUN_PID_CHANGE
>   int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
>   #else
>   static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
>   {
>   	return 0;
>   }
> -#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
> +#endif /* KVM_VCPU_RUN_PID_CHANGE */
>   
>   #ifdef CONFIG_VIRT_XFER_TO_GUEST_WORK
>   static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index c3c0ee253fc7..f3d7f66746c8 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -50,21 +50,12 @@ config KVM_ASYNC_PF
>   config KVM_ASYNC_PF_SYNC
>          bool
>   
> -config HAVE_KVM_MSI
> -       bool
> -
> -config HAVE_KVM_READONLY_MEM
> -       bool
> -
>   config HAVE_KVM_CPU_RELAX_INTERCEPT
>          bool
>   
>   config KVM_VFIO
>          bool
>   
> -config HAVE_KVM_INVALID_WAKEUPS
> -       bool
> -
>   config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>          bool
>   
> @@ -79,12 +70,6 @@ config HAVE_KVM_IRQ_BYPASS
>          tristate
>          select IRQ_BYPASS_MANAGER
>   
> -config HAVE_KVM_VCPU_RUN_PID_CHANGE
> -       bool
> -
> -config HAVE_KVM_NO_POLL
> -       bool
> -
>   config VIRT_XFER_TO_GUEST_WORK
>          bool
>   
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f62901b7e23d..cd2d752816ab 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4916,7 +4916,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>   	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>   	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
>   	case KVM_CAP_INTERNAL_ERROR_DATA:
> -#ifdef CONFIG_HAVE_KVM_MSI
> +#ifdef KVM_MSI
>   	case KVM_CAP_SIGNAL_MSI:
>   #endif
>   #ifdef CONFIG_HAVE_KVM_IRQCHIP
> @@ -5306,7 +5306,7 @@ static long kvm_vm_ioctl(struct file *filp,
>   		r = kvm_ioeventfd(kvm, &data);
>   		break;
>   	}
> -#ifdef CONFIG_HAVE_KVM_MSI
> +#ifdef KVM_MSI
>   	case KVM_SIGNAL_MSI: {
>   		struct kvm_msi msi;
>   

