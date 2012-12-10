From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 5/5] KVM: s390: Split out early console code.
Date: Mon, 10 Dec 2012 10:06:31 +0100
Message-ID: <20121210100631.160cd7bc@BR9GNB5Z>
References: <1354883369-36537-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354883369-36537-6-git-send-email-cornelia.huck@de.ibm.com>
	<C9C36A9A-40FC-47DD-B10D-0027CE590EFB@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <C9C36A9A-40FC-47DD-B10D-0027CE590EFB@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Avi Kivity <avi.kivity@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, 9 Dec 2012 13:45:47 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 07.12.2012, at 13:29, Cornelia Huck wrote:
> 
> > This code is transport agnostic and can be used by both the legacy
> > virtio code and virtio_ccw.
> 
> This code should die. It's a nightmare to implement in QEMU, because it ends up being a separate char device. I'd prefer if we don't carry it over to the virtio-ccw world :).

I don't really want to kill an interface in a patchset adding a new
transport. We may kill this later on, though...

> 
> 
> Alex
> 
> > 
> > Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > drivers/s390/kvm/Makefile       |  2 +-
> > drivers/s390/kvm/early_printk.c | 42 +++++++++++++++++++++++++++++++++++++++++
> > drivers/s390/kvm/kvm_virtio.c   | 29 ++--------------------------
> > drivers/s390/kvm/virtio_ccw.c   |  1 -
> > 4 files changed, 45 insertions(+), 29 deletions(-)
> > create mode 100644 drivers/s390/kvm/early_printk.c
> > 
> > diff --git a/drivers/s390/kvm/Makefile b/drivers/s390/kvm/Makefile
> > index 241891a..a3c8fc4 100644
> > --- a/drivers/s390/kvm/Makefile
> > +++ b/drivers/s390/kvm/Makefile
> > @@ -6,4 +6,4 @@
> > # it under the terms of the GNU General Public License (version 2 only)
> > # as published by the Free Software Foundation.
> > 
> > -obj-$(CONFIG_S390_GUEST) += kvm_virtio.o virtio_ccw.o
> > +obj-$(CONFIG_S390_GUEST) += kvm_virtio.o early_printk.o virtio_ccw.o
> > diff --git a/drivers/s390/kvm/early_printk.c b/drivers/s390/kvm/early_printk.c
> > new file mode 100644
> > index 0000000..915d687
> > --- /dev/null
> > +++ b/drivers/s390/kvm/early_printk.c
> > @@ -0,0 +1,42 @@
> > +/*
> > + * early_printk.c - code for early console output with virtio_console
> > + * split off from kvm_virtio.c
> > + *
> > + * Copyright IBM Corp. 2008
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License (version 2 only)
> > + * as published by the Free Software Foundation.
> > + *
> > + *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
> > + */
> > +
> > +#include <linux/kernel_stat.h>
> > +#include <linux/init.h>
> > +#include <linux/err.h>
> > +#include <linux/virtio_console.h>
> > +#include <linux/kvm_para.h>
> > +#include <asm/kvm_virtio.h>
> > +#include <asm/setup.h>
> > +#include <asm/sclp.h>
> > +
> > +static __init int early_put_chars(u32 vtermno, const char *buf, int count)
> > +{
> > +	char scratch[17];
> > +	unsigned int len = count;
> > +
> > +	if (len > sizeof(scratch) - 1)
> > +		len = sizeof(scratch) - 1;
> > +	scratch[len] = '\0';
> > +	memcpy(scratch, buf, len);
> > +	kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, __pa(scratch));
> > +	return len;
> > +}
> > +
> > +static int __init s390_virtio_console_init(void)
> > +{
> > +	if (sclp_has_vt220() || sclp_has_linemode())
> > +		return -ENODEV;
> > +	return virtio_cons_early_init(early_put_chars);
> > +}
> > +console_initcall(s390_virtio_console_init);
> > diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
> > index 779e480..6ca06ed 100644
> > --- a/drivers/s390/kvm/kvm_virtio.c
> > +++ b/drivers/s390/kvm/kvm_virtio.c
> > @@ -17,7 +17,6 @@
> > #include <linux/virtio.h>
> > #include <linux/virtio_config.h>
> > #include <linux/slab.h>
> > -#include <linux/virtio_console.h>
> > #include <linux/interrupt.h>
> > #include <linux/virtio_ring.h>
> > #include <linux/export.h>
> > @@ -25,9 +24,9 @@
> > #include <asm/io.h>
> > #include <asm/kvm_para.h>
> > #include <asm/kvm_virtio.h>
> > -#include <asm/sclp.h>
> > #include <asm/setup.h>
> > #include <asm/irq.h>
> > +#include <asm/sclp.h>
> > 
> > #define VIRTIO_SUBCODE_64 0x0D00
> > 
> > @@ -453,8 +452,7 @@ static int __init kvm_devices_init(void)
> > 		return -ENODEV;
> > 
> > 	if (test_devices_support(real_memory_size) < 0)
> > -		/* No error. */
> > -		return 0;
> > +		return -ENODEV;
> > 
> > 	rc = vmem_add_mapping(real_memory_size, PAGE_SIZE);
> > 	if (rc)
> > @@ -479,29 +477,6 @@ static int __init kvm_devices_init(void)
> > 	return 0;
> > }
> > 
> > -/* code for early console output with virtio_console */
> > -static __init int early_put_chars(u32 vtermno, const char *buf, int count)
> > -{
> > -	char scratch[17];
> > -	unsigned int len = count;
> > -
> > -	if (len > sizeof(scratch) - 1)
> > -		len = sizeof(scratch) - 1;
> > -	scratch[len] = '\0';
> > -	memcpy(scratch, buf, len);
> > -	kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, __pa(scratch));
> > -	return len;
> > -}
> > -
> > -static int __init s390_virtio_console_init(void)
> > -{
> > -	if (sclp_has_vt220() || sclp_has_linemode())
> > -		return -ENODEV;
> > -	return virtio_cons_early_init(early_put_chars);
> > -}
> > -console_initcall(s390_virtio_console_init);
> > -
> > -
> > /*
> >  * We do this after core stuff, but before the drivers.
> >  */
> > diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> > index 0e98b523a..1350391 100644
> > --- a/drivers/s390/kvm/virtio_ccw.c
> > +++ b/drivers/s390/kvm/virtio_ccw.c
> > @@ -17,7 +17,6 @@
> > #include <linux/virtio.h>
> > #include <linux/virtio_config.h>
> > #include <linux/slab.h>
> > -#include <linux/virtio_console.h>
> > #include <linux/interrupt.h>
> > #include <linux/virtio_ring.h>
> > #include <linux/pfn.h>
> > -- 
> > 1.7.12.4
> > 
> 
