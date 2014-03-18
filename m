From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/5] kvm: add kvm_enable_cap_{vm,vcpu}
Date: Tue, 18 Mar 2014 17:08:35 +0100
Message-ID: <53286F83.2090502@redhat.com>
References: <1395079921-29325-1-git-send-email-cornelia.huck@de.ibm.com> <1395079921-29325-3-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079921-29325-3-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

Il 17/03/2014 19:11, Cornelia Huck ha scritto:
> Provide helper functions for enabling capabilities (on a vcpu and on a vm).
>
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  include/sysemu/kvm.h |    4 ++++
>  kvm-all.c            |   19 ++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 0bee1e8..d89911c 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -294,6 +294,10 @@ bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
>
>  int kvm_check_extension(KVMState *s, unsigned int extension);
>
> +int kvm_enable_cap_vm(KVMState *s, unsigned int capability);
> +
> +int kvm_enable_cap_vcpu(CPUState *cpu, unsigned int capability);
> +
>  uint32_t kvm_arch_get_supported_cpuid(KVMState *env, uint32_t function,
>                                        uint32_t index, int reg);
>
> diff --git a/kvm-all.c b/kvm-all.c
> index 82a9119..658690f 100644
> --- a/kvm-all.c
> +++ b/kvm-all.c
> @@ -501,7 +501,24 @@ int kvm_check_extension(KVMState *s, unsigned int extension)
>      return ret;
>  }
>
> -static int kvm_set_ioeventfd_mmio(int fd, hwaddr addr, uint32_t val,
> +int kvm_enable_cap_vm(KVMState *s, unsigned int capability)
> +{
> +    struct kvm_enable_cap cap = {};
> +
> +    cap.cap = capability;
> +    return kvm_vm_ioctl(s, KVM_ENABLE_CAP, &cap);
> +}
> +
> +int kvm_enable_cap_vcpu(CPUState *cpu, unsigned int capability)
> +{
> +    struct kvm_enable_cap cap = {};
> +
> +    cap.cap = capability;
> +    return kvm_vcpu_ioctl(cpu, KVM_ENABLE_CAP, &cap);
> +}
> +
> +
> +static int kvm_set_ioeventfd_mmio(int fd, uint32_t addr, uint32_t val,

Merge conflict here (addr became uint32_t), otherwise ok.

Paolo

>                                    bool assign, uint32_t size, bool datamatch)
>  {
>      int ret;
>
