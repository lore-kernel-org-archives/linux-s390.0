From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2 3/5] s390: Add new channel I/O based virtio transport.
Date: Thu, 20 Sep 2012 16:50:59 +0200
Message-ID: <B99CEDC6-6AC8-4156-8898-1F661DEB8F25@suse.de>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com> <1346771633-53081-4-git-send-email-cornelia.huck@de.ibm.com> <87pq5grcuz.fsf@codemonkey.ws>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <87pq5grcuz.fsf@codemonkey.ws>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 20.09.2012, at 16:24, Anthony Liguori <aliguori@us.ibm.com> wrote:

> Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> 
>> Add a new virtio transport that uses channel commands to perform
>> virtio operations.
>> 
>> Add a new machine type s390-ccw that uses this virtio-ccw transport
>> and make it the default machine for s390.
>> 
>> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
>> ---
>> 
>> Changes v1->v2:
>> - update to virtio-ccw interface changes
>> 
>> ---
>> hw/qdev-monitor.c      |   5 +
>> hw/s390-virtio.c       | 277 ++++++++++++----
>> hw/s390x/Makefile.objs |   1 +
>> hw/s390x/css.c         |  45 +++
>> hw/s390x/css.h         |   3 +
>> hw/s390x/virtio-ccw.c  | 875 +++++++++++++++++++++++++++++++++++++++++++++++++
>> hw/s390x/virtio-ccw.h  |  79 +++++
>> vl.c                   |   1 +
>> 8 files changed, 1215 insertions(+), 71 deletions(-)
>> create mode 100644 hw/s390x/virtio-ccw.c
>> create mode 100644 hw/s390x/virtio-ccw.h
>> 
>> diff --git a/hw/qdev-monitor.c b/hw/qdev-monitor.c
>> index 33b7f79..92b7c59 100644
>> --- a/hw/qdev-monitor.c
>> +++ b/hw/qdev-monitor.c
>> @@ -42,6 +42,11 @@ static const QDevAlias qdev_alias_table[] = {
>>     { "virtio-blk-s390", "virtio-blk", QEMU_ARCH_S390X },
>>     { "virtio-net-s390", "virtio-net", QEMU_ARCH_S390X },
>>     { "virtio-serial-s390", "virtio-serial", QEMU_ARCH_S390X },
>> +    { "virtio-blk-ccw", "virtio-blk", QEMU_ARCH_S390X },
>> +    { "virtio-net-ccw", "virtio-net", QEMU_ARCH_S390X },
>> +    { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_S390X },
>> +    { "virtio-balloon-ccw", "virtio-balloon", QEMU_ARCH_S390X },
>> +    { "virtio-scsi-ccw", "virtio-scsi", QEMU_ARCH_S390X },
>>     { "lsi53c895a", "lsi" },
>>     { "ich9-ahci", "ahci" },
> 
> Please don't add aliases.  That's just an ugly hack to maintain compatibility.
> 
>>     { }
>> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
>> index 47eed35..2509291 100644
>> --- a/hw/s390-virtio.c
>> +++ b/hw/s390-virtio.c
>> @@ -30,8 +30,11 @@
>> #include "hw/sysbus.h"
>> #include "kvm.h"
>> #include "exec-memory.h"
>> +#include "qemu-thread.h"
>> 
>> #include "hw/s390-virtio-bus.h"
>> +#include "hw/s390x/css.h"
>> +#include "hw/s390x/virtio-ccw.h"
>> 
>> //#define DEBUG_S390
>> 
>> @@ -46,6 +49,7 @@
>> #define KVM_S390_VIRTIO_NOTIFY          0
>> #define KVM_S390_VIRTIO_RESET           1
>> #define KVM_S390_VIRTIO_SET_STATUS      2
>> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
>> 
>> #define KERN_IMAGE_START                0x010000UL
>> #define KERN_PARM_AREA                  0x010480UL
>> @@ -62,6 +66,7 @@
>> 
>> static VirtIOS390Bus *s390_bus;
>> static S390CPU **ipi_states;
>> +VirtioCcwBus *ccw_bus;
>> 
>> S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>> {
>> @@ -75,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
>> int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
>> {
>>     int r = 0, i;
>> +    int cssid, ssid, schid, m;
>> +    SubchDev *sch;
>> 
>>     dprintf("KVM hypercall: %ld\n", hypercall);
>>     switch (hypercall) {
>>     case KVM_S390_VIRTIO_NOTIFY:
>>         if (mem > ram_size) {
>> -            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
>> -                                                               mem, &i);
>> -            if (dev) {
>> -                virtio_queue_notify(dev->vdev, i);
>> +            if (s390_bus) {
>> +                VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
>> +                                                                   mem, &i);
>> +                if (dev) {
>> +                    virtio_queue_notify(dev->vdev, i);
>> +                } else {
>> +                    r = -EINVAL;
>> +                }
>>             } else {
>>                 r = -EINVAL;
>>             }
>> @@ -92,28 +103,49 @@ int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
>>         }
>>         break;
>>     case KVM_S390_VIRTIO_RESET:
>> -    {
>> -        VirtIOS390Device *dev;
>> -
>> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
>> -        virtio_reset(dev->vdev);
>> -        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
>> -        s390_virtio_device_sync(dev);
>> -        s390_virtio_reset_idx(dev);
>> +        if (s390_bus) {
>> +            VirtIOS390Device *dev;
>> +
>> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
>> +            virtio_reset(dev->vdev);
>> +            stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
>> +            s390_virtio_device_sync(dev);
>> +            s390_virtio_reset_idx(dev);
>> +        } else {
>> +            r = -EINVAL;
>> +        }
>>         break;
>> -    }
>>     case KVM_S390_VIRTIO_SET_STATUS:
>> -    {
>> -        VirtIOS390Device *dev;
>> +        if (s390_bus) {
>> +            VirtIOS390Device *dev;
>> 
>> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
>> -        if (dev) {
>> -            s390_virtio_device_update_status(dev);
>> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
>> +            if (dev) {
>> +                s390_virtio_device_update_status(dev);
>> +            } else {
>> +                r = -EINVAL;
>> +            }
>>         } else {
>>             r = -EINVAL;
>>         }
>>         break;
>> -    }
>> +    case KVM_S390_VIRTIO_CCW_NOTIFY:
>> +        if (ccw_bus) {
>> +            if (ioinst_disassemble_sch_ident(env->regs[2], &m, &cssid, &ssid,
>> +                                             &schid)) {
>> +                r = -EINVAL;
>> +            } else {
>> +                sch = css_find_subch(m, cssid, ssid, schid);
>> +                if (sch) {
>> +                    virtio_queue_notify(virtio_ccw_get_vdev(sch), env->regs[3]);
>> +                } else {
>> +                    r = -EINVAL;
>> +                }
>> +            }
>> +         } else {
>> +             r = -EINVAL;
>> +         }
>> +         break;
>>     default:
>>         r = -EINVAL;
>>         break;
>> @@ -150,58 +182,12 @@ unsigned s390_del_running_cpu(CPUS390XState *env)
>>     return s390_running_cpus;
>> }
>> 
>> -/* PC hardware initialisation */
>> -static void s390_init(ram_addr_t my_ram_size,
>> -                      const char *boot_device,
>> -                      const char *kernel_filename,
>> -                      const char *kernel_cmdline,
>> -                      const char *initrd_filename,
>> -                      const char *cpu_model)
>> +static CPUS390XState *s390_init_cpus(const char *cpu_model,
>> +                                     uint8_t *storage_keys)
>> {
>>     CPUS390XState *env = NULL;
>> -    MemoryRegion *sysmem = get_system_memory();
>> -    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> -    ram_addr_t kernel_size = 0;
>> -    ram_addr_t initrd_offset;
>> -    ram_addr_t initrd_size = 0;
>> -    int shift = 0;
>> -    uint8_t *storage_keys;
>> -    void *virtio_region;
>> -    target_phys_addr_t virtio_region_len;
>> -    target_phys_addr_t virtio_region_start;
>>     int i;
>> 
>> -    /* s390x ram size detection needs a 16bit multiplier + an increment. So
>> -       guests > 64GB can be specified in 2MB steps etc. */
>> -    while ((my_ram_size >> (20 + shift)) > 65535) {
>> -        shift++;
>> -    }
>> -    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
>> -
>> -    /* lets propagate the changed ram size into the global variable. */
>> -    ram_size = my_ram_size;
>> -
>> -    /* get a BUS */
>> -    s390_bus = s390_virtio_bus_init(&my_ram_size);
>> -
>> -    /* allocate RAM */
>> -    memory_region_init_ram(ram, "s390.ram", my_ram_size);
>> -    vmstate_register_ram_global(ram);
>> -    memory_region_add_subregion(sysmem, 0, ram);
>> -
>> -    /* clear virtio region */
>> -    virtio_region_len = my_ram_size - ram_size;
>> -    virtio_region_start = ram_size;
>> -    virtio_region = cpu_physical_memory_map(virtio_region_start,
>> -                                            &virtio_region_len, true);
>> -    memset(virtio_region, 0, virtio_region_len);
>> -    cpu_physical_memory_unmap(virtio_region, virtio_region_len, 1,
>> -                              virtio_region_len);
>> -
>> -    /* allocate storage keys */
>> -    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
>> -
>> -    /* init CPUs */
>>     if (cpu_model == NULL) {
>>         cpu_model = "host";
>>     }
>> @@ -222,6 +208,17 @@ static void s390_init(ram_addr_t my_ram_size,
>>         tmp_env->exception_index = EXCP_HLT;
>>         tmp_env->storage_keys = storage_keys;
>>     }
>> +    return env;
>> +}
>> +
>> +static void s390_set_up_kernel(CPUS390XState *env,
>> +                               const char *kernel_filename,
>> +                               const char *kernel_cmdline,
>> +                               const char *initrd_filename)
>> +{
>> +    ram_addr_t kernel_size = 0;
>> +    ram_addr_t initrd_offset;
>> +    ram_addr_t initrd_size = 0;
>> 
>>     /* One CPU has to run */
>>     s390_add_running_cpu(env);
>> @@ -294,8 +291,13 @@ static void s390_init(ram_addr_t my_ram_size,
>>                strlen(kernel_cmdline) + 1);
>>     }
>> 
>> -    /* Create VirtIO network adapters */
>> -    for(i = 0; i < nb_nics; i++) {
>> +}
>> +
>> +static void s390_create_virtio_net(BusState *bus, const char *name)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < nb_nics; i++) {
>>         NICInfo *nd = &nd_table[i];
>>         DeviceState *dev;
>> 
>> @@ -308,7 +310,7 @@ static void s390_init(ram_addr_t my_ram_size,
>>             exit(1);
>>         }
>> 
>> -        dev = qdev_create((BusState *)s390_bus, "virtio-net-s390");
>> +        dev = qdev_create(bus, name);
>>         qdev_set_nic_properties(dev, nd);
>>         qdev_init_nofail(dev);
>>     }
>> @@ -329,6 +331,63 @@ static void s390_init(ram_addr_t my_ram_size,
>>     }
>> }
>> 
>> +/* PC hardware initialisation */
>> +static void s390_init(ram_addr_t my_ram_size,
>> +                      const char *boot_device,
>> +                      const char *kernel_filename,
>> +                      const char *kernel_cmdline,
>> +                      const char *initrd_filename,
>> +                      const char *cpu_model)
>> +{
>> +    CPUS390XState *env = NULL;
>> +    MemoryRegion *sysmem = get_system_memory();
>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +    int shift = 0;
>> +    uint8_t *storage_keys;
>> +    void *virtio_region;
>> +    target_phys_addr_t virtio_region_len;
>> +    target_phys_addr_t virtio_region_start;
>> +
>> +    /* s390x ram size detection needs a 16bit multiplier + an increment. So
>> +       guests > 64GB can be specified in 2MB steps etc. */
>> +    while ((my_ram_size >> (20 + shift)) > 65535) {
>> +        shift++;
>> +    }
>> +    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
>> +
>> +    /* lets propagate the changed ram size into the global variable. */
>> +    ram_size = my_ram_size;
>> +
>> +    /* get a BUS */
>> +    s390_bus = s390_virtio_bus_init(&my_ram_size);
>> +
>> +    /* allocate RAM */
>> +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
>> +    vmstate_register_ram_global(ram);
>> +    memory_region_add_subregion(sysmem, 0, ram);
>> +
>> +    /* clear virtio region */
>> +    virtio_region_len = my_ram_size - ram_size;
>> +    virtio_region_start = ram_size;
>> +    virtio_region = cpu_physical_memory_map(virtio_region_start,
>> +                                            &virtio_region_len, true);
>> +    memset(virtio_region, 0, virtio_region_len);
>> +    cpu_physical_memory_unmap(virtio_region, virtio_region_len, 1,
>> +                              virtio_region_len);
>> +
>> +    /* allocate storage keys */
>> +    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
>> +
>> +    /* init CPUs */
>> +    env = s390_init_cpus(cpu_model, storage_keys);
>> +
>> +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, initrd_filename);
>> +
>> +    /* Create VirtIO network adapters */
>> +    s390_create_virtio_net((BusState *)s390_bus, "virtio-net-s390");
>> +
>> +}
>> +
>> static QEMUMachine s390_machine = {
>>     .name = "s390-virtio",
>>     .alias = "s390",
>> @@ -341,7 +400,6 @@ static QEMUMachine s390_machine = {
>>     .no_sdcard = 1,
>>     .use_virtcon = 1,
>>     .max_cpus = 255,
>> -    .is_default = 1,
>> };
>> 
>> static void s390_machine_init(void)
>> @@ -350,3 +408,80 @@ static void s390_machine_init(void)
>> }
>> 
>> machine_init(s390_machine_init);
> 
> Alex et al.
> 
> Now that we're doing virtio-ccw for s390, any reason to keep around the
> old virtio transport?
> 
> Can we at least schedule it for removal?

