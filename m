From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/5] s390: Add new channel I/O based virtio transport.
Date: Thu, 9 Aug 2012 14:12:48 +0200
Message-ID: <20120809141248.00080419@BR9GNB5Z>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-4-git-send-email-cornelia.huck@de.ibm.com>
	<CAJSP0QX+tv46xjqFAhQ6XZcF6OkqSs+9EbyF2wktq-rquBBNVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAJSP0QX+tv46xjqFAhQ6XZcF6OkqSs+9EbyF2wktq-rquBBNVA@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 9 Aug 2012 12:34:04 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Aug 7, 2012 at 3:52 PM, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> > Add a new virtio transport that uses channel commands to perform
> > virtio operations.
> >
> > Add a new machine type s390-ccw that uses this virtio-ccw transport
> > and make it the default machine for s390.
> >
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/qdev-monitor.c      |   5 +
> >  hw/s390-virtio.c       | 268 ++++++++++----
> >  hw/s390x/Makefile.objs |   1 +
> >  hw/s390x/virtio-ccw.c  | 962 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/s390x/virtio-ccw.h  |  77 ++++
> >  vl.c                   |   1 +
> >  6 files changed, 1243 insertions(+), 71 deletions(-)
> >  create mode 100644 hw/s390x/virtio-ccw.c
> >  create mode 100644 hw/s390x/virtio-ccw.h
> 
> Is the virtqueue still using vring and assuming the hypervisor reaches
> into guest memory?

The virtqueues are guest-allocated and their location is transmitted
via a control-type ccw to the host, which can then use it until
notified otherwise.

> 
> Can existing ccw device types access memory directly (for some reason
> I assumed ccw always copies or send messages)?

Not sure if I understand your question correctly, but read or write
type ccws specify a memory area where the hardware/hypervisor may write
to or read from. These accesses happen while the channel program is
running (any time between the ssch/rsch and ending status present at
the subchannel). The "specify an area that can be used by hardware and
os" approach exists as well; the closed thing to the virtio-ccw
approach is probably qdio.
