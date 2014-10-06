Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Oct 2014 11:20:16 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 02/16] virtio: unify config_changed handling
Message-ID: <20141006112016.0227d0d3.cornelia.huck@de.ibm.com>
In-Reply-To: <1412525038-15871-3-git-send-email-mst@redhat.com>
References: <1412525038-15871-1-git-send-email-mst@redhat.com>
	<1412525038-15871-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Sudeep Dutt <sudeep.dutt@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nikhil Rao <nikhil.rao@intel.com>, Wolfram Sang <wsa@the-dreams.de>, Siva Yerramreddy <yshivakrishna@gmail.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, 5 Oct 2014 19:06:52 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Replace duplicated code in all transports with a single wrapper in
> virtio.c.
> 
> The only functional change is in virtio_mmio.c: if a buggy device sends
> us an interrupt before driver is set, we previously returned IRQ_NONE,
> now we return IRQ_HANDLED.
> 
> As this must not happen in practice, this does not look like a big deal.
> 
> See also commit 3fff0179e33cd7d0a688dab65700c46ad089e934
> 	virtio-pci: do not oops on config change if driver not loaded.
> for the original motivation behind the driver check.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/virtio.h             |  2 ++
>  drivers/misc/mic/card/mic_virtio.c |  6 +-----
>  drivers/s390/kvm/kvm_virtio.c      |  9 +--------
>  drivers/s390/kvm/virtio_ccw.c      |  6 +-----
>  drivers/virtio/virtio.c            | 10 ++++++++++
>  drivers/virtio/virtio_mmio.c       |  7 ++-----
>  drivers/virtio/virtio_pci.c        |  6 +-----
>  7 files changed, 18 insertions(+), 28 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
