From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] s390: Add new channel I/O based virtio
 transport.
Date: Wed, 16 Jan 2013 14:58:17 +0100
Message-ID: <20130116145817.3957a763@gondolin>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
	<22014A51-6745-4B48-AF72-4AEEE5AB67E2@suse.de>
	<50C9AACA-4975-421A-AD8F-53CF313BB7C2@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <50C9AACA-4975-421A-AD8F-53CF313BB7C2@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 Jan 2013 14:53:06 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 16.01.2013, at 14:24, Alexander Graf wrote:
> 
> > 
> > On 07.12.2012, at 13:50, Cornelia Huck wrote:
> > 
> >> Add a new virtio transport that uses channel commands to perform
> >> virtio operations.
> >> 
> >> Add a new machine type s390-ccw that uses this virtio-ccw transport
> >> and make it the default machine for s390.
> >> 
> >> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> >> ---
> >> hw/s390-virtio.c       | 149 ++++++--
> >> hw/s390x/Makefile.objs |   1 +
> >> hw/s390x/virtio-ccw.c  | 909 +++++++++++++++++++++++++++++++++++++++++++++++++
> >> hw/s390x/virtio-ccw.h  |  81 +++++
> >> trace-events           |   4 +
> >> 5 files changed, 1124 insertions(+), 20 deletions(-)
> >> create mode 100644 hw/s390x/virtio-ccw.c
> >> create mode 100644 hw/s390x/virtio-ccw.h
> >> 
> >> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> >> index 9e1afb2..f29ff74 100644
> >> --- a/hw/s390-virtio.c
> >> +++ b/hw/s390-virtio.c
> >> @@ -33,6 +33,8 @@
> >> 
> >> #include "hw/s390-virtio-bus.h"
> >> #include "hw/s390x/sclp.h"
> >> +#include "hw/s390x/css.h"
> >> +#include "hw/s390x/virtio-ccw.h"
> >> 
> >> //#define DEBUG_S390
> >> 
> >> @@ -47,6 +49,7 @@
> >> #define KVM_S390_VIRTIO_NOTIFY          0
> >> #define KVM_S390_VIRTIO_RESET           1
> >> #define KVM_S390_VIRTIO_SET_STATUS      2
> >> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
> >> 
> >> #define KERN_IMAGE_START                0x010000UL
> >> #define KERN_PARM_AREA                  0x010480UL
> >> @@ -63,6 +66,7 @@
> >> 
> >> static VirtIOS390Bus *s390_bus;
> >> static S390CPU **ipi_states;
> >> +VirtioCcwBus *ccw_bus;
> >> 
> >> S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >> {
> >> @@ -76,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >> int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
> >> {
> >>    int r = 0, i;
> >> +    int cssid, ssid, schid, m;
> >> +    SubchDev *sch;
> >> 
> >>    dprintf("KVM hypercall: %ld\n", hypercall);
> >>    switch (hypercall) {
> >>    case KVM_S390_VIRTIO_NOTIFY:
> >>        if (mem > ram_size) {
> >> -            VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> >> -                                                               mem, &i);
> >> -            if (dev) {
> >> -                virtio_queue_notify(dev->vdev, i);
> >> +            if (s390_bus) {
> >> +                VirtIOS390Device *dev = s390_virtio_bus_find_vring(s390_bus,
> >> +                                                                   mem, &i);
> >> +                if (dev) {
> >> +                    virtio_queue_notify(dev->vdev, i);
> >> +                } else {
> >> +                    r = -EINVAL;
> >> +                }
> >>            } else {
> >>                r = -EINVAL;
> >>            }
> >> @@ -93,28 +103,49 @@ int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t hypercall)
> >>        }
> >>        break;
> >>    case KVM_S390_VIRTIO_RESET:
> >> -    {
> >> -        VirtIOS390Device *dev;
> >> -
> >> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> >> -        virtio_reset(dev->vdev);
> >> -        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> >> -        s390_virtio_device_sync(dev);
> >> -        s390_virtio_reset_idx(dev);
> >> +        if (s390_bus) {
> >> +            VirtIOS390Device *dev;
> >> +
> >> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> >> +            virtio_reset(dev->vdev);
> >> +            stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> >> +            s390_virtio_device_sync(dev);
> >> +            s390_virtio_reset_idx(dev);
> >> +        } else {
> >> +            r = -EINVAL;
> >> +        }
> >>        break;
> >> -    }
> >>    case KVM_S390_VIRTIO_SET_STATUS:
> >> -    {
> >> -        VirtIOS390Device *dev;
> >> +        if (s390_bus) {
> >> +            VirtIOS390Device *dev;
> >> 
> >> -        dev = s390_virtio_bus_find_mem(s390_bus, mem);
> >> -        if (dev) {
> >> -            s390_virtio_device_update_status(dev);
> >> +            dev = s390_virtio_bus_find_mem(s390_bus, mem);
> >> +            if (dev) {
> >> +                s390_virtio_device_update_status(dev);
> >> +            } else {
> >> +                r = -EINVAL;
> >> +            }
> >>        } else {
> >>            r = -EINVAL;
> >>        }
> >>        break;
> >> -    }
> >> +    case KVM_S390_VIRTIO_CCW_NOTIFY:
> >> +        if (ccw_bus) {
> >> +            if (ioinst_disassemble_sch_ident(env->regs[2], &m, &cssid, &ssid,
> >> +                                             &schid)) {
> >> +                r = -EINVAL;
> >> +            } else {
> >> +                sch = css_find_subch(m, cssid, ssid, schid);
> >> +                if (sch && css_subch_visible(sch)) {
> >> +                    virtio_queue_notify(virtio_ccw_get_vdev(sch), env->regs[3]);
> >> +                } else {
> >> +                    r = -EINVAL;
> >> +                }
> >> +            }
> >> +         } else {
> >> +             r = -EINVAL;
> >> +         }
> >> +         break;
> >>    default:
> >>        r = -EINVAL;
> >>        break;
> >> @@ -370,7 +401,6 @@ static QEMUMachine s390_machine = {
> >>    .no_sdcard = 1,
> >>    .use_virtcon = 1,
> >>    .max_cpus = 255,
> >> -    .is_default = 1,
> >> };
> >> 
> >> static void s390_machine_init(void)
> >> @@ -379,3 +409,82 @@ static void s390_machine_init(void)
> >> }
> >> 
> >> machine_init(s390_machine_init);
> >> +
> >> +static void ccw_init(QEMUMachineInitArgs *args)
> >> +{
> >> +    ram_addr_t my_ram_size = args->ram_size;
> >> +    ram_addr_t ram_size = args->ram_size;
> >> +    const char *cpu_model = args->cpu_model;
> >> +    const char *kernel_filename = args->kernel_filename;
> >> +    const char *kernel_cmdline = args->kernel_cmdline;
> >> +    const char *initrd_filename = args->initrd_filename;
> >> +    CPUS390XState *env = NULL;
> >> +    MemoryRegion *sysmem = get_system_memory();
> >> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >> +    int shift = 0;
> >> +    uint8_t *storage_keys;
> >> +    int ret;
> >> +
> >> +    /* s390x ram size detection needs a 16bit multiplier + an increment. So
> >> +       guests > 64GB can be specified in 2MB steps etc. */
> >> +    while ((my_ram_size >> (20 + shift)) > 65535) {
> >> +        shift++;
> >> +    }
> >> +    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
> >> +
> >> +    /* lets propagate the changed ram size into the global variable. */
> >> +    ram_size = my_ram_size;
> >> +
> >> +    /* get a BUS */
> >> +    ccw_bus = virtio_ccw_bus_init();
> >> +    s390_sclp_init();
> >> +
> >> +    /* allocate RAM */
> >> +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
> >> +    vmstate_register_ram_global(ram);
> >> +    memory_region_add_subregion(sysmem, 0, ram);
> >> +
> >> +    /* allocate storage keys */
> >> +    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
> >> +
> >> +    /* init CPUs */
> >> +    env = s390_init_cpus(cpu_model, storage_keys);
> >> +
> >> +    kvm_s390_enable_css_support(env);
> >> +
> >> +    /*
> >> +     * Create virtual css and set it as default so that non mcss-e
> >> +     * enabled guests only see virtio devices.
> >> +     */
> >> +    ret = css_create_css_image(VIRTUAL_CSSID, true);
> >> +    assert(ret == 0);
> >> +
> >> +
> >> +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, initrd_filename);
> >> +
> >> +    /* Create VirtIO network adapters */
> >> +    s390_create_virtio_net((BusState *)ccw_bus, "virtio-net-ccw");
> >> +
> >> +}
> >> +
> >> +static QEMUMachine ccw_machine = {
> >> +    .name = "s390-ccw-virtio",
> >> +    .alias = "s390-ccw",
> >> +    .desc = "VirtIO-ccw based S390 machine",
> >> +    .init = ccw_init,
> >> +    .no_cdrom = 1,
> >> +    .no_floppy = 1,
> >> +    .no_serial = 1,
> >> +    .no_parallel = 1,
> >> +    .no_sdcard = 1,
> >> +    .use_virtcon = 1,
> > 
> > The ccw machine should use the ASCII console as default.
> 
> In fact, here is a patch doing this based on the code base that this patch set was on. It would be nice to include this for the next round of the virtio-ccw machine.

Yes. It's sometimes a bit hard to keep track of things :)

> 
> 
> Alex
> 
> diff --git a/hw/boards.h b/hw/boards.h
> index 813d0e5..7ab634a 100644
> --- a/hw/boards.h
> +++ b/hw/boards.h
> @@ -29,6 +29,7 @@ typedef struct QEMUMachine {
>      unsigned int no_serial:1,
>          no_parallel:1,
>          use_virtcon:1,
> +        use_sclp:1,
>          no_floppy:1,
>          no_cdrom:1,
>          no_sdcard:1;
> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> index e03ac52..3b908d6 100644
> --- a/hw/s390-virtio.c
> +++ b/hw/s390-virtio.c
> @@ -483,7 +483,7 @@ static QEMUMachine ccw_machine = {
>      .no_serial = 1,
>      .no_parallel = 1,
>      .no_sdcard = 1,
> -    .use_virtcon = 1,
> +    .use_sclp = 1,
>      .max_cpus = 255,
>      .is_default = 1,
>  };
> diff --git a/vl.c b/vl.c
> index bee122e..803463e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -176,6 +176,7 @@ int main(int argc, char **argv)
>  #define DEFAULT_RAM_SIZE 512
>  
>  #define MAX_VIRTIO_CONSOLES 1
> +#define MAX_SCLP_CONSOLES 1
>  
>  static const char *data_dir;
>  const char *bios_name = NULL;
> @@ -203,6 +204,7 @@ int no_quit = 0;
>  CharDriverState *serial_hds[MAX_SERIAL_PORTS];
>  CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
>  CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
> +CharDriverState *sclp_hds[MAX_SCLP_CONSOLES];
>  int win2k_install_hack = 0;
>  int singlestep = 0;
>  int smp_cpus = 1;
> @@ -272,6 +274,7 @@ static int tcg_tb_size;
>  static int default_serial = 1;
>  static int default_parallel = 1;
>  static int default_virtcon = 1;
> +static int default_sclp = 1;
>  static int default_monitor = 1;
>  static int default_floppy = 1;
>  static int default_cdrom = 1;
> @@ -2157,6 +2160,7 @@ struct device_config {
>          DEV_VIRTCON,   /* -virtioconsole */
>          DEV_DEBUGCON,  /* -debugcon */
>          DEV_GDB,       /* -gdb, -s */
> +        DEV_SCLP,      /* s390 sclp */
>      } type;
>      const char *cmdline;
>      Location loc;
> @@ -2275,6 +2279,39 @@ static int virtcon_parse(const char *devname)
>      return 0;
>  }
>  
> +static int sclp_parse(const char *devname)
> +{
> +    QemuOptsList *device = qemu_find_opts("device");
> +    static int index = 0;
> +    char label[32];
> +    QemuOpts *dev_opts;
> +
> +    if (strcmp(devname, "none") == 0) {
> +        return 0;
> +    }
> +    if (index == MAX_SCLP_CONSOLES) {
> +        fprintf(stderr, "qemu: too many sclp consoles\n");
> +        exit(1);
> +    }
> +
> +    assert(arch_type == QEMU_ARCH_S390X);
> +
> +    dev_opts = qemu_opts_create(device, NULL, 0, NULL);
> +    qemu_opt_set(dev_opts, "driver", "sclpconsole");
> +
> +    snprintf(label, sizeof(label), "sclpcon%d", index);
> +    sclp_hds[index] = qemu_chr_new(label, devname, NULL);
> +    if (!sclp_hds[index]) {
> +        fprintf(stderr, "qemu: could not connect sclp console"
> +                " to character backend '%s'\n", devname);
> +        return -1;
> +    }
> +    qemu_opt_set(dev_opts, "chardev", label);
> +
> +    index++;
> +    return 0;
> +}
> +
>  static int debugcon_parse(const char *devname)
>  {   
>      QemuOpts *opts;
> @@ -3654,6 +3691,9 @@ int main(int argc, char **argv, char **envp)
>      if (!machine->use_virtcon) {
>          default_virtcon = 0;
>      }
> +    if (!machine->use_sclp) {
> +        default_sclp = 0;
> +    }
>      if (machine->no_floppy) {
>          default_floppy = 0;
>      }
> @@ -3671,11 +3711,15 @@ int main(int argc, char **argv, char **envp)
>              add_device_config(DEV_SERIAL, "mon:stdio");
>          } else if (default_virtcon && default_monitor) {
>              add_device_config(DEV_VIRTCON, "mon:stdio");
> +        } else if (default_sclp && default_monitor) {
> +            add_device_config(DEV_SCLP, "mon:stdio");
>          } else {
>              if (default_serial)
>                  add_device_config(DEV_SERIAL, "stdio");
>              if (default_virtcon)
>                  add_device_config(DEV_VIRTCON, "stdio");
> +            if (default_sclp)
> +                add_device_config(DEV_SCLP, "stdio");
>              if (default_monitor)
>                  monitor_parse("stdio", "readline");
>          }
> @@ -3688,6 +3732,8 @@ int main(int argc, char **argv, char **envp)
>              monitor_parse("vc:80Cx24C", "readline");
>          if (default_virtcon)
>              add_device_config(DEV_VIRTCON, "vc:80Cx24C");
> +        if (default_sclp)
> +            add_device_config(DEV_SCLP, "vc:80Cx24C");
>      }
>  
>      socket_init();
> @@ -3855,6 +3901,8 @@ int main(int argc, char **argv, char **envp)
>          exit(1);
>      if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
>          exit(1);
> +    if (foreach_device_config(DEV_SCLP, sclp_parse) < 0)
> +        exit(1);
>      if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
>          exit(1);
>  
