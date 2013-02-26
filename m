From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/5] kvm: Make ioeventfd usable on s390.
Date: Tue, 26 Feb 2013 13:04:21 +0200
Message-ID: <20130226110421.GB10915@redhat.com>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 25, 2013 at 04:27:45PM +0100, Cornelia Huck wrote:
> Here's the latest version of my patch series enabling ioeventfds
> on s390, again against kvm-next.
> 
> Patches 1 and 2 (cleaning up initialization and exporting the virtio-ccw
> api) would make sense even independent of the ioeventfd enhancements.
> 
> Patches 3-5 are concerned with adding a new type of ioeventfds for
> virtio-ccw notifications on s390. The naming is now hopefully clearer.
> We won't add ioeventfd support for the legacy s390-virtio transport.
> 
> Please consider applying.

I just had a thought: this makes us lookup the device on the bus
for each notification. It would be better to simply get the
device index from guest instead.

We could validate that it matches the correct device,
if not - fallback to the current linear scan.

We could return the index to guest for the next call.

I know this needs guest changes but it's still not too late to
fix this for 3.9 guests so that we won't need to worry
about compatibility going forward.

Hmm?

> v2 -> v3:
> - Added a patch exporting the virtio-ccw api and use it for the
>   diagnose implementation.
> - Better naming: We're dealing with virtio-ccw notifications only.
> v1 -> v2:
> - Move irqfd initialization from a module init function to kvm_init,
>   eliminating the need for a second module for kvm/s390.
> - Use kvm_io_device for s390 css devices.
> 
> Cornelia Huck (5):
>   KVM: Initialize irqfd from kvm_init().
>   KVM: s390: Export virtio-ccw api.
>   KVM: Introduce KVM_VIRTIO_CCW_NOTIFY_BUS.
>   KVM: ioeventfd for virtio-ccw devices.
>   KVM: s390: Wire up ioeventfd.
> 
>  Documentation/virtual/kvm/api.txt       |  8 ++++++++
>  arch/s390/include/uapi/asm/Kbuild       |  1 +
>  arch/s390/include/uapi/asm/virtio-ccw.h | 21 +++++++++++++++++++++
>  arch/s390/kvm/Kconfig                   |  1 +
>  arch/s390/kvm/Makefile                  |  2 +-
>  arch/s390/kvm/diag.c                    | 26 ++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c                |  1 +
>  drivers/s390/kvm/virtio_ccw.c           |  5 +----
>  include/linux/kvm_host.h                | 14 ++++++++++++++
>  include/uapi/linux/kvm.h                |  3 +++
>  virt/kvm/eventfd.c                      | 21 ++++++++++++++-------
>  virt/kvm/kvm_main.c                     |  6 ++++++
>  12 files changed, 97 insertions(+), 12 deletions(-)
>  create mode 100644 arch/s390/include/uapi/asm/virtio-ccw.h
> 
> -- 
> 1.7.12.4
