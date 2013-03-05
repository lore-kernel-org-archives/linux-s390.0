From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v5 0/6] kvm: Make ioeventfd usable on s390.
Date: Tue, 5 Mar 2013 19:14:58 -0300
Message-ID: <20130305221458.GA5477@amt.cnet>
References: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <1362051201-56541-1-git-send-email-cornelia.huck@de.ibm.com>
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

On Thu, Feb 28, 2013 at 12:33:15PM +0100, Cornelia Huck wrote:
> v5 of the ioeventfd patch set, this time with a proper return code
> from __diag_virtio_hypercall(), otherwise unchanged.
> 
> v4 -> v5:
> - Proper return code in __diag_virtio_hypercall()
> v3 -> v4:
> - Pass cookies in virtio-ccw notify hypercall
> - Coding style
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
>   KVM: s390: Export virtio-ccw api.
>   KVM: Initialize irqfd from kvm_init().
>   KVM: Introduce KVM_VIRTIO_CCW_NOTIFY_BUS.
>   KVM: ioeventfd for virtio-ccw devices.
>   KVM: s390: Wire up ioeventfd.
> 
> Michael S. Tsirkin (1):
>   virtio_ccw: pass a cookie value to kvm hypercall

Applied, thanks.
