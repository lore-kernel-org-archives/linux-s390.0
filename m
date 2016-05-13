From: David Matlack <dmatlack@google.com>
Subject: Re: [PATCH 1/2] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Fri, 13 May 2016 09:47:44 -0700
Message-ID: <CALzav=cxqKRETHxBDarp5z3UWn5tw3r_NJaR5=yO-U3C7af7fQ@mail.gmail.com>
References: <1463134596-19470-1-git-send-email-borntraeger@de.ibm.com> <1463134596-19470-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1463134596-19470-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 13, 2016 at 3:16 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> Some wakeups should not be considered a sucessful poll. For example o=
n
> s390 I/O interrupts are usually floating, which means that _ALL_ CPUs
> would be considered runnable - letting all vCPUs poll all the time fo=
r
> transactional like workload, even if one vCPU would be enough.
> This can result in huge CPU usage for large guests.
> This patch lets architectures provide a way to qualify wakeups if the=
y
> should be considered a good/bad wakeups in regard to polls.
>
> For s390 the implementation will fence of halt polling for anything b=
ut
> known good, single vCPU events. The s390 implementation for floating
> interrupts does a wakeup for one vCPU, but the interrupt will be deli=
vered
> by whatever CPU checks first for a pending interrupt. We prefer the
> woken up CPU by marking the poll of this CPU as "good" poll.
> This code will also mark several other wakeup reasons like IPI or
> expired timers as "good". This will of course also mark some events a=
s
> not sucessful. As  KVM on z runs always as a 2nd level hypervisor,
> we prefer to not poll, unless we are really sure, though.
>
> This patch successfully limits the CPU usage for cases like uperf 1by=
te
> transactional ping pong workload or wakeup heavy workload like OLTP
> while still providing a proper speedup.
>
> This also introduced a new vcpu stat "halt_poll_no_tuning" that marks
> wakeups that are considered not good for polling.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Acked-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com> (for an ea=
rlier version)
> Cc: David Matlack <dmatlack@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

> Cc: Wanpeng Li <kernellwp@gmail.com>
> ---
>  arch/arm/include/asm/kvm_host.h     |  2 ++
>  arch/arm64/include/asm/kvm_host.h   |  2 ++
>  arch/mips/include/asm/kvm_host.h    |  2 ++
>  arch/mips/kvm/mips.c                |  1 +
>  arch/powerpc/include/asm/kvm_host.h |  2 ++
>  arch/powerpc/kvm/book3s.c           |  1 +
>  arch/powerpc/kvm/booke.c            |  1 +
>  arch/s390/include/asm/kvm_host.h    |  3 +++
>  arch/s390/kvm/Kconfig               |  1 +
>  arch/s390/kvm/interrupt.c           |  5 +++++
>  arch/s390/kvm/kvm-s390.c            |  6 ++++++
>  arch/x86/include/asm/kvm_host.h     |  2 ++
>  arch/x86/kvm/x86.c                  |  1 +
>  include/linux/kvm_host.h            | 15 +++++++++++++++
>  include/trace/events/kvm.h          | 11 +++++++----
>  virt/kvm/Kconfig                    |  3 +++
>  virt/kvm/kvm_main.c                 |  8 ++++++--
>  17 files changed, 60 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/k=
vm_host.h
> index 3850701..4cd8732 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -187,6 +187,7 @@ struct kvm_vm_stat {
>  struct kvm_vcpu_stat {
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>         u32 hvc_exit_stat;
>         u64 wfe_exit_stat;
> @@ -282,6 +283,7 @@ static inline void kvm_arch_hardware_unsetup(void=
) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)=
 {}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)=
 {}
>
>  static inline void kvm_arm_init_debug(void) {}
>  static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/a=
sm/kvm_host.h
> index f5c6bd2..d49399d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -293,6 +293,7 @@ struct kvm_vm_stat {
>  struct kvm_vcpu_stat {
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>         u32 hvc_exit_stat;
>         u64 wfe_exit_stat;
> @@ -357,6 +358,7 @@ static inline void kvm_arch_hardware_unsetup(void=
) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)=
 {}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)=
 {}
>
>  void kvm_arm_init_debug(void);
>  void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
> diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm=
/kvm_host.h
> index 942b8f6..9a37a10 100644
> --- a/arch/mips/include/asm/kvm_host.h
> +++ b/arch/mips/include/asm/kvm_host.h
> @@ -122,6 +122,7 @@ struct kvm_vcpu_stat {
>         u32 flush_dcache_exits;
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>  };
>
> @@ -812,5 +813,6 @@ static inline void kvm_arch_vcpu_uninit(struct kv=
m_vcpu *vcpu) {}
>  static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)=
 {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {=
}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)=
 {}
