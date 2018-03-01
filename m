From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 01/15] KVM: s390: refactor crypto initialization
Date: Thu, 1 Mar 2018 10:59:15 +0100
Message-ID: <20180301105915.5c871524.cohuck@redhat.com>
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1519741693-17440-2-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180228183741.5276e3d3.cohuck@redhat.com>
        <edab4611-2393-4b82-99af-7d3192b488bc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edab4611-2393-4b82-99af-7d3192b488bc@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 28 Feb 2018 16:23:29 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 02/28/2018 12:37 PM, Cornelia Huck wrote:
> > On Tue, 27 Feb 2018 09:27:59 -0500
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
> >> new file mode 100644
> >> index 0000000..5305f4c
> >> --- /dev/null
> >> +++ b/arch/s390/kvm/kvm-ap.c
> >> @@ -0,0 +1,47 @@
> >> +/*
> >> + * Adjunct Processor (AP) configuration management for KVM guests
> >> + *
> >> + * Copyright IBM Corp. 2017
> >> + *
> >> + * Author(s): Tony Krowiak <akrowia@linux.vnet.ibm.com>
> >> + */
> >> +
> >> +#include <asm/kvm-ap.h>
> >> +#include <asm/ap.h>
> >> +
> >> +#include "kvm-s390.h"
> >> +
> >> +static int kvm_ap_apxa_installed(void)
> >> +{
> >> +	int ret;
> >> +	struct ap_config_info config;
> >> +
> >> +	ret = ap_query_configuration(&config);  
> > Doesn't that introduce a dependency on CONFIG_ZCRYPT?  
> It does, but AFAIK zcrypt is built into the kernel. Or is that not what 
> you are asking?

It is built into the kernel (and not into a module) if CONFIG_ZCRYPT is
set. When I compile a kernel with CONFIG_KVM set and CONFIG_ZCRYPT
unset, with this patch applied I get

arch/s390/kvm/kvm-ap.o: In function `kvm_ap_apxa_installed':
/home/cohuck/git/linux/arch/s390/kvm/kvm-ap.c:19: undefined reference to `ap_query_configuration'

So I'm afraid you cannot use ap_query_configuration() in base s390 kvm
code unless you move that function to a place where it is always built
(or at least always built if either CONFIG_KVM or CONFIG_ZCRYPT are
set).
