From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 08/11] s390: Add new channel I/O based
 virtio transport.
Date: Thu, 24 Jan 2013 15:35:16 +0100
Message-ID: <20130124153516.5742fad2@gondolin>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
	<1359030491-46725-9-git-send-email-cornelia.huck@de.ibm.com>
	<51013492.9070703@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <51013492.9070703@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, Gleb Natapov <gleb@redhat.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 24 Jan 2013 14:18:10 +0100
Andreas F=C3=A4rber <afaerber@suse.de> wrote:

> Am 24.01.2013 13:28, schrieb Cornelia Huck:
> > Add a new virtio transport that uses channel commands to perform
> > virtio operations.
> >=20
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >=20
> > ---
> >=20
> > v5 -> v6:
> > - Get rid of qemu_get_ram_ptr usage
> > - Adapt to virtual css changes
> > - Constify TypeInfos
> > - Prepare for VirtioBus
> > ---
> >  hw/s390x/Makefile.objs |   1 +
> >  hw/s390x/virtio-ccw.c  | 947 +++++++++++++++++++++++++++++++++++++=
++++++++++++
> >  hw/s390x/virtio-ccw.h  |  94 +++++
> >  trace-events           |   4 +
> >  4 files changed, 1046 insertions(+)
> >  create mode 100644 hw/s390x/virtio-ccw.c
> >  create mode 100644 hw/s390x/virtio-ccw.h
> >=20
> > diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> > index ab99da6..f6b461b 100644
> > --- a/hw/s390x/Makefile.objs
> > +++ b/hw/s390x/Makefile.objs
> > @@ -7,3 +7,4 @@ obj-y +=3D event-facility.o
> >  obj-y +=3D sclpquiesce.o sclpconsole.o
> >  obj-y +=3D ipl.o
> >  obj-y +=3D css.o
> > +obj-y +=3D virtio-ccw.o
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > new file mode 100644
> > index 0000000..58f9982
> > --- /dev/null
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -0,0 +1,947 @@
> > +/*
> > + * virtio ccw target implementation
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2=
 or (at
> > + * your option) any later version. See the COPYING file in the top=
-level
> > + * directory.
> > + */
> > +
> > +#include <hw/hw.h>
>=20
> "hw/hw.h"?

ok

>=20
> > +#include "block/block.h"
> > +#include "sysemu/blockdev.h"
> > +#include "sysemu/sysemu.h"
> > +#include "net/net.h"
> > +#include "monitor/monitor.h"
> > +#include "hw/virtio.h"
> > +#include "hw/virtio-serial.h"
> > +#include "hw/virtio-net.h"
> > +#include "hw/sysbus.h"
> > +#include "qemu/bitops.h"
> > +#include "hw/virtio-bus.h"
> > +
> > +#include "ioinst.h"
> > +#include "css.h"
> > +#include "virtio-ccw.h"
> > +#include "trace.h"
> > +
> > +static const TypeInfo virtual_css_bus_info =3D {
> > +    .name =3D TYPE_VIRTUAL_CSS_BUS,
> > +    .parent =3D TYPE_BUS,
> > +    .instance_size =3D sizeof(VirtualCssBus),
> > +};
> > +
> > +static const VirtIOBindings virtio_ccw_bindings;
> > +
> > +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
> > +{
> > +    VirtIODevice *vdev =3D NULL;
> > +
> > +    if (sch->driver_data) {
> > +        vdev =3D ((VirtioCcwData *)sch->driver_data)->vdev;
> > +    }
> > +    return vdev;
> > +}
> > +
> > +static void virtio_ccw_reset_subchannels(void *opaque)
> > +{
> > +    VirtualCssBus *bus =3D opaque;
> > +    BusChild *kid;
> > +    VirtioCcwData *data;
> > +    BusState *parent =3D BUS(bus);
> > +
> > +    QTAILQ_FOREACH(kid, &parent->children, sibling) {
> > +        data =3D (VirtioCcwData *)kid->child;
> > +        virtio_reset(data->vdev);
> > +        css_reset_sch(data->sch);
> > +    }
> > +    css_reset();
> > +}
> > +
> > +VirtualCssBus *virtual_css_bus_init(void)
> > +{
> > +    VirtualCssBus *cbus;
> > +    BusState *bus;
> > +    DeviceState *dev;
> > +
> > +    /* Create bridge device */
> > +    dev =3D qdev_create(NULL, "virtual-css-bridge");
> > +    qdev_init_nofail(dev);
> > +
> > +    /* Create bus on bridge device */
> > +    bus =3D qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
> > +    cbus =3D VIRTUAL_CSS_BUS(bus);
> > +
> > +    /* Enable hotplugging */
> > +    bus->allow_hotplug =3D 1;
> > +
> > +    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
>=20
> Can't this be done via BusClass::reset? (requires reordering before
> TypeInfo / class_init)

This got lost somewhere during my rebasing, I'll re-add.

