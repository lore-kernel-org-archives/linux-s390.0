Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgDOGgU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Apr 2020 02:36:20 -0400
Subject: Re: [PATCH v2] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
References: <20200414155625.20559-1-eesposit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b479e7ff-4534-5ced-e19b-2a2914905a8b@amsat.org>
Date: Wed, 15 Apr 2020 08:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <20200414155625.20559-1-eesposit@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>, kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org

On 4/14/20 5:56 PM, Emanuele Giuseppe Esposito wrote:
> The macros VM_STAT and VCPU_STAT are redundantly implemented in multiple
> files, each used by a different architecure to initialize the debugfs
> entries for statistics. Since they all have the same purpose, they can be
> unified in a single common definition in include/linux/kvm_host.h
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/arm64/kvm/guest.c    |  23 ++---
>  arch/mips/kvm/mips.c      |  61 ++++++------
>  arch/powerpc/kvm/book3s.c |  61 ++++++------
>  arch/powerpc/kvm/booke.c  |  41 ++++----
>  arch/s390/kvm/kvm-s390.c  | 203 +++++++++++++++++++-------------------
>  arch/x86/kvm/x86.c        |  80 +++++++--------
>  include/linux/kvm_host.h  |   5 +
>  7 files changed, 231 insertions(+), 243 deletions(-)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 23ebe51410f0..8417b200bec9 100644
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
> +	VCPU_STAT("halt_successful_poll", halt_successful_poll),
> +	VCPU_STAT("halt_attempted_poll", halt_attempted_poll),
> +	VCPU_STAT("halt_poll_invalid", halt_poll_invalid),
> +	VCPU_STAT("halt_wakeup", halt_wakeup),
> +	VCPU_STAT("hvc_exit_stat", hvc_exit_stat),
> +	VCPU_STAT("wfe_exit_stat", wfe_exit_stat),
> +	VCPU_STAT("wfi_exit_stat", wfi_exit_stat),
> +	VCPU_STAT("mmio_exit_user", mmio_exit_user),
> +	VCPU_STAT("mmio_exit_kernel", mmio_exit_kernel),
> +	VCPU_STAT("exits", exits),
>  	{ NULL }
>  };

Patch easily reviewed with --word-diff.

[...]
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6d58beb65454..2e6ead872957 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1130,6 +1130,11 @@ struct kvm_stats_debugfs_item {
>  #define KVM_DBGFS_GET_MODE(dbgfs_item)                                         \
>  	((dbgfs_item)->mode ? (dbgfs_item)->mode : 0644)
>  
> +#define VM_STAT(n, x, ...) 													   \
> +	{ n, offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__ }
> +#define VCPU_STAT(n, x, ...)												   \

Not sure while you use so many whitespaces here... (maybe Paolo can
strip some when applying?).

Otherwise it looks nicer that v1, thanks.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +	{ n, offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__ }
> +
>  extern struct kvm_stats_debugfs_item debugfs_entries[];
>  extern struct dentry *kvm_debugfs_dir;
>  
> 
