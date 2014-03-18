From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 1/5] KVM: eventfd: Fix lock order inversion.
Date: Tue, 18 Mar 2014 10:18:25 +0100
Message-ID: <20140318101825.6e2b9f7c.cornelia.huck@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
	<1395079899-29239-2-git-send-email-cornelia.huck@de.ibm.com>
	<53276F65.4070501@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53276F65.4070501@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 17 Mar 2014 22:55:49 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 17/03/14 19:11, Cornelia Huck wrote:
> > When registering a new irqfd, we call its ->poll method to collect any
> > event that might have previously been pending so that we can trigger it.
> > This is done under the kvm->irqfds.lock, which means the eventfd's ctx
> > lock is taken under it.
> > 
> > However, if we get a POLLHUP in irqfd_wakeup, we will be called with the
> > ctx lock held before getting the irqfds.lock to deactivate the irqfd,
> > causing lockdep to complain.
> > 
> > Calling the ->poll method does not really need the irqfds.lock, so let's
> > just move it after we've given up the irqfds.lock in kvm_irqfd_assign().
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> Do you still have the lockdep message somewhere? 

Unfortunately not, and it does not seem to be readily triggerable.

> Looking at the patch and the description this makes sense. Even without
> irqfd for s390:
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Paolo, maybe this patch can go in independently from s390?
> 
> Christian
