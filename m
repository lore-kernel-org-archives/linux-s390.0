From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 5/5] KVM: s390: clear_io_irq() requests are not expected
 for adapter interrupts
Date: Wed, 8 Nov 2017 10:19:05 +0100
Message-ID: <20171108101905.0b5dabb4.cohuck@redhat.com>
References: <20171108084143.78654-1-borntraeger@de.ibm.com>
        <20171108084143.78654-6-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171108084143.78654-6-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed,  8 Nov 2017 09:41:43 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Michael Mueller <mimu@linux.vnet.ibm.com>
> 
> There is a chance to delete not yet delivered I/O interrupts if an
> exploiter uses the subsystem identification word 0x0000 while
> processing a KVM_DEV_FLIC_CLEAR_IO_IRQ ioctl. -EINVAL will be returned
> now instead in that case.
> 
> Classic interrupts will always have bit 0x10000 set in the schid while
> adapter interrupts have a zero schid. The clear_io_irq interface is
> only useful for classic interrupts (as adapter interrupts belong to
> many devices). Let's make this interface more strict and forbid a schid
> of 0.

I'm wondering: Is there any possible use case to clear adapter
interrupts? This interface was introduced to handle the case where a
CRW was made pending for a subchannel (which implies any pending
interrupt needs to be cleared.)

Alas, I cannot check the adapter interrupt question myself, as the
public doc is lacking :( But qdio as another adapter interrupt user
comes to mind (not that we support it in qemu, but still...)

> 
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virtual/kvm/devices/s390_flic.txt | 3 +++
>  arch/s390/kvm/interrupt.c                       | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
> index 2f1cbf1..27ad53c 100644
> --- a/Documentation/virtual/kvm/devices/s390_flic.txt
> +++ b/Documentation/virtual/kvm/devices/s390_flic.txt
> @@ -156,3 +156,6 @@ FLIC with an unknown group or attribute gives the error code EINVAL (instead of
>  ENXIO, as specified in the API documentation). It is not possible to conclude
>  that a FLIC operation is unavailable based on the error code resulting from a
>  usage attempt.
> +
> +Note: The KVM_DEV_FLIC_CLEAR_IO_IRQ ioctl will return EINVAL in case a zero
> +schid is specified.
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index a3da4f3..c8aacce 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2191,6 +2191,8 @@ static int clear_io_irq(struct kvm *kvm, struct kvm_device_attr *attr)
>  		return -EINVAL;
>  	if (copy_from_user(&schid, (void __user *) attr->addr, sizeof(schid)))
>  		return -EFAULT;
> +	if (!schid)
> +		return -EINVAL;
>  	kfree(kvm_s390_get_io_int(kvm, isc_mask, schid));
>  	/*
>  	 * If userspace is conforming to the architecture, we can have at most
