From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/6] virtio: add context flag to find vqs
Date: Thu, 30 Mar 2017 09:17:31 +0200
Message-ID: <20170330091731.1b54a2e1.cornelia.huck@de.ibm.com>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
        <1490820507-8005-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1490820507-8005-3-git-send-email-mst@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, John Fastabend <john.fastabend@gmail.com>, Sudeep Dutt <sudeep.dutt@intel.com>, virtualization@lists.linux-foundation.org, Ashutosh Dixit <ashutosh.dixit@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 29 Mar 2017 23:48:51 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Allows maintaining extra context per vq.  For ease of use, passing in
> NULL is legal and disables the feature for all vqs.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/misc/mic/vop/vop_main.c    |  9 ++++++---
>  drivers/s390/virtio/kvm_virtio.c   |  6 ++++--
>  drivers/s390/virtio/virtio_ccw.c   |  7 ++++---
>  drivers/virtio/virtio_mmio.c       |  8 +++++---
>  drivers/virtio/virtio_pci_common.c | 18 +++++++++++-------
>  drivers/virtio/virtio_pci_common.h |  4 +++-
>  drivers/virtio/virtio_pci_legacy.c |  4 +++-
>  drivers/virtio/virtio_pci_modern.c | 12 ++++++++----
>  drivers/virtio/virtio_ring.c       |  7 +++++--
>  include/linux/virtio_config.h      | 18 +++++++++++++++---
>  include/linux/virtio_ring.h        |  3 +++
>  11 files changed, 67 insertions(+), 29 deletions(-)

This series really needs a cover letter, explaining the motivation for
adding this context.

From what I understand, you want to track some length parameter in
virtio-net. As you don't use indirect descriptors in that case, you
want to use a context instead. Did I get this correctly?
