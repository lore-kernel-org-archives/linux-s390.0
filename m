From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 8/8] s390: Add new channel I/O based virtio transport.
Date: Tue, 11 Dec 2012 14:03:58 +0100
Message-ID: <20121211140358.1b39b8c6@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
	<DC47DBAD-3386-4443-BBE4-48BD0BDACEE6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <DC47DBAD-3386-4443-BBE4-48BD0BDACEE6@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 11 Dec 2012 11:53:18 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 07.12.2012, at 13:50, Cornelia Huck wrote:
> 
> > Add a new virtio transport that uses channel commands to perform
> > virtio operations.
> > 
> > Add a new machine type s390-ccw that uses this virtio-ccw transport
> > and make it the default machine for s390.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > hw/s390-virtio.c       | 149 ++++++--
> > hw/s390x/Makefile.objs |   1 +
> > hw/s390x/virtio-ccw.c  | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
> > hw/s390x/virtio-ccw.h  |  81 +++++
> > trace-events           |   4 +
> > 5 files changed, 1124 insertions(+), 20 deletions(-)
> > create mode 100644 hw/s390x/virtio-ccw.c
> > create mode 100644 hw/s390x/virtio-ccw.h
> > 
> > diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> > index 9e1afb2..f29ff74 100644
> > --- a/hw/s390-virtio.c
> > +++ b/hw/s390-virtio.c
> > @@ -33,6 +33,8 @@
> > 
> > #include "hw/s390-virtio-bus.h"
> > #include "hw/s390x/sclp.h"
> > +#include "hw/s390x/css.h"
> > +#include "hw/s390x/virtio-ccw.h"
> > 
> > //#define DEBUG_S390
> > 
> > @@ -47,6 +49,7 @@
> > #define KVM_S390_VIRTIO_NOTIFY          0
> > #define KVM_S390_VIRTIO_RESET           1
> > #define KVM_S390_VIRTIO_SET_STATUS      2
> > +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
> > 
> > #define KERN_IMAGE_START                0x010000UL
> > #define KERN_PARM_AREA                  0x010480UL
> > @@ -63,6 +66,7 @@
> > 
> > static VirtIOS390Bus *s390_bus;
> > static S390CPU **ipi_states;
> > +VirtioCcwBus *ccw_bus;
> > 
> > S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> > {
> > @@ -76,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> > int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
> > {
> >     int r = 0, i;
> > +    int cssid, ssid, schid, m;
> > +    SubchDev *sch;
> > 
> >     dprintf("KVM hypercall: %ld\n", hypercall);
> >     switch (hypercall) {
> >     case KVM_S390_VIRTIO_NOTIFY:
> >         if (mem > ram_size) {
> > -            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> > -                                                               mem, &i);
> > -            if (dev) {
> > -                virtio_queue_notify(dev->vdev, i);
> > +            if (s390_bus) {
> > +                VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> > +                                                                   mem, &i);
> > +                if (dev) {
> > +                    virtio_queue_notify(dev->vdev, i);
> > +                } else {
> > +                    r = -EINVAL;
> > +                }
> 
> We really want to factor out the DIAG handling code similar to how spapr handles its hypercalls. That way the legacy s390-virtio machine can register a VIRTIO_NOTIFY hypercall that works for it here, while the s390-virtio-ccw machine doesn't.
> 
> >             } else {
> >                 r = -EINVAL;
> >             }
> > @@ -93,28 +103,49 @@ int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
> >         }
> >         break;
> >     case KVM_S390_VIRTIO_RESET:
> > -    {
> > -        VirtIOS390Device *dev;
> > -
> > -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> > -        virtio_reset(dev->vdev);
> > -        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> > -        s390_virtio_device_sync(dev);
> > -        s390_virtio_reset_idx(dev);
> > +        if (s390_bus) {
> > +            VirtIOS390Device *dev;
> > +
> > +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> > +            virtio_reset(dev->vdev);
> > +            stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> > +            s390_virtio_device_sync(dev);
> > +            s390_virtio_reset_idx(dev);
> > +        } else {
> > +            r = -EINVAL;
> > +        }
> >         break;
> > -    }
> >     case KVM_S390_VIRTIO_SET_STATUS:
> > -    {
> > -        VirtIOS390Device *dev;
> > +        if (s390_bus) {
> > +            VirtIOS390Device *dev;
> > 
> > -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> > -        if (dev) {
> > -            s390_virtio_device_update_status(dev);
> > +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> > +            if (dev) {
> > +                s390_virtio_device_update_status(dev);
> > +            } else {
> > +                r = -EINVAL;
> > +            }
> >         } else {
> >             r = -EINVAL;
> >         }
> >         break;
> > -    }
> > +    case KVM_S390_VIRTIO_CCW_NOTIFY:
> > +        if (ccw_bus) {
> > +            if (ioinst_disassemble_sch_ident(env->regs[2], &m, &cssid, &ssid,
> > +                                             &schid)) {
> > +                r = -EINVAL;
> > +            } else {
> > +                sch = css_find_subch(m, cssid, ssid, schid);
> > +                if (sch && css_subch_visible(sch)) {
> > +                    virtio_queue_notify(virtio_ccw_get_vdev(sch), env->regs[3]);
> > +                } else {
> > +                    r = -EINVAL;
> > +                }
> > +            }
> > +         } else {
> > +             r = -EINVAL;
> > +         }
> > +         break;
> >     default:
> >         r = -EINVAL;
> >         break;
> > @@ -370,7 +401,6 @@ static QEMUMachine s390_machine = {
> >     .no_sdcard = 1,
> >     .use_virtcon = 1,
> >     .max_cpus = 255,
> > -    .is_default = 1,
> > };
> > 
> > static void s390_machine_init(void)
> > @@ -379,3 +409,82 @@ static void s390_machine_init(void)
> > }
> > 
> > machine_init(s390_machine_init);
> > +
> > +static void ccw_init(QEMUMachineInitArgs *args)
> 
> Do you think it'd be possible to move this into its own .c file?

Any particular reason why it should be moved? I saw this file as
'handle generic s390 virtio stuff'.

> 
> > +{
> > +    ram_addr_t my_ram_size = args->ram_size;
> > +    ram_addr_t ram_size = args->ram_size;
> > +    const char *cpu_model = args->cpu_model;
> > +    const char *kernel_filename = args->kernel_filename;
> > +    const char *kernel_cmdline = args->kernel_cmdline;
> > +    const char *initrd_filename = args->initrd_filename;
> > +    CPUS390XState *env = NULL;
> > +    MemoryRegion *sysmem = get_system_memory();
> > +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> > +    int shift = 0;
> > +    uint8_t *storage_keys;
> > +    int ret;
> > +
> > +    /* s390x ram size detection needs a 16bit multiplier + an increment. So
> > +       guests > 64GB can be specified in 2MB steps etc. */
> > +    while ((my_ram_size >> (20 + shift)) > 65535) {
> > +        shift++;
> > +    }
> > +    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
> > +
> > +    /* lets propagate the changed ram size into the global variable. */
> > +    ram_size = my_ram_size;
> > +
> > +    /* get a BUS */
> > +    ccw_bus = virtio_ccw_bus_init();
> > +    s390_sclp_init();
> > +
> > +    /* allocate RAM */
> > +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
> > +    vmstate_register_ram_global(ram);
> > +    memory_region_add_subregion(sysmem, 0, ram);
> > +
> > +    /* allocate storage keys */
> > +    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
> > +
> > +    /* init CPUs */
> > +    env = s390_init_cpus(cpu_model, storage_keys);
> > +
> > +    kvm_s390_enable_css_support(env);
> > +
> > +    /*
> > +     * Create virtual css and set it as default so that non mcss-e
> > +     * enabled guests only see virtio devices.
> > +     */
> > +    ret = css_create_css_image(VIRTUAL_CSSID, true);
> > +    assert(ret == 0);
> > +
> > +
> > +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, initrd_filename);
> > +
> > +    /* Create VirtIO network adapters */
> > +    s390_create_virtio_net((BusState *)ccw_bus, "virtio-net-ccw");
> > +
> > +}
> > +
> > +static QEMUMachine ccw_machine = {
> > +    .name = "s390-ccw-virtio",
> > +    .alias = "s390-ccw",
> > +    .desc = "VirtIO-ccw based S390 machine",
> > +    .init = ccw_init,
> > +    .no_cdrom = 1,
> > +    .no_floppy = 1,
> > +    .no_serial = 1,
> > +    .no_parallel = 1,
> > +    .no_sdcard = 1,
> > +    .use_virtcon = 1,
> > +    .max_cpus = 255,
> > +    .is_default = 1,
> > +};
> > +
> > +static void ccw_machine_init(void)
> > +{
> > +    qemu_register_machine(&ccw_machine);
> > +}
> > +
> > +machine_init(ccw_machine_init);
> > diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> > index 378b099..d408558 100644
> > --- a/hw/s390x/Makefile.objs
> > +++ b/hw/s390x/Makefile.objs
> > @@ -5,3 +5,4 @@ obj-y += sclp.o
> > obj-y += event-facility.o
> > obj-y += sclpquiesce.o sclpconsole.o
> > obj-y += css.o
> > +obj-y += virtio-ccw.o
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > new file mode 100644
> > index 0000000..b4624ab
> > --- /dev/null
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -0,0 +1,909 @@
> > +/*
> > + * virtio ccw target implementation
> 
> Please extract this into a separate patch.

You mean first add the virtio-ccw backend and then introduce the new
machine?


> > +static int virtio_ccw_device_init(VirtioCcwData *dev, VirtIODevice *vdev)
> > +{
> > +    unsigned int cssid = 0;
> > +    unsigned int ssid = 0;
> > +    unsigned int schid;
> > +    unsigned int devno;
> > +    bool have_devno = false;
> > +    bool found = false;
> > +    SubchDev *sch;
> > +    int ret;
> > +    int num;
> > +
> > +    sch = g_malloc0(sizeof(SubchDev));
> 
> Any reason to not just make sch part of dev?

If anything, we'd probably want the virtio-ccw stuff extending the
generic subchannel stuff (so that we can have a basic subchannel
structure which might later be extended in a different way if we want
real device passthrough).

I'll try to implement it in such a way that it can be easily refactored
and extended.
