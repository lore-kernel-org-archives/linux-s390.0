From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [RFC PATCH 1/3] KVM: s390: Move out initialization code.
Date: Thu, 21 Feb 2013 15:07:32 +0100
Message-ID: <20130221150732.1580dbd4@gondolin>
References: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1361452380-50398-2-git-send-email-cornelia.huck@de.ibm.com>
	<20130221134355.GA24738@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20130221134355.GA24738@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Feb 2013 15:43:55 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 21, 2013 at 02:12:58PM +0100, Cornelia Huck wrote:
> > kvm-s390's module initialization code needs to live in a separate
> > module (kvm-s390.ko) if we want to include eventfd (which has its
> > own module init func).
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> I don't get this explanation.
> What's the problem this solves?
> Could you clarify please?

On s390, we currently build a single 'kvm' module, with a module_init
function. eventfd has its own module_init function, and we can't have
two of them in the same module. I just moved our specific module
initialization into a new 'kvm_s390' module.

> 
> > ---
> >  arch/s390/kvm/Makefile   |  4 +++-
> >  arch/s390/kvm/init.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  arch/s390/kvm/kvm-s390.c | 38 ++++-------------------------------
> >  3 files changed, 59 insertions(+), 35 deletions(-)
> >  create mode 100644 arch/s390/kvm/init.c
> > 
> > diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> > index 3975722..2441ffd 100644
> > --- a/arch/s390/kvm/Makefile
> > +++ b/arch/s390/kvm/Makefile
> > @@ -11,4 +11,6 @@ common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
> >  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
> >  
> >  kvm-objs := $(common-objs) kvm-s390.o intercept.o interrupt.o priv.o sigp.o diag.o
> > -obj-$(CONFIG_KVM) += kvm.o
> > +kvm_s390-objs := init.o
> > +
> > +obj-$(CONFIG_KVM) += kvm.o kvm_s390.o
> > diff --git a/arch/s390/kvm/init.c b/arch/s390/kvm/init.c
> > new file mode 100644
> > index 0000000..dc4028a
> > --- /dev/null
> > +++ b/arch/s390/kvm/init.c
> > @@ -0,0 +1,52 @@
> > +/*
> > + * kvm on s390 module initialization
> > + *
> > + * Copyright IBM Corp. 2013
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License (version 2 only)
> > + * as published by the Free Software Foundation.
> > + *
> > + *    Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + */
> > +
> > +#include <linux/kvm.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/module.h>
> > +#include "kvm-s390.h"
> > +
> > +extern unsigned long long *facilities;
> > +
> > +static int __init kvm_s390_init(void)
> > +{
> > +	int ret;
> > +	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * guests can ask for up to 255+1 double words, we need a full page
> > +	 * to hold the maximum amount of facilities. On the other hand, we
> > +	 * only set facilities that are known to work in KVM.
> > +	 */
> > +	facilities = (unsigned long long *) get_zeroed_page(GFP_KERNEL|GFP_DMA);
> > +	if (!facilities) {
> > +		kvm_exit();
> > +		return -ENOMEM;
> > +	}
> > +	memcpy(facilities, S390_lowcore.stfle_fac_list, 16);
> > +	facilities[0] &= 0xff00fff3f47c0000ULL;
> > +	facilities[1] &= 0x001c000000000000ULL;
> > +	return 0;
> > +}
> > +
> > +static void __exit kvm_s390_exit(void)
> > +{
> > +	free_page((unsigned long) facilities);
> > +	kvm_exit();
> > +}
> > +
> > +module_init(kvm_s390_init);
> > +module_exit(kvm_s390_exit);
> > +
> > +MODULE_LICENSE("GPL");
> 
> GPL v2?
> 
> > diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> > index f822d36..58a5f03 100644
> > --- a/arch/s390/kvm/kvm-s390.c
> > +++ b/arch/s390/kvm/kvm-s390.c
> > @@ -36,6 +36,9 @@
> >  #include "trace.h"
> >  #include "trace-s390.h"
> >  
> > +unsigned long long *facilities;
> > +EXPORT_SYMBOL_GPL(facilities);
> > +
> >  #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
> >  
> >  struct kvm_stats_debugfs_item debugfs_entries[] = {
> > @@ -83,8 +86,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
> >  	{ NULL }
> >  };
> >  
> > -static unsigned long long *facilities;
> > -
> >  /* Section: not file related */
> >  int kvm_arch_hardware_enable(void *garbage)
> >  {
> > @@ -823,6 +824,7 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
> >  		return -EFAULT;
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(kvm_s390_vcpu_store_status);
> >  
> >  static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
> >  				     struct kvm_enable_cap *cap)
> > @@ -1026,35 +1028,3 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> >  				   struct kvm_memory_slot *slot)
> >  {
> >  }
> > -
> > -static int __init kvm_s390_init(void)
> > -{
> > -	int ret;
> > -	ret = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
> > -	if (ret)
> > -		return ret;
> > -
> > -	/*
> > -	 * guests can ask for up to 255+1 double words, we need a full page
> > -	 * to hold the maximum amount of facilities. On the other hand, we
> > -	 * only set facilities that are known to work in KVM.
> > -	 */
> > -	facilities = (unsigned long long *) get_zeroed_page(GFP_KERNEL|GFP_DMA);
> > -	if (!facilities) {
> > -		kvm_exit();
> > -		return -ENOMEM;
> > -	}
> > -	memcpy(facilities, S390_lowcore.stfle_fac_list, 16);
> > -	facilities[0] &= 0xff00fff3f47c0000ULL;
> > -	facilities[1] &= 0x001c000000000000ULL;
> > -	return 0;
> > -}
> > -
> > -static void __exit kvm_s390_exit(void)
> > -{
> > -	free_page((unsigned long) facilities);
> > -	kvm_exit();
> > -}
> > -
> > -module_init(kvm_s390_init);
> > -module_exit(kvm_s390_exit);
> > -- 
> > 1.7.12.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
