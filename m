From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] KVM: s390: cleanup struct kvm_s390_float_interrupt
Date: Tue, 9 Jan 2018 14:55:14 +0100
Message-ID: <20180109145514.619eb7c3.cohuck@redhat.com>
References: <20180108193747.10818-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180108193747.10818-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Jan 2018 20:37:47 +0100
David Hildenbrand <david@redhat.com> wrote:

> "wq" is not used at all.

That seems to date back to 66933b78e3204057bfc26343afcd0d463c0e8e55.

> "cpuflags" can be access directly via the vcpu,
> just as "float_int" via vcpu->kvm.

I'm trying to remember whether there were any caching/locality issues,
but I don't think so.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - Properly make use of dst_vcpu instead of vcpu in sigp.c
> 
>  arch/s390/include/asm/kvm_host.h |  3 ---
>  arch/s390/kvm/interrupt.c        | 25 +++++++++++--------------
>  arch/s390/kvm/kvm-s390.c         |  3 ---
>  arch/s390/kvm/kvm-s390.h         |  2 +-
>  arch/s390/kvm/sigp.c             | 12 ++++--------
>  5 files changed, 16 insertions(+), 29 deletions(-)
> 

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 818aa4248b0f..f8eb2cfa763a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -107,12 +107,11 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
>  
>  static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
>  	int rc, expect;
>  
>  	if (!kvm_s390_use_sca_entries())
>  		return;
> -	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
> +	atomic_andnot(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);

We have __set_cpuflag() to set a flag; do we also want
__clear_cpuflag()? Would make the code nicer, I think. (There are more
possible callers for that.)

>  	read_lock(&vcpu->kvm->arch.sca_lock);
>  	if (vcpu->kvm->arch.use_esca) {
>  		struct esca_block *sca = vcpu->kvm->arch.sca;
