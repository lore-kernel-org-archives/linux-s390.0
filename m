From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v3 4/5] KVM: ioeventfd for virtio-ccw
 devices.
Date: Tue, 26 Feb 2013 15:47:08 +0100
Message-ID: <20130226154708.12fbe3bf@gondolin>
References: <1361806070-62465-1-git-send-email-cornelia.huck@de.ibm.com>
	<1361806070-62465-5-git-send-email-cornelia.huck@de.ibm.com>
	<20130226105536.GA10915@redhat.com>
	<20130226142052.GB7828@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20130226142052.GB7828@stefanha-thinkpad.redhat.com>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Carsten Otte <cotte@de.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Feb 2013 15:20:52 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Feb 26, 2013 at 12:55:36PM +0200, Michael S. Tsirkin wrote:
> > On Mon, Feb 25, 2013 at 04:27:49PM +0100, Cornelia Huck wrote:
> > > diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> > > index f0ced1a..8de3cd7 100644
> > > --- a/virt/kvm/eventfd.c
> > > +++ b/virt/kvm/eventfd.c
> > > @@ -679,11 +679,16 @@ static int
> > >  kvm_assign_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
> > >  {
> > >  	int                       pio = args->flags & KVM_IOEVENTFD_FLAG_PIO;
> > > -	enum kvm_bus              bus_idx = pio ? KVM_PIO_BUS : KVM_MMIO_BUS;
> > > +	int                       ccw;
> > > +	enum kvm_bus              bus_idx;
> > >  	struct _ioeventfd        *p;
> > >  	struct eventfd_ctx       *eventfd;
> > >  	int                       ret;
> > >  
> > > +	ccw = args->flags & KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY;
> > > +	bus_idx = pio ? KVM_PIO_BUS :
> > > +		ccw ? KVM_VIRTIO_CCW_NOTIFY_BUS :
> > > +		KVM_MMIO_BUS;
> > 
> > May be better to rewrite using if/else.
> 
> Saw this after sending my comment.  I agree with Michael, an if
> statement allows you to drop the locals and capture the bus_idx
> conversion in a single place (it could even be a static function to save
> duplicating the code in both functions that use it).
> 
> Stefan
> 

Introducing a helper function sounds reasonable.
