From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 12/12] s390: Add s390-ccw-virtio machine.
Date: Fri, 18 Jan 2013 18:24:36 +0100
Message-ID: <906ADD96-F8C3-463D-9D6B-9D7C5F022120@suse.de>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com> <1358432637-42512-13-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-13-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 17.01.2013, at 15:23, Cornelia Huck wrote:

> Add a new machine type, s390-ccw-virtio, making use of the
> virtio-ccw transport to present virtio devices as channel
> devices and make it the default on s390.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> hw/s390-virtio.c           |   1 -
> hw/s390-virtio.h           |   1 +
> hw/s390x/Makefile.objs     |   1 +
> hw/s390x/s390-virtio-ccw.c | 141 +++++++++++++++++++++++++++++++++++++++++++++
> 4 files changed, 143 insertions(+), 1 deletion(-)
> create mode 100644 hw/s390x/s390-virtio-ccw.c
> 
> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> index 603f6b0..3e58bc2 100644
> --- a/hw/s390-virtio.c
> +++ b/hw/s390-virtio.c
> @@ -353,7 +353,6 @@ static QEMUMachine s390_machine = {
>     .no_sdcard = 1,
>     .use_virtcon = 1,
>     .max_cpus = 255,
> -    .is_default = 1,
>     DEFAULT_MACHINE_OPTIONS,
> };
> 
> diff --git a/hw/s390-virtio.h b/hw/s390-virtio.h
> index aefc99d..a2cad40 100644
> --- a/hw/s390-virtio.h
> +++ b/hw/s390-virtio.h
> @@ -15,6 +15,7 @@
> #define KVM_S390_VIRTIO_NOTIFY          0
> #define KVM_S390_VIRTIO_RESET           1
> #define KVM_S390_VIRTIO_SET_STATUS      2
> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
> 
> typedef int (*s390_virtio_fn)(const uint64_t *args);
> void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 71ad255..54688b4 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -6,4 +6,5 @@ obj-y += sclp.o
> obj-y += event-facility.o
> obj-y += sclpquiesce.o sclpconsole.o
> obj-y += css.o
> +obj-y += s390-virtio-ccw.o
> obj-y += virtio-ccw.o
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> new file mode 100644
> index 0000000..98552d3
> --- /dev/null
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -0,0 +1,141 @@
> +/*
> + * virtio ccw machine
> + *
> + * Copyright 2012 IBM Corp.
> + * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#include "hw/boards.h"
> +#include "exec/address-spaces.h"
> +#include "hw/s390-virtio.h"
> +#include "hw/s390x/sclp.h"
> +#include "ioinst.h"
> +#include "css.h"
> +#include "virtio-ccw.h"
> +
> +static VirtioCcwBus *ccw_bus;
> +
> +static int virtio_ccw_hcall_notify(const uint64_t *args)
> +{
> +    uint64_t subch_id = args[0];
> +    uint64_t queue = args[1];
> +    SubchDev *sch;
> +    int cssid, ssid, schid, m;
> +
> +    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
> +        return -EINVAL;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (!sch || !css_subch_visible(sch)) {
> +        return -EINVAL;
> +    }
> +    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
> +    return 0;
> +
> +}
> +
> +static int virtio_ccw_hcall_early_printk(const uint64_t *args)
> +{
> +    uint64_t mem = args[0];
> +
> +    if (mem < ram_size) {
> +        /* Early printk */
> +        return 0;
> +    }
> +    return -EINVAL;
> +}
> +
> +static void virtio_ccw_register_hcalls(void)
> +{
> +    s390_register_virtio_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY,
> +                                   virtio_ccw_hcall_notify);
> +    /* Tolerate early printk. */
> +    s390_register_virtio_hypercall(KVM_S390_VIRTIO_NOTIFY,
> +                                   virtio_ccw_hcall_early_printk);
> +}
> +
> +static void ccw_init(QEMUMachineInitArgs *args)
> +{
> +    ram_addr_t my_ram_size = args->ram_size;
> +    const char *cpu_model = args->cpu_model;
> +    const char *kernel_filename = args->kernel_filename;
> +    const char *kernel_cmdline = args->kernel_cmdline;
> +    const char *initrd_filename = args->initrd_filename;
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
> +    /* register hypercalls */
> +    virtio_ccw_register_hcalls();
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
> +    s390_init_cpus(cpu_model, storage_keys);
> +
> +    kvm_s390_enable_css_support(s390_cpu_addr2state(0));
> +
> +    /*
> +     * Create virtual css and set it as default so that non mcss-e
> +     * enabled guests only see virtio devices.
> +     */
> +    ret = css_create_css_image(VIRTUAL_CSSID, true);
> +    assert(ret == 0);
> +
> +
> +    s390_set_up_kernel(kernel_filename, kernel_cmdline, initrd_filename);
> +
> +    /* Create VirtIO network adapters */
> +    s390_create_virtio_net(BUS(ccw_bus), "virtio-net-ccw");
> +
> +}
> +
> +static QEMUMachine ccw_machine = {
> +    .name = "s390-ccw-virtio",
> +    .alias = "s390-ccw",
> +    .desc = "VirtIO-ccw based S390 machine",
> +    .init = ccw_init,
> +    .block_default_type = IF_VIRTIO,
> +    .no_cdrom = 1,
> +    .no_floppy = 1,
> +    .no_serial = 1,
> +    .no_parallel = 1,
> +    .no_sdcard = 1,
> +    .use_virtcon = 1,

Still using virtcon? :)


Alex

> +    .max_cpus = 255,
> +    .is_default = 1,
> +    DEFAULT_MACHINE_OPTIONS,
> +};
> +
> +static void ccw_machine_init(void)
> +{
> +    qemu_register_machine(&ccw_machine);
> +}
> +
> +machine_init(ccw_machine_init);
> -- 
> 1.7.12.4
> 
