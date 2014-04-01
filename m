From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] s390x/kvm: implement and use QEMU config device for
 s390
Date: Tue, 01 Apr 2014 20:56:24 +0200
Message-ID: <533B0BD8.7000209@de.ibm.com>
References: <1396363663-50450-1-git-send-email-borntraeger@de.ibm.com> <1396363663-50450-3-git-send-email-borntraeger@de.ibm.com> <533ADD92.7010101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <533ADD92.7010101@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>, Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/04/14 17:38, Paolo Bonzini wrote:
> Il 01/04/2014 16:47, Christian Borntraeger ha scritto:
>> From: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>>
>> The following patch adds Qemu CONFIG device,
>> which interacts with kvm CONFIG device by calling KVM_CREATE_DEVICE
>> (to create the device in kernel), KVM_GET_DEVICE_ATTR and
>> KVM_SET_DEVICE_ATTR (to get and set the particular attributes of
>> KVM CONFIG device respectively).
>> This patch uses the Qemu CONFIG device to copy the
>> qemu_name (if specified) into the kvm CONFIG device.
>>
>> Signed-off-by: Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
> 
> On the QEMU side we'll soon have per-machine-type options in -machine. s390 can then use that.

Well we need some calls in the kernel at runtime (e.g. during reset), so we need more than
static options. (But we can use those for several things). This device was mostly meant as an achor for "doesnt fit into something else and would require a new
ioctl. Lets encapsulate everything in a way that follows the everything is a device approach with QOM and all these things".

Is there a branch for the per-machine-type things?

Christian


