From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v2 0/4] kvm: Make ioeventfd usable on s390.
Date: Sun, 24 Feb 2013 11:56:39 +0200
Message-ID: <20130224095639.GE25269@redhat.com>
References: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1361534989-38884-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Feb 22, 2013 at 01:09:45PM +0100, Cornelia Huck wrote:
> Here's the second attempt at implementing ioeventfd for s390.

The patchset looks fine overall.
Minor comments and questions below.

> 
> Rather than the architecture-specific functions used in v1, we
> now try to integrate with the kvm_io_device infrastructure.
> Calls to diagnose 500 subcode 3 are now mapped to _write.
> These devices are created on a new KVM_CSS_BUS when using a
> new flag KVM_IOEVENTFD_FLAG_CSS. addr and datamatch are (ab)used
> to contain the subchannel id and the virtqueue.
> 
> A drawback is that this interface is not easily extendable should
> we want to attach other hypercalls or carry more payload.

Under s390 kvm_hypercallX already uses diagnose 500 so that seems
fine. If you want to make it more generic and support
more subcodes, I think you'll have to pass an extra u64 field:
to bus to both avoid overflowing int value and avoid ugly
bus-specific hacks in generic code.

Will we ever need that? Code using subcode 3 does not yet seem
to be upstream in 3.8 so maybe yes, but you decide.
An alternative is to add new bus types when kvm needs to handle
new subcodes. So e.g. KVM_BUS_S390_VIRTIO_CCW_NOTIFY and
KVM_BUS_S390_VIRTIO_NOTIFY ?

You decide, I'm fine with either approach.

More minor comments and questions in response to individual patches.

> Another limitation is the limit of 1000 io devices per bus, which
> we would hit easily with a few hundred devices, but that should
> be fixable.
> 
> v1 -> v2:
> - Move irqfd initialization from a module init function to kvm_init,
>   eliminating the need for a second module for kvm/s390.
> - Use kvm_io_device for s390 css devices.
> 
> 
> Cornelia Huck (4):
>   KVM: Initialize irqfd from kvm_init().
>   KVM: Introduce KVM_CSS_BUS.
>   KVM: ioeventfd for s390 css devices.
>   KVM: s390: Wire up ioeventfd.
> 
>  Documentation/virtual/kvm/api.txt |  7 +++++++
>  arch/s390/kvm/Kconfig             |  1 +
>  arch/s390/kvm/Makefile            |  2 +-
>  arch/s390/kvm/diag.c              | 25 +++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c          |  1 +
>  include/linux/kvm_host.h          | 14 ++++++++++++++
>  include/uapi/linux/kvm.h          |  2 ++
>  virt/kvm/eventfd.c                | 15 ++++++++-------
>  virt/kvm/kvm_main.c               |  6 ++++++
>  9 files changed, 65 insertions(+), 8 deletions(-)
> 
> -- 
> 1.7.12.4
