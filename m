From: Jens Freimann <jfrei@linux.vnet.ibm.com>
Subject: Re: [Patchv5 2/7] KVM: s390: add floating irq controller
Date: Mon, 14 Oct 2013 10:28:57 +0200
Message-ID: <20131014082857.GB21221@linux.vnet.ibm.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
 <1381244100-59056-3-git-send-email-borntraeger@de.ibm.com>
 <20131013083954.GB15657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131013083954.GB15657@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Oct 13, 2013 at 11:39:55AM +0300, Gleb Natapov wrote:
> On Tue, Oct 08, 2013 at 04:54:55PM +0200, Christian Borntraeger wrote:
> > From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> > 
> > This patch adds a floating irq controller as a kvm_device.
> > It will be necessary for migration of floating interrupts as well
> > as for hardening the reset code by allowing user space to explicitly
> > remove all pending floating interrupts.
> > 
> > Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  Documentation/virtual/kvm/devices/s390_flic.txt |  36 +++
> >  arch/s390/include/asm/kvm_host.h                |   1 +
> >  arch/s390/include/uapi/asm/kvm.h                |   5 +
> >  arch/s390/kvm/interrupt.c                       | 296 ++++++++++++++++++++----
> >  arch/s390/kvm/kvm-s390.c                        |   1 +
> >  include/linux/kvm_host.h                        |   1 +
> >  include/uapi/linux/kvm.h                        |   1 +
> >  virt/kvm/kvm_main.c                             |   5 +
> >  8 files changed, 295 insertions(+), 51 deletions(-)
> >  create mode 100644 Documentation/virtual/kvm/devices/s390_flic.txt
> > 
> > diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
> > new file mode 100644
> > index 0000000..06aef31
> > --- /dev/null
> > +++ b/Documentation/virtual/kvm/devices/s390_flic.txt
> > @@ -0,0 +1,36 @@
> > +FLIC (floating interrupt controller)
> > +====================================
> > +
> > +FLIC handles floating (non per-cpu) interrupts, i.e.  I/O, service and some
> > +machine check interruptions. All interrupts are stored in a per-vm list of
> > +pending interrupts. FLIC performs operations on this list.
> > +
> > +Only one FLIC instance may be instantiated.
> > +
> > +FLIC provides support to
> > +- add/delete interrupts (KVM_DEV_FLIC_ENQUEUE and _DEQUEUE)
> > +- purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
> > +
> > +Groups:
> > +  KVM_DEV_FLIC_ENQUEUE
> > +    Adds one interrupt to the list of pending floating interrupts. Interrupts
> > +    are taken from this list for injection into the guest. attr contains
> > +    a struct kvm_s390_irq which contains all data relevant for
> > +    interrupt injection.
> > +    The format of the data structure kvm_s390_irq as it is copied from userspace
> > +    is defined in usr/include/linux/kvm.h.
> > +    For historic reasons list members are stored in a different data structure, i.e.
> > +    we need to copy the relevant data into a struct kvm_s390_interrupt_info
> > +    which can then be added to the list.
> > +
> > +  KVM_DEV_FLIC_DEQUEUE
> > +    Takes one element off the pending interrupts list and copies it into userspace.
> > +    Dequeued interrupts are not injected into the guest.
> > +    attr->addr contains the userspace address of a struct kvm_s390_irq.
> > +    List elements are stored in the format of struct kvm_s390_interrupt_info
> > +    (arch/s390/include/asm/kvm_host.h) and are copied into a struct kvm_s390_irq
> > +    (usr/include/linux/kvm.h)
> > +
> Can interrupt be dequeued on real HW also? When this interface will be
> used?

We will it for migration. (See Christians mail)  
 
