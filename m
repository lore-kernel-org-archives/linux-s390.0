From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 3/4] KVM: ioeventfd for s390 css devices.
Date: Sun, 24 Feb 2013 11:47:50 +0200
Message-ID: <20130224094750.GD25269@redhat.com>
References: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
 <1361534989-38884-4-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361534989-38884-4-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 22, 2013 at 01:09:48PM +0100, Cornelia Huck wrote:
> Enhance KVM_IOEVENTFD with a new flag that allows to attach to s390 css
> devices.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  Documentation/virtual/kvm/api.txt | 7 +++++++
>  include/uapi/linux/kvm.h          | 2 ++
>  virt/kvm/eventfd.c                | 8 ++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index c2534c3..40e799c 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -1468,15 +1468,22 @@ struct kvm_ioeventfd {
>  	__u8  pad[36];
>  };
>  
> +For the special case of s390 css devices, the ioevent is matched to a
> +subchannel/virtqueue tuple instead.
> +
>  The following flags are defined:
>  
>  #define KVM_IOEVENTFD_FLAG_DATAMATCH (1 << kvm_ioeventfd_flag_nr_datamatch)
>  #define KVM_IOEVENTFD_FLAG_PIO       (1 << kvm_ioeventfd_flag_nr_pio)
>  #define KVM_IOEVENTFD_FLAG_DEASSIGN  (1 << kvm_ioeventfd_flag_nr_deassign)
> +#define KVM_IOEVENTFD_FLAG_CSS       (1 << kvm_ioeventfd_flag_nr_css)
>  
>  If datamatch flag is set, the event will be signaled only if the written value
>  to the registered address is equal to datamatch in struct kvm_ioeventfd.
>  
> +For css devices, addr contains the subchannel id and datamatch the virtqueue
> +index.
> +
>  
>  4.60 KVM_DIRTY_TLB
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

So let's explicitly name is KVM_IOEVENTFD_S390_VIRTIO_CCW or even
KVM_IOEVENTFD_S390_VIRTIO_CCW_NOTIFY?
Also, maybe we want to add KVM_IOEVENTFD_S390_VIRTIO_NOTIFY as well?

>  
>  #define KVM_IOEVENTFD_VALID_FLAG_MASK  ((1 << kvm_ioeventfd_flag_nr_max) - 1)
>  
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f0ced1a..7347652 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -679,11 +679,13 @@ static int
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
> +	bus_idx = pio ? KVM_PIO_BUS : css ? KVM_CSS_BUS: KVM_MMIO_BUS;
>  	/* must be natural-word sized */
>  	switch (args->len) {
>  	case 1:
> @@ -759,11 +761,13 @@ static int
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
> -- 
> 1.7.12.4
