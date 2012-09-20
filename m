From: Jens Freimann <jfrei@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/5] s390: Add new channel I/O based
 virtio transport.
Date: Thu, 20 Sep 2012 09:39:40 +0200
Message-ID: <20120920073940.GB12978@chuck.boeblingen.de.ibm.com>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771633-53081-4-git-send-email-cornelia.huck@de.ibm.com>
	<92A64BAD-77EB-4A7A-A310-B9AB55989446@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
Content-Disposition: inline
In-Reply-To: <92A64BAD-77EB-4A7A-A310-B9AB55989446@suse.de>
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
To: Alexander Graf <agraf@suse.de>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Sep 19, 2012 at 06:12:55PM +0200, Alexander Graf wrote:
> Just a really quick glimpse. This patch is huge :).
> 
> On 04.09.2012, at 17:13, Cornelia Huck wrote:
> 
> > Add a new virtio transport that uses channel commands to perform
> > virtio operations.
> > 
> > Add a new machine type s390-ccw that uses this virtio-ccw transport
> > and make it the default machine for s390.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > 
> > Changes v1->v2:
> > - update to virtio-ccw interface changes
> > 
> > ---
> > hw/qdev-monitor.c      |   5 +
> > hw/s390-virtio.c       | 277 ++++++++++++----
> > hw/s390x/Makefile.objs |   1 +
> > hw/s390x/css.c         |  45 +++
> > hw/s390x/css.h         |   3 +
> > hw/s390x/virtio-ccw.c  | 875 +++++++++++++++++++++++++++++++++++++++++++++++++
> > hw/s390x/virtio-ccw.h  |  79 +++++
> > vl.c                   |   1 +
> > 8 files changed, 1215 insertions(+), 71 deletions(-)
> > create mode 100644 hw/s390x/virtio-ccw.c
> > create mode 100644 hw/s390x/virtio-ccw.h
> > 
> > diff --git a/hw/qdev-monitor.c b/hw/qdev-monitor.c
> > index 33b7f79..92b7c59 100644
> > --- a/hw/qdev-monitor.c
> > +++ b/hw/qdev-monitor.c
> > @@ -42,6 +42,11 @@ static const QDevAlias qdev_alias_table[] = {
> >     { "virtio-blk-s390", "virtio-blk", QEMU_ARCH_S390X },
> >     { "virtio-net-s390", "virtio-net", QEMU_ARCH_S390X },
> >     { "virtio-serial-s390", "virtio-serial", QEMU_ARCH_S390X },
> > +    { "virtio-blk-ccw", "virtio-blk", QEMU_ARCH_S390X },
> > +    { "virtio-net-ccw", "virtio-net", QEMU_ARCH_S390X },
> > +    { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_S390X },
> > +    { "virtio-balloon-ccw", "virtio-balloon", QEMU_ARCH_S390X },
> > +    { "virtio-scsi-ccw", "virtio-scsi", QEMU_ARCH_S390X },
> 
> How does this work? We want to default to virtio-xxx-pci on !s390, to virtio-xxx-s390 on the legacy machine and to virtio-xxx-ccw for the s390-ccw machine, right?

See patch 5. As you said, we need to find a nice way to solve this. 

> > [...]  
> > +
> > +static void virtio_ccw_notify(void *opaque, uint16_t vector)
> > +{
> > +    VirtioCcwData *dev = opaque;
> > +    SubchDev *sch = dev->sch;
> > +    uint64_t indicators;
> > +
> > +    if (vector >= VIRTIO_PCI_QUEUE_MAX) {
> > +        return;
> > +    }
> > +
> > +    qemu_mutex_lock(&sch->mutex);
> 
> Why do you need this lock?

The locks are probably a leftover from an earlier version where Conny used
a separate thread for subchannel work. We will double check if the lock would
be needed when the big QEMU lock is gone and, if yes, leave a comment in the code 
as a reminder.

Jens
