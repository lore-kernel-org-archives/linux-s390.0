From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v3 7/9] KVM: add kvm_free_vcpus and
 kvm_arch_free_vcpus
Date: Tue, 22 Aug 2017 16:18:59 +0200
Message-ID: <45e07499-e60c-5289-f439-9c51f59866ec@redhat.com>
References: <20170821203530.9266-1-rkrcmar@redhat.com>
 <20170821203530.9266-8-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170821203530.9266-8-rkrcmar@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>


> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 33a15e176927..0d2d8b0c785c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -750,6 +750,23 @@ static void kvm_destroy_devices(struct kvm *kvm)
>  	}
>  }
>  
> +void kvm_free_vcpus(struct kvm *kvm)
> +{
> +	int i;
> +
> +	kvm_arch_free_vcpus(kvm);

I wonder if it would be possible to get rid of kvm_arch_free_vcpus(kvm)
completely and simply call

kvm_for_each_vcpu(i, vcpu, kvm)
	kvm_arch_vcpu_free(vcpu);

at that point.

Would certainly require some refactoring, and I am not sure if we could
modify the special mmu handling for x86 ("Unpin any mmu pages first.").
But if in doubt, that part could be moved to kvm_arch_destroy_vm(), just
before calling kvm_free_vcpus().

> +
> +	mutex_lock(&kvm->lock);
> +
> +	i = atomic_read(&kvm->online_vcpus);
> +	atomic_set(&kvm->online_vcpus, 0);

i = atomic_xchg(&kvm->online_vcpus, 0);

> +
> +	while (i--)
> +		kvm->vcpus[i] = NULL;
> +
> +	mutex_unlock(&kvm->lock);
> +}
> +
>  static void kvm_destroy_vm(struct kvm *kvm)
>  {
>  	int i;
> 


-- 

Thanks,

David