> > +  KVM_DEV_FLIC_CLEAR_IRQS
> > +    Simply deletes all elements from the list of currently pending floating interrupts.
> > +    No interrupts are injected into the guest.
> > diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> > index 78b6918..2d09c1d 100644
> > --- a/arch/s390/include/asm/kvm_host.h
> > +++ b/arch/s390/include/asm/kvm_host.h
> > @@ -237,6 +237,7 @@ struct kvm_arch{
> >  	struct sca_block *sca;
> >  	debug_info_t *dbf;
> >  	struct kvm_s390_float_interrupt float_int;
> > +	struct kvm_device *flic;
> >  	struct gmap *gmap;
> >  	int css_support;
> >  };
> > diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
> > index d25da59..33d52b8 100644
> > --- a/arch/s390/include/uapi/asm/kvm.h
> > +++ b/arch/s390/include/uapi/asm/kvm.h
> > @@ -16,6 +16,11 @@
> >  
> >  #define __KVM_S390
> >  
> > +/* Device control API: s390-specific devices */
> > +#define KVM_DEV_FLIC_DEQUEUE 1
> > +#define KVM_DEV_FLIC_ENQUEUE 2
> > +#define KVM_DEV_FLIC_CLEAR_IRQS 3
> > +
> >  /* for KVM_GET_REGS and KVM_SET_REGS */
> >  struct kvm_regs {
> >  	/* general purpose regs for s390 */
> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index e7323cd..66478a0 100644
> > --- a/arch/s390/kvm/interrupt.c
> > +++ b/arch/s390/kvm/interrupt.c
> > @@ -659,53 +659,85 @@ struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
> >  	return inti;
> >  }
> >  
> > -int kvm_s390_inject_vm(struct kvm *kvm,
> > -		       struct kvm_s390_interrupt *s390int)
> > +static void __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
> >  {
> >  	struct kvm_s390_local_interrupt *li;
> >  	struct kvm_s390_float_interrupt *fi;
> > -	struct kvm_s390_interrupt_info *inti, *iter;
> > +	struct kvm_s390_interrupt_info *iter;
> >  	int sigcpu;
> >  
> > +	mutex_lock(&kvm->lock);
> > +	fi = &kvm->arch.float_int;
> > +	spin_lock(&fi->lock);
> > +	if (!is_ioint(inti->type)) {
> > +		list_add_tail(&inti->list, &fi->list);
> > +	} else {
> > +		u64 isc_bits = int_word_to_isc_bits(inti->io.io_int_word);
> > +
> > +		/* Keep I/O interrupts sorted in isc order. */
> > +		list_for_each_entry(iter, &fi->list, list) {
> > +			if (!is_ioint(iter->type))
> > +				continue;
> > +			if (int_word_to_isc_bits(iter->io.io_int_word) <= isc_bits)
> > +				continue;
> > +			break;
> > +		}
> > +		list_add_tail(&inti->list, &iter->list);
> > +	}
> > +	atomic_set(&fi->active, 1);
> > +	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
> > +	if (sigcpu == KVM_MAX_VCPUS) {
> > +		do {
> > +			sigcpu = fi->next_rr_cpu++;
> > +			if (sigcpu == KVM_MAX_VCPUS)
> > +				sigcpu = fi->next_rr_cpu = 0;
> > +		} while (fi->local_int[sigcpu] == NULL);
> > +	}
> > +	li = fi->local_int[sigcpu];
> > +	spin_lock_bh(&li->lock);
> > +	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
> > +	if (waitqueue_active(li->wq))
> > +		wake_up_interruptible(li->wq);
> > +	spin_unlock_bh(&li->lock);
> > +	spin_unlock(&fi->lock);
> > +	mutex_unlock(&kvm->lock);
> > +}
> > +
> > +int kvm_s390_inject_vm(struct kvm *kvm,
> > +		       struct kvm_s390_interrupt *s390int)
> > +{
> > +	struct kvm_s390_interrupt_info *inti;
> > +
> >  	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> >  	if (!inti)
> >  		return -ENOMEM;
> >  
> > -	switch (s390int->type) {
> > +	inti->type = s390int->type;
> > +	switch (inti->type) {
> >  	case KVM_S390_INT_VIRTIO:
> >  		VM_EVENT(kvm, 5, "inject: virtio parm:%x,parm64:%llx",
> >  			 s390int->parm, s390int->parm64);
> > -		inti->type = s390int->type;
> >  		inti->ext.ext_params = s390int->parm;
> >  		inti->ext.ext_params2 = s390int->parm64;
> >  		break;
> >  	case KVM_S390_INT_SERVICE:
> >  		VM_EVENT(kvm, 5, "inject: sclp parm:%x", s390int->parm);
> > -		inti->type = s390int->type;
> >  		inti->ext.ext_params = s390int->parm;
> >  		break;
> > -	case KVM_S390_PROGRAM_INT:
> > -	case KVM_S390_SIGP_STOP:
> > -	case KVM_S390_INT_EXTERNAL_CALL:
> > -	case KVM_S390_INT_EMERGENCY:
> > -		kfree(inti);
> > -		return -EINVAL;
> >  	case KVM_S390_MCHK:
> >  		VM_EVENT(kvm, 5, "inject: machine check parm64:%llx",
> >  			 s390int->parm64);
> > -		inti->type = s390int->type;
> >  		inti->mchk.cr14 = s390int->parm; /* upper bits are not used */
> >  		inti->mchk.mcic = s390int->parm64;
> >  		break;
> >  	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> > -		if (s390int->type & IOINT_AI_MASK)
> > +		if (inti->type & IOINT_AI_MASK)
> >  			VM_EVENT(kvm, 5, "%s", "inject: I/O (AI)");
> >  		else
> >  			VM_EVENT(kvm, 5, "inject: I/O css %x ss %x schid %04x",
> >  				 s390int->type & IOINT_CSSID_MASK,
> >  				 s390int->type & IOINT_SSID_MASK,
> >  				 s390int->type & IOINT_SCHID_MASK);
> > -		inti->type = s390int->type;
> >  		inti->io.subchannel_id = s390int->parm >> 16;
> >  		inti->io.subchannel_nr = s390int->parm & 0x0000ffffu;
> >  		inti->io.io_int_parm = s390int->parm64 >> 32;
> > @@ -718,42 +750,7 @@ int kvm_s390_inject_vm(struct kvm *kvm,
> >  	trace_kvm_s390_inject_vm(s390int->type, s390int->parm, s390int->parm64,
> >  				 2);
> >  
> > -	mutex_lock(&kvm->lock);
> > -	fi = &kvm->arch.float_int;
> > -	spin_lock(&fi->lock);
> > -	if (!is_ioint(inti->type))
> > -		list_add_tail(&inti->list, &fi->list);
> > -	else {
> > -		u64 isc_bits = int_word_to_isc_bits(inti->io.io_int_word);
> > -
> > -		/* Keep I/O interrupts sorted in isc order. */
> > -		list_for_each_entry(iter, &fi->list, list) {
> > -			if (!is_ioint(iter->type))
> > -				continue;
> > -			if (int_word_to_isc_bits(iter->io.io_int_word)
> > -			    <= isc_bits)
> > -				continue;
> > -			break;
> > -		}
> > -		list_add_tail(&inti->list, &iter->list);
> > -	}
> > -	atomic_set(&fi->active, 1);
> > -	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
> > -	if (sigcpu == KVM_MAX_VCPUS) {
> > -		do {
> > -			sigcpu = fi->next_rr_cpu++;
> > -			if (sigcpu == KVM_MAX_VCPUS)
> > -				sigcpu = fi->next_rr_cpu = 0;
> > -		} while (fi->local_int[sigcpu] == NULL);
> > -	}
> > -	li = fi->local_int[sigcpu];
> > -	spin_lock_bh(&li->lock);
> > -	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
> > -	if (waitqueue_active(li->wq))
> > -		wake_up_interruptible(li->wq);
> > -	spin_unlock_bh(&li->lock);
> > -	spin_unlock(&fi->lock);
> > -	mutex_unlock(&kvm->lock);
> > +	__inject_vm(kvm, inti);
> >  	return 0;
> >  }
> >  
> > @@ -841,3 +838,200 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
> >  	mutex_unlock(&vcpu->kvm->lock);
> >  	return 0;
> >  }
> > +
> > +static void clear_floating_interrupts(struct kvm *kvm)
> > +{
> > +	struct kvm_s390_float_interrupt *fi;
> > +	struct kvm_s390_interrupt_info	*n, *inti = NULL;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	fi = &kvm->arch.float_int;
> > +	spin_lock(&fi->lock);
> > +	list_for_each_entry_safe(inti, n, &fi->list, list) {
> > +		list_del(&inti->list);
> > +		kfree(inti);
> > +	}
> > +	atomic_set(&fi->active, 0);
> > +	spin_unlock(&fi->lock);
> > +	mutex_unlock(&kvm->lock);
> > +}
> > +
> > +static inline int copy_irq_to_user(struct kvm_s390_interrupt_info *inti,
> > +				   u64 addr)
> > +{
> > +	struct kvm_s390_irq __user *uptr = (struct kvm_s390_irq __user *) addr;
> > +	void __user *target;
> > +	void *source;
> > +	u64 size;
> > +	int r = 0;
> > +
> > +	switch (inti->type) {
> > +	case KVM_S390_INT_VIRTIO:
> > +	case KVM_S390_INT_SERVICE:
> > +		source = &inti->ext;
> > +		target = &uptr->u.ext;
> > +		size = sizeof(inti->ext);
> > +		break;
> > +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> > +		source = &inti->io;
> > +		target = &uptr->u.io;
> > +		size = sizeof(inti->io);
> > +		break;
> > +	case KVM_S390_MCHK:
> > +		source = &inti->mchk;
> > +		target = &uptr->u.mchk;
> > +		size = sizeof(inti->mchk);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	r = put_user(inti->type, (u64 __user *) &uptr->type);
> > +	if (copy_to_user(target, source, size))
> > +		r = -EFAULT;
> > +
> > +	return r;
> > +}
> > +
> > +static int dequeue_floating_irq(struct kvm *kvm, __u64 addr)
> > +{
> > +	struct kvm_s390_interrupt_info *inti;
> > +	struct kvm_s390_float_interrupt *fi;
> > +	int r = 0;
> > +
> > +
> > +	mutex_lock(&kvm->lock);
> > +	fi = &kvm->arch.float_int;
> > +	spin_lock(&fi->lock);
> > +	if (list_empty(&fi->list)) {
> > +		mutex_unlock(&kvm->lock);
> > +		spin_unlock(&fi->lock);
> > +		return -ENODATA;
> > +	}
> > +	inti = list_first_entry(&fi->list, struct kvm_s390_interrupt_info, list);
> > +	list_del(&inti->list);
> > +	spin_unlock(&fi->lock);
> > +	mutex_unlock(&kvm->lock);
> > +
> > +	r = copy_irq_to_user(inti, addr);
> > +
> > +	kfree(inti);
> > +	return r;
> > +}
> > +
> > +static int flic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> > +{
> > +	int r;
> > +
> > +	switch (attr->group) {
> > +	case KVM_DEV_FLIC_DEQUEUE:
> > +		r = dequeue_floating_irq(dev->kvm, attr->addr);
> > +		break;
> > +	default:
> > +		r = -EINVAL;
> > +	}
> > +
> > +	return r;
> > +}
> > +
> > +static inline int copy_irq_from_user(struct kvm_s390_interrupt_info *inti,
> > +				     u64 addr)
> > +{
> > +	struct kvm_s390_irq __user *uptr = (struct kvm_s390_irq __user *) addr;
> > +	void *target = NULL;
> > +	void __user *source;
> > +	u64 size;
> > +	int r = 0;
> > +
> > +	if (get_user(inti->type, (u64 __user *)addr))
> > +		return -EFAULT;
> > +	switch (inti->type) {
> > +	case KVM_S390_INT_VIRTIO:
> > +	case KVM_S390_INT_SERVICE:
> > +		target = (void *) &inti->ext;
> > +		source = &uptr->u.ext;
> > +		size = sizeof(inti->ext);
> > +		break;
> > +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> > +		target = (void *) &inti->io;
> > +		source = &uptr->u.io;
> > +		size = sizeof(inti->io);
> > +		break;
> > +	case KVM_S390_MCHK:
> > +		target = (void *) &inti->mchk;
> > +		source = &uptr->u.mchk;
> > +		size = sizeof(inti->mchk);
> > +		break;
> > +	default:
> > +		r = -EINVAL;
> > +		return r;
> > +	}
> > +
> > +	if (copy_from_user(target, source, size))
> > +		r = -EFAULT;
> > +
> > +	return r;
> > +}
> > +
> > +static int enqueue_floating_irq(struct kvm_device *dev,
> > +				 struct kvm_device_attr *attr)
> > +{
> > +	struct kvm_s390_interrupt_info *inti = NULL;
> > +	int r = 0;
> > +
> > +	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
> > +	if (!inti)
> > +		return -ENOMEM;
> > +
> > +	r = copy_irq_from_user(inti, attr->addr);
> > +	if (r) {
> > +		kfree(inti);
> > +		return r;
> > +	}
> > +	__inject_vm(dev->kvm, inti);
> > +
> > +	return r;
> > +}
> > +
> > +static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
> > +{
> > +	int r = 0;
> > +
> > +	switch (attr->group) {
> > +	case KVM_DEV_FLIC_ENQUEUE:
> > +		r = enqueue_floating_irq(dev, attr);
> > +		break;
> > +	case KVM_DEV_FLIC_CLEAR_IRQS:
> > +		r = 0;
> > +		clear_floating_interrupts(dev->kvm);
> > +		break;
> > +	default:
> > +		r = -EINVAL;
> > +	}
> > +
> > +	return r;
> > +}
> > +
> > +static int flic_create(struct kvm_device *dev, u32 type)
> > +{
> > +	if (!dev)
> > +		return -EINVAL;
> > +	if (dev->kvm->arch.flic)
> > +		return -EINVAL;
> > +	dev->kvm->arch.flic = dev;
> > +	return 0;
> > +}
> > +
> > +static void flic_destroy(struct kvm_device *dev)
> > +{
> > +	dev->kvm->arch.flic = NULL;
> You need to call kfree(dev) here. There is a patch that moves this free
> to a common code, but it is not yet in.

Ok, I wasn't aware of this. Will fix.

regards
Jens
 