>=20
> > +    return cbus;
> > +}
> > +
> > +/* Communication blocks used by several channel commands. */
> > +typedef struct VqInfoBlock {
> > +    uint64_t queue;
> > +    uint32_t align;
> > +    uint16_t index;
> > +    uint16_t num;
> > +} QEMU_PACKED VqInfoBlock;
> > +
> > +typedef struct VqConfigBlock {
> > +    uint16_t index;
> > +    uint16_t num_max;
> > +} QEMU_PACKED VqConfigBlock;
> > +
> > +typedef struct VirtioFeatDesc {
> > +    uint32_t features;
> > +    uint8_t index;
> > +} QEMU_PACKED VirtioFeatDesc;
> > +
> > +/* Specify where the virtqueues for the subchannel are in guest me=
mory. */
> > +static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32=
_t align,
> > +                              uint16_t index, uint16_t num)
> > +{
> > +    VirtioCcwData *data =3D sch->driver_data;
> > +
> > +    if (index > VIRTIO_PCI_QUEUE_MAX) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    /* Current code in virtio.c relies on 4K alignment. */
> > +    if (addr && (align !=3D 4096)) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    if (!data) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    virtio_queue_set_addr(data->vdev, index, addr);
> > +    if (!addr) {
> > +        virtio_queue_set_vector(data->vdev, index, 0);
> > +    } else {
> > +        /* Fail if we don't have a big enough queue. */
> > +        /* TODO: Add interface to handle vring.num changing */
> > +        if (virtio_queue_get_num(data->vdev, index) > num) {
> > +            return -EINVAL;
> > +        }
> > +        virtio_queue_set_vector(data->vdev, index, index);
> > +    }
> > +    /* tell notify handler in case of config change */
> > +    data->vdev->config_vector =3D VIRTIO_PCI_QUEUE_MAX;
> > +    return 0;
> > +}
> > +
> > +static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
> > +{
> > +    int ret;
> > +    VqInfoBlock info;
> > +    uint8_t status;
> > +    VirtioFeatDesc features;
> > +    void *config;
> > +    hwaddr indicators;
> > +    VqConfigBlock vq_config;
> > +    VirtioCcwData *data =3D sch->driver_data;
> > +    bool check_len;
> > +    int len;
> > +    hwaddr hw_len;
> > +
> > +    if (!data) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    trace_virtio_ccw_interpret_ccw(sch->cssid, sch->ssid, sch->sch=
id,
> > +                                   ccw.cmd_code);
> > +    check_len =3D !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CC=
W_FLAG_DC));
> > +
> > +    /* Look at the command. */
> > +    switch (ccw.cmd_code) {
> > +    case CCW_CMD_SET_VQ:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(info)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(info)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            info.queue =3D ldq_phys(ccw.cda);
> > +            info.align =3D ldl_phys(ccw.cda + sizeof(info.queue));
> > +            info.index =3D lduw_phys(ccw.cda + sizeof(info.queue)
> > +                                   + sizeof(info.align));
> > +            info.num =3D lduw_phys(ccw.cda + sizeof(info.queue)
> > +                                 + sizeof(info.align)
> > +                                 + sizeof(info.index));
> > +            ret =3D virtio_ccw_set_vqs(sch, info.queue, info.align=
, info.index,
> > +                                     info.num);
> > +            sch->curr_status.scsw.count =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_VDEV_RESET:
> > +        virtio_reset(data->vdev);
> > +        ret =3D 0;
> > +        break;
> > +    case CCW_CMD_READ_FEAT:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(features)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(features)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            features.index =3D ldub_phys(ccw.cda + sizeof(features=
=2Efeatures));
> > +            if (features.index < ARRAY_SIZE(data->host_features)) =
{
> > +                features.features =3D data->host_features[features=
=2Eindex];
> > +            } else {
> > +                /* Return zeroes if the guest supports more featur=
e bits. */
> > +                features.features =3D 0;
> > +            }
> > +            stl_le_phys(ccw.cda, features.features);
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(fea=
tures);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_WRITE_FEAT:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(features)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(features)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            features.index =3D ldub_phys(ccw.cda + sizeof(features=
=2Efeatures));
> > +            features.features =3D ldl_le_phys(ccw.cda);
> > +            if (features.index < ARRAY_SIZE(data->host_features)) =
{
> > +                if (data->vdev->set_features) {
> > +                    data->vdev->set_features(data->vdev, features.=
features);
> > +                }
> > +                data->vdev->guest_features =3D features.features;
> > +            } else {
> > +                /*
> > +                 * If the guest supports more feature bits, assert=
 that it
> > +                 * passes us zeroes for those we don't support.
> > +                 */
> > +                if (features.features) {
> > +                    fprintf(stderr, "Guest bug: features[%i]=3D%x =
(expected 0)\n",
> > +                            features.index, features.features);
> > +                    /* XXX: do a unit check here? */
> > +                }
> > +            }
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(fea=
tures);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_READ_CONF:
> > +        if (check_len) {
> > +            if (ccw.count > data->vdev->config_len) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        }
> > +        len =3D MIN(ccw.count, data->vdev->config_len);
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            data->vdev->get_config(data->vdev, data->vdev->config)=
;
> > +            /* XXX config space endianness */
> > +            cpu_physical_memory_write(ccw.cda, data->vdev->config,=
 len);
> > +            sch->curr_status.scsw.count =3D ccw.count - len;
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_WRITE_CONF:
> > +        if (check_len) {
> > +            if (ccw.count > data->vdev->config_len) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        }
> > +        len =3D MIN(ccw.count, data->vdev->config_len);
> > +        hw_len =3D len;
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            config =3D cpu_physical_memory_map(ccw.cda, &hw_len, 0=
);
> > +            if (!config) {
> > +                ret =3D -EFAULT;
> > +            } else {
> > +                len =3D hw_len;
> > +                /* XXX config space endianness */
> > +                memcpy(data->vdev->config, config, len);
> > +                cpu_physical_memory_unmap(config, hw_len, 0, hw_le=
n);
> > +                if (data->vdev->set_config) {
> > +                    data->vdev->set_config(data->vdev, data->vdev-=
>config);
> > +                }
> > +                sch->curr_status.scsw.count =3D ccw.count - len;
> > +                ret =3D 0;
> > +            }
> > +        }
> > +        break;
> > +    case CCW_CMD_WRITE_STATUS:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(status)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(status)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            status =3D ldub_phys(ccw.cda);
> > +            virtio_set_status(data->vdev, status);
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(sta=
tus);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_SET_IND:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(indicators)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(indicators)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        indicators =3D ldq_phys(ccw.cda);
> > +        if (!indicators) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            data->indicators =3D indicators;
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(ind=
icators);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_SET_CONF_IND:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(indicators)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(indicators)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        indicators =3D ldq_phys(ccw.cda);
> > +        if (!indicators) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            data->indicators2 =3D indicators;
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(ind=
icators);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    case CCW_CMD_READ_VQ_CONF:
> > +        if (check_len) {
> > +            if (ccw.count !=3D sizeof(vq_config)) {
> > +                ret =3D -EINVAL;
> > +                break;
> > +            }
> > +        } else if (ccw.count < sizeof(vq_config)) {
> > +            /* Can't execute command. */
> > +            ret =3D -EINVAL;
> > +            break;
> > +        }
> > +        if (!ccw.cda) {
> > +            ret =3D -EFAULT;
> > +        } else {
> > +            vq_config.index =3D lduw_phys(ccw.cda);
> > +            vq_config.num_max =3D virtio_queue_get_num(data->vdev,
> > +                                                     vq_config.ind=
ex);
> > +            stw_phys(ccw.cda + sizeof(vq_config.index), vq_config.=
num_max);
> > +            sch->curr_status.scsw.count =3D ccw.count - sizeof(vq_=
config);
> > +            ret =3D 0;
> > +        }
> > +        break;
> > +    default:
> > +        ret =3D -EOPNOTSUPP;
> > +        break;
> > +    }
> > +    return ret;
> > +}
> > +
> > +static int virtio_ccw_device_init(VirtioCcwData *dev, VirtIODevice=
 *vdev)
