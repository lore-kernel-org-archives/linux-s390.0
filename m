Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389146AbgDMVeX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Apr 2020 17:34:23 -0400
Subject: Re: [PATCH] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
References: <20200413140332.22896-1-eesposit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
Date: Mon, 13 Apr 2020 23:34:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200413140332.22896-1-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

Hi Emanuele,

On 4/13/20 4:03 PM, Emanuele Giuseppe Esposito wrote:
> The macros VM_STAT and VCPU_STAT are redundantly implemented in multiple
> files, each used by a different architecure to initialize the debugfs
> entries for statistics. Since they all have the same purpose, they can be
> unified in a single common definition in include/linux/kvm_host.h
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/arm64/kvm/guest.c    | 23 +++++++--------
>  arch/mips/kvm/mips.c      | 61 +++++++++++++++++++--------------------
>  arch/powerpc/kvm/book3s.c |  3 --
>  arch/powerpc/kvm/booke.c  |  3 --
>  arch/s390/kvm/kvm-s390.c  |  3 --
>  arch/x86/kvm/x86.c        |  3 --
>  include/linux/kvm_host.h  |  3 ++
>  7 files changed, 43 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 23ebe51410f0..3e3aee8b37c0 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -29,20 +29,17 @@
>  
>  #include "trace.h"
>  
> -#define VM_STAT(x) { #x, offsetof(struct kvm, stat.x), KVM_STAT_VM }
> -#define VCPU_STAT(x) { #x, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU }
> -
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
> -	VCPU_STAT(halt_successful_poll),
> -	VCPU_STAT(halt_attempted_poll),
> -	VCPU_STAT(halt_poll_invalid),
> -	VCPU_STAT(halt_wakeup),
> -	VCPU_STAT(hvc_exit_stat),
> -	VCPU_STAT(wfe_exit_stat),
> -	VCPU_STAT(wfi_exit_stat),
> -	VCPU_STAT(mmio_exit_user),
> -	VCPU_STAT(mmio_exit_kernel),
> -	VCPU_STAT(exits),
> +	{ "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
> +	{ "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
> +	{ "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
> +	{ "halt_wakeup", VCPU_STAT(halt_wakeup) },
> +	{ "hvc_exit_stat", VCPU_STAT(hvc_exit_stat) },
> +	{ "wfe_exit_stat", VCPU_STAT(wfe_exit_stat) },
> +	{ "wfi_exit_stat", VCPU_STAT(wfi_exit_stat) },
> +	{ "mmio_exit_user", VCPU_STAT(mmio_exit_user) },
> +	{ "mmio_exit_kernel", VCPU_STAT(mmio_exit_kernel) },
> +	{ "exits", VCPU_STAT(exits) },
>  	{ NULL }
>  };
>  
[...]
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6d58beb65454..e02d38c7fff1 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1130,6 +1130,9 @@ struct kvm_stats_debugfs_item {
>  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>  	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>  
> +#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
> +#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__

I find this macro expanding into multiple fields odd... Maybe a matter
of taste. Sugggestion, have the macro define the full structure, as in
the arm64 arch:

#define VM_STAT(n, x, ...) { n, offsetof(struct kvm, stat.x),
KVM_STAT_VM, ## __VA_ARGS__ }

Ditto for VCPU_STAT().

> +
>  extern struct kvm_stats_debugfs_item debugfs_entries[];
>  extern struct dentry *kvm_debugfs_dir;
>  
> 
