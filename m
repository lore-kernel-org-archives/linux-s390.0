From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 3/3] KVM: s390: Hook up ioeventfds.
Date: Thu, 21 Feb 2013 22:42:41 +0200
Message-ID: <20130221204241.GA29497@redhat.com>
References: <1361452380-50398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1361452380-50398-4-git-send-email-cornelia.huck@de.ibm.com>
	<20130221143904.GC24738@redhat.com>
	<20130221162143.4813d6c5@gondolin>
	<20130221163459.GA26543@redhat.com>
	<20130221191431.4318f949@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <20130221191431.4318f949@gondolin>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 21, 2013 at 07:14:31PM +0100, Cornelia Huck wrote:
> On Thu, 21 Feb 2013 18:34:59 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 21, 2013 at 04:21:43PM +0100, Cornelia Huck wrote:
> > > On Thu, 21 Feb 2013 16:39:05 +0200
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > > On Thu, Feb 21, 2013 at 02:13:00PM +0100, Cornelia Huck wrote:
> > > > > As s390 doesn't use memory writes for virtio notifcations, create
> > > > > a special kind of ioeventfd instead that hooks up into diagnose
> > > > > 0x500 (kvm hypercall) with function code 3 (virtio-ccw notification).
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > 
> > > > Do we really have to put virtio specific stuff into kvm?
> > > > How about we add generic functionality to match GPRs
> > > > on a hypercall and signal an eventfd?
> > > 
> > > Worth a try implementing that.
> > > 
> > > > 
> > > > Also, it's a bit unfortunate that this doesn't use
> > > > the io bus datastructure, long term the linked list handling
> > > > might become a bottleneck, using shared code this could maybe
> > > > benefit from performance optimizations there.
> > > 
> > > The linked list stuff was more like an initial implementation that
> > > could be improved later.
> > > 
> > > > io bus data structure currently has the ability to match on
> > > > two 64 bit fields (addr/datamatch) and a signed 32 bit one (length).
> > > > Isn't this sufficient for your purposes?
> > > > How about sticking subchannel id in address, vq in data match
> > > > and using io bus?
> > > 
> > > I can give that a try. (I must admit that I didn't look at the iobus
> > > stuff in detail.)
> > > 
> > > > 
> > > > BTW maybe we could do this for the user interface too,
> > > > while I'm not 100% sure it's the cleanest thing to do
> > > > (or will work), it would certainly minimize the patchset.
> > > 
> > > You mean integrating with the generic interface and dropping the new
> > > ARCH flag?
> > 
> > Not sure about the flag but we could use the general structure
> > without an arch-specific format, if that's a good fit.
> > 
> So I have something that seems to do what I want. I'll see if I can
> morph it into something presentable tomorrow.
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
> index a390687..7fc195e 100644
> --- a/arch/s390/kvm/diag.c
> +++ b/arch/s390/kvm/diag.c
> @@ -104,6 +104,20 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
>  	return -EREMOTE;
>  }
>  
> +static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
> +{
> +	int ret, idx;
> +	u64 vq = vcpu->run->s.regs.gprs[3];
> +
> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
> +	ret = kvm_io_bus_write(vcpu->kvm, KVM_CSS_BUS,
> +				vcpu->run->s.regs.gprs[2],
> +				vcpu->run->s.regs.gprs[1],
> +				&vq);

Hmm, do you really need three gprs? If not, we could
just pass len == 8, which would be cleaner.
Also might as well drop the vq variable, no?

> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
> +	return ret;
> +}
> +
>  int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>  {
>  	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
> @@ -118,6 +132,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
>  		return __diag_time_slice_end_directed(vcpu);
>  	case 0x308:
>  		return __diag_ipl_functions(vcpu);
> +	case 0x500:
> +		return __diag_virtio_hypercall(vcpu);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f822d36..04d2454 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -142,6 +142,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>  	case KVM_CAP_ONE_REG:
>  	case KVM_CAP_ENABLE_CAP:
>  	case KVM_CAP_S390_CSS_SUPPORT:
> +	case KVM_CAP_IOEVENTFD:
>  		r = 1;
>  		break;
>  	case KVM_CAP_NR_VCPUS:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 3b768ef..59be516 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -148,6 +148,7 @@ struct kvm_io_bus {
>  enum kvm_bus {
>  	KVM_MMIO_BUS,
>  	KVM_PIO_BUS,
> +	KVM_CSS_BUS,
>  	KVM_NR_BUSES
>  };
>  
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 9a2db57..1df0766 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -448,12 +448,14 @@ enum {
>  	kvm_ioeventfd_flag_nr_datamatch,
>  	kvm_ioeventfd_flag_nr_pio,
>  	kvm_ioeventfd_flag_nr_deassign,
> +	kvm_ioeventfd_flag_nr_css,
>  	kvm_ioeventfd_flag_nr_max,
>  };
>  
>  #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
>  #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
>  #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
> +#define KVM_IOEVENTFD_FLAG_CSS       (1 << kvm_ioeventfd_flag_nr_css)
>  
>  #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
>  
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f0ced1a..57a06ff 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -576,6 +576,7 @@ struct _ioeventfd {
>  	u64                  datamatch;
>  	struct kvm_io_device dev;
>  	bool                 wildcard;
> +	bool                 is_css;
>  };
>  
>  static inline struct _ioeventfd *
> @@ -607,24 +608,27 @@ ioeventfd_in_range(struct _ioeventfd *p, gpa_t addr, int len, const void *val)
>  
>  	/* otherwise, we have to actually compare the data */
>  
> -	BUG_ON(!IS_ALIGNED((unsigned long)val, len));
> -
> -	switch (len) {
> -	case 1:
> -		_val = *(u8 *)val;
> -		break;
> -	case 2:
> -		_val = *(u16 *)val;
> -		break;
> -	case 4:
> -		_val = *(u32 *)val;
> -		break;
> -	case 8:
> +	if (!p->is_css) {
> +		BUG_ON(!IS_ALIGNED((unsigned long)val, len));
> +
> +		switch (len) {
> +		case 1:
> +			_val = *(u8 *)val;
> +			break;
> +		case 2:
> +			_val = *(u16 *)val;
> +			break;
> +		case 4:
> +			_val = *(u32 *)val;
> +			break;
> +		case 8:
> +			_val = *(u64 *)val;
> +			break;
> +		default:
> +			return false;
> +		}
> +	} else
>  		_val = *(u64 *)val;
> -		break;
> -	default:
> -		return false;
> -	}
>  
>  	return _val == p->datamatch ? true : false;
>  }
> @@ -679,25 +683,29 @@ static int
>  kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  {
>  	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
> -	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
> +	int                       css = args->flags & KVM_IOEVENTFD_FLAG_CSS;
> +	enum kvm_bus              bus_idx;
>  	struct _ioeventfd        *p;
>  	struct eventfd_ctx       *eventfd;
>  	int                       ret;
>  
> -	/* must be natural-word sized */
> -	switch (args->len) {
> -	case 1:
> -	case 2:
> -	case 4:
> -	case 8:
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	bus_idx = pio ? KVM_PIO_BUS : css ? KVM_CSS_BUS: KVM_MMIO_BUS;
> +	if (!css) {
> +		/* must be natural-word sized */
> +		switch (args->len) {
> +		case 1:
> +		case 2:
> +		case 4:
> +		case 8:
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
>  
> -	/* check for range overflow */
> -	if (args->addr + args->len < args->addr)
> -		return -EINVAL;
> +		/* check for range overflow */
> +		if (args->addr + args->len < args->addr)
> +			return -EINVAL;
> +	}
>  
>  	/* check for extra flags that we don't understand */
>  	if (args->flags & ~KVM_IOEVENTFD_VALID_FLAG_MASK)
> @@ -717,6 +725,7 @@ kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  	p->addr    = args->addr;
>  	p->length  = args->len;
>  	p->eventfd = eventfd;
> +	p->is_css  = css;
>  
>  	/* The datamatch feature is optional, otherwise this is a wildcard */
>  	if (args->flags & KVM_IOEVENTFD_FLAG_DATAMATCH)
> @@ -759,11 +768,13 @@ static int
>  kvm_deassign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  {
>  	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
> -	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
> +	int                       css = args->flags & KVM_IOEVENTFD_FLAG_CSS;
> +	enum kvm_bus              bus_idx;
>  	struct _ioeventfd        *p, *tmp;
>  	struct eventfd_ctx       *eventfd;
>  	int                       ret = -ENOENT;
>  
> +	bus_idx = pio ? KVM_PIO_BUS : css ? KVM_CSS_BUS: KVM_MMIO_BUS;
>  	eventfd = eventfd_ctx_fdget(args->fd);
>  	if (IS_ERR(eventfd))
>  		return PTR_ERR(eventfd);
