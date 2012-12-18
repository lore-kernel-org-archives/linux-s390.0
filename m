From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/5] s390: Add new channel I/O based
	virtio transport.
Date: Tue, 18 Dec 2012 16:01:34 +0100
Message-ID: <50D0854E.5030509@redhat.com>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
	<1346771633-53081-4-git-send-email-cornelia.huck@de.ibm.com>
	<50D02D27.6070604@redhat.com> <20121218155842.5ac3c4ee@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20121218155842.5ac3c4ee@gondolin>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, KVM <kvm@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 18/12/2012 15:58, Cornelia Huck ha scritto:
> On Tue, 18 Dec 2012 09:45:27 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> Il 04/09/2012 17:13, Cornelia Huck ha scritto:
>>> +VirtioCcwBus *virtio_ccw_bus_init(void)
>>> +{
>>> +    VirtioCcwBus *cbus;
>>> +    BusState *bus;
>>> +    DeviceState *dev;
>>> +
>>> +    /* Create bridge device */
>>> +    dev = qdev_create(NULL, "virtio-ccw-bridge");
>>> +    qdev_init_nofail(dev);
>>> +
>>> +    /* Create bus on bridge device */
>>> +    bus = qbus_create(TYPE_VIRTIO_CCW_BUS, dev, "virtio-ccw");
>>> +    cbus = DO_UPCAST(VirtioCcwBus, bus, bus);
>>> +
>>> +    /* Enable hotplugging */
>>> +    bus->allow_hotplug = 1;
>>> +
>>> +    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
>>
>> Please use qdev device-reset and bus-reset callbacks instead of this.
> 
> Will do for the next version.
>>
>> In particular, when writing the status you should call
>> qdev_reset_all(DEVICE(sch)), and whatever state should be reset will
>> have to be cleared by the device-reset callback of SubchDev, including
>> calling virtio_reset.
> 
> With "writing the status" you mean "the guest sets the status to 0",
> right?

Yes.

Paolo

>> Everything else will be cleared instead by the bus-reset callback of
>> virtio-ccw-bus, similar to what you are doing in
>> virtio_ccw_reset_subchannels.
> 
> Looking at the reset handler, css_reset() is a bit oddly placed, as it
> doesn't really have anything to do with virtio-ccw; virtio-ccw is just
> the only current creator of channel subsystem images. I'll try to come
> up with a better model.
> 
>>
>> Paolo
>>
>>
>>> +    return cbus;
>>> +}
>>
> 
