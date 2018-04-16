From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 01/15] s390: zcrypt: externalize AP instructions
 available function
Date: Mon, 16 Apr 2018 14:11:36 +0200
Message-ID: <20180416141136.04be5558.cohuck@redhat.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-2-git-send-email-akrowiak@linux.vnet.ibm.com>
        <77bbd4ca-8412-e59d-e1ca-9a114cf495a6@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77bbd4ca-8412-e59d-e1ca-9a114cf495a6@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 16 Apr 2018 10:44:53 +0200
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 15/04/2018 23:22, Tony Krowiak wrote:
> > If the AP instructions are not available on the linux host, then
> > AP devices can not be interpreted by the SIE. The AP bus has a
> > function it uses to determine if the AP instructions are
> > available. This patch provides a new function that wraps the
> > AP bus's function to externalize it for use by KVM.
> >
> > Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > Reviewed-by: Harald Freudenberger <freude@linux.vnet.ibm.com>
> > ---
> >   arch/s390/include/asm/ap.h     |    7 +++++++
> >   arch/s390/include/asm/kvm-ap.h |   23 +++++++++++++++++++++++
> >   arch/s390/kvm/Makefile         |    2 +-
> >   arch/s390/kvm/kvm-ap.c         |   21 +++++++++++++++++++++
> >   drivers/s390/crypto/ap_bus.c   |    6 ++++++
> >   5 files changed, 58 insertions(+), 1 deletions(-)
> >   create mode 100644 arch/s390/include/asm/kvm-ap.h
> >   create mode 100644 arch/s390/kvm/kvm-ap.c

> > diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> > new file mode 100644
> > index 0000000..1267588
> > --- /dev/null
> > +++ b/arch/s390/kvm/kvm-ap.c
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Adjunct Processor (AP) configuration management for KVM guests
> > + *
> > + * Copyright IBM Corp. 2018
> > + *
> > + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> > + */
> > +#include <linux/kernel.h>
> > +#include <asm/kvm-ap.h>
> > +#include <asm/ap.h>
> > +
> > +int kvm_ap_instructions_installed(void)
> > +{
> > +#ifdef CONFIG_ZCRYPT  
> 
> I did not give my R-B for this.
> please change it or suppress my R-B
> 
> I think you should review the way you wrap functions
> calling the AP interface.
> Having all of them together would simplify code and review.

I don't like the ifdeffery either (especially as there's more later).

Consolidating all functions for querying basic ap capabilities sounds
like a good idea. What about collecting them in a ap-util file and
either always building it or selecting it from both zcrypt and kvm?

> 
> > +	return ap_instructions_installed();
> > +#else
> > +	return 0;
> > +#endif
> > +}
> > +EXPORT_SYMBOL(kvm_ap_instructions_installed);
> > diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> > index 35a0c2b..9d108b6 100644
> > --- a/drivers/s390/crypto/ap_bus.c
> > +++ b/drivers/s390/crypto/ap_bus.c
> > @@ -210,6 +210,12 @@ int ap_query_configuration(struct ap_config_info *info)
> >   }
> >   EXPORT_SYMBOL(ap_query_configuration);
> >
> > +int ap_instructions_installed(void)
> > +{
> > +	return (ap_instructions_available() == 0);
> > +}
> > +EXPORT_SYMBOL(ap_instructions_installed);
> > +
> >   /**
> >    * ap_init_configuration(): Allocate and query configuration array.
> >    */  
> 
> 
