From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: add proper locking for CMMA migration bitmap
Date: Tue, 23 Jan 2018 17:43:51 +0100
Message-ID: <20180123174351.4adf253c@p-imbrenda.boeblingen.de.ibm.com>
References: <20171222112145.80485-1-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171222112145.80485-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Dec 2017 12:21:45 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Some parts of the cmma migration bitmap is already protected
> with the kvm->lock (e.g. the migration start). On the other
> hand the read of the cmma bits is not protected against a
> concurrent free, neither is the emulation of the ESSA instruction.
> Let's extend the locking to all related ioctls by using
> the slots lock and wait for the freeing until all unlocked
> users have finished (those hold kvm->srcu for read).

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

I'm working on a better fix to apply on top of this patch, but it will
take some time. This patch will at least plug the holes until then.

> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: stable@vger.kernel.org # 4.13+
> Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation,
> migration mode) ---
>  arch/s390/kvm/kvm-s390.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 3373d8dff131..4458d7fe45df 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -837,6 +837,8 @@ static int kvm_s390_vm_stop_migration(struct kvm
> *kvm)
> 
>  	if (kvm->arch.use_cmma) {
>  		kvm_s390_sync_request_broadcast(kvm,
> KVM_REQ_STOP_MIGRATION);
> +		/* We have to wait for the essa emulation to finish
> */
> +		synchronize_srcu(&kvm->srcu);
>  		vfree(mgs->pgste_bitmap);
>  	}
>  	kfree(mgs);
> @@ -846,14 +848,12 @@ static int kvm_s390_vm_stop_migration(struct
> kvm *kvm) static int kvm_s390_vm_set_migration(struct kvm *kvm,
>  				     struct kvm_device_attr *attr)
>  {
> -	int idx, res = -ENXIO;
> +	int res = -ENXIO;
> 
> -	mutex_lock(&kvm->lock);
> +	mutex_lock(&kvm->slots_lock);
>  	switch (attr->attr) {
>  	case KVM_S390_VM_MIGRATION_START:
> -		idx = srcu_read_lock(&kvm->srcu);
>  		res = kvm_s390_vm_start_migration(kvm);
> -		srcu_read_unlock(&kvm->srcu, idx);
>  		break;
>  	case KVM_S390_VM_MIGRATION_STOP:
>  		res = kvm_s390_vm_stop_migration(kvm);
> @@ -861,7 +861,7 @@ static int kvm_s390_vm_set_migration(struct kvm
> *kvm, default:
>  		break;
>  	}
> -	mutex_unlock(&kvm->lock);
> +	mutex_unlock(&kvm->slots_lock);
> 
>  	return res;
>  }
> @@ -1763,7 +1763,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&args, argp, sizeof(args)))
>  			break;
> +		mutex_lock(&kvm->slots_lock);
>  		r = kvm_s390_get_cmma_bits(kvm, &args);
> +		mutex_unlock(&kvm->slots_lock);
>  		if (!r) {
>  			r = copy_to_user(argp, &args, sizeof(args));
>  			if (r)
> @@ -1777,7 +1779,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&args, argp, sizeof(args)))
>  			break;
> +		mutex_lock(&kvm->slots_lock);
>  		r = kvm_s390_set_cmma_bits(kvm, &args);
> +		mutex_unlock(&kvm->slots_lock);
>  		break;
>  	}
>  	default:
