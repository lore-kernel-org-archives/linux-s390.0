From: Gleb Natapov <gleb@redhat.com>
Subject: Re: [Patchv5 2/7] KVM: s390: add floating irq controller
Date: Mon, 14 Oct 2013 12:07:24 +0300
Message-ID: <20131014090724.GL15657@redhat.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
 <1381244100-59056-3-git-send-email-borntraeger@de.ibm.com>
 <20131013083954.GB15657@redhat.com>
 <20131014082857.GB21221@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131014082857.GB21221@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Jens Freimann <jfrei@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Oct 14, 2013 at 10:28:57AM +0200, Jens Freimann wrote:
> On Sun, Oct 13, 2013 at 11:39:55AM +0300, Gleb Natapov wrote:
> > On Tue, Oct 08, 2013 at 04:54:55PM +0200, Christian Borntraeger wrote:
> > > From: Jens Freimann <jfrei@linux.vnet.ibm.com>
> > > 
> > > This patch adds a floating irq controller as a kvm_device.
> > > It will be necessary for migration of floating interrupts as well
> > > as for hardening the reset code by allowing user space to explicitly
> > > remove all pending floating interrupts.
> > > 
> > > Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> > > Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > ---
> > >  Documentation/virtual/kvm/devices/s390_flic.txt |  36 +++
> > >  arch/s390/include/asm/kvm_host.h                |   1 +
> > >  arch/s390/include/uapi/asm/kvm.h                |   5 +
> > >  arch/s390/kvm/interrupt.c                       | 296 ++++++++++++++++++++----
> > >  arch/s390/kvm/kvm-s390.c                        |   1 +
> > >  include/linux/kvm_host.h                        |   1 +
> > >  include/uapi/linux/kvm.h                        |   1 +
> > >  virt/kvm/kvm_main.c                             |   5 +
> > >  8 files changed, 295 insertions(+), 51 deletions(-)
> > >  create mode 100644 Documentation/virtual/kvm/devices/s390_flic.txt
> > > 
> > > diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
> > > new file mode 100644
> > > index 0000000..06aef31
> > > --- /dev/null
> > > +++ b/Documentation/virtual/kvm/devices/s390_flic.txt
> > > @@ -0,0 +1,36 @@
> > > +FLIC (floating interrupt controller)
> > > +====================================
> > > +
> > > +FLIC handles floating (non per-cpu) interrupts, i.e.  I/O, service and some
> > > +machine check interruptions. All interrupts are stored in a per-vm list of
> > > +pending interrupts. FLIC performs operations on this list.
> > > +
> > > +Only one FLIC instance may be instantiated.
> > > +
> > > +FLIC provides support to
> > > +- add/delete interrupts (KVM_DEV_FLIC_ENQUEUE and _DEQUEUE)
> > > +- purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
> > > +
> > > +Groups:
> > > +  KVM_DEV_FLIC_ENQUEUE
> > > +    Adds one interrupt to the list of pending floating interrupts. Interrupts
> > > +    are taken from this list for injection into the guest. attr contains
> > > +    a struct kvm_s390_irq which contains all data relevant for
> > > +    interrupt injection.
> > > +    The format of the data structure kvm_s390_irq as it is copied from userspace
> > > +    is defined in usr/include/linux/kvm.h.
> > > +    For historic reasons list members are stored in a different data structure, i.e.
> > > +    we need to copy the relevant data into a struct kvm_s390_interrupt_info
> > > +    which can then be added to the list.
> > > +
> > > +  KVM_DEV_FLIC_DEQUEUE
> > > +    Takes one element off the pending interrupts list and copies it into userspace.
> > > +    Dequeued interrupts are not injected into the guest.
> > > +    attr->addr contains the userspace address of a struct kvm_s390_irq.
> > > +    List elements are stored in the format of struct kvm_s390_interrupt_info
> > > +    (arch/s390/include/asm/kvm_host.h) and are copied into a struct kvm_s390_irq
> > > +    (usr/include/linux/kvm.h)
> > > +
> > Can interrupt be dequeued on real HW also? When this interface will be
> > used?
> 
> We will it for migration. (See Christians mail)  
>  
For migration you do not need dequeue semantics though, dequeuing
does not hurt in case of migration, but what if we will want to add
QEMU monitor command that inspects interrupt queue (like we have for
inspecting processor's register state). The destructive nature of the
command will prevent us from doing so. We need non destructive way to
inspect the state, no?

--
			Gleb.
