From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 6/6] KVM: s390: Wire up ioeventfd.
Date: Mon, 4 Mar 2013 21:07:41 -0300
Message-ID: <20130305000741.GA17903@amt.cnet>
References: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
	<1362051201-56541-7-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1362051201-56541-7-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 28, 2013 at 12:33:21PM +0100, Cornelia Huck wrote:
> Enable ioeventfd support on s390 and hook up diagnose 500 virtio-ccw
> notifications.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  arch/s390/kvm/Kconfig    |  1 +
>  arch/s390/kvm/Makefile   |  2 +-
>  arch/s390/kvm/diag.c     | 26 ++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c |  1 +
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
> index b58dd86..3c43e30 100644
> --- a/arch/s390/kvm/Kconfig
> +++ b/arch/s390/kvm/Kconfig
> @@ -22,6 +22,7 @@ config KVM
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
> +	select HAVE_KVM_EVENTFD
>  	---help---
>  	  Support hosting paravirtualized guest machines using the SIE
>  	  virtualization capability on the mainframe. This should work
> diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
> index 3975722..8fe9d65 100644
> --- a/arch/s390/kvm/Makefile
> +++ b/arch/s390/kvm/Makefile
> @@ -6,7 +6,7 @@
>  # it under the terms of the GNU General Public License (version 2 only)
>  # as published by the Free Software Foundation.
>  
> -common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o)
> +common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o eventfd.o)
>  
>  ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
>  
> diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
> index a390687..1c01a99 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/kvm.h>
>  #include <linux/kvm_host.h>
> +#include <asm/virtio-ccw.h>
>  #include "kvm-s390.h"
>  #include "trace.h"
>  #include "trace-s390.h"
> @@ -104,6 +105,29 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
>  	return -EREMOTE;
>  }
>  
> +static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	int ret, idx;
> +
> +	/* No virtio-ccw notification? Get out quickly. */
> +	if (!vcpu->kvm->arch.css_support ||
> +	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
> +		return -EOPNOTSUPP;
> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	/*
> +	 * The layout is as follows:
> +	 * - gpr 2 contains the subchannel id (passed as addr)
> +	 * - gpr 3 contains the virtqueue index (passed as datamatch)
> +	 */
> +	ret = kvm_io_bus_write(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
> +				vcpu->run->s.regs.gprs[2],
> +				8, &vcpu->run->s.regs.gprs[3]);
> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
> +	return ret < 0 ? ret : 0;
> +}
> +

What about the cookie?