>
>  #endif /* __MIPS_KVM_HOST_H__ */
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index 23b2094..dc052fb 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -56,6 +56,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>         { "flush_dcache", VCPU_STAT(flush_dcache_exits), KVM_STAT_VCP=
U },
>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll), KV=
M_STAT_VCPU },
>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), KVM_=
STAT_VCPU },
> +       { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid), KVM_STAT=
_VCPU },
>         { "halt_wakeup",  VCPU_STAT(halt_wakeup),        KVM_STAT_VCP=
U },
>         {NULL}
>  };
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/inclu=
de/asm/kvm_host.h
> index a07645c..ec35af3 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -116,6 +116,7 @@ struct kvm_vcpu_stat {
>         u32 ext_intr_exits;
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>         u32 dbell_exits;
>         u32 gdbell_exits;
> @@ -727,5 +728,6 @@ static inline void kvm_arch_sched_in(struct kvm_v=
cpu *vcpu, int cpu) {}
>  static inline void kvm_arch_exit(void) {}
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {=
}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)=
 {}
>
>  #endif /* __POWERPC_KVM_HOST_H__ */
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index b34220d2..47018fc 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -54,6 +54,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>         { "queue_intr",  VCPU_STAT(queue_intr) },
>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll), },
>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll), },
> +       { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>         { "pf_storage",  VCPU_STAT(pf_storage) },
>         { "sp_storage",  VCPU_STAT(sp_storage) },
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 4d66f44..4afae69 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -64,6 +64,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>         { "ext_intr",   VCPU_STAT(ext_intr_exits) },
>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
> +       { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>         { "doorbell", VCPU_STAT(dbell_exits) },
>         { "guest doorbell", VCPU_STAT(gdbell_exits) },
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm=
/kvm_host.h
> index 9282ccf..53d7945 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -247,6 +247,7 @@ struct kvm_vcpu_stat {
>         u32 exit_instruction;
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>         u32 instruction_lctl;
>         u32 instruction_lctlg;
> @@ -696,4 +697,6 @@ static inline void kvm_arch_flush_shadow_memslot(=
struct kvm *kvm,
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {=
}
>
> +void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu);
> +
>  #endif
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index 5ea5af3..ccfe6f6 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -28,6 +28,7 @@ config KVM
>         select HAVE_KVM_IRQCHIP
>         select HAVE_KVM_IRQFD
>         select HAVE_KVM_IRQ_ROUTING
> +       select HAVE_KVM_INVALID_POLLS
>         select SRCU
>         select KVM_VFIO
>         ---help---
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index e550404..5a80af7 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -977,6 +977,11 @@ no_timer:
>
>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
>  {
> +       /*
> +        * We cannot move this into the if, as the CPU might be alrea=
dy
> +        * in kvm_vcpu_block without having the waitqueue set (pollin=
g)
> +        */
> +       vcpu->valid_wakeup =3D true;
>         if (swait_active(&vcpu->wq)) {
>                 /*
>                  * The vcpu gave up the cpu voluntarily, mark it as a=
 good
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c597201..6d8ec3a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -65,6 +65,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>         { "exit_instr_and_program_int", VCPU_STAT(exit_instr_and_prog=
ram) },
>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
> +       { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>         { "instruction_lctlg", VCPU_STAT(instruction_lctlg) },
>         { "instruction_lctl", VCPU_STAT(instruction_lctl) },
> @@ -2992,6 +2993,11 @@ static inline unsigned long nonhyp_mask(int i)
>         return 0x0000ffffffffffffUL >> (nonhyp_fai << 4);
>  }
>
> +void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)
> +{
> +       vcpu->valid_wakeup =3D false;
> +}
> +
>  static int __init kvm_s390_init(void)
>  {
>         int i;
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/k=
vm_host.h
> index c66e262..c99494b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -803,6 +803,7 @@ struct kvm_vcpu_stat {
>         u32 halt_exits;
>         u32 halt_successful_poll;
>         u32 halt_attempted_poll;
> +       u32 halt_poll_invalid;
>         u32 halt_wakeup;
>         u32 request_irq_exits;
>         u32 irq_exits;
> @@ -1342,5 +1343,6 @@ void kvm_set_msi_irq(struct kvm_kernel_irq_rout=
ing_entry *e,
>
>  static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
>  static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {=
}
> +static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu)=
 {}
>
>  #endif /* _ASM_X86_KVM_HOST_H */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6c774cd..bcef92f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -161,6 +161,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] =3D=
 {
>         { "halt_exits", VCPU_STAT(halt_exits) },
>         { "halt_successful_poll", VCPU_STAT(halt_successful_poll) },
>         { "halt_attempted_poll", VCPU_STAT(halt_attempted_poll) },
> +       { "halt_poll_invalid", VCPU_STAT(halt_poll_invalid) },
>         { "halt_wakeup", VCPU_STAT(halt_wakeup) },
>         { "hypercalls", VCPU_STAT(hypercalls) },
>         { "request_irq", VCPU_STAT(request_irq_exits) },
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 92a0229..f350dc9 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -229,6 +229,7 @@ struct kvm_vcpu {
>         sigset_t sigset;
>         struct kvm_vcpu_stat stat;
>         unsigned int halt_poll_ns;
> +       bool valid_wakeup;
>
>  #ifdef CONFIG_HAS_IOMEM
>         int mmio_needed;
> @@ -1196,4 +1197,18 @@ int kvm_arch_update_irqfd_routing(struct kvm *=
kvm, unsigned int host_irq,
>                                   uint32_t guest_irq, bool set);
>  #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
>
> +#ifdef CONFIG_HAVE_KVM_INVALID_POLLS
> +/* If we wakeup during the poll time, was it a sucessful poll? */
> +static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
> +{
> +       return vcpu->valid_wakeup;
> +}
> +
> +#else
> +static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
> +{
> +       return true;
> +}
> +#endif /* CONFIG_HAVE_KVM_INVALID_POLLS */
> +
>  #endif
> diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
> index aa69253..526fb3d 100644
> --- a/include/trace/events/kvm.h
> +++ b/include/trace/events/kvm.h
> @@ -38,22 +38,25 @@ TRACE_EVENT(kvm_userspace_exit,
>  );
>
>  TRACE_EVENT(kvm_vcpu_wakeup,
> -           TP_PROTO(__u64 ns, bool waited),
> -           TP_ARGS(ns, waited),
> +           TP_PROTO(__u64 ns, bool waited, bool valid),
> +           TP_ARGS(ns, waited, valid),
>
>         TP_STRUCT__entry(
>                 __field(        __u64,          ns              )
>                 __field(        bool,           waited          )
> +               __field(        bool,           valid           )
>         ),
>
>         TP_fast_assign(
>                 __entry->ns             =3D ns;
>                 __entry->waited         =3D waited;
> +               __entry->valid          =3D valid;
>         ),
>
> -       TP_printk("%s time %lld ns",
> +       TP_printk("%s time %lld ns, polling %s",
>                   __entry->waited ? "wait" : "poll",
> -                 __entry->ns)
> +                 __entry->ns,
> +                 __entry->valid ? "valid" : "invalid")
>  );
>
>  #if defined(CONFIG_HAVE_KVM_IRQFD)
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 7a79b68..4451842 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -41,6 +41,9 @@ config KVM_VFIO
>  config HAVE_KVM_ARCH_TLB_FLUSH_ALL
>         bool
>
> +config HAVE_KVM_INVALID_POLLS
> +       bool
> +
>  config KVM_GENERIC_DIRTYLOG_READ_PROTECT
>         bool
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ed3d9bb..21f6498 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2028,6 +2028,8 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>                          */
>                         if (kvm_vcpu_check_block(vcpu) < 0) {
>                                 ++vcpu->stat.halt_successful_poll;
> +                               if (!vcpu_valid_wakeup(vcpu))
> +                                       ++vcpu->stat.halt_poll_invali=
d;
>                                 goto out;
>                         }
>                         cur =3D ktime_get();
> @@ -2057,7 +2059,8 @@ out:
>                 if (block_ns <=3D vcpu->halt_poll_ns)
>                         ;
>                 /* we had a long block, shrink polling */
> -               else if (vcpu->halt_poll_ns && block_ns > halt_poll_n=
s)
> +               else if (!vcpu_valid_wakeup(vcpu) ||
> +                       (vcpu->halt_poll_ns && block_ns > halt_poll_n=
s))
>                         shrink_halt_poll_ns(vcpu);
>                 /* we had a short halt and our poll time is too small=
 */
>                 else if (vcpu->halt_poll_ns < halt_poll_ns &&
> @@ -2066,7 +2069,8 @@ out:
>         } else
>                 vcpu->halt_poll_ns =3D 0;
>
> -       trace_kvm_vcpu_wakeup(block_ns, waited);
> +       trace_kvm_vcpu_wakeup(block_ns, waited, vcpu_valid_wakeup(vcp=
u));
> +       kvm_arch_vcpu_block_finish(vcpu);
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_block);
>
> --
> 2.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
