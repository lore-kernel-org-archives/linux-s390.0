From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v3 4/5] KVM: ioeventfd for virtio-ccw devices.
Date: Tue, 26 Feb 2013 15:19:03 +0100
Message-ID: <20130226141903.GA7828@stefanha-thinkpad.redhat.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
 <1361806070-62465-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361806070-62465-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 25, 2013 at 04:27:49PM +0100, Cornelia Huck wrote:
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f0ced1a..8de3cd7 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -679,11 +679,16 @@ static int
>  kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  {
>  	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
> -	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
> +	int                       ccw;
> +	enum kvm_bus              bus_idx;
>  	struct _ioeventfd        *p;
>  	struct eventfd_ctx       *eventfd;
>  	int                       ret;
>  
> +	ccw = args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY;
> +	bus_idx = pio ? KVM_PIO_BUS :
> +		ccw ? KVM_VIRTIO_CCW_NOTIFY_BUS :
> +		KVM_MMIO_BUS;
>  	/* must be natural-word sized */
>  	switch (args->len) {
>  	case 1:
> @@ -759,11 +764,16 @@ static int
>  kvm_deassign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
>  {
>  	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
> -	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
> +	int                       ccw;
> +	enum kvm_bus              bus_idx;
>  	struct _ioeventfd        *p, *tmp;
>  	struct eventfd_ctx       *eventfd;
>  	int                       ret = -ENOENT;
>  
> +	ccw = args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY;
> +	bus_idx = pio ? KVM_PIO_BUS :
> +		ccw ? KVM_VIRTIO_CCW_NOTIFY_BUS :
> +		KVM_MMIO_BUS;

This is getting pretty convoluted.  Drop of pio and ccw local variables,
replace ?: with an if statement:

if (args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY)
	bus_idx = KVM_VIRTIO_CCW_NOTIFY_BUS;
else if (args->flags & KVM_IOEVENTFD_FLAG_PIO)
	bus_idx = KVM_PIO_BUS;
else
	bus_idx = KVM_MMIO_BUS;
