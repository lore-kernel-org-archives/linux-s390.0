From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/6] virtio: add context flag to find vqs
Date: Thu, 30 Mar 2017 17:57:59 +0300
Message-ID: <20170330175726-mutt-send-email-mst@kernel.org>
References: <1490820507-8005-1-git-send-email-mst@redhat.com>
	<1490820507-8005-3-git-send-email-mst@redhat.com>
	<20170330091731.1b54a2e1.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170330091731.1b54a2e1.cornelia.huck@de.ibm.com>
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
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, John Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Mar 30, 2017 at 09:17:31AM +0200, Cornelia Huck wrote:
> On Wed, 29 Mar 2017 23:48:51 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Allows maintaining extra context per vq.  For ease of use, passing in
> > NULL is legal and disables the feature for all vqs.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/misc/mic/vop/vop_main.c    |  9 ++++++---
> >  drivers/s390/virtio/kvm_virtio.c   |  6 ++++--
> >  drivers/s390/virtio/virtio_ccw.c   |  7 ++++---
> >  drivers/virtio/virtio_mmio.c       |  8 +++++---
> >  drivers/virtio/virtio_pci_common.c | 18 +++++++++++-------
> >  drivers/virtio/virtio_pci_common.h |  4 +++-
> >  drivers/virtio/virtio_pci_legacy.c |  4 +++-
> >  drivers/virtio/virtio_pci_modern.c | 12 ++++++++----
> >  drivers/virtio/virtio_ring.c       |  7 +++++--
> >  include/linux/virtio_config.h      | 18 +++++++++++++++---
> >  include/linux/virtio_ring.h        |  3 +++
> >  11 files changed, 67 insertions(+), 29 deletions(-)
> 
> This series really needs a cover letter, explaining the motivation for
> adding this context.

True. Will try to improve that for v2.

> From what I understand, you want to track some length parameter in
> virtio-net. As you don't use indirect descriptors in that case, you
> want to use a context instead. Did I get this correctly?

Exactly.

-- 
MST