> > +{
> > +    unsigned int cssid =3D 0;
> > +    unsigned int ssid =3D 0;
> > +    unsigned int schid;
> > +    unsigned int devno;
> > +    bool have_devno =3D false;
> > +    bool found =3D false;
> > +    SubchDev *sch;
> > +    int ret;
> > +    int num;
> > +    DeviceState *parent =3D DEVICE(dev);
> > +
> > +    sch =3D g_malloc0(sizeof(SubchDev));
> > +
> > +    sch->driver_data =3D dev;
> > +    dev->sch =3D sch;
> > +
> > +    dev->vdev =3D vdev;
> > +    dev->indicators =3D 0;
> > +
> > +    /* Initialize subchannel structure. */
> > +    sch->channel_prog =3D 0x0;
> > +    sch->last_cmd_valid =3D false;
> > +    sch->orb =3D NULL;
> > +    /*
> > +     * Use a device number if provided. Otherwise, fall back to su=
bchannel
> > +     * number.
> > +     */
> > +    if (dev->bus_id) {
> > +        num =3D sscanf(dev->bus_id, "%x.%x.%04x", &cssid, &ssid, &=
devno);
> > +        if (num =3D=3D 3) {
> > +            if ((cssid > MAX_CSSID) || (ssid > MAX_SSID)) {
> > +                ret =3D -EINVAL;
> > +                error_report("Invalid cssid or ssid: cssid %x, ssi=
d %x",
> > +                             cssid, ssid);
> > +                goto out_err;
> > +            }
> > +            /* Enforce use of virtual cssid. */
> > +            if (cssid !=3D VIRTUAL_CSSID) {
> > +                ret =3D -EINVAL;
> > +                error_report("cssid %x not valid for virtio device=
s", cssid);
> > +                goto out_err;
> > +            }
> > +            if (css_devno_used(cssid, ssid, devno)) {
> > +                ret =3D -EEXIST;
> > +                error_report("Device %x.%x.%04x already exists", c=
ssid, ssid,
> > +                             devno);
> > +                goto out_err;
> > +            }
> > +            sch->cssid =3D cssid;
> > +            sch->ssid =3D ssid;
> > +            sch->devno =3D devno;
> > +            have_devno =3D true;
> > +        } else {
> > +            ret =3D -EINVAL;
> > +            error_report("Malformed devno parameter '%s'", dev->bu=
s_id);
> > +            goto out_err;
> > +        }
> > +    }
> > +
> > +    /* Find the next free id. */
> > +    if (have_devno) {
> > +        for (schid =3D 0; schid <=3D MAX_SCHID; schid++) {
> > +            if (!css_find_subch(1, cssid, ssid, schid)) {
> > +                sch->schid =3D schid;
> > +                css_subch_assign(cssid, ssid, schid, devno, sch);
> > +                found =3D true;
> > +                break;
> > +            }
> > +        }
> > +        if (!found) {
> > +            ret =3D -ENODEV;
> > +            error_report("No free subchannel found for %x.%x.%04x"=
, cssid, ssid,
> > +                         devno);
> > +            goto out_err;
> > +        }
> > +        trace_virtio_ccw_new_device(cssid, ssid, schid, devno,
> > +                                    "user-configured");
> > +    } else {
> > +        cssid =3D VIRTUAL_CSSID;
> > +        for (ssid =3D 0; ssid <=3D MAX_SSID; ssid++) {
> > +            for (schid =3D 0; schid <=3D MAX_SCHID; schid++) {
> > +                if (!css_find_subch(1, cssid, ssid, schid)) {
> > +                    sch->cssid =3D cssid;
> > +                    sch->ssid =3D ssid;
> > +                    sch->schid =3D schid;
> > +                    devno =3D schid;
> > +                    /*
> > +                     * If the devno is already taken, look further=
 in this
> > +                     * subchannel set.
> > +                     */
> > +                    while (css_devno_used(cssid, ssid, devno)) {
> > +                        if (devno =3D=3D MAX_SCHID) {
> > +                            devno =3D 0;
> > +                        } else if (devno =3D=3D schid - 1) {
> > +                            ret =3D -ENODEV;
> > +                            error_report("No free devno found");
> > +                            goto out_err;
> > +                        } else {
> > +                            devno++;
> > +                        }
> > +                    }
> > +                    sch->devno =3D devno;
> > +                    css_subch_assign(cssid, ssid, schid, devno, sc=
h);
> > +                    found =3D true;
> > +                    break;
> > +                }
> > +            }
> > +            if (found) {
> > +                break;
> > +            }
> > +        }
> > +        if (!found) {
> > +            ret =3D -ENODEV;
> > +            error_report("Virtual channel subsystem is full!");
> > +            goto out_err;
> > +        }
> > +        trace_virtio_ccw_new_device(cssid, ssid, schid, devno,
> > +                                    "auto-configured");
> > +    }
> > +
> > +    /* Build initial schib. */
> > +    css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
> > +
> > +    sch->ccw_cb =3D virtio_ccw_cb;
> > +
> > +    /* Build senseid data. */
> > +    memset(&sch->id, 0, sizeof(SenseId));
> > +    sch->id.reserved =3D 0xff;
> > +    sch->id.cu_type =3D VIRTIO_CCW_CU_TYPE;
> > +    sch->id.cu_model =3D dev->vdev->device_id;
> > +
> > +    virtio_bind_device(vdev, &virtio_ccw_bindings, DEVICE(dev));
> > +    /* Only the first 32 feature bits are used. */
> > +    dev->host_features[0] =3D vdev->get_features(vdev, dev->host_f=
eatures[0]);
> > +    dev->host_features[0] |=3D 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
> > +    dev->host_features[0] |=3D 0x1 << VIRTIO_F_BAD_FEATURE;
> > +
> > +    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
> > +                          parent->hotplugged, 1);
> > +    return 0;
> > +
> > +out_err:
> > +    dev->sch =3D NULL;
> > +    g_free(sch);
> > +    return ret;
> > +}
> > +
> > +static int virtio_ccw_exit(VirtioCcwData *dev)
> > +{
> > +    SubchDev *sch =3D dev->sch;
> > +
> > +    if (sch) {
> > +        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->d=
evno, NULL);
> > +        g_free(sch);
> > +    }
> > +    dev->indicators =3D 0;
> > +    return 0;
> > +}
> > +
> > +static int virtio_ccw_net_init(VirtioCcwData *dev)
> > +{
> > +    VirtIODevice *vdev;
> > +
> > +    vdev =3D virtio_net_init((DeviceState *)dev, &dev->nic, &dev->=
net);
> > +    if (!vdev) {
> > +        return -1;
> > +    }
> > +
> > +    return virtio_ccw_device_init(dev, vdev);
> > +}
> > +
> > +static int virtio_ccw_net_exit(VirtioCcwData *dev)
> > +{
> > +    virtio_net_exit(dev->vdev);
> > +    return virtio_ccw_exit(dev);
> > +}
> > +
> > +static int virtio_ccw_blk_init(VirtioCcwData *dev)
> > +{
> > +    VirtIODevice *vdev;
> > +
> > +    vdev =3D virtio_blk_init((DeviceState *)dev, &dev->blk);
> > +    if (!vdev) {
> > +        return -1;
> > +    }
> > +
> > +    return virtio_ccw_device_init(dev, vdev);
> > +}
> > +
> > +static int virtio_ccw_blk_exit(VirtioCcwData *dev)
> > +{
> > +    virtio_blk_exit(dev->vdev);
> > +    blockdev_mark_auto_del(dev->blk.conf.bs);
> > +    return virtio_ccw_exit(dev);
> > +}
> > +
> > +static int virtio_ccw_serial_init(VirtioCcwData *dev)
> > +{
> > +    VirtIODevice *vdev;
> > +
> > +    vdev =3D virtio_serial_init((DeviceState *)dev, &dev->serial);
> > +    if (!vdev) {
> > +        return -1;
> > +    }
> > +
> > +    return virtio_ccw_device_init(dev, vdev);
> > +}
> > +
> > +static int virtio_ccw_serial_exit(VirtioCcwData *dev)
> > +{
> > +    virtio_serial_exit(dev->vdev);
> > +    return virtio_ccw_exit(dev);
> > +}
> > +
> > +static int virtio_ccw_balloon_init(VirtioCcwData *dev)
> > +{
> > +    VirtIODevice *vdev;
> > +
> > +    vdev =3D virtio_balloon_init((DeviceState *)dev);
> > +    if (!vdev) {
> > +        return -1;
> > +    }
> > +
> > +    return virtio_ccw_device_init(dev, vdev);
> > +}
> > +
> > +static int virtio_ccw_balloon_exit(VirtioCcwData *dev)
> > +{
> > +    virtio_balloon_exit(dev->vdev);
> > +    return virtio_ccw_exit(dev);
> > +}
> > +
> > +static int virtio_ccw_scsi_init(VirtioCcwData *dev)
> > +{
> > +    VirtIODevice *vdev;
> > +
> > +    vdev =3D virtio_scsi_init((DeviceState *)dev, &dev->scsi);
> > +    if (!vdev) {
> > +        return -1;
> > +    }
> > +
> > +    return virtio_ccw_device_init(dev, vdev);
> > +}
> > +
> > +static int virtio_ccw_scsi_exit(VirtioCcwData *dev)
> > +{
> > +    virtio_scsi_exit(dev->vdev);
> > +    return virtio_ccw_exit(dev);
> > +}
> > +
> > +/* DeviceState to VirtioCcwData. Note: used on datapath,
> > + * be careful and test performance if you change this.
> > + */
> > +static inline VirtioCcwData *to_virtio_ccw_data_fast(DeviceState *=
d)
> > +{
> > +    return container_of(d, VirtioCcwData, parent_obj);
> > +}
> > +
> > +/* DeviceState to VirtioCcwData. TODO: use QOM. */
>=20
> Are the prerequisites to resolve this TODO not yet in qemu.git?
>=20
> > +static inline VirtioCcwData *to_virtio_ccw_data(DeviceState *d)
> > +{
> > +    return container_of(d, VirtioCcwData, parent_obj);
> > +}
> > +
> > +static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
> > +{
> > +    VirtioCcwData *dev =3D to_virtio_ccw_data_fast(d);
> > +    SubchDev *sch =3D dev->sch;
> > +    uint64_t indicators;
> > +
> > +    if (vector >=3D 128) {
> > +        return;
> > +    }
> > +
> > +    if (vector < VIRTIO_PCI_QUEUE_MAX) {
> > +        indicators =3D ldq_phys(dev->indicators);
> > +        set_bit(vector, &indicators);
> > +        stq_phys(dev->indicators, indicators);
> > +    } else {
> > +        vector =3D 0;
> > +        indicators =3D ldq_phys(dev->indicators2);
> > +        set_bit(vector, &indicators);
> > +        stq_phys(dev->indicators2, indicators);
> > +    }
> > +
> > +    css_conditional_io_interrupt(sch);
> > +
> > +}
> > +
> > +static unsigned virtio_ccw_get_features(DeviceState *d)
> > +{
> > +    VirtioCcwData *dev =3D to_virtio_ccw_data(d);
> > +
> > +    /* Only the first 32 feature bits are used. */
> > +    return dev->host_features[0];
> > +}
> > +
> > +/**************** Virtio-ccw Bus Device Descriptions *************=
******/
> > +
> > +static const VirtIOBindings virtio_ccw_bindings =3D {
> > +    .notify =3D virtio_ccw_notify,
> > +    .get_features =3D virtio_ccw_get_features,
> > +};
> > +
> > +static Property virtio_ccw_net_properties[] =3D {
> > +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
> > +    DEFINE_VIRTIO_NET_FEATURES(VirtioCcwData, host_features[0]),
> > +    DEFINE_NIC_PROPERTIES(VirtioCcwData, nic),
> > +    DEFINE_PROP_UINT32("x-txtimer", VirtioCcwData,
> > +                       net.txtimer, TX_TIMER_INTERVAL),
> > +    DEFINE_PROP_INT32("x-txburst", VirtioCcwData,
> > +                      net.txburst, TX_BURST),
> > +    DEFINE_PROP_STRING("tx", VirtioCcwData, net.tx),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_ccw_net_class_init(ObjectClass *klass, void *da=
ta)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtio_ccw_net_init;
> > +    k->exit =3D virtio_ccw_net_exit;
> > +    dc->props =3D virtio_ccw_net_properties;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_net =3D {
> > +    .name          =3D "virtio-net-ccw",
> > +    .parent        =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init    =3D virtio_ccw_net_class_init,
> > +};
> > +
> > +static Property virtio_ccw_blk_properties[] =3D {
> > +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
> > +    DEFINE_BLOCK_PROPERTIES(VirtioCcwData, blk.conf),
> > +    DEFINE_PROP_STRING("serial", VirtioCcwData, blk.serial),
> > +#ifdef __linux__
> > +    DEFINE_PROP_BIT("scsi", VirtioCcwData, blk.scsi, 0, true),
> > +#endif
> > +    DEFINE_VIRTIO_BLK_FEATURES(VirtioCcwData, host_features[0]),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_ccw_blk_class_init(ObjectClass *klass, void *da=
ta)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtio_ccw_blk_init;
> > +    k->exit =3D virtio_ccw_blk_exit;
> > +    dc->props =3D virtio_ccw_blk_properties;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_blk =3D {
> > +    .name          =3D "virtio-blk-ccw",
> > +    .parent        =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init    =3D virtio_ccw_blk_class_init,
> > +};
> > +
> > +static Property virtio_ccw_serial_properties[] =3D {
> > +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
> > +    DEFINE_PROP_UINT32("max_ports", VirtioCcwData, serial.max_virt=
serial_ports,
> > +                       31),
> > +    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwData, host_features[0])=
,
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_ccw_serial_class_init(ObjectClass *klass, void =
*data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtio_ccw_serial_init;
> > +    k->exit =3D virtio_ccw_serial_exit;
> > +    dc->props =3D virtio_ccw_serial_properties;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_serial =3D {
> > +    .name          =3D "virtio-serial-ccw",
> > +    .parent        =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init    =3D virtio_ccw_serial_class_init,
> > +};
> > +
> > +static Property virtio_ccw_balloon_properties[] =3D {
> > +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
> > +    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwData, host_features[0])=
,
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_ccw_balloon_class_init(ObjectClass *klass, void=
 *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtio_ccw_balloon_init;
> > +    k->exit =3D virtio_ccw_balloon_exit;
> > +    dc->props =3D virtio_ccw_balloon_properties;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_balloon =3D {
> > +    .name          =3D "virtio-balloon-ccw",
> > +    .parent        =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init    =3D virtio_ccw_balloon_class_init,
> > +};
> > +
> > +static Property virtio_ccw_scsi_properties[] =3D {
> > +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
> > +    DEFINE_VIRTIO_SCSI_PROPERTIES(VirtioCcwData, host_features[0],=
 scsi),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *d=
ata)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    VirtIOCCWDeviceClass *k =3D VIRTIO_CCW_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtio_ccw_scsi_init;
> > +    k->exit =3D virtio_ccw_scsi_exit;
> > +    dc->props =3D virtio_ccw_scsi_properties;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_scsi =3D {
> > +    .name          =3D "virtio-scsi-ccw",
> > +    .parent        =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init    =3D virtio_ccw_scsi_class_init,
> > +};
> > +
> > +static int virtio_ccw_busdev_init(DeviceState *dev)
> > +{
> > +    VirtioCcwData *_dev =3D (VirtioCcwData *)dev;
> > +    VirtIOCCWDeviceClass *_info =3D VIRTIO_CCW_DEVICE_GET_CLASS(de=
v);
> > +
> > +    virtio_ccw_bus_new(&_dev->bus, _dev);
> > +
> > +    return _info->init(_dev);
> > +}
> > +
> > +static int virtio_ccw_busdev_exit(DeviceState *dev)
> > +{
> > +    VirtioCcwData *_dev =3D (VirtioCcwData *)dev;
> > +    VirtIOCCWDeviceClass *_info =3D VIRTIO_CCW_DEVICE_GET_CLASS(de=
v);
> > +
> > +    return _info->exit(_dev);
> > +}
> > +
> > +static int virtio_ccw_busdev_unplug(DeviceState *dev)
> > +{
> > +    VirtioCcwData *_dev =3D (VirtioCcwData *)dev;
> > +    SubchDev *sch =3D _dev->sch;
> > +
> > +    /*
> > +     * We should arrive here only for device_del, since we don't s=
upport
> > +     * direct hot(un)plug of channels, but only through virtio.
> > +     */
> > +    assert(sch !=3D NULL);
> > +    /* Subchannel is now disabled and no longer valid. */
> > +    sch->curr_status.pmcw.flags &=3D ~(PMCW_FLAGS_MASK_ENA |
> > +                                     PMCW_FLAGS_MASK_DNV);
> > +
> > +    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0)=
;
> > +
> > +    object_unparent(OBJECT(dev));
> > +    qdev_free(dev);
> > +    return 0;
> > +}
> > +
> > +static void virtio_ccw_device_class_init(ObjectClass *klass, void =
*data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->init =3D virtio_ccw_busdev_init;
> > +    dc->exit =3D virtio_ccw_busdev_exit;
> > +    dc->unplug =3D virtio_ccw_busdev_unplug;
> > +    dc->bus_type =3D TYPE_VIRTUAL_CSS_BUS;
> > +
> > +}
> > +
> > +static const TypeInfo virtio_ccw_device_info =3D {
> > +    .name =3D TYPE_VIRTIO_CCW_DEVICE,
> > +    .parent =3D TYPE_DEVICE,
> > +    .instance_size =3D sizeof(VirtioCcwData),
> > +    .class_init =3D virtio_ccw_device_class_init,
> > +    .class_size =3D sizeof(VirtIOCCWDeviceClass),
> > +    .abstract =3D true,
> > +};
> > +
> > +/***************** Virtual-css Bus Bridge Device *****************=
***/
> > +/* Only required to have the virtio bus as child in the system bus=
 */
> > +
> > +static int virtual_css_bridge_init(SysBusDevice *dev)
> > +{
> > +    /* nothing */
> > +    return 0;
> > +}
> > +
> > +static void virtual_css_bridge_class_init(ObjectClass *klass, void=
 *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> > +
> > +    k->init =3D virtual_css_bridge_init;
> > +    dc->no_user =3D 1;
> > +}
> > +
> > +static const TypeInfo virtual_css_bridge_info =3D {
> > +    .name          =3D "virtual-css-bridge",
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(SysBusDevice),
> > +    .class_init    =3D virtual_css_bridge_class_init,
> > +};
> > +
> > +/* virtio-ccw-bus */
> > +
> > +void virtio_ccw_bus_new(VirtioBusState *bus, VirtioCcwData *dev)
> > +{
> > +    DeviceState *qdev =3D DEVICE(dev);
> > +    BusState *qbus;
> > +
> > +    qbus_create_inplace((BusState *)bus, TYPE_VIRTIO_CCW_BUS, qdev=
, NULL);
> > +    qbus =3D BUS(bus);
> > +    qbus->allow_hotplug =3D 0;
> > +}
> > +
> > +static void virtio_ccw_bus_class_init(ObjectClass *klass, void *da=
ta)
> > +{
> > +    VirtioBusClass *k =3D VIRTIO_BUS_CLASS(klass);
> > +    BusClass *bus_class =3D BUS_CLASS(klass);
> > +
> > +    bus_class->max_dev =3D 1;
> > +    k->notify =3D virtio_ccw_notify;
> > +    k->get_features =3D virtio_ccw_get_features;
> > +}
> > +
> > +static const TypeInfo virtio_ccw_bus_info =3D {
> > +    .name =3D TYPE_VIRTIO_CCW_BUS,
> > +    .parent =3D TYPE_VIRTIO_BUS,
> > +    .instance_size =3D sizeof(VirtioCcwBusState),
> > +    .class_init =3D virtio_ccw_bus_class_init,
> > +};
> > +
> > +static void virtio_ccw_register(void)
> > +{
> > +    type_register_static(&virtio_ccw_bus_info);
> > +    type_register_static(&virtual_css_bus_info);
> > +    type_register_static(&virtio_ccw_device_info);
> > +    type_register_static(&virtio_ccw_serial);
> > +    type_register_static(&virtio_ccw_blk);
> > +    type_register_static(&virtio_ccw_net);
> > +    type_register_static(&virtio_ccw_balloon);
> > +    type_register_static(&virtio_ccw_scsi);
> > +    type_register_static(&virtual_css_bridge_info);
> > +}
>=20
> White line please if you resend.

ok

>=20
> > +type_init(virtio_ccw_register)
> > diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
> > new file mode 100644
> > index 0000000..87c0e6d
> > --- /dev/null
> > +++ b/hw/s390x/virtio-ccw.h
> > @@ -0,0 +1,94 @@
> > +/*
> > + * virtio ccw target definitions
> > + *
> > + * Copyright 2012 IBM Corp.
> > + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2=
 or (at
> > + * your option) any later version. See the COPYING file in the top=
-level
> > + * directory.
> > + */
>=20
> Add a header guard?
>=20
> #ifndef HW_S390X_VIRTIO_CCW_H
> #define HW_S390X_VIRTIO_CCW_H

yup

>=20
> > +
> > +#include <hw/virtio-blk.h>
> > +#include <hw/virtio-net.h>
> > +#include <hw/virtio-serial.h>
> > +#include <hw/virtio-scsi.h>
> > +#include <hw/virtio-bus.h>
> > +
> > +#define VIRTUAL_CSSID 0xfe
> > +
> > +#define VIRTIO_CCW_CU_TYPE 0x3832
> > +#define VIRTIO_CCW_CHPID_TYPE 0x32
> > +
> > +#define CCW_CMD_SET_VQ       0x13
> > +#define CCW_CMD_VDEV_RESET   0x33
> > +#define CCW_CMD_READ_FEAT    0x12
> > +#define CCW_CMD_WRITE_FEAT   0x11
> > +#define CCW_CMD_READ_CONF    0x22
> > +#define CCW_CMD_WRITE_CONF   0x21
> > +#define CCW_CMD_WRITE_STATUS 0x31
> > +#define CCW_CMD_SET_IND      0x43
> > +#define CCW_CMD_SET_CONF_IND 0x53
> > +#define CCW_CMD_READ_VQ_CONF 0x32
> > +
> > +#define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
> > +#define VIRTIO_CCW_DEVICE(obj) \
> > +     OBJECT_CHECK(VirtioCcwData, (obj), TYPE_VIRTIO_CCW_DEVICE)
>=20
> Why ...Data and not ...Device?

Historical reasons, I've changed it now.

>=20
> > +#define VIRTIO_CCW_DEVICE_CLASS(klass) \
> > +     OBJECT_CLASS_CHECK(VirtIOCCWDeviceClass, (klass), TYPE_VIRTIO=
_CCW_DEVICE)
> > +#define VIRTIO_CCW_DEVICE_GET_CLASS(obj) \
> > +     OBJECT_GET_CLASS(VirtIOCCWDeviceClass, (obj), TYPE_VIRTIO_CCW=
_DEVICE)
> > +
> > +typedef struct VirtioBusState VirtioCcwBusState;
> > +typedef struct VirtioBusClass VirtioCcwBusClass;
> > +
> > +#define TYPE_VIRTIO_CCW_BUS "virtio-ccw-bus"
> > +#define VIRTIO_CCW_BUS(obj) \
> > +     OBJECT_CHECK(VirtioCcwBus, (obj), TYPE_VIRTIO_CCW_BUS)
> > +#define VIRTIO_CCW_BUS_GET_CLASS(obj) \
> > +    OBJECT_CHECK(VirtioCcwBusState, (obj), TYPE_VIRTIO_CCW_BUS)
> > +#define VIRTIO_CCW_BUS_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(VirtioCcwBusClass, klass, TYPE_VIRTIO_CCW_B=
US)
> > +
> > +typedef struct VirtioCcwData VirtioCcwData;
> > +
> > +void virtio_ccw_bus_new(VirtioBusState *bus, VirtioCcwData *dev);
> > +
> > +typedef struct VirtIOCCWDeviceClass {
> > +    DeviceClass parent_class;
> > +    int (*init)(VirtioCcwData *dev);
> > +    int (*exit)(VirtioCcwData *dev);
> > +} VirtIOCCWDeviceClass;
> > +
> > +/* Change here if we want to support more feature bits. */
> > +#define VIRTIO_CCW_FEATURE_SIZE 1
> > +
> > +struct VirtioCcwData {
> > +    DeviceState parent_obj;
> > +    SubchDev *sch;
> > +    VirtIODevice *vdev;
> > +    char *bus_id;
> > +    VirtIOBlkConf blk;
> > +    NICConf nic;
> > +    uint32_t host_features[VIRTIO_CCW_FEATURE_SIZE];
> > +    virtio_serial_conf serial;
> > +    virtio_net_conf net;
> > +    VirtIOSCSIConf scsi;
> > +    VirtioBusState bus;
> > +    /* Guest provided values: */
> > +    hwaddr indicators;
> > +    hwaddr indicators2;
> > +};
> > +
> > +/* virtual css bus type */
> > +typedef struct VirtualCssBus {
> > +    BusState parent_obj;
> > +} VirtualCssBus;
> > +
> > +#define TYPE_VIRTUAL_CSS_BUS "virtual-css-bus"
> > +#define VIRTUAL_CSS_BUS(obj) \
> > +     OBJECT_CHECK(VirtualCssBus, (obj), TYPE_VIRTUAL_CSS_BUS)
> > +
> > +VirtualCssBus *virtual_css_bus_init(void);
> > +void virtio_ccw_device_update_status(SubchDev *sch);
> > +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch);
> > diff --git a/trace-events b/trace-events
> > index bbed1cd..8796426 100644
> > --- a/trace-events
> > +++ b/trace-events
> > @@ -1074,3 +1074,7 @@ css_chpid_add(uint8_t cssid, uint8_t chpid, u=
int8_t type) "CSS: add chpid %x.%02
> >  css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add =
css image %02x %s"
> >  css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssi=
d, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
> >  css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm,=
 uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x=
=2E%04x (intparm %08x, isc %x) %s"
> > +
> > +# hw/s390x/virtio-ccw.c
> > +virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_c=
ode) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
> > +virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, c=
onst char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %0=
4x (%s)"
> >=20
>=20
> Andreas
>=20

Will rebase against s390-next and resend.
