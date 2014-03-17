From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 1/5] KVM: eventfd: Fix lock order inversion.
Date: Mon, 17 Mar 2014 22:55:49 +0100
Message-ID: <53276F65.4070501@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com> <1395079899-29239-2-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079899-29239-2-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 17/03/14 19:11, Cornelia Huck wrote:
> When registering a new irqfd, we call its ->poll method to collect any
> event that might have previously been pending so that we can trigger it.
> This is done under the kvm->irqfds.lock, which means the eventfd's ctx
> lock is taken under it.
> 
> However, if we get a POLLHUP in irqfd_wakeup, we will be called with the
> ctx lock held before getting the irqfds.lock to deactivate the irqfd,
> causing lockdep to complain.
> 
> Calling the ->poll method does not really need the irqfds.lock, so let's
> just move it after we've given up the irqfds.lock in kvm_irqfd_assign().
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Do you still have the lockdep message somewhere? 
Looking at the patch and the description this makes sense. Even without
irqfd for s390:
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

Paolo, maybe this patch can go in independently from s390?

Christian

> ---
>  virt/kvm/eventfd.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index abe4d60..29c2a04 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -391,19 +391,19 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  					   lockdep_is_held(&kvm->irqfds.lock));
>  	irqfd_update(kvm, irqfd, irq_rt);
> 
> -	events = f.file->f_op->poll(f.file, &irqfd->pt);
> -
>  	list_add_tail(&irqfd->list, &kvm->irqfds.items);
> 
> +	spin_unlock_irq(&kvm->irqfds.lock);
> +
>  	/*
>  	 * Check if there was an event already pending on the eventfd
>  	 * before we registered, and trigger it as if we didn't miss it.
>  	 */
> +	events = f.file->f_op->poll(f.file, &irqfd->pt);
> +
>  	if (events & POLLIN)
>  		schedule_work(&irqfd->inject);
> 
> -	spin_unlock_irq(&kvm->irqfds.lock);
> -
>  	/*
>  	 * do not drop the file until the irqfd is fully initialized, otherwise
>  	 * we might race against the POLLHUP
> 
