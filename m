From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 8/8] s390: Add new channel I/O based virtio transport.
Date: Tue, 11 Dec 2012 11:53:18 +0100
Message-ID: <DC47DBAD-3386-4443-BBE4-48BD0BDACEE6@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com> <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 07.12.2012, at 13:50, Cornelia Huck wrote:

> Add a new virtio transport that uses channel commands to perform
> virtio operations.
> 
> Add a new machine type s390-ccw that uses this virtio-ccw transport
> and make it the default machine for s390.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> hw/s390-virtio.c       | 149 ++++++--
> hw/s390x/Makefile.objs |   1 +
> hw/s390x/virtio-ccw.c  | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
> hw/s390x/virtio-ccw.h  |  81 +++++
> trace-events           |   4 +
> 5 files changed, 1124 insertions(+), 20 deletions(-)
> create mode 100644 hw/s390x/virtio-ccw.c
> create mode 100644 hw/s390x/virtio-ccw.h
> 
> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> index 9e1afb2..f29ff74 100644
> --- a/hw/s390-virtio.c
> +++ b/hw/s390-virtio.c
> @@ -33,6 +33,8 @@
> 
> #include "hw/s390-virtio-bus.h"
> #include "hw/s390x/sclp.h"
> +#include "hw/s390x/css.h"
> +#include "hw/s390x/virtio-ccw.h"
> 
> //#define DEBUG_S390
> 
> @@ -47,6 +49,7 @@
> #define KVM_S390_VIRTIO_NOTIFY          0
> #define KVM_S390_VIRTIO_RESET           1
> #define KVM_S390_VIRTIO_SET_STATUS      2
> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
> 
> #define KERN_IMAGE_START                0x010000UL
> #define KERN_PARM_AREA                  0x010480UL
> @@ -63,6 +66,7 @@
> 
> static VirtIOS390Bus *s390_bus;
> static S390CPU **ipi_states;
> +VirtioCcwBus *ccw_bus;
> 
> S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> {
> @@ -76,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
> {
>     int r = 0, i;
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> 
>     dprintf("KVM hypercall: %ld\n", hypercall);
>     switch (hypercall) {
>     case KVM_S390_VIRTIO_NOTIFY:
>         if (mem > ram_size) {
> -            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> -                                                               mem, &i);
> -            if (dev) {
> -                virtio_queue_notify(dev->vdev, i);
> +            if (s390_bus) {
> +                VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> +                                                                   mem, &i);
> +                if (dev) {
> +                    virtio_queue_notify(dev->vdev, i);
> +                } else {
> +                    r = -EINVAL;
> +                }

We really want to factor out the DIAG handling code similar to how spapr handles its hypercalls. That way the legacy s390-virtio machine can register a VIRTIO_NOTIFY hypercall that works for it here, while the s390-virtio-ccw machine doesn't.

>             } else {
>                 r = -EINVAL;
>             }
> @@ -93,28 +103,49 @@ int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
>         }
>         break;
>     case KVM_S390_VIRTIO_RESET:
> -    {
> -        VirtIOS390Device *dev;
> -
> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> -        virtio_reset(dev->vdev);
> -        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> -        s390_virtio_device_sync(dev);
> -        s390_virtio_reset_idx(dev);
> +        if (s390_bus) {
> +            VirtIOS390Device *dev;
> +
> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> +            virtio_reset(dev->vdev);
> +            stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> +            s390_virtio_device_sync(dev);
> +            s390_virtio_reset_idx(dev);
> +        } else {
> +            r = -EINVAL;
> +        }
>         break;
> -    }
>     case KVM_S390_VIRTIO_SET_STATUS:
> -    {
> -        VirtIOS390Device *dev;
> +        if (s390_bus) {
> +            VirtIOS390Device *dev;
> 
> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> -        if (dev) {
> -            s390_virtio_device_update_status(dev);
> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> +            if (dev) {
> +                s390_virtio_device_update_status(dev);
> +            } else {
> +                r = -EINVAL;
> +            }
>         } else {
>             r = -EINVAL;
>         }
>         break;
> -    }
> +    case KVM_S390_VIRTIO_CCW_NOTIFY:
> +        if (ccw_bus) {
> +            if (ioinst_disassemble_sch_ident(env->regs[2], &m, &cssid, &ssid,
> +                                             &schid)) {
> +                r = -EINVAL;
> +            } else {
> +                sch = css_find_subch(m, cssid, ssid, schid);
> +                if (sch && css_subch_visible(sch)) {
> +                    virtio_queue_notify(virtio_ccw_get_vdev(sch), env->regs[3]);
> +                } else {
> +                    r = -EINVAL;
> +                }
> +            }
> +         } else {
> +             r = -EINVAL;
> +         }
> +         break;
>     default:
>         r = -EINVAL;
>         break;
> @@ -370,7 +401,6 @@ static QEMUMachine s390_machine = {
>     .no_sdcard = 1,
>     .use_virtcon = 1,
>     .max_cpus = 255,
> -    .is_default = 1,
> };
> 
> static void s390_machine_init(void)
> @@ -379,3 +409,82 @@ static void s390_machine_init(void)
> }
> 
> machine_init(s390_machine_init);
> +
> +static void ccw_init(QEMUMachineInitArgs *args)

Do you think it'd be possible to move this into its own .c file?

> +{
> +    ram_addr_t my_ram_size = args->ram_size;
> +    ram_addr_t ram_size = args->ram_size;
> +    const char *cpu_model = args->cpu_model;
> +    const char *kernel_filename = args->kernel_filename;
> +    const char *kernel_cmdline = args->kernel_cmdline;
> +    const char *initrd_filename = args->initrd_filename;
> +    CPUS390XState *env = NULL;
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    int shift = 0;
> +    uint8_t *storage_keys;
> +    int ret;
> +
> +    /* s390x ram size detection needs a 16bit multiplier + an increment. So
> +       guests > 64GB can be specified in 2MB steps etc. */
> +    while ((my_ram_size >> (20 + shift)) > 65535) {
> +        shift++;
> +    }
> +    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
> +
> +    /* lets propagate the changed ram size into the global variable. */
> +    ram_size = my_ram_size;
> +
> +    /* get a BUS */
> +    ccw_bus = virtio_ccw_bus_init();
> +    s390_sclp_init();
> +
> +    /* allocate RAM */
> +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
> +    vmstate_register_ram_global(ram);
> +    memory_region_add_subregion(sysmem, 0, ram);
> +
> +    /* allocate storage keys */
> +    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
> +
> +    /* init CPUs */
> +    env = s390_init_cpus(cpu_model, storage_keys);
> +
> +    kvm_s390_enable_css_support(env);
> +
> +    /*
> +     * Create virtual css and set it as default so that non mcss-e
> +     * enabled guests only see virtio devices.
> +     */
> +    ret = css_create_css_image(VIRTUAL_CSSID, true);
> +    assert(ret == 0);
> +
> +
> +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, initrd_filename);
> +
> +    /* Create VirtIO network adapters */
> +    s390_create_virtio_net((BusState *)ccw_bus, "virtio-net-ccw");
> +
> +}
> +
> +static QEMUMachine ccw_machine = {
> +    .name = "s390-ccw-virtio",
> +    .alias = "s390-ccw",
> +    .desc = "VirtIO-ccw based S390 machine",
> +    .init = ccw_init,
> +    .no_cdrom = 1,
> +    .no_floppy = 1,
> +    .no_serial = 1,
> +    .no_parallel = 1,
> +    .no_sdcard = 1,
> +    .use_virtcon = 1,
> +    .max_cpus = 255,
> +    .is_default = 1,
> +};
> +
> +static void ccw_machine_init(void)
> +{
> +    qemu_register_machine(&ccw_machine);
> +}
> +
> +machine_init(ccw_machine_init);
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 378b099..d408558 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -5,3 +5,4 @@ obj-y += sclp.o
> obj-y += event-facility.o
> obj-y += sclpquiesce.o sclpconsole.o
> obj-y += css.o
> +obj-y += virtio-ccw.o
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> new file mode 100644
> index 0000000..b4624ab
> --- /dev/null
> +++ b/hw/s390x/virtio-ccw.c
> @@ -0,0 +1,909 @@
> +/*
> + * virtio ccw target implementation

Please extract this into a separate patch.

> + *
> + * Copyright 2012 IBM Corp.
> + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include <hw/hw.h>
> +#include "block.h"
> +#include "blockdev.h"
> +#include "sysemu.h"
> +#include "net.h"
> +#include "monitor.h"
> +#include "qemu-thread.h"
> +#include "hw/virtio.h"
> +#include "hw/virtio-serial.h"
> +#include "hw/virtio-net.h"
> +#include "hw/sysbus.h"
> +#include "bitops.h"
> +
> +#include "ioinst.h"
> +#include "css.h"
> +#include "virtio-ccw.h"
> +#include "trace.h"
> +
> +static const TypeInfo virtio_ccw_bus_info = {
> +    .name = TYPE_VIRTIO_CCW_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = sizeof(VirtioCcwBus),
> +};
> +
> +static const VirtIOBindings virtio_ccw_bindings;
> +
> +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
> +{
> +    VirtIODevice *vdev = NULL;
> +
> +    if (sch->driver_data) {
> +        vdev = ((VirtioCcwData *)sch->driver_data)->vdev;
> +    }
> +    return vdev;
> +}
> +
> +static void virtio_ccw_reset_subchannels(void *opaque)
> +{
> +    VirtioCcwBus *bus = opaque;
> +    BusChild *kid;
> +    VirtioCcwData *data;
> +
> +    QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
> +        data = (VirtioCcwData *)kid->child;
> +        virtio_reset(data->vdev);
> +        css_reset_sch(data->sch);
> +    }
> +    css_reset();
> +}
> +
> +VirtioCcwBus *virtio_ccw_bus_init(void)
> +{
> +    VirtioCcwBus *cbus;
> +    BusState *bus;
> +    DeviceState *dev;
> +
> +    /* Create bridge device */
> +    dev = qdev_create(NULL, "virtio-ccw-bridge");
> +    qdev_init_nofail(dev);
> +
> +    /* Create bus on bridge device */
> +    bus = qbus_create(TYPE_VIRTIO_CCW_BUS, dev, "virtio-ccw");
> +    cbus = DO_UPCAST(VirtioCcwBus, bus, bus);
> +
> +    /* Enable hotplugging */
> +    bus->allow_hotplug = 1;
> +
> +    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
> +    return cbus;
> +}
> +
> +/* Communication blocks used by several channel commands. */
> +typedef struct VqInfoBlock {
> +    uint64_t queue;
> +    uint32_t align;
> +    uint16_t index;
> +    uint16_t num;
> +} QEMU_PACKED VqInfoBlock;
> +
> +typedef struct VqConfigBlock {
> +    uint16_t index;
> +    uint16_t num_max;
> +} QEMU_PACKED VqConfigBlock;
> +
> +typedef struct VirtioFeatDesc {
> +    uint32_t features;
> +    uint8_t index;
> +} QEMU_PACKED VirtioFeatDesc;
> +
> +/* Specify where the virtqueues for the subchannel are in guest memory. */
> +static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
> +                              uint16_t index, uint16_t num)
> +{
> +    VirtioCcwData *data = sch->driver_data;
> +
> +    if (index > VIRTIO_PCI_QUEUE_MAX) {
> +        return -EINVAL;
> +    }
> +
> +    /* Current code in virtio.c relies on 4K alignment. */
> +    if (addr && (align != 4096)) {
> +        return -EINVAL;
> +    }
> +
> +    if (!data) {
> +        return -EINVAL;
> +    }
> +
> +    virtio_queue_set_addr(data->vdev, index, addr);
> +    if (!addr) {
> +        virtio_queue_set_vector(data->vdev, index, 0);
> +    } else {
> +        /* Fail if we don't have a big enough queue. */
> +        /* TODO: Add interface to handle vring.num changing */
> +        if (virtio_queue_get_num(data->vdev, index) > num) {
> +            return -EINVAL;
> +        }
> +        virtio_queue_set_vector(data->vdev, index, index);
> +    }
> +    /* tell notify handler in case of config change */
> +    data->vdev->config_vector = VIRTIO_PCI_QUEUE_MAX;
> +    return 0;
> +}
> +
> +static int virtio_ccw_cb(SubchDev *sch, CCW1 *ccw)
> +{
> +    int ret;
> +    VqInfoBlock info;
> +    uint8_t status;
> +    VirtioFeatDesc features;
> +    void *config;
> +    hwaddr indicators;
> +    VqConfigBlock vq_config;
> +    VirtioCcwData *data = sch->driver_data;
> +    bool check_len;
> +    int len;
> +
> +    if (!ccw) {
> +        return -EIO;
> +    }
> +
> +    if (!data) {
> +        return -EINVAL;
> +    }
> +
> +    trace_virtio_ccw_interpret_ccw(sch->cssid, sch->ssid, sch->schid,
> +                                   ccw->cmd_code);
> +    check_len = !((ccw->flags & CCW_FLAG_SLI) && !(ccw->flags & CCW_FLAG_DC));
> +
> +    /* Look at the command. */
> +    switch (ccw->cmd_code) {
> +    case CCW_CMD_SET_VQ:
> +        if (check_len) {
> +            if (ccw->count != sizeof(info)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(info)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            info.queue = ldq_phys(ccw->cda);
> +            info.align = ldl_phys(ccw->cda + sizeof(info.queue));
> +            info.index = lduw_phys(ccw->cda + sizeof(info.queue)
> +                                   + sizeof(info.align));
> +            info.num = lduw_phys(ccw->cda + sizeof(info.queue)
> +                                 + sizeof(info.align)
> +                                 + sizeof(info.index));
> +            ret = virtio_ccw_set_vqs(sch, info.queue, info.align, info.index,
> +                                     info.num);
> +            sch->curr_status.scsw.count = 0;
> +        }
> +        break;
> +    case CCW_CMD_VDEV_RESET:
> +        virtio_reset(data->vdev);
> +        ret = 0;
> +        break;
> +    case CCW_CMD_READ_FEAT:
> +        if (check_len) {
> +            if (ccw->count != sizeof(features)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(features)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            features.index = ldub_phys(ccw->cda + sizeof(features.features));
> +            if (features.index < ARRAY_SIZE(data->host_features)) {
> +                features.features = data->host_features[features.index];
> +            } else {
> +                /* Return zeroes if the guest supports more feature bits. */
> +                features.features = 0;
> +            }
> +            stl_le_phys(ccw->cda, features.features);
> +            sch->curr_status.scsw.count = ccw->count - sizeof(features);
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_WRITE_FEAT:
> +        if (check_len) {
> +            if (ccw->count != sizeof(features)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(features)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            features.index = ldub_phys(ccw->cda + sizeof(features.features));
> +            features.features = ldl_le_phys(ccw->cda);
> +            if (features.index < ARRAY_SIZE(data->host_features)) {
> +                if (data->vdev->set_features) {
> +                    data->vdev->set_features(data->vdev, features.features);
> +                }
> +                data->vdev->guest_features = features.features;
> +            } else {
> +                /*
> +                 * If the guest supports more feature bits, assert that it
> +                 * passes us zeroes for those we don't support.
> +                 */
> +                if (features.features) {
> +                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
> +                            features.index, features.features);
> +                    /* XXX: do a unit check here? */
> +                }
> +            }
> +            sch->curr_status.scsw.count = ccw->count - sizeof(features);
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_READ_CONF:
> +        if (check_len) {
> +            if (ccw->count > data->vdev->config_len) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        }
> +        len = MIN(ccw->count, data->vdev->config_len);
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            data->vdev->get_config(data->vdev, data->vdev->config);
> +            cpu_physical_memory_write(ccw->cda, data->vdev->config, len);
> +            sch->curr_status.scsw.count = ccw->count - len;
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_WRITE_CONF:
> +        if (check_len) {
> +            if (ccw->count > data->vdev->config_len) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        }
> +        len = MIN(ccw->count, data->vdev->config_len);
> +        config = qemu_get_ram_ptr(ccw->cda);
> +        if (!config) {
> +            ret = -EFAULT;
> +        } else {
> +            memcpy(data->vdev->config, config, len);
> +            if (data->vdev->set_config) {
> +                data->vdev->set_config(data->vdev, data->vdev->config);
> +            }
> +            sch->curr_status.scsw.count = ccw->count - len;
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_WRITE_STATUS:
> +        if (check_len) {
> +            if (ccw->count != sizeof(status)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(status)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            status = ldub_phys(ccw->cda);
> +            virtio_set_status(data->vdev, status);
> +            sch->curr_status.scsw.count = ccw->count - sizeof(status);
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_SET_IND:
> +        if (check_len) {
> +            if (ccw->count != sizeof(indicators)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(indicators)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        indicators = ldq_phys(ccw->cda);
> +        if (!indicators) {
> +            ret = -EFAULT;
> +        } else {
> +            data->indicators = indicators;
> +            sch->curr_status.scsw.count = ccw->count - sizeof(indicators);
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_SET_CONF_IND:
> +        if (check_len) {
> +            if (ccw->count != sizeof(indicators)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(indicators)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        indicators = ldq_phys(ccw->cda);
> +        if (!indicators) {
> +            ret = -EFAULT;
> +        } else {
> +            data->indicators2 = indicators;
> +            sch->curr_status.scsw.count = ccw->count - sizeof(indicators);
> +            ret = 0;
> +        }
> +        break;
> +    case CCW_CMD_READ_VQ_CONF:
> +        if (check_len) {
> +            if (ccw->count != sizeof(vq_config)) {
> +                ret = -EINVAL;
> +                break;
> +            }
> +        } else if (ccw->count < sizeof(vq_config)) {
> +            /* Can't execute command. */
> +            ret = -EINVAL;
> +            break;
> +        }
> +        if (!qemu_get_ram_ptr(ccw->cda)) {
> +            ret = -EFAULT;
> +        } else {
> +            vq_config.index = lduw_phys(ccw->cda);
> +            vq_config.num_max = virtio_queue_get_num(data->vdev,
> +                                                     vq_config.index);
> +            stw_phys(ccw->cda + sizeof(vq_config.index), vq_config.num_max);
> +            sch->curr_status.scsw.count = ccw->count - sizeof(vq_config);
> +            ret = 0;
> +        }
> +        break;
> +    default:
> +        ret = -EOPNOTSUPP;
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static int virtio_ccw_device_init(VirtioCcwData *dev, VirtIODevice *vdev)
> +{
> +    unsigned int cssid = 0;
> +    unsigned int ssid = 0;
> +    unsigned int schid;
> +    unsigned int devno;
> +    bool have_devno = false;
> +    bool found = false;
> +    SubchDev *sch;
> +    int ret;
> +    int num;
> +
> +    sch = g_malloc0(sizeof(SubchDev));

Any reason to not just make sch part of dev?

Alex