We can schedule it for removal, but that's still a few years out. Old kernels (read: all current distros) don't support the ccw machine yet.

So we should at least have virtio-ccw in Debian stable and the by-then current SLES and RHEL releases. Preferably version+1 even. Since those roadmaps are not public yet, I wouldn't dare to settle on a deprecation date yet.


Alex


> 
>> +
>> +static void ccw_init(ram_addr_t my_ram_size,
>> +                     const char *boot_device,
>> +                     const char *kernel_filename,
>> +                     const char *kernel_cmdline,
>> +                     const char *initrd_filename,
>> +                     const char *cpu_model)
>> +{
>> +    CPUS390XState *env = NULL;
>> +    MemoryRegion *sysmem = get_system_memory();
>> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
>> +    int shift = 0;
>> +    uint8_t *storage_keys;
>> +    int ret;
>> +
>> +    /* s390x ram size detection needs a 16bit multiplier + an increment. So
>> +       guests > 64GB can be specified in 2MB steps etc. */
>> +    while ((my_ram_size >> (20 + shift)) > 65535) {
>> +        shift++;
>> +    }
>> +    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
>> +
>> +    /* lets propagate the changed ram size into the global variable. */
>> +    ram_size = my_ram_size;
>> +
>> +    /* get a BUS */
>> +    ccw_bus = virtio_ccw_bus_init();
>> +
>> +    /* allocate RAM */
>> +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
>> +    vmstate_register_ram_global(ram);
>> +    memory_region_add_subregion(sysmem, 0, ram);
>> +
>> +    /* allocate storage keys */
>> +    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
>> +
>> +    /* init CPUs */
>> +    env = s390_init_cpus(cpu_model, storage_keys);
>> +
>> +    kvm_s390_enable_css_support(env);
>> +
>> +    /*
>> +     * Create virtual css and set it as default so that non mcss-e
>> +     * enabled guests only see virtio devices.
>> +     */
>> +    ret = css_create_css_image(VIRTUAL_CSSID, true);
>> +    assert(ret == 0);
>> +
>> +
>> +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, initrd_filename);
>> +
>> +    /* Create VirtIO network adapters */
>> +    s390_create_virtio_net((BusState *)ccw_bus, "virtio-net-ccw");
>> +
>> +}
>> +
>> +static QEMUMachine ccw_machine = {
>> +    .name = "s390-ccw-virtio",
>> +    .alias = "s390-ccw",
>> +    .desc = "VirtIO-ccw based S390 machine",
>> +    .init = ccw_init,
>> +    .no_cdrom = 1,
>> +    .no_floppy = 1,
>> +    .no_serial = 1,
>> +    .no_parallel = 1,
>> +    .no_sdcard = 1,
>> +    .use_virtcon = 1,
>> +    .max_cpus = 255,
>> +    .is_default = 1,
>> +};
>> +
>> +static void ccw_machine_init(void)
>> +{
>> +    qemu_register_machine(&ccw_machine);
>> +}
>> +
>> +machine_init(ccw_machine_init);
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index 93b41fb..e4c3d6f 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -2,3 +2,4 @@ obj-y = s390-virtio-bus.o s390-virtio.o
>> 
>> obj-y := $(addprefix ../,$(obj-y))
>> obj-y += css.o
>> +obj-y += virtio-ccw.o
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index b9b6e48..a671e28 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -441,6 +441,51 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid, uint16_t schid)
>>     return channel_subsys->css[real_cssid]->sch_set[ssid]->sch[schid];
>> }
>> 
>> +bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno)
>> +{
>> +    if (!channel_subsys->css[cssid]) {
>> +        return false;
>> +    }
>> +    if (!channel_subsys->css[cssid]->sch_set[ssid]) {
>> +        return false;
>> +    }
>> +
>> +    return !!test_bit(devno,
>> +                      channel_subsys->css[cssid]->sch_set[ssid]->devnos_used);
>> +}
>> +
>> +void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno,
>> +                      SubchDev *sch)
>> +{
>> +    CssImage *css;
>> +    SubchSet *s_set;
>> +
>> +    if (!channel_subsys->css[cssid]) {
>> +        fprintf(stderr,
>> +                "Suspicious call to %s (%x.%x.%04x) for non-existing css!\n",
>> +                __func__, cssid, ssid, schid);
>> +       return;
>> +   }
>> +    css = channel_subsys->css[cssid];
>> +
>> +   if (!css->sch_set[ssid]) {
>> +        size_t set_size = sizeof(SubchSet) +
>> +            BITS_TO_LONGS(MAX_SCHID + 1) * 2;
>> +        css->sch_set[ssid] = g_malloc0(set_size);
>> +    }
>> +    s_set = css->sch_set[ssid];
>> +
>> +    s_set->sch[schid] = sch;
>> +    if (sch) {
>> +        set_bit(schid, s_set->schids_used);
>> +        set_bit(devno, s_set->devnos_used);
>> +    } else {
>> +        clear_bit(schid, s_set->schids_used);
>> +        clear_bit(schid, s_set->devnos_used);
>> +    }
>> +}
>> +
>> +
>> bool css_present(uint8_t cssid)
>> {
>>     return (channel_subsys->css[cssid] != NULL);
>> diff --git a/hw/s390x/css.h b/hw/s390x/css.h
>> index f3590eb..6876633 100644
>> --- a/hw/s390x/css.h
>> +++ b/hw/s390x/css.h
>> @@ -53,6 +53,9 @@ struct SubchDev {
>> };
>> 
>> int css_create_css_image(uint8_t cssid, bool default_image);
>> +bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
>> +void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno,
>> +                      SubchDev *sch);
>> void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
>> void css_reset(void);
>> void css_reset_sch(SubchDev *sch);
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> new file mode 100644
>> index 0000000..28be1a7
>> --- /dev/null
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -0,0 +1,875 @@
>> +/*
>> + * virtio ccw target implementation
>> + *
>> + * Copyright 2012 IBM Corp.
>> + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include <hw/hw.h>
> 
> #include "hw.h"
> 
>> +#include "block.h"
>> +#include "blockdev.h"
>> +#include "sysemu.h"
>> +#include "net.h"
>> +#include "monitor.h"
>> +#include "qemu-thread.h"
>> +#include "hw/virtio.h"
>> +#include "hw/virtio-serial.h"
>> +#include "hw/virtio-net.h"
>> +#include "hw/sysbus.h"
>> +#include "bitops.h"
>> +
>> +#include "ioinst.h"
>> +#include "css.h"
>> +#include "virtio-ccw.h"
>> +
>> +static const TypeInfo virtio_ccw_bus_info = {
>> +    .name = TYPE_VIRTIO_CCW_BUS,
>> +    .parent = TYPE_BUS,
>> +    .instance_size = sizeof(VirtioCcwBus),
>> +};
>> +
>> +static const VirtIOBindings virtio_ccw_bindings;
>> +
>> +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
>> +{
>> +    VirtIODevice *vdev = NULL;
>> +
>> +    if (sch->driver_data) {
>> +        vdev = ((VirtioCcwData *)sch->driver_data)->vdev;
>> +    }
>> +    return vdev;
>> +}
>> +
>> +static void virtio_ccw_reset_subchannels(void *opaque)
>> +{
>> +    VirtioCcwBus *bus = opaque;
>> +    BusChild *kid;
>> +    VirtioCcwData *data;
>> +
>> +    QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
>> +        data = (VirtioCcwData *)kid->child;
>> +        virtio_reset(data->vdev);
>> +        css_reset_sch(data->sch);
>> +    }
>> +    css_reset();
>> +}
>> +
>> +VirtioCcwBus *virtio_ccw_bus_init(void)
>> +{
>> +    VirtioCcwBus *cbus;
>> +    BusState *bus;
>> +    DeviceState *dev;
>> +
>> +    /* Create bridge device */
>> +    dev = qdev_create(NULL, "virtio-ccw-bridge");
>> +    qdev_init_nofail(dev);
>> +
>> +    /* Create bus on bridge device */
>> +    bus = qbus_create(TYPE_VIRTIO_CCW_BUS, dev, "virtio-ccw");
>> +    cbus = DO_UPCAST(VirtioCcwBus, bus, bus);
>> +
>> +    /* Enable hotplugging */
>> +    bus->allow_hotplug = 1;
>> +
>> +    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
>> +    return cbus;
>> +}
>> +
>> +/* Communication blocks used by several channel commands. */
>> +typedef struct VqInfoBlock {
>> +    uint64_t queue;
>> +    uint32_t align;
>> +    uint16_t index;
>> +    uint16_t num;
>> +} QEMU_PACKED VqInfoBlock;
>> +
>> +typedef struct VqConfigBlock {
>> +    uint16_t index;
>> +    uint16_t num_max;
>> +} QEMU_PACKED VqConfigBlock;
>> +
>> +typedef struct VirtioFeatDesc {
>> +    uint32_t features;
>> +    uint8_t index;
>> +} QEMU_PACKED VirtioFeatDesc;
>> +
>> +/* Specify where the virtqueues for the subchannel are in guest memory. */
>> +static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
>> +                              uint16_t index, uint16_t num)
>> +{
>> +    VirtioCcwData *data = sch->driver_data;
>> +
>> +    if (index > VIRTIO_PCI_QUEUE_MAX) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Current code in virtio.c relies on 4K alignment. */
>> +    if (align != 4096) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!data) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    virtio_queue_set_addr(data->vdev, index, addr);
>> +    if (!addr) {
>> +        virtio_queue_set_vector(data->vdev, index, 0);
>> +    } else {
>> +        /* Fail if we don't have a big enough queue. */
>> +        /* TODO: Add interface to handle vring.num changing */
>> +        if (virtio_queue_get_num(data->vdev, index) > num) {
>> +            return -EINVAL;
>> +        }
>> +        virtio_queue_set_vector(data->vdev, index, index);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int virtio_ccw_cb(SubchDev *sch, CCW1 *ccw)
>> +{
>> +    int ret;
>> +    VqInfoBlock info;
>> +    uint8_t status;
>> +    VirtioFeatDesc features;
>> +    void *config;
>> +    uint64_t *indicators;
>> +    VqConfigBlock vq_config;
>> +    VirtioCcwData *data = sch->driver_data;
>> +    bool check_len;
>> +    int len;
>> +
>> +    if (!ccw) {
>> +        return -EIO;
>> +    }
>> +
>> +    if (!data) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    check_len = !((ccw->flags & CCW_FLAG_SLI) && !(ccw->flags & CCW_FLAG_DC));
>> +
>> +    /* Look at the command. */
>> +    switch (ccw->cmd_code) {
>> +    case CCW_CMD_SET_VQ:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(info)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(info)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
> 
> This is an interesting check.  But I don't think we want to spread
> qemu_get_ram_ptr() around so perhaps you can introduce a
> qemu_is_ram_addr_valid() call?
> 
>> +        } else {
>> +            info.queue = ldq_phys(ccw->cda);
>> +            info.align = ldl_phys(ccw->cda + sizeof(info.queue));
>> +            info.index = lduw_phys(ccw->cda + sizeof(info.queue)
>> +                                   + sizeof(info.align));
>> +            info.num = lduw_phys(ccw->cda + sizeof(info.queue)
>> +                                 + sizeof(info.align)
>> +                                 + sizeof(info.index));
>> +            ret = virtio_ccw_set_vqs(sch, info.queue, info.align, info.index,
>> +                                     info.num);
>> +            sch->curr_status.scsw.count = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_VDEV_RESET:
>> +        virtio_reset(data->vdev);
>> +        ret = 0;
>> +        break;
>> +    case CCW_CMD_READ_FEAT:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(features)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(features)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            features.index = ldub_phys(ccw->cda + sizeof(features.features));
>> +            if (features.index < ARRAY_SIZE(data->host_features)) {
>> +                features.features = data->host_features[features.index];
>> +            } else {
>> +                /* Return zeroes if the guest supports more feature bits. */
>> +                features.features = 0;
>> +            }
>> +            stw_le_phys(ccw->cda, features.features);
>> +            sch->curr_status.scsw.count = ccw->count - sizeof(features);
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_WRITE_FEAT:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(features)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(features)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            features.index = ldub_phys(ccw->cda + sizeof(features.features));
>> +            features.features = bswap32(lduw_phys(ccw->cda));
>> +            if (features.index < ARRAY_SIZE(data->host_features)) {
>> +                if (data->vdev->set_features) {
>> +                    data->vdev->set_features(data->vdev, features.features);
>> +                }
>> +                data->vdev->guest_features = features.features;
>> +            } else {
>> +                /*
>> +                 * If the guest supports more feature bits, assert that it
>> +                 * passes us zeroes for those we don't support.
>> +                 */
>> +                if (features.features) {
>> +                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
>> +                            features.index, features.features);
>> +                    /* XXX: do a unit check here? */
> 
> In general, we try to avoid guest initiated printf()s.  libvirt blindly
> logs stdio from QEMU to the disk file system and a malicious guest
> could, in theory, exhaust the host disk space.
> 
>> +                }
>> +            }
>> +            sch->curr_status.scsw.count = ccw->count - sizeof(features);
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_READ_CONF:
>> +        if (check_len) {
>> +            if (ccw->count > data->vdev->config_len) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        }
>> +        len = MIN(ccw->count, data->vdev->config_len);
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            data->vdev->get_config(data->vdev, data->vdev->config);
>> +            cpu_physical_memory_write(ccw->cda, data->vdev->config, len);
>> +            sch->curr_status.scsw.count = ccw->count - len;
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_WRITE_CONF:
>> +        if (check_len) {
>> +            if (ccw->count > data->vdev->config_len) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        }
>> +        len = MIN(ccw->count, data->vdev->config_len);
>> +        config = qemu_get_ram_ptr(ccw->cda);
>> +        if (!config) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            memcpy(data->vdev->config, config, len);
>> +            if (data->vdev->set_config) {
>> +                data->vdev->set_config(data->vdev, data->vdev->config);
>> +            }
>> +            sch->curr_status.scsw.count = ccw->count - len;
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_WRITE_STATUS:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(status)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(status)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            status = ldub_phys(ccw->cda);
>> +            virtio_set_status(data->vdev, status);
>> +            sch->curr_status.scsw.count = ccw->count - sizeof(status);
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_SET_IND:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(*indicators)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(*indicators)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        indicators = qemu_get_ram_ptr(ccw->cda);
>> +        if (!indicators) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            data->indicators = ccw->cda;
>> +            sch->curr_status.scsw.count = ccw->count - sizeof(*indicators);
>> +            ret = 0;
>> +        }
>> +        break;
>> +    case CCW_CMD_READ_VQ_CONF:
>> +        if (check_len) {
>> +            if (ccw->count != sizeof(vq_config)) {
>> +                ret = -EINVAL;
>> +                break;
>> +            }
>> +        } else if (ccw->count < sizeof(vq_config)) {
>> +            /* Can't execute command. */
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +        if (!qemu_get_ram_ptr(ccw->cda)) {
>> +            ret = -EFAULT;
>> +        } else {
>> +            vq_config.index = lduw_phys(ccw->cda);
>> +            vq_config.num_max = virtio_queue_get_num(data->vdev,
>> +                                                     vq_config.index);
>> +            stw_phys(ccw->cda + sizeof(vq_config.index), vq_config.num_max);
>> +            sch->curr_status.scsw.count = ccw->count - sizeof(vq_config);
>> +            ret = 0;
>> +        }
>> +        break;
>> +    default:
>> +        ret = -EOPNOTSUPP;
>> +        break;
>> +    }
>> +    return ret;
>> +}
>> +
>> +static int virtio_ccw_device_init(VirtioCcwData *dev, VirtIODevice *vdev)
>> +{
>> +    unsigned int cssid = 0;
>> +    unsigned int ssid = 0;
>> +    unsigned int schid;
>> +    unsigned int devno;
>> +    bool have_devno = false;
>> +    bool found = false;
>> +    SubchDev *sch;
>> +    int ret;
>> +    int num;
>> +
>> +    sch = g_malloc0(sizeof(SubchDev));
>> +
>> +    sch->driver_data = dev;
>> +    dev->sch = sch;
>> +
>> +    dev->vdev = vdev;
>> +    dev->indicators = 0;
>> +
>> +    /* Initialize subchannel structure. */
>> +    qemu_mutex_init(&sch->mutex);
>> +    sch->channel_prog = NULL;
>> +    sch->last_cmd = NULL;
>> +    sch->orb = NULL;
>> +    /*
>> +     * Use a device number if provided. Otherwise, fall back to subchannel
>> +     * number.
>> +     */
>> +    if (dev->bus_id) {
>> +        num = sscanf(dev->bus_id, "%x.%x.%04x", &cssid, &ssid, &devno);
>> +        if (num == 3) {
>> +            if ((cssid > MAX_CSSID) || (ssid > MAX_SSID)) {
>> +                ret = -EINVAL;
>> +                error_report("Invalid cssid or ssid: cssid %x, ssid %x",
>> +                             cssid, ssid);
>> +                goto out_err;
>> +            }
>> +            /* Enforce use of virtual cssid. */
>> +            if (cssid != VIRTUAL_CSSID) {
>> +                ret = -EINVAL;
>> +                error_report("cssid %x not valid for virtio devices", cssid);
>> +                goto out_err;
>> +            }
>> +            if (css_devno_used(cssid, ssid, devno)) {
>> +                ret = -EEXIST;
>> +                error_report("Device %x.%x.%04x already exists", cssid, ssid,
>> +                             devno);
>> +                goto out_err;
>> +            }
>> +            sch->cssid = cssid;
>> +            sch->ssid = ssid;
>> +            sch->devno = devno;
>> +            have_devno = true;
>> +        } else {
>> +            ret = -EINVAL;
>> +            error_report("Malformed devno parameter '%s'", dev->bus_id);
>> +            goto out_err;
>> +        }
>> +    }
>> +
>> +    /* Find the next free id. */
>> +    if (have_devno) {
>> +        for (schid = 0; schid <= MAX_SCHID; schid++) {
>> +            if (!css_find_subch(1, cssid, ssid, schid)) {
>> +                sch->schid = schid;
>> +                css_subch_assign(cssid, ssid, schid, devno, sch);
>> +                found = true;
>> +                break;
>> +            }
>> +        }
>> +        if (!found) {
>> +            ret = -ENODEV;
>> +            error_report("No free subchannel found for %x.%x.%04x", cssid, ssid,
>> +                         devno);
>> +            goto out_err;
>> +        }
>> +    } else {
>> +        cssid = VIRTUAL_CSSID;
>> +        for (ssid = 0; ssid <= MAX_SSID; ssid++) {
>> +            for (schid = 0; schid <= MAX_SCHID; schid++) {
>> +                if (!css_find_subch(1, cssid, ssid, schid)) {
>> +                    sch->cssid = cssid;
>> +                    sch->ssid = ssid;
>> +                    sch->schid = schid;
>> +                    devno = schid;
>> +                    /*
>> +                     * If the devno is already taken, look further in this
>> +                     * subchannel set.
>> +                     */
>> +                    while (css_devno_used(cssid, ssid, devno)) {
>> +                        if (devno == MAX_SCHID) {
>> +                            devno = 0;
>> +                        } else if (devno == schid - 1) {
>> +                            ret = -ENODEV;
>> +                            error_report("No free devno found");
>> +                            goto out_err;
>> +                        } else {
>> +                            devno++;
>> +                        }
>> +                    }
>> +                    sch->devno = devno;
>> +                    css_subch_assign(cssid, ssid, schid, devno, sch);
>> +                    found = true;
>> +                    break;
>> +                }
>> +            }
>> +            if (found) {
>> +                break;
>> +            }
>> +        }
>> +        if (!found) {
>> +            ret = -ENODEV;
>> +            error_report("Virtual channel subsystem is full!");
>> +            goto out_err;
>> +        }
>> +    }
>> +
>> +    /* Build initial schib. */
>> +    css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
>> +
>> +    sch->ccw_cb = virtio_ccw_cb;
>> +
>> +    /* Build senseid data. */
>> +    memset(&sch->id, 0, sizeof(SenseId));
>> +    sch->id.reserved = 0xff;
>> +    sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
>> +    sch->id.cu_model = dev->vdev->device_id;
>> +
>> +    virtio_bind_device(vdev, &virtio_ccw_bindings, dev);
>> +    /* Only the first 32 feature bits are used. */
>> +    dev->host_features[0] = vdev->get_features(vdev, dev->host_features[0]);
>> +
>> +    s390_sch_hotplug(sch->cssid, sch->ssid, sch->schid, sch->devno,
>> +                     &sch->curr_status, dev->qdev.hotplugged, 1, 1);
>> +    return 0;
>> +
>> +out_err:
>> +    dev->sch = NULL;
>> +    g_free(sch);
>> +    return ret;
>> +}
>> +
>> +static int virtio_ccw_exit(VirtioCcwData *dev)
>> +{
>> +    SubchDev *sch = dev->sch;
>> +
>> +    if (sch) {
>> +        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>> +        g_free(sch);
>> +    }
>> +    dev->indicators = 0;
>> +    return 0;
>> +}
>> +
>> +static int virtio_ccw_net_init(VirtioCcwData *dev)
>> +{
>> +    VirtIODevice *vdev;
>> +
>> +    vdev = virtio_net_init((DeviceState *)dev, &dev->nic, &dev->net);
>> +    if (!vdev) {
>> +        return -1;
>> +    }
>> +
>> +    return virtio_ccw_device_init(dev, vdev);
>> +}
>> +
>> +static int virtio_ccw_net_exit(VirtioCcwData *dev)
>> +{
>> +    virtio_net_exit(dev->vdev);
>> +    return virtio_ccw_exit(dev);
>> +}
>> +
>> +static int virtio_ccw_blk_init(VirtioCcwData *dev)
>> +{
>> +    VirtIODevice *vdev;
>> +
>> +    vdev = virtio_blk_init((DeviceState *)dev, &dev->blk);
>> +    if (!vdev) {
>> +        return -1;
>> +    }
>> +
>> +    return virtio_ccw_device_init(dev, vdev);
>> +}
>> +
>> +static int virtio_ccw_blk_exit(VirtioCcwData *dev)
>> +{
>> +    virtio_blk_exit(dev->vdev);
>> +    blockdev_mark_auto_del(dev->blk.conf.bs);
>> +    return virtio_ccw_exit(dev);
>> +}
>> +
>> +static int virtio_ccw_serial_init(VirtioCcwData *dev)
>> +{
>> +    VirtioCcwBus *bus;
>> +    VirtIODevice *vdev;
>> +    int r;
>> +
>> +    bus = DO_UPCAST(VirtioCcwBus, bus, dev->qdev.parent_bus);
>> +
>> +    vdev = virtio_serial_init((DeviceState *)dev, &dev->serial);
>> +    if (!vdev) {
>> +        return -1;
>> +    }
>> +
>> +    r = virtio_ccw_device_init(dev, vdev);
>> +    if (!r) {
>> +        bus->console = dev;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +static int virtio_ccw_serial_exit(VirtioCcwData *dev)
>> +{
>> +    VirtioCcwBus *bus;
>> +
>> +    bus = DO_UPCAST(VirtioCcwBus, bus, dev->qdev.parent_bus);
>> +    bus->console = NULL;
>> +    virtio_serial_exit(dev->vdev);
>> +    return virtio_ccw_exit(dev);
>> +}
>> +
>> +static int virtio_ccw_balloon_init(VirtioCcwData *dev)
>> +{
>> +    VirtIODevice *vdev;
>> +
>> +    vdev = virtio_balloon_init((DeviceState *)dev);
>> +    if (!vdev) {
>> +        return -1;
>> +    }
>> +
>> +    return virtio_ccw_device_init(dev, vdev);
>> +}
>> +
>> +static int virtio_ccw_balloon_exit(VirtioCcwData *dev)
>> +{
>> +    virtio_balloon_exit(dev->vdev);
>> +    return virtio_ccw_exit(dev);
>> +}
>> +
>> +static int virtio_ccw_scsi_init(VirtioCcwData *dev)
>> +{
>> +    VirtIODevice *vdev;
>> +
>> +    vdev = virtio_scsi_init((DeviceState *)dev, &dev->scsi);
>> +    if (!vdev) {
>> +        return -1;
>> +    }
>> +
>> +    return virtio_ccw_device_init(dev, vdev);
>> +}
>> +
>> +static int virtio_ccw_scsi_exit(VirtioCcwData *dev)
>> +{
>> +    virtio_scsi_exit(dev->vdev);
>> +    return virtio_ccw_exit(dev);
>> +}
>> +
>> +VirtioCcwData *virtio_ccw_bus_console(VirtioCcwBus *bus)
>> +{
>> +    return bus->console;
>> +}
>> +
>> +static void virtio_ccw_notify(void *opaque, uint16_t vector)
>> +{
>> +    VirtioCcwData *dev = opaque;
>> +    SubchDev *sch = dev->sch;
>> +    uint64_t indicators;
>> +
>> +    if (vector >= VIRTIO_PCI_QUEUE_MAX) {
>> +        return;
>> +    }
>> +
>> +    qemu_mutex_lock(&sch->mutex);
>> +    indicators = ldq_phys(dev->indicators);
>> +    set_bit(vector, &indicators);
>> +    stq_phys(dev->indicators, indicators);
>> +
>> +    css_conditional_io_interrupt(sch);
>> +
>> +    qemu_mutex_unlock(&sch->mutex);
> 
> I don't understand the mutex here...
> 
>> +}
>> +
>> +static unsigned virtio_ccw_get_features(void *opaque)
>> +{
>> +    VirtioCcwData *dev = opaque;
>> +
>> +    /* Only the first 32 feature bits are used. */
>> +    return dev->host_features[0];
>> +}
>> +
>> +/**************** Virtio-ccw Bus Device Descriptions *******************/
>> +
>> +static const VirtIOBindings virtio_ccw_bindings = {
>> +    .notify = virtio_ccw_notify,
>> +    .get_features = virtio_ccw_get_features,
>> +};
>> +
>> +static Property virtio_ccw_net_properties[] = {
>> +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
>> +    DEFINE_NIC_PROPERTIES(VirtioCcwData, nic),
>> +    DEFINE_PROP_UINT32("x-txtimer", VirtioCcwData,
>> +                       net.txtimer, TX_TIMER_INTERVAL),
>> +    DEFINE_PROP_INT32("x-txburst", VirtioCcwData,
>> +                      net.txburst, TX_BURST),
>> +    DEFINE_PROP_STRING("tx", VirtioCcwData, net.tx),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_net_init;
>> +    k->exit = virtio_ccw_net_exit;
>> +    dc->props = virtio_ccw_net_properties;
>> +}
>> +
>> +static TypeInfo virtio_ccw_net = {
>> +    .name          = "virtio-net-ccw",
>> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init    = virtio_ccw_net_class_init,
>> +};
>> +
>> +static Property virtio_ccw_blk_properties[] = {
>> +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
>> +    DEFINE_BLOCK_PROPERTIES(VirtioCcwData, blk.conf),
>> +    DEFINE_PROP_STRING("serial", VirtioCcwData, blk.serial),
>> +#ifdef __linux__
>> +    DEFINE_PROP_BIT("scsi", VirtioCcwData, blk.scsi, 0, true),
>> +#endif
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_blk_init;
>> +    k->exit = virtio_ccw_blk_exit;
>> +    dc->props = virtio_ccw_blk_properties;
>> +}
>> +
>> +static TypeInfo virtio_ccw_blk = {
>> +    .name          = "virtio-blk-ccw",
>> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init    = virtio_ccw_blk_class_init,
>> +};
>> +
>> +static Property virtio_ccw_serial_properties[] = {
>> +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
>> +    DEFINE_PROP_UINT32("max_ports", VirtioCcwData, serial.max_virtserial_ports,
>> +                       31),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_serial_init;
>> +    k->exit = virtio_ccw_serial_exit;
>> +    dc->props = virtio_ccw_serial_properties;
>> +}
>> +
>> +static TypeInfo virtio_ccw_serial = {
>> +    .name          = "virtio-serial-ccw",
>> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init    = virtio_ccw_serial_class_init,
>> +};
>> +
>> +static Property virtio_ccw_balloon_properties[] = {
>> +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_balloon_init;
>> +    k->exit = virtio_ccw_balloon_exit;
>> +    dc->props = virtio_ccw_balloon_properties;
>> +}
>> +
>> +static TypeInfo virtio_ccw_balloon = {
>> +    .name          = "virtio-balloon-ccw",
>> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init    = virtio_ccw_balloon_class_init,
>> +};
>> +
>> +static Property virtio_ccw_scsi_properties[] = {
>> +    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
>> +    DEFINE_VIRTIO_SCSI_PROPERTIES(VirtioCcwData, host_features[0], scsi),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_scsi_init;
>> +    k->exit = virtio_ccw_scsi_exit;
>> +    dc->props = virtio_ccw_scsi_properties;
>> +}
>> +
>> +static TypeInfo virtio_ccw_scsi = {
>> +    .name          = "virtio-scsi-ccw",
>> +    .parent        = TYPE_VIRTIO_CCW_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init    = virtio_ccw_scsi_class_init,
>> +};
>> +
>> +static int virtio_ccw_busdev_init(DeviceState *dev)
>> +{
>> +    VirtioCcwData *_dev = (VirtioCcwData *)dev;
>> +    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>> +
>> +    return _info->init(_dev);
>> +}
>> +
>> +static int virtio_ccw_busdev_exit(DeviceState *dev)
>> +{
>> +    VirtioCcwData *_dev = (VirtioCcwData *)dev;
>> +    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>> +
>> +    return _info->exit(_dev);
>> +}
>> +
>> +static int virtio_ccw_busdev_unplug(DeviceState *dev)
>> +{
>> +    VirtioCcwData *_dev = (VirtioCcwData *)dev;
>> +    SubchDev *sch = _dev->sch;
>> +
>> +    /*
>> +     * We should arrive here only for device_del, since we don't support
>> +     * direct hot(un)plug of channels, but only through virtio.
>> +     */
>> +    assert(sch != NULL);
>> +    /* Subchannel is now disabled and no longer valid. */
>> +    qemu_mutex_lock(&sch->mutex);
>> +    sch->curr_status.pmcw.ena = 0;
>> +    sch->curr_status.pmcw.dnv = 0;
>> +    qemu_mutex_unlock(&sch->mutex);
>> +
>> +    s390_sch_hotplug(sch->cssid, sch->ssid, sch->schid, sch->devno,
>> +                     &sch->curr_status, 1, 0, 1);
>> +
>> +    object_unparent(OBJECT(dev));
>> +    qdev_free(dev);
>> +    return 0;
>> +}
>> +
>> +static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->init = virtio_ccw_busdev_init;
>> +    dc->exit = virtio_ccw_busdev_exit;
>> +    dc->unplug = virtio_ccw_busdev_unplug;
>> +    dc->bus_type = TYPE_VIRTIO_CCW_BUS;
>> +
>> +}
>> +
>> +static TypeInfo virtio_ccw_device_info = {
>> +    .name = TYPE_VIRTIO_CCW_DEVICE,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_size = sizeof(VirtioCcwData),
>> +    .class_init = virtio_ccw_device_class_init,
>> +    .class_size = sizeof(VirtIOCCWDeviceClass),
>> +    .abstract = true,
>> +};
>> +
>> +/***************** Virtio-ccw Bus Bridge Device ********************/
>> +/* Only required to have the virtio bus as child in the system bus */
>> +
>> +static int virtio_ccw_bridge_init(SysBusDevice *dev)
>> +{
>> +    /* nothing */
>> +    return 0;
>> +}
>> +
>> +static void virtio_ccw_bridge_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
>> +
>> +    k->init = virtio_ccw_bridge_init;
>> +    dc->no_user = 1;
>> +}
>> +
>> +static TypeInfo virtio_ccw_bridge_info = {
>> +    .name          = "virtio-ccw-bridge",
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(SysBusDevice),
>> +    .class_init    = virtio_ccw_bridge_class_init,
>> +};
>> +
>> +static void virtio_ccw_register(void)
>> +{
>> +    type_register_static(&virtio_ccw_bus_info);
>> +    type_register_static(&virtio_ccw_device_info);
>> +    type_register_static(&virtio_ccw_serial);
>> +    type_register_static(&virtio_ccw_blk);
>> +    type_register_static(&virtio_ccw_net);
>> +    type_register_static(&virtio_ccw_balloon);
>> +    type_register_static(&virtio_ccw_scsi);
>> +    type_register_static(&virtio_ccw_bridge_info);
>> +}
>> +type_init(virtio_ccw_register);
>> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
>> new file mode 100644
>> index 0000000..8125acf
>> --- /dev/null
>> +++ b/hw/s390x/virtio-ccw.h
>> @@ -0,0 +1,79 @@
>> +/*
>> + * virtio ccw target definitions
>> + *
>> + * Copyright 2012 IBM Corp.
>> + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include <hw/virtio-blk.h>
>> +#include <hw/virtio-net.h>
>> +#include <hw/virtio-serial.h>
>> +#include <hw/virtio-scsi.h>
>> +
>> +#define VIRTUAL_CSSID 0xfe
>> +
>> +#define VIRTIO_CCW_CU_TYPE 0x3832
>> +#define VIRTIO_CCW_CHPID_TYPE 0x32
>> +
>> +#define CCW_CMD_SET_VQ       0x13
>> +#define CCW_CMD_VDEV_RESET   0x33
>> +#define CCW_CMD_READ_FEAT    0x12
>> +#define CCW_CMD_WRITE_FEAT   0x11
>> +#define CCW_CMD_READ_CONF    0x22
>> +#define CCW_CMD_WRITE_CONF   0x21
>> +#define CCW_CMD_WRITE_STATUS 0x31
>> +#define CCW_CMD_SET_IND      0x43
>> +#define CCW_CMD_READ_VQ_CONF 0x32
>> +
>> +#define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
>> +#define VIRTIO_CCW_DEVICE(obj) \
>> +     OBJECT_CHECK(VirtioCcwData, (obj), TYPE_VIRTIO_CCW_DEVICE)
>> +#define VIRTIO_CCW_DEVICE_CLASS(klass) \
>> +     OBJECT_CLASS_CHECK(VirtIOCCWDeviceClass, (klass), TYPE_VIRTIO_CCW_DEVICE)
>> +#define VIRTIO_CCW_DEVICE_GET_CLASS(obj) \
>> +     OBJECT_GET_CLASS(VirtIOCCWDeviceClass, (obj), TYPE_VIRTIO_CCW_DEVICE)
>> +
>> +#define TYPE_VIRTIO_CCW_BUS "virtio-ccw-bus"
>> +#define VIRTIO_CCW_BUS(obj) \
>> +     OBJECT_CHECK(VirtioCcwBus, (obj), TYPE_VIRTIO_CCW_BUS)
>> +
>> +typedef struct VirtioCcwData VirtioCcwData;
>> +
>> +typedef struct VirtIOCCWDeviceClass {
>> +    DeviceClass qdev;
>> +    int (*init)(VirtioCcwData *dev);
>> +    int (*exit)(VirtioCcwData *dev);
>> +} VirtIOCCWDeviceClass;
>> +
>> +/* Change here if we want to support more feature bits. */
>> +#define VIRTIO_CCW_FEATURE_SIZE 1
>> +
>> +struct VirtioCcwData {
>> +    DeviceState qdev;
>> +    SubchDev *sch;
>> +    VirtIODevice *vdev;
>> +    char *bus_id;
>> +    VirtIOBlkConf blk;
>> +    NICConf nic;
>> +    uint32_t host_features[VIRTIO_CCW_FEATURE_SIZE];
>> +    virtio_serial_conf serial;
>> +    virtio_net_conf net;
>> +    VirtIOSCSIConf scsi;
>> +    /* Guest provided values: */
>> +    target_phys_addr_t indicators;
>> +};
>> +
>> +/* virtio-ccw bus type */
>> +typedef struct VirtioCcwBus {
>> +    BusState bus;
>> +    VirtioCcwData *console;
>> +} VirtioCcwBus;
>> +
>> +VirtioCcwBus *virtio_ccw_bus_init(void);
>> +void virtio_ccw_device_update_status(SubchDev *sch);
>> +VirtioCcwData *virtio_ccw_bus_console(VirtioCcwBus *bus);
>> +VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch);
>> diff --git a/vl.c b/vl.c
>> index 7c577fa..2b8cae6 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -289,6 +289,7 @@ static struct {
>>     { .driver = "scsi-cd",              .flag = &default_cdrom     },
>>     { .driver = "virtio-serial-pci",    .flag = &default_virtcon   },
>>     { .driver = "virtio-serial-s390",   .flag = &default_virtcon   },
>> +    { .driver = "virtio-serial-ccw",    .flag = &default_virtcon   },
>>     { .driver = "virtio-serial",        .flag = &default_virtcon   },
>>     { .driver = "VGA",                  .flag = &default_vga       },
>>     { .driver = "isa-vga",              .flag = &default_vga       },
>> -- 
>> 1.7.11.5
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe kvm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
