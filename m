From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/2] KVM: RCU protected dynamic vcpus array
Date: Thu, 17 Aug 2017 13:14:27 +0200
Message-ID: <7cb42373-355c-7cb3-2979-9529aef0641c@redhat.com>
References: <20170816194037.9460-1-rkrcmar@redhat.com>
 <20170816194037.9460-3-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816194037.9460-3-rkrcmar@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <cdall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, James Hogan <james.hogan@imgtec.com>, Paul Mackerras <paulus@ozlabs.org>, Alexander Graf <agraf@suse.com>
List-ID: <linux-s390.vger.kernel.org>


>  	atomic_set(&kvm->online_vcpus, 0);
>  	mutex_unlock(&kvm->lock);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c8df733eed41..eb9fb5b493ac 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -386,12 +386,17 @@ struct kvm_memslots {
>  	int used_slots;
>  };
>  
> +struct kvm_vcpus {
> +	u32 online;
> +	struct kvm_vcpu *array[];

On option could be to simply chunk it:

+struct kvm_vcpus {
+       struct kvm_vcpu vcpus[32];
+};
+
 /*
  * Note:
  * memslots are not sorted by id anymore, please use id_to_memslot()
@@ -391,7 +395,7 @@ struct kvm {
        struct mutex slots_lock;
        struct mm_struct *mm; /* userspace tied to this vm */
        struct kvm_memslots __rcu *memslots[KVM_ADDRESS_SPACE_NUM];
-       struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+       struct kvm_vcpus vcpus[(KVM_MAX_VCPUS + 31) / 32];

        /*
         * created_vcpus is protected by kvm->lock, and is incremented
@@ -483,12 +487,14 @@ static inline struct kvm_io_bus
*kvm_get_bus(struct kvm *kvm, enum kvm_bus idx)


1. make nobody access kvm->vcpus directly (factor out)
2. allocate next chunk if necessary when creating a VCPU and store
pointer using WRITE_ONCE
3. use READ_ONCE to test for availability of the current chunk

kvm_for_each_vcpu just has to use READ_ONCE to access/test for the right
chunk. Pointers never get invalid. No RCU needed. Sleeping in the loop
is possible.

-- 

Thanks,

David
