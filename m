From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2 3/5] s390: Add new channel I/O based virtio
 transport.
Date: Tue, 18 Dec 2012 15:58:42 +0100
Message-ID: <20121218155842.5ac3c4ee@gondolin>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771633-53081-4-git-send-email-cornelia.huck@de.ibm.com>
	<50D02D27.6070604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50D02D27.6070604@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 18 Dec 2012 09:45:27 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Il 04/09/2012 17:13, Cornelia Huck ha scritto:
> > +VirtioCcwBus *virtio_ccw_bus_init(void)
> > +{
> > +    VirtioCcwBus *cbus;
> > +    BusState *bus;
> > +    DeviceState *dev;
> > +
> > +    /* Create bridge device */
> > +    dev = qdev_create(NULL, "virtio-ccw-bridge");
> > +    qdev_init_nofail(dev);
> > +
> > +    /* Create bus on bridge device */
> > +    bus = qbus_create(TYPE_VIRTIO_CCW_BUS, dev, "virtio-ccw");
> > +    cbus = DO_UPCAST(VirtioCcwBus, bus, bus);
> > +
> > +    /* Enable hotplugging */
> > +    bus->allow_hotplug = 1;
> > +
> > +    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
> 
> Please use qdev device-reset and bus-reset callbacks instead of this.

Will do for the next version.
> 
> In particular, when writing the status you should call
> qdev_reset_all(DEVICE(sch)), and whatever state should be reset will
> have to be cleared by the device-reset callback of SubchDev, including
> calling virtio_reset.

With "writing the status" you mean "the guest sets the status to 0",
right?

> 
> Everything else will be cleared instead by the bus-reset callback of
> virtio-ccw-bus, similar to what you are doing in
> virtio_ccw_reset_subchannels.

Looking at the reset handler, css_reset() is a bit oddly placed, as it
doesn't really have anything to do with virtio-ccw; virtio-ccw is just
the only current creator of channel subsystem images. I'll try to come
up with a better model.

> 
> Paolo
> 
> 
> > +    return cbus;
> > +}
> 
