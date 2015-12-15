From: Kees Cook <keescook@chromium.org>
Subject: Re: [GIT PULL 2/4] KVM: s390: obey kptr_restrict in traces
Date: Tue, 15 Dec 2015 11:33:23 -0800
Message-ID: <CAGXu5jL2BD5gh7QvArSXNV=_F9+7d7j4u6-bXKv1ewR17nDLLQ@mail.gmail.com>
References: <1450207426-17222-1-git-send-email-borntraeger@de.ibm.com>
	<1450207426-17222-3-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1450207426-17222-3-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 15, 2015 at 11:23 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> The s390dbf and trace events provide a debugfs interface.
> If kptr_restrict is active, we should not expose kernel
> pointers. We can fence the debugfs output by using %pK
> instead of %p.
>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Nice catch, thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/s390/kvm/kvm-s390.c   | 9 +++++----
>  arch/s390/kvm/trace-s390.h | 6 +++---
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 6dec01d..c14845c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1185,7 +1185,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>         kvm->arch.epoch = 0;
>
>         spin_lock_init(&kvm->arch.start_stop_lock);
> -       KVM_EVENT(3, "vm 0x%p created by pid %u", kvm, current->pid);
> +       KVM_EVENT(3, "vm 0x%pK created by pid %u", kvm, current->pid);
>
>         return 0;
>  out_err:
> @@ -1245,7 +1245,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>                 gmap_free(kvm->arch.gmap);
>         kvm_s390_destroy_adapters(kvm);
>         kvm_s390_clear_float_irqs(kvm);
> -       KVM_EVENT(3, "vm 0x%p destroyed", kvm);
> +       KVM_EVENT(3, "vm 0x%pK destroyed", kvm);
>  }
>
>  /* Section: vcpu related */
> @@ -1349,7 +1349,8 @@ static int sca_switch_to_extended(struct kvm *kvm)
>
>         free_page((unsigned long)old_sca);
>
> -       VM_EVENT(kvm, 2, "Switched to ESCA (%p -> %p)", old_sca, kvm->arch.sca);
> +       VM_EVENT(kvm, 2, "Switched to ESCA (0x%pK -> 0x%pK)",
> +                old_sca, kvm->arch.sca);
>         return 0;
>  }
>
> @@ -1624,7 +1625,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
>         rc = kvm_vcpu_init(vcpu, kvm, id);
>         if (rc)
>                 goto out_free_sie_block;
> -       VM_EVENT(kvm, 3, "create cpu %d at %p, sie block at %p", id, vcpu,
> +       VM_EVENT(kvm, 3, "create cpu %d at 0x%pK, sie block at 0x%pK", id, vcpu,
>                  vcpu->arch.sie_block);
>         trace_kvm_s390_create_vcpu(id, vcpu, vcpu->arch.sie_block);
>
> diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
> index cc1d6c6..396485b 100644
> --- a/arch/s390/kvm/trace-s390.h
> +++ b/arch/s390/kvm/trace-s390.h
> @@ -55,8 +55,8 @@ TRACE_EVENT(kvm_s390_create_vcpu,
>                     __entry->sie_block = sie_block;
>                     ),
>
> -           TP_printk("create cpu %d at %p, sie block at %p", __entry->id,
> -                     __entry->vcpu, __entry->sie_block)
> +           TP_printk("create cpu %d at 0x%pK, sie block at 0x%pK",
> +                     __entry->id, __entry->vcpu, __entry->sie_block)
>         );
>
>  TRACE_EVENT(kvm_s390_destroy_vcpu,
> @@ -254,7 +254,7 @@ TRACE_EVENT(kvm_s390_enable_css,
>                     __entry->kvm = kvm;
>                     ),
>
> -           TP_printk("enabling channel I/O support (kvm @ %p)\n",
> +           TP_printk("enabling channel I/O support (kvm @ %pK)\n",
>                       __entry->kvm)
>         );
>
> --
> 2.3.0
>



-- 
Kees Cook
Chrome OS & Brillo Security
