From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] s390: Add new channel I/O based virtio
 transport.
Date: Wed, 8 Aug 2012 10:28:20 +0200
Message-ID: <20120808102820.799d3d9a@BR9GNB5Z>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
	<1344351173-2716-4-git-send-email-cornelia.huck@de.ibm.com>
	<CAAu8pHvt+17+EF=k7ZOx1bKpO=33PVXfBNQJWzNpYmqKkhR1ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAAu8pHvt+17+EF=k7ZOx1bKpO=33PVXfBNQJWzNpYmqKkhR1ZQ@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 7 Aug 2012 20:47:22 +0000
Blue Swirl <blauwirbel@gmail.com> wrote:


> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > new file mode 100644
> > index 0000000..8a90c3a
> > --- /dev/null
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -0,0 +1,962 @@
> > +/*
> > + * virtio ccw target implementation
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> > + * your option) any later version. See the COPYING file in the top-level
> > + * directory.
> > + */
> > +
> > +#include <hw/hw.h>
> > +#include "block.h"
> > +#include "blockdev.h"
> > +#include "sysemu.h"
> > +#include "net.h"
> > +#include "monitor.h"
> > +#include "qemu-thread.h"
> > +#include "../virtio.h"
> > +#include "../virtio-serial.h"
> > +#include "../virtio-net.h"
> > +#include "../sysbus.h"
> 
> "hw/virtio..." for the above

OK.
> 
> > +#include "bitops.h"
> > +
> > +#include "ioinst.h"
> > +#include "css.h"
> > +#include "virtio-ccw.h"
> > +
> > +static const TypeInfo virtio_ccw_bus_info = {
> > +    .name = TYPE_VIRTIO_CCW_BUS,
> > +    .parent = TYPE_BUS,
> > +    .instance_size = sizeof(VirtioCcwBus),
> > +};
> > +
> > +static const VirtIOBindings virtio_ccw_bindings;
> > +
> > +typedef struct sch_entry {
> > +    SubchDev *sch;
> > +    QLIST_ENTRY(sch_entry) entry;
> > +} sch_entry;
> 
> SubchEntry, see CODING_STYLE. Also other struct and typedef names below.
> 
> > +
> > +QLIST_HEAD(subch_list, sch_entry);
> 
> static, but please put this to a structure that is passed around instead.
> 
> > +
> > +typedef struct devno_entry {
> > +    uint16_t devno;
> > +    QLIST_ENTRY(devno_entry) entry;
> > +} devno_entry;
> > +
> > +QLIST_HEAD(devno_list, devno_entry);
> 
> Ditto
> 
> > +
> > +struct subch_set {
> > +    struct subch_list *s_list[256];
> > +    struct devno_list *d_list[256];
> > +};
> > +
> > +struct css_set {
> > +    struct subch_set *set[MAX_SSID + 1];
> > +};
> > +
> > +static struct css_set *channel_subsys[MAX_CSSID + 1];

OK, will try to come up with some kind of structure for this and
CamelCasify it.

> > +
> > +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
> > +{
> > +    VirtIODevice *vdev = NULL;
> > +
> > +    if (sch->driver_data) {
> > +        vdev = ((VirtioCcwData *)sch->driver_data)->vdev;
> > +    }
> > +    return vdev;
> > +}
> > +

> > +VirtioCcwBus *virtio_ccw_bus_init(void)
> > +{
> > +    VirtioCcwBus *bus;
> > +    BusState *_bus;
> 
> Please avoid identifiers with leading underscores.

OK.

> 
> > +    DeviceState *dev;
> > +
> > +    css_set_subch_cb(virtio_ccw_find_subch);
> > +
> > +    /* Create bridge device */
> > +    dev = qdev_create(NULL, "virtio-ccw-bridge");
> > +    qdev_init_nofail(dev);
> > +
> > +    /* Create bus on bridge device */
> > +    _bus = qbus_create(TYPE_VIRTIO_CCW_BUS, dev, "virtio-ccw");
> > +    bus = DO_UPCAST(VirtioCcwBus, bus, _bus);
> > +
> > +    /* Enable hotplugging */
> > +    _bus->allow_hotplug = 1;
> > +
> > +    return bus;
> > +}
> > +
> > +struct vq_info_block {
> > +    uint64_t queue;
> > +    uint16_t num;
> > +} QEMU_PACKED;
> > +
> > +struct vq_config_block {
> > +    uint16_t index;
> > +    uint16_t num;
> > +} QEMU_PACKED;
> 
> Aren't these KVM structures? They should be defined in a KVM header
> file file in linux-headers.

Not really, virtio-ccw isn't tied to kvm.

I see this more as command blocks that are specific to the "control
unit" - like something that would be defined in an attachment
specification for a classic s390 device (and in the virtio spec in this
case) and modeled as C structures here.

> 

> > +    case CCW_CMD_WRITE_CONF:
> > +        if (check_len) {
> > +            if (ccw->count > data->vdev->config_len) {
> > +                ret = -EINVAL;
> > +                break;
> > +            }
> > +        }
> > +        len = MIN(ccw->count, data->vdev->config_len);
> > +        config = qemu_get_ram_ptr(ccw->cda);
> 
> Please use cpu_physical_memory_read() (or DMA versions) instead of
> this + memcpy().

Will check.
> 
> > +        if (!config) {
> > +            ret = -EFAULT;
> > +        } else {
> > +            memcpy(data->vdev->config, config, len);
> > +            if (data->vdev->set_config) {
> > +                data->vdev->set_config(data->vdev, data->vdev->config);
> > +            }
> > +            sch->curr_status.scsw.count = ccw->count - len;
> > +            ret = 0;
> > +        }
> > +        break;

> > +    case CCW_CMD_READ_VQ_CONF:
> > +        if (check_len) {
> > +            if (ccw->count != sizeof(vq_config)) {
> > +                ret = -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw->count < sizeof(vq_config)) {
> > +            /* Can't execute command. */
> > +            ret = -EINVAL;
> > +            break;
> > +        }
> > +        if (!qemu_get_ram_ptr(ccw->cda)) {
> > +            ret = -EFAULT;
> > +        } else {
> > +            vq_config.index = lduw_phys(ccw->cda);
> 
> lduw_{b,l}e_phys()
> 
> > +            vq_config.num = virtio_queue_get_num(data->vdev, vq_config.index);
> > +            stw_phys(ccw->cda + sizeof(vq_config.index), vq_config.num);
> 
> stw_{b,l]e_phys(), likewise elsewhere.


Will check as well.
> 
> > +            sch->curr_status.scsw.count = ccw->count - sizeof(vq_config);
> > +            ret = 0;
> > +        }
> > +        break;
> > +    default:
> > +        ret = -EOPNOTSUPP;
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