> 
> Paolo
> 
>> ---
>>  default-configs/s390x-softmmu.mak |   1 +
>>  hw/s390x/Makefile.objs            |   1 +
>>  hw/s390x/config.c                 | 113 ++++++++++++++++++++++++++++++++++++++
>>  hw/s390x/s390-virtio-ccw.c        |   6 ++
>>  hw/s390x/s390-virtio.c            |  24 ++++++++
>>  hw/s390x/s390-virtio.h            |   1 +
>>  include/hw/s390x/config.h         |  51 +++++++++++++++++
>>  linux-headers/asm-s390/kvm.h      |  11 ++++
>>  linux-headers/linux/kvm.h         |   1 +
>>  trace-events                      |   4 ++
>>  10 files changed, 213 insertions(+)
>>  create mode 100644 hw/s390x/config.c
>>  create mode 100644 include/hw/s390x/config.h
>>
>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
>> index d843dc0..a07697d 100644
>> --- a/default-configs/s390x-softmmu.mak
>> +++ b/default-configs/s390x-softmmu.mak
>> @@ -1,3 +1,4 @@
>>  CONFIG_VIRTIO=y
>>  CONFIG_SCLPCONSOLE=y
>>  CONFIG_S390_FLIC=$(CONFIG_KVM)
>> +CONFIG_S390_CONFIG=$(CONFIG_KVM)
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index 1ba6c3a..dc03e1d 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -8,3 +8,4 @@ obj-y += ipl.o
>>  obj-y += css.o
>>  obj-y += s390-virtio-ccw.o
>>  obj-y += virtio-ccw.o
>> +obj-$(CONFIG_S390_CONFIG) += config.o
>> diff --git a/hw/s390x/config.c b/hw/s390x/config.c
>> new file mode 100644
>> index 0000000..f70e880
>> --- /dev/null
>> +++ b/hw/s390x/config.c
>> @@ -0,0 +1,113 @@
>> +/*
>> + * S390 configuration and control device
>> + *
>> + * Copyright 2014 IBM Corp.
>> + * Author(s): Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#include <sys/ioctl.h>
>> +#include "hw/s390x/config.h"
>> +#include "trace.h"
>> +
>> +S390ConfigState *get_config_state(void)
>> +{
>> +    return S390_CONFIG(object_resolve_path("/machine/s390-config", NULL));
>> +}
>> +
>> +static int config_set(S390ConfigState *config, struct kvm_device_attr *attr)
>> +{
>> +    int rc;
>> +
>> +    rc = ioctl(config->fd, KVM_SET_DEVICE_ATTR, attr);
>> +    return rc < 0 ? -errno : rc;
>> +}
>> +
>> +/*
>> +static int config_get(S390ConfigState *config, struct kvm_device_attr *attr)
>> +{
>> +    int rc;
>> +
>> +    rc = ioctl(config->fd, KVM_GET_DEVICE_ATTR, attr);
>> +    return rc < 0 ? -errno : rc;
>> +}
>> +*/
>> +
>> +static int config_set_name(S390ConfigState *config, char *name)
>> +{
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_DEV_CONFIG_GROUP,
>> +        .attr  = KVM_DEV_CONFIG_NAME,
>> +        .addr  = (uint64_t)name,
>> +    };
>> +
>> +    if (!name ||
>> +        (qemu_strnlen(name, S390_MACHINE_NAME_SIZE)
>> +         >= S390_MACHINE_NAME_SIZE)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return config_set(config, &attr);
>> +}
>> +
>> +static void s390_config_realize(DeviceState *dev, Error **errp)
>> +{
>> +    S390ConfigState *cfg = S390_CONFIG(dev);
>> +    struct kvm_create_device cd = {0};
>> +    int ret;
>> +
>> +    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>> +        trace_config_no_device_api(errno);
>> +        return;
>> +    }
>> +
>> +    cd.type = KVM_DEV_TYPE_S390_CONFIG;
>> +    ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
>> +    if (ret < 0) {
>> +        trace_config_create_device(errno);
>> +        return;
>> +    }
>> +    cfg->fd = cd.fd;
>> +}
>> +
>> +void s390_config_dev_init(void)
>> +{
>> +    DeviceState *dev;
>> +
>> +    if (kvm_enabled()) {
>> +        dev  = qdev_create(NULL, TYPE_S390_CONFIG);
>> +
>> +        object_property_add_child(qdev_get_machine(),
>> +                                  TYPE_S390_CONFIG,
>> +                                  OBJECT(dev), NULL);
>> +        qdev_init_nofail(dev);
>> +    }
>> +}
>> +
>> +static void s390_config_class_init(ObjectClass *oc, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(oc);
>> +    S390ConfigClass *scc = S390_CONFIG_CLASS(oc);
>> +
>> +    dc->realize = s390_config_realize;
>> +    scc->set_name = config_set_name;
>> +}
>> +
>> +static const TypeInfo s390_config_info = {
>> +    .name          = TYPE_S390_CONFIG,
>> +    .parent        = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(S390ConfigState),
>> +    .class_init    = s390_config_class_init,
>> +    .class_size    = sizeof(S390ConfigClass),
>> +};
>> +
>> +
>> +static void s390_config_register_types(void)
>> +{
>> +    type_register_static(&s390_config_info);
>> +}
>> +
>> +type_init(s390_config_register_types)
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 0d4f6ae..1e4b9ad 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -14,9 +14,11 @@
>>  #include "s390-virtio.h"
>>  #include "hw/s390x/sclp.h"
>>  #include "hw/s390x/s390_flic.h"
>> +#include "hw/s390x/config.h"
>>  #include "ioinst.h"
>>  #include "css.h"
>>  #include "virtio-ccw.h"
>> +#include "qemu/error-report.h"
>>
>>  void io_subsystem_reset(void)
>>  {
>> @@ -106,6 +108,10 @@ static void ccw_init(QEMUMachineInitArgs *args)
>>                        args->initrd_filename, "s390-ccw.img");
>>      s390_flic_init();
>>
>> +    s390_config_dev_init();
>> +
>> +    s390_set_vm_name();
>> +
>>      /* register hypercalls */
>>      virtio_ccw_register_hcalls();
>>
>> diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
>> index aef2003..7a296fd 100644
>> --- a/hw/s390x/s390-virtio.c
>> +++ b/hw/s390x/s390-virtio.c
>> @@ -39,6 +39,8 @@
>>  #include "hw/s390x/s390_flic.h"
>>  #include "hw/s390x/s390-virtio.h"
>>
>> +#include "hw/s390x/config.h"
>> +
>>  //#define DEBUG_S390
>>
>>  #ifdef DEBUG_S390
>> @@ -223,6 +225,24 @@ void s390_create_virtio_net(BusState *bus, const char *name)
>>      }
>>  }
>>
>> +void s390_set_vm_name(void)
>> +{
>> +    S390ConfigState *config = get_config_state();
>> +    char machine_name[S390_MACHINE_NAME_SIZE];
>> +    S390ConfigClass *scc;
>> +
>> +    if (!config || !qemu_name) {
>> +        return;
>> +    }
>> +    strncpy(machine_name, qemu_name, sizeof(machine_name));
>> +
>> +    scc = S390_CONFIG_GET_CLASS(config);
>> +
>> +    if (scc->set_name(config, machine_name)) {
>> +        error_report("Setting machine name failed: %m");
>> +    }
>> +}
>> +
>>  /* PC hardware initialisation */
>>  static void s390_init(QEMUMachineInitArgs *args)
>>  {
>> @@ -252,6 +272,10 @@ static void s390_init(QEMUMachineInitArgs *args)
>>                        args->initrd_filename, ZIPL_FILENAME);
>>      s390_flic_init();
>>
>> +    s390_config_dev_init();
>> +
>> +    s390_set_vm_name();
>> +
>>      /* register hypercalls */
>>      s390_virtio_register_hcalls();
>>
>> diff --git a/hw/s390x/s390-virtio.h b/hw/s390x/s390-virtio.h
>> index 5c405e7..deca18e 100644
>> --- a/hw/s390x/s390-virtio.h
>> +++ b/hw/s390x/s390-virtio.h
>> @@ -26,4 +26,5 @@ void s390_init_ipl_dev(const char *kernel_filename,
>>                         const char *initrd_filename,
>>                         const char *firmware);
>>  void s390_create_virtio_net(BusState *bus, const char *name);
>> +void s390_set_vm_name(void);
>>  #endif
>> diff --git a/include/hw/s390x/config.h b/include/hw/s390x/config.h
>> new file mode 100644
>> index 0000000..14d9b02
>> --- /dev/null
>> +++ b/include/hw/s390x/config.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * S390 configuration and control device
>> + *
>> + * Copyright 2014 IBM Corp.
>> + * Author(s): Ekaterina Tumanova <tumanova@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#ifndef __KVM_S390_CONFIG_H
>> +#define __KVM_S390_CONFIG_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "migration/qemu-file.h"
>> +
>> +#define TYPE_S390_CONFIG "s390-config"
>> +#define S390_CONFIG(obj) \
>> +    OBJECT_CHECK(S390ConfigState, (obj), TYPE_S390_CONFIG)
>> +#define S390_CONFIG_CLASS(class) \
>> +     OBJECT_CLASS_CHECK(S390ConfigClass, (class), TYPE_S390_CONFIG)
>> +#define S390_CONFIG_GET_CLASS(obj) \
>> +     OBJECT_GET_CLASS(S390ConfigClass, (obj), TYPE_S390_CONFIG)
>> +
>> +typedef struct S390ConfigState {
>> +    SysBusDevice parent_obj;
>> +    uint32_t fd;
>> +} S390ConfigState;
>> +
>> +typedef struct S390ConfigClass {
>> +    /*< private >*/
>> +    SysBusDeviceClass parent_class;
>> +    /*< public >*/
>> +    int (*set_name)(S390ConfigState *config, char *name);
>> +} S390ConfigClass;
>> +
>> +#ifdef CONFIG_KVM
>> +void s390_config_dev_init(void);
>> +S390ConfigState *get_config_state(void);
>> +#define S390_MACHINE_NAME_SIZE sizeof(struct kvm_s390_attr_name)
>> +#else
>> +static inline void s390_config_dev_init(void) { }
>> +static inline S390ConfigState *get_config_state(void)
>> +{
>> +    return NULL;
>> +}
>> +#define S390_MACHINE_NAME_SIZE 128
>> +#endif
>> +
>> +#endif /* __KVM_S390_CONFIG_H */
>> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
>> index cb4c1eb..432ffa5 100644
>> --- a/linux-headers/asm-s390/kvm.h
>> +++ b/linux-headers/asm-s390/kvm.h
>> @@ -57,6 +57,17 @@ struct kvm_debug_exit_arch {
>>  struct kvm_guest_debug_arch {
>>  };
>>
>> +
>> +
>> +/* config device specific GROUPS */
>> +
>> +#define KVM_DEV_CONFIG_GROUP        0
>> +#define KVM_DEV_CONFIG_NAME        0
>> +
>> +struct kvm_s390_attr_name {
>> +    char name[128];
>> +};
>> +
>>  #define KVM_SYNC_PREFIX (1UL << 0)
>>  #define KVM_SYNC_GPRS   (1UL << 1)
>>  #define KVM_SYNC_ACRS   (1UL << 2)
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index e27a4b3..59d1ec3 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -921,6 +921,7 @@ struct kvm_device_attr {
>>  #define   KVM_DEV_VFIO_GROUP_DEL            2
>>  #define KVM_DEV_TYPE_ARM_VGIC_V2    5
>>  #define KVM_DEV_TYPE_FLIC        6
>> +#define KVM_DEV_TYPE_S390_CONFIG    7
>>
>>  /*
>>   * ioctls for VM fds
>> diff --git a/trace-events b/trace-events
>> index 3df3f32..6ccd619 100644
>> --- a/trace-events
>> +++ b/trace-events
>> @@ -1185,6 +1185,10 @@ css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
>>  virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
>>  virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
>>
>> +# hw/s390x/config.c
>> +config_no_device_api(int err) "config_dev: no Device Control API support %d"
>> +config_create_device(int err) "config_dev: create device failed %d"
>> +
>>  # hw/intc/s390_flic.c
>>  flic_create_device(int err) "flic: create device failed %d"
>>  flic_no_device_api(int err) "flic: no Device Contral API support %d"
>>
> 
