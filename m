From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 4/5] KVM: s390: irq routing for adapter interrupts.
Date: Fri, 21 Mar 2014 11:08:40 +0100
Message-ID: <20140321110840.1af6c078.cornelia.huck@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
	<1395079899-29239-5-git-send-email-cornelia.huck@de.ibm.com>
	<532C0713.7080208@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <532C0713.7080208@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 21 Mar 2014 10:32:03 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 17/03/14 19:11, Cornelia Huck wrote:
> > Introduce a new interrupt class for s390 adapter interrupts and enable
> > irqfds for s390.
> > 
> > This is depending on a new s390 specific vm capability, KVM_CAP_S390_IRQCHIP,
> > that needs to be enabled by userspace.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  Documentation/virtual/kvm/api.txt               |   21 +++-
> >  Documentation/virtual/kvm/devices/s390_flic.txt |    6 +-
> >  arch/s390/include/asm/kvm_host.h                |   10 ++
> >  arch/s390/kvm/Kconfig                           |    2 +
> >  arch/s390/kvm/Makefile                          |    2 +-
> >  arch/s390/kvm/interrupt.c                       |  132 ++++++++++++++++++++++-
> >  arch/s390/kvm/irq.h                             |   22 ++++
> >  arch/s390/kvm/kvm-s390.c                        |   17 +++
> >  include/linux/kvm_host.h                        |    9 ++
> >  include/uapi/linux/kvm.h                        |   11 ++
> >  10 files changed, 222 insertions(+), 10 deletions(-)
> >  create mode 100644 arch/s390/kvm/irq.h

> > diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> > index 94b337e..8155bb4 100644
> > --- a/arch/s390/kvm/interrupt.c
> > +++ b/arch/s390/kvm/interrupt.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/kvm_host.h>
> >  #include <linux/hrtimer.h>
> > +#include <linux/mmu_context.h>
> >  #include <linux/signal.h>
> >  #include <linux/slab.h>
> >  #include <asm/asm-offsets.h>
> > @@ -1118,8 +1119,13 @@ static int kvm_s390_adapter_map(struct kvm *kvm, unsigned int id, __u64 addr)
> >  		goto out;
> >  	}
> >  	INIT_LIST_HEAD(&map->list);
> > -	map->addr = addr;
> > -	ret = get_user_pages_fast(addr, 1, 1, &map->page);
> > +	map->guest_addr = addr;
> > +	map->addr = gmap_translate(addr, kvm->arch.gmap);
> > +	if (map->addr == -EFAULT) {
> > +		ret = -EFAULT;
> > +		goto out;
> > +	}
> > +	ret = get_user_pages_fast(map->addr, 1, 1, &map->page);
> >  	if (ret < 0)
> >  		goto out;
> >  	BUG_ON(ret != 1);
> > @@ -1144,7 +1150,7 @@ static int kvm_s390_adapter_unmap(struct kvm *kvm, unsigned int id, __u64 addr)
> > 
> >  	down_write(&adapter->maps_lock);
> >  	list_for_each_entry_safe(map, tmp, &adapter->maps, list) {
> > -		if (map->addr == addr) {
> > +		if (map->guest_addr == addr) {
> >  			found = 1;
> >  			list_del(&map->list);
> >  			put_page(map->page);
> 
> 
> Can't these two hunks be merged into the previous patch? 

The guest_addr stuff should be in the previous patch, proably some
rebasing fallout. Will fix.

> 
> Otherwise:
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
