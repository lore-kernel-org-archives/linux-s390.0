From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC v3 3/9] KVM: remember position in kvm->vcpus array
Date: Tue, 29 Aug 2017 13:30:59 +0200
Message-ID: <20170829133059.2b9442a5.cohuck@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
        <20170821203530.9266-4-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170821203530.9266-4-rkrcmar@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 Aug 2017 22:35:24 +0200
Radim Krčmář <rkrcmar@redhat.com> wrote:

> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  include/linux/kvm_host.h | 11 +++--------
>  virt/kvm/kvm_main.c      |  5 ++++-
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6882538eda32..a8ff956616d2 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -220,7 +220,8 @@ struct kvm_vcpu {
>  	struct preempt_notifier preempt_notifier;
>  #endif
>  	int cpu;
> -	int vcpu_id;
> +	int vcpu_id; /* id given by userspace at creation */
> +	int vcpus_idx; /* index in kvm->vcpus array */

I predict confusion in the future over which is which... maybe
s/vcpus_idx/vcpus_array_pos/ or something like that?

>  	int srcu_idx;
>  	int mode;
>  	unsigned long requests;
> @@ -516,13 +517,7 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
>  
>  static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_vcpu *tmp;
> -	int idx;
> -
> -	kvm_for_each_vcpu(idx, tmp, vcpu->kvm)
> -		if (tmp == vcpu)
> -			return idx;
> -	BUG();
> +	return vcpu->vcpus_idx;
>  }
>  
>  #define kvm_for_each_memslot(memslot, slots)	\
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e17c40d986f3..caf8323f7df7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2498,7 +2498,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
>  		goto unlock_vcpu_destroy;
>  	}
>  
> -	BUG_ON(kvm->vcpus[atomic_read(&kvm->online_vcpus)]);
> +	vcpu->vcpus_idx = atomic_read(&kvm->online_vcpus);
> +
> +	BUG_ON(kvm->vcpus[vcpu->vcpus_idx]);
> +
>  
>  	/* Now it's all set up, let userspace reach it */
>  	kvm_get_kvm(kvm);

I like the concept.
