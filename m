From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v5 6/6] KVM: s390: Wire up ioeventfd.
Date: Tue, 5 Mar 2013 15:24:02 +0100
Message-ID: <20130305152402.2c54161e@gondolin>
References: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
	<1362051201-56541-7-git-send-email-cornelia.huck@de.ibm.com>
	<20130305000741.GA17903@amt.cnet>
	<20130305091308.1a1173d1@gondolin>
	<20130305131943.GC2256@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130305131943.GC2256@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 5 Mar 2013 15:19:43 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 05, 2013 at 09:13:08AM +0100, Cornelia Huck wrote:
> > On Mon, 4 Mar 2013 21:07:41 -0300
> > Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > 
> > > On Thu, Feb 28, 2013 at 12:33:21PM +0100, Cornelia Huck wrote:
> > > > Enable ioeventfd support on s390 and hook up diagnose 500 virtio-ccw
> > > > notifications.
> > > > 
> > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > ---
> > > >  arch/s390/kvm/Kconfig    |  1 +
> > > >  arch/s390/kvm/Makefile   |  2 +-
> > > >  arch/s390/kvm/diag.c     | 26 ++++++++++++++++++++++++++
> > > >  arch/s390/kvm/kvm-s390.c |  1 +
> > > >  4 files changed, 29 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> > > > index b58dd86..3c43e30 100644
> > > > --- a/arch/s390/kvm/Kconfig
> > > > +++ b/arch/s390/kvm/Kconfig
> > > > @@ -22,6 +22,7 @@ config KVM
> > > >  	select PREEMPT_NOTIFIERS
> > > >  	select ANON_INODES
> > > >  	select HAVE_KVM_CPU_RELAX_INTERCEPT
> > > > +	select HAVE_KVM_EVENTFD
> > > >  	---help---
> > > >  	  Support hosting paravirtualized guest machines using the SIE
> > > >  	  virtualization capability on the mainframe. This should work
> > > > diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> > > > index 3975722..8fe9d65 100644
> > > > --- a/arch/s390/kvm/Makefile
> > > > +++ b/arch/s390/kvm/Makefile
> > > > @@ -6,7 +6,7 @@
> > > >  # it under the terms of the GNU General Public License (version 2 only)
> > > >  # as published by the Free Software Foundation.
> > > >  
> > > > -common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
> > > > +common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o eventfd.o)
> > > >  
> > > >  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> > > >  
> > > > diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> > > > index a390687..1c01a99 100644
> > > > --- a/arch/s390/kvm/diag.c
> > > > +++ b/arch/s390/kvm/diag.c
> > > > @@ -13,6 +13,7 @@
> > > >  
> > > >  #include <linux/kvm.h>
> > > >  #include <linux/kvm_host.h>
> > > > +#include <asm/virtio-ccw.h>
> > > >  #include "kvm-s390.h"
> > > >  #include "trace.h"
> > > >  #include "trace-s390.h"
> > > > @@ -104,6 +105,29 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
> > > >  	return -EREMOTE;
> > > >  }
> > > >  
> > > > +static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
> > > > +{
> > > > +	int ret, idx;
> > > > +
> > > > +	/* No virtio-ccw notification? Get out quickly. */
> > > > +	if (!vcpu->kvm->arch.css_support ||
> > > > +	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> > > > +	/*
> > > > +	 * The layout is as follows:
> > > > +	 * - gpr 2 contains the subchannel id (passed as addr)
> > > > +	 * - gpr 3 contains the virtqueue index (passed as datamatch)
> > > > +	 */
> > > > +	ret = kvm_io_bus_write(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
> > > > +				vcpu->run->s.regs.gprs[2],
> > > > +				8, &vcpu->run->s.regs.gprs[3]);
> > > > +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > > > +	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
> > > > +	return ret < 0 ? ret : 0;
> > > > +}
> > > > +
> > > 
> > > What about the cookie?
> > 
> > This is the not-performance-optimized version which went through our
> > testing and which I'd like to see applied. I also have a not-yet-tested
> > patch that adds cookie support (see below), but I'd like to postpone
> > this to 3.10.
> 
> I agree it's best to delay this optimization, focus on basic
> functionality now. As guest with cookie support is
> compatible with host without said support (all we do
> really is reserve a gpr), there won't be issues adding it later.
> Some comments on the draft below.
> 
> 
> > commit 8fce4a8a3478252f7ee2eb74d2732673f5911120
> > Author: Cornelia Huck <cornelia.huck@de.ibm.com>
> > Date:   Tue Feb 26 17:05:01 2013 +0100
> > 
> >     virtio-ccw: ioeventfd: use cookies
> >     
> >     Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> > index 1c01a99..bd2a013 100644
> > --- a/arch/s390/kvm/diag.c
> > +++ b/arch/s390/kvm/diag.c
> > @@ -108,22 +108,29 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
> >  static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
> >  {
> >  	int ret, idx;
> > +	long cookie;
> >  
> >  	/* No virtio-ccw notification? Get out quickly. */
> >  	if (!vcpu->kvm->arch.css_support ||
> >  	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
> >  		return -EOPNOTSUPP;
> >  
> > +	cookie = vcpu->run->s.regs.gprs[4];
> 
> Hmm signed so this can become negative.
> 
> >  	idx = srcu_read_lock(&vcpu->kvm->srcu);
> >  	/*
> >  	 * The layout is as follows:
> >  	 * - gpr 2 contains the subchannel id (passed as addr)
> >  	 * - gpr 3 contains the virtqueue index (passed as datamatch)
> > +	 * - gpr 4 contains the index on the bus (optionally)
> >  	 */
> > -	ret = kvm_io_bus_write(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
> > -				vcpu->run->s.regs.gprs[2],
> > -				8, &vcpu->run->s.regs.gprs[3]);
> > +	ret = kvm_io_bus_write_cookie(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
> > +				      vcpu->run->s.regs.gprs[2],
> > +				      8, &vcpu->run->s.regs.gprs[3],
> > +				      &cookie);
> >  	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> > +	if (!ret)
> > +		/* Return cookie in gpr 2. */
> > +		vcpu->run->s.regs.gprs[2] = cookie;
> 
> We should also set gprs[2] to something sane if exiting to userspace
> so avoid adding overhead for that case.
> Probably # of devices + 1 or a negative value.

Negative value would probably be the most obvious.

> Are there 32 bit guests? If yes can they pass a negative value?

No, we only support 64 bit guests.

> 
> >  	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
> >  	return ret < 0 ? ret : 0;
> >  }
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 206247f..2f65a3a 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -154,6 +154,8 @@ enum kvm_bus {
> >  
> >  int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> >  		     int len, const void *val);
> > +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> > +			    int len, const void *val, long *cookie);
> >  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr, int len,
> >  		    void *val);
> >  int kvm_io_bus_register_dev(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 7c188a3..b77ea5f 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2710,6 +2710,51 @@ int kvm_io_bus_write(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +/* kvm_io_bus_write_cookie - called under kvm->slots_lock */
> > +int kvm_io_bus_write_cookie(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> > +			    int len, const void *val, long *cookie)
> > +{
> > +	int idx, ret = -EOPNOTSUPP;
> > +	struct kvm_io_bus *bus;
> > +	struct kvm_io_range range;
> > +
> > +	range = (struct kvm_io_range) {
> > +		.addr = addr,
> > +		.len = len,
> > +	};
> > +
> > +	if (!cookie)
> > +		return -EINVAL;
> > +
> 
> Hmm does this ever trigger?

Probably not.

> 
> > +	bus = srcu_dereference(kvm->buses[bus_idx], &kvm->srcu);
> > +
> > +	/* First try the device referenced by *cookie. */
> > +	if (kvm_io_bus_sort_cmp(&range, &bus->range[*cookie]) == 0)
> 
> We need to range-check the cookie.

Yup.

> 
> > +		if (!kvm_iodevice_write(bus->range[*cookie].dev, addr, len,
> > +					val))
> > +			return 0;
> > +
> > +	/*
> > +	 * *cookie contained garbage; fall back to search and return the
> > +	 * correct value in *cookie.
> > +	 */
> > +	idx = kvm_io_bus_get_first_dev(bus, addr, len);
> > +	if (idx < 0)
> > +		goto out;
> > +
> > +	while (idx < bus->dev_count &&
> > +		kvm_io_bus_sort_cmp(&range, &bus->range[idx]) == 0) {
> > +		if (!kvm_iodevice_write(bus->range[idx].dev, addr, len, val)) {
> > +			ret = 0;
> > +			goto out;
> > +		}
> > +		idx++;
> > +	}
> > +out:
> > +	*cookie = idx;
> > +	return ret;
> > +}
> > +
> >  /* kvm_io_bus_read - called under kvm->slots_lock */
> >  int kvm_io_bus_read(struct kvm *kvm, enum kvm_bus bus_idx, gpa_t addr,
> >  		    int len, void *val)
> 
