From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 8/8] s390: Add new channel I/O based virtio
	transport.
Date: Wed, 16 Jan 2013 14:24:45 +0100
Message-ID: <22014A51-6745-4B48-AF72-4AEEE5AB67E2@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1354884626-15060-9-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: linux-s390 <linux-s390@vger.kernel.org>, Anthony Liguori <aliguori@us.ibm.com>, KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, Carsten Otte <cotte@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 07.12.2012, at 13:50, Cornelia Huck wrote:

> Add a new virtio transport that uses channel commands to perform
> virtio operations.
>=20
> Add a new machine type s390-ccw that uses this virtio-ccw transport
> and make it the default machine for s390.
>=20
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> hw/s390-virtio.c       | 149 ++++++--
> hw/s390x/Makefile.objs |   1 +
> hw/s390x/virtio-ccw.c  | 909 =
+++++++++++++++++++++++++++++++++++++++++++++++++
> hw/s390x/virtio-ccw.h  |  81 +++++
> trace-events           |   4 +
> 5 files changed, 1124 insertions(+), 20 deletions(-)
> create mode 100644 hw/s390x/virtio-ccw.c
> create mode 100644 hw/s390x/virtio-ccw.h
>=20
> diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
> index 9e1afb2..f29ff74 100644
> --- a/hw/s390-virtio.c
> +++ b/hw/s390-virtio.c
> @@ -33,6 +33,8 @@
>=20
> #include "hw/s390-virtio-bus.h"
> #include "hw/s390x/sclp.h"
> +#include "hw/s390x/css.h"
> +#include "hw/s390x/virtio-ccw.h"
>=20
> //#define DEBUG_S390
>=20
> @@ -47,6 +49,7 @@
> #define KVM_S390_VIRTIO_NOTIFY          0
> #define KVM_S390_VIRTIO_RESET           1
> #define KVM_S390_VIRTIO_SET_STATUS      2
> +#define KVM_S390_VIRTIO_CCW_NOTIFY      3
>=20
> #define KERN_IMAGE_START                0x010000UL
> #define KERN_PARM_AREA                  0x010480UL
> @@ -63,6 +66,7 @@
>=20
> static VirtIOS390Bus *s390_bus;
> static S390CPU **ipi_states;
> +VirtioCcwBus *ccw_bus;
>=20
> S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> {
> @@ -76,15 +80,21 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> int s390_virtio_hypercall(CPUS390XState *env, uint64_t mem, uint64_t =
hypercall)
> {
>     int r =3D 0, i;
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
>=20
>     dprintf("KVM hypercall: %ld\n", hypercall);
>     switch (hypercall) {
>     case KVM_S390_VIRTIO_NOTIFY:
>         if (mem > ram_size) {
> -            VirtIOS390Device *dev =3D =
s390_virtio_bus_find_vring(s390_bus,
> -                                                               mem, =
&i);
> -            if (dev) {
> -                virtio_queue_notify(dev->vdev, i);
> +            if (s390_bus) {
> +                VirtIOS390Device *dev =3D =
s390_virtio_bus_find_vring(s390_bus,
> +                                                                   =
mem, &i);
> +                if (dev) {
> +                    virtio_queue_notify(dev->vdev, i);
> +                } else {
> +                    r =3D -EINVAL;
> +                }
>             } else {
>                 r =3D -EINVAL;
>             }
> @@ -93,28 +103,49 @@ int s390_virtio_hypercall(CPUS390XState *env, =
uint64_t mem, uint64_t hypercall)
>         }
>         break;
>     case KVM_S390_VIRTIO_RESET:
> -    {
> -        VirtIOS390Device *dev;
> -
> -        dev =3D s390_virtio_bus_find_mem(s390_bus, mem);
> -        virtio_reset(dev->vdev);
> -        stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> -        s390_virtio_device_sync(dev);
> -        s390_virtio_reset_idx(dev);
> +        if (s390_bus) {
> +            VirtIOS390Device *dev;
> +
> +            dev =3D s390_virtio_bus_find_mem(s390_bus, mem);
> +            virtio_reset(dev->vdev);
> +            stb_phys(dev->dev_offs + VIRTIO_DEV_OFFS_STATUS, 0);
> +            s390_virtio_device_sync(dev);
> +            s390_virtio_reset_idx(dev);
> +        } else {
> +            r =3D -EINVAL;
> +        }
>         break;
> -    }
>     case KVM_S390_VIRTIO_SET_STATUS:
> -    {
> -        VirtIOS390Device *dev;
> +        if (s390_bus) {
> +            VirtIOS390Device *dev;
>=20
> -        dev =3D s390_virtio_bus_find_mem(s390_bus, mem);
> -        if (dev) {
> -            s390_virtio_device_update_status(dev);
> +            dev =3D s390_virtio_bus_find_mem(s390_bus, mem);
> +            if (dev) {
> +                s390_virtio_device_update_status(dev);
> +            } else {
> +                r =3D -EINVAL;
> +            }
>         } else {
>             r =3D -EINVAL;
>         }
>         break;
> -    }
> +    case KVM_S390_VIRTIO_CCW_NOTIFY:
> +        if (ccw_bus) {
> +            if (ioinst_disassemble_sch_ident(env->regs[2], &m, =
&cssid, &ssid,
> +                                             &schid)) {
> +                r =3D -EINVAL;
> +            } else {
> +                sch =3D css_find_subch(m, cssid, ssid, schid);
> +                if (sch && css_subch_visible(sch)) {
> +                    virtio_queue_notify(virtio_ccw_get_vdev(sch), =
env->regs[3]);
> +                } else {
> +                    r =3D -EINVAL;
> +                }
> +            }
> +         } else {
> +             r =3D -EINVAL;
> +         }
> +         break;
>     default:
>         r =3D -EINVAL;
>         break;
> @@ -370,7 +401,6 @@ static QEMUMachine s390_machine =3D {
>     .no_sdcard =3D 1,
>     .use_virtcon =3D 1,
>     .max_cpus =3D 255,
> -    .is_default =3D 1,
> };
>=20
> static void s390_machine_init(void)
> @@ -379,3 +409,82 @@ static void s390_machine_init(void)
> }
>=20
> machine_init(s390_machine_init);
> +
> +static void ccw_init(QEMUMachineInitArgs *args)
> +{
> +    ram_addr_t my_ram_size =3D args->ram_size;
> +    ram_addr_t ram_size =3D args->ram_size;
> +    const char *cpu_model =3D args->cpu_model;
> +    const char *kernel_filename =3D args->kernel_filename;
> +    const char *kernel_cmdline =3D args->kernel_cmdline;
> +    const char *initrd_filename =3D args->initrd_filename;
> +    CPUS390XState *env =3D NULL;
> +    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> +    int shift =3D 0;
> +    uint8_t *storage_keys;
> +    int ret;
> +
> +    /* s390x ram size detection needs a 16bit multiplier + an =
increment. So
> +       guests > 64GB can be specified in 2MB steps etc. */
> +    while ((my_ram_size >> (20 + shift)) > 65535) {
> +        shift++;
> +    }
> +    my_ram_size =3D my_ram_size >> (20 + shift) << (20 + shift);
> +
> +    /* lets propagate the changed ram size into the global variable. =
*/
> +    ram_size =3D my_ram_size;
> +
> +    /* get a BUS */
> +    ccw_bus =3D virtio_ccw_bus_init();
> +    s390_sclp_init();
> +
> +    /* allocate RAM */
> +    memory_region_init_ram(ram, "s390.ram", my_ram_size);
> +    vmstate_register_ram_global(ram);
> +    memory_region_add_subregion(sysmem, 0, ram);
> +
> +    /* allocate storage keys */
> +    storage_keys =3D g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
> +
> +    /* init CPUs */
> +    env =3D s390_init_cpus(cpu_model, storage_keys);
> +
> +    kvm_s390_enable_css_support(env);
> +
> +    /*
> +     * Create virtual css and set it as default so that non mcss-e
> +     * enabled guests only see virtio devices.
> +     */
> +    ret =3D css_create_css_image(VIRTUAL_CSSID, true);
> +    assert(ret =3D=3D 0);
> +
> +
> +    s390_set_up_kernel(env, kernel_filename, kernel_cmdline, =
initrd_filename);
> +
> +    /* Create VirtIO network adapters */
> +    s390_create_virtio_net((BusState *)ccw_bus, "virtio-net-ccw");
> +
> +}
> +
> +static QEMUMachine ccw_machine =3D {
> +    .name =3D "s390-ccw-virtio",
> +    .alias =3D "s390-ccw",
> +    .desc =3D "VirtIO-ccw based S390 machine",
> +    .init =3D ccw_init,
> +    .no_cdrom =3D 1,
> +    .no_floppy =3D 1,
> +    .no_serial =3D 1,
> +    .no_parallel =3D 1,
> +    .no_sdcard =3D 1,
> +    .use_virtcon =3D 1,

The ccw machine should use the ASCII console as default.


Alex
