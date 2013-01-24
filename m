From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 08/11] s390: Add new channel I/O based virtio transport.
Date: Thu, 24 Jan 2013 13:28:08 +0100
Message-ID: <1359030491-46725-9-git-send-email-cornelia.huck@de.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Add a new virtio transport that uses channel commands to perform
virtio operations.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

v5 -> v6:
- Get rid of qemu_get_ram_ptr usage
- Adapt to virtual css changes
- Constify TypeInfos
- Prepare for VirtioBus
---
 hw/s390x/Makefile.objs |   1 +
 hw/s390x/virtio-ccw.c  | 947 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h  |  94 +++++
 trace-events           |   4 +
 4 files changed, 1046 insertions(+)
 create mode 100644 hw/s390x/virtio-ccw.c
 create mode 100644 hw/s390x/virtio-ccw.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index ab99da6..f6b461b 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -7,3 +7,4 @@ obj-y += event-facility.o
 obj-y += sclpquiesce.o sclpconsole.o
 obj-y += ipl.o
 obj-y += css.o
+obj-y += virtio-ccw.o
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
new file mode 100644
index 0000000..58f9982
--- /dev/null
+++ b/hw/s390x/virtio-ccw.c
@@ -0,0 +1,947 @@
+/*
+ * virtio ccw target implementation
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <hw/hw.h>
+#include "block/block.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/sysemu.h"
+#include "net/net.h"
+#include "monitor/monitor.h"
+#include "hw/virtio.h"
+#include "hw/virtio-serial.h"
+#include "hw/virtio-net.h"
+#include "hw/sysbus.h"
+#include "qemu/bitops.h"
+#include "hw/virtio-bus.h"
+
+#include "ioinst.h"
+#include "css.h"
+#include "virtio-ccw.h"
+#include "trace.h"
+
+static const TypeInfo virtual_css_bus_info = {
+    .name = TYPE_VIRTUAL_CSS_BUS,
+    .parent = TYPE_BUS,
+    .instance_size = sizeof(VirtualCssBus),
+};
+
+static const VirtIOBindings virtio_ccw_bindings;
+
+VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch)
+{
+    VirtIODevice *vdev = NULL;
+
+    if (sch->driver_data) {
+        vdev = ((VirtioCcwData *)sch->driver_data)->vdev;
+    }
+    return vdev;
+}
+
+static void virtio_ccw_reset_subchannels(void *opaque)
+{
+    VirtualCssBus *bus = opaque;
+    BusChild *kid;
+    VirtioCcwData *data;
+    BusState *parent = BUS(bus);
+
+    QTAILQ_FOREACH(kid, &parent->children, sibling) {
+        data = (VirtioCcwData *)kid->child;
+        virtio_reset(data->vdev);
+        css_reset_sch(data->sch);
+    }
+    css_reset();
+}
+
+VirtualCssBus *virtual_css_bus_init(void)
+{
+    VirtualCssBus *cbus;
+    BusState *bus;
+    DeviceState *dev;
+
+    /* Create bridge device */
+    dev = qdev_create(NULL, "virtual-css-bridge");
+    qdev_init_nofail(dev);
+
+    /* Create bus on bridge device */
+    bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
+    cbus = VIRTUAL_CSS_BUS(bus);
+
+    /* Enable hotplugging */
+    bus->allow_hotplug = 1;
+
+    qemu_register_reset(virtio_ccw_reset_subchannels, cbus);
+    return cbus;
+}
+
+/* Communication blocks used by several channel commands. */
+typedef struct VqInfoBlock {
+    uint64_t queue;
+    uint32_t align;
+    uint16_t index;
+    uint16_t num;
+} QEMU_PACKED VqInfoBlock;
+
+typedef struct VqConfigBlock {
+    uint16_t index;
+    uint16_t num_max;
+} QEMU_PACKED VqConfigBlock;
+
+typedef struct VirtioFeatDesc {
+    uint32_t features;
+    uint8_t index;
+} QEMU_PACKED VirtioFeatDesc;
+
+/* Specify where the virtqueues for the subchannel are in guest memory. */
+static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
+                              uint16_t index, uint16_t num)
+{
+    VirtioCcwData *data = sch->driver_data;
+
+    if (index > VIRTIO_PCI_QUEUE_MAX) {
+        return -EINVAL;
+    }
+
+    /* Current code in virtio.c relies on 4K alignment. */
+    if (addr && (align != 4096)) {
+        return -EINVAL;
+    }
+
+    if (!data) {
+        return -EINVAL;
+    }
+
+    virtio_queue_set_addr(data->vdev, index, addr);
+    if (!addr) {
+        virtio_queue_set_vector(data->vdev, index, 0);
+    } else {
+        /* Fail if we don't have a big enough queue. */
+        /* TODO: Add interface to handle vring.num changing */
+        if (virtio_queue_get_num(data->vdev, index) > num) {
+            return -EINVAL;
+        }
+        virtio_queue_set_vector(data->vdev, index, index);
+    }
+    /* tell notify handler in case of config change */
+    data->vdev->config_vector = VIRTIO_PCI_QUEUE_MAX;
+    return 0;
+}
+
+static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
+{
+    int ret;
+    VqInfoBlock info;
+    uint8_t status;
+    VirtioFeatDesc features;
+    void *config;
+    hwaddr indicators;
+    VqConfigBlock vq_config;
+    VirtioCcwData *data = sch->driver_data;
+    bool check_len;
+    int len;
+    hwaddr hw_len;
+
+    if (!data) {
+        return -EINVAL;
+    }
+
+    trace_virtio_ccw_interpret_ccw(sch->cssid, sch->ssid, sch->schid,
+                                   ccw.cmd_code);
+    check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
+
+    /* Look at the command. */
+    switch (ccw.cmd_code) {
+    case CCW_CMD_SET_VQ:
+        if (check_len) {
+            if (ccw.count != sizeof(info)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(info)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            info.queue = ldq_phys(ccw.cda);
+            info.align = ldl_phys(ccw.cda + sizeof(info.queue));
+            info.index = lduw_phys(ccw.cda + sizeof(info.queue)
+                                   + sizeof(info.align));
+            info.num = lduw_phys(ccw.cda + sizeof(info.queue)
+                                 + sizeof(info.align)
+                                 + sizeof(info.index));
+            ret = virtio_ccw_set_vqs(sch, info.queue, info.align, info.index,
+                                     info.num);
+            sch->curr_status.scsw.count = 0;
+        }
+        break;
+    case CCW_CMD_VDEV_RESET:
+        virtio_reset(data->vdev);
+        ret = 0;
+        break;
+    case CCW_CMD_READ_FEAT:
+        if (check_len) {
+            if (ccw.count != sizeof(features)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(features)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            features.index = ldub_phys(ccw.cda + sizeof(features.features));
+            if (features.index < ARRAY_SIZE(data->host_features)) {
+                features.features = data->host_features[features.index];
+            } else {
+                /* Return zeroes if the guest supports more feature bits. */
+                features.features = 0;
+            }
+            stl_le_phys(ccw.cda, features.features);
+            sch->curr_status.scsw.count = ccw.count - sizeof(features);
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_WRITE_FEAT:
+        if (check_len) {
+            if (ccw.count != sizeof(features)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(features)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            features.index = ldub_phys(ccw.cda + sizeof(features.features));
+            features.features = ldl_le_phys(ccw.cda);
+            if (features.index < ARRAY_SIZE(data->host_features)) {
+                if (data->vdev->set_features) {
+                    data->vdev->set_features(data->vdev, features.features);
+                }
+                data->vdev->guest_features = features.features;
+            } else {
+                /*
+                 * If the guest supports more feature bits, assert that it
+                 * passes us zeroes for those we don't support.
+                 */
+                if (features.features) {
+                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
+                            features.index, features.features);
+                    /* XXX: do a unit check here? */
+                }
+            }
+            sch->curr_status.scsw.count = ccw.count - sizeof(features);
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_READ_CONF:
+        if (check_len) {
+            if (ccw.count > data->vdev->config_len) {
+                ret = -EINVAL;
+                break;
+            }
+        }
+        len = MIN(ccw.count, data->vdev->config_len);
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            data->vdev->get_config(data->vdev, data->vdev->config);
+            /* XXX config space endianness */
+            cpu_physical_memory_write(ccw.cda, data->vdev->config, len);
+            sch->curr_status.scsw.count = ccw.count - len;
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_WRITE_CONF:
+        if (check_len) {
+            if (ccw.count > data->vdev->config_len) {
+                ret = -EINVAL;
+                break;
+            }
+        }
+        len = MIN(ccw.count, data->vdev->config_len);
+        hw_len = len;
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            config = cpu_physical_memory_map(ccw.cda, &hw_len, 0);
+            if (!config) {
+                ret = -EFAULT;
+            } else {
+                len = hw_len;
+                /* XXX config space endianness */
+                memcpy(data->vdev->config, config, len);
+                cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
+                if (data->vdev->set_config) {
+                    data->vdev->set_config(data->vdev, data->vdev->config);
+                }
+                sch->curr_status.scsw.count = ccw.count - len;
+                ret = 0;
+            }
+        }
+        break;
+    case CCW_CMD_WRITE_STATUS:
+        if (check_len) {
+            if (ccw.count != sizeof(status)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(status)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            status = ldub_phys(ccw.cda);
+            virtio_set_status(data->vdev, status);
+            sch->curr_status.scsw.count = ccw.count - sizeof(status);
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_SET_IND:
+        if (check_len) {
+            if (ccw.count != sizeof(indicators)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(indicators)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        indicators = ldq_phys(ccw.cda);
+        if (!indicators) {
+            ret = -EFAULT;
+        } else {
+            data->indicators = indicators;
+            sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_SET_CONF_IND:
+        if (check_len) {
+            if (ccw.count != sizeof(indicators)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(indicators)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        indicators = ldq_phys(ccw.cda);
+        if (!indicators) {
+            ret = -EFAULT;
+        } else {
+            data->indicators2 = indicators;
+            sch->curr_status.scsw.count = ccw.count - sizeof(indicators);
+            ret = 0;
+        }
+        break;
+    case CCW_CMD_READ_VQ_CONF:
+        if (check_len) {
+            if (ccw.count != sizeof(vq_config)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(vq_config)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            vq_config.index = lduw_phys(ccw.cda);
+            vq_config.num_max = virtio_queue_get_num(data->vdev,
+                                                     vq_config.index);
+            stw_phys(ccw.cda + sizeof(vq_config.index), vq_config.num_max);
+            sch->curr_status.scsw.count = ccw.count - sizeof(vq_config);
+            ret = 0;
+        }
+        break;
+    default:
+        ret = -EOPNOTSUPP;
+        break;
+    }
+    return ret;
+}
+
+static int virtio_ccw_device_init(VirtioCcwData *dev, VirtIODevice *vdev)
+{
+    unsigned int cssid = 0;
+    unsigned int ssid = 0;
+    unsigned int schid;
+    unsigned int devno;
+    bool have_devno = false;
+    bool found = false;
+    SubchDev *sch;
+    int ret;
+    int num;
+    DeviceState *parent = DEVICE(dev);
+
+    sch = g_malloc0(sizeof(SubchDev));
+
+    sch->driver_data = dev;
+    dev->sch = sch;
+
+    dev->vdev = vdev;
+    dev->indicators = 0;
+
+    /* Initialize subchannel structure. */
+    sch->channel_prog = 0x0;
+    sch->last_cmd_valid = false;
+    sch->orb = NULL;
+    /*
+     * Use a device number if provided. Otherwise, fall back to subchannel
+     * number.
+     */
+    if (dev->bus_id) {
+        num = sscanf(dev->bus_id, "%x.%x.%04x", &cssid, &ssid, &devno);
+        if (num == 3) {
+            if ((cssid > MAX_CSSID) || (ssid > MAX_SSID)) {
+                ret = -EINVAL;
+                error_report("Invalid cssid or ssid: cssid %x, ssid %x",
+                             cssid, ssid);
+                goto out_err;
+            }
+            /* Enforce use of virtual cssid. */
+            if (cssid != VIRTUAL_CSSID) {
+                ret = -EINVAL;
+                error_report("cssid %x not valid for virtio devices", cssid);
+                goto out_err;
+            }
+            if (css_devno_used(cssid, ssid, devno)) {
+                ret = -EEXIST;
+                error_report("Device %x.%x.%04x already exists", cssid, ssid,
+                             devno);
+                goto out_err;
+            }
+            sch->cssid = cssid;
+            sch->ssid = ssid;
+            sch->devno = devno;
+            have_devno = true;
+        } else {
+            ret = -EINVAL;
+            error_report("Malformed devno parameter '%s'", dev->bus_id);
+            goto out_err;
+        }
+    }
+
+    /* Find the next free id. */
+    if (have_devno) {
+        for (schid = 0; schid <= MAX_SCHID; schid++) {
+            if (!css_find_subch(1, cssid, ssid, schid)) {
+                sch->schid = schid;
+                css_subch_assign(cssid, ssid, schid, devno, sch);
+                found = true;
+                break;
+            }
+        }
+        if (!found) {
+            ret = -ENODEV;
+            error_report("No free subchannel found for %x.%x.%04x", cssid, ssid,
+                         devno);
+            goto out_err;
+        }
+        trace_virtio_ccw_new_device(cssid, ssid, schid, devno,
+                                    "user-configured");
+    } else {
+        cssid = VIRTUAL_CSSID;
+        for (ssid = 0; ssid <= MAX_SSID; ssid++) {
+            for (schid = 0; schid <= MAX_SCHID; schid++) {
+                if (!css_find_subch(1, cssid, ssid, schid)) {
+                    sch->cssid = cssid;
+                    sch->ssid = ssid;
+                    sch->schid = schid;
+                    devno = schid;
+                    /*
+                     * If the devno is already taken, look further in this
+                     * subchannel set.
+                     */
+                    while (css_devno_used(cssid, ssid, devno)) {
+                        if (devno == MAX_SCHID) {
+                            devno = 0;
+                        } else if (devno == schid - 1) {
+                            ret = -ENODEV;
+                            error_report("No free devno found");
+                            goto out_err;
+                        } else {
+                            devno++;
+                        }
+                    }
+                    sch->devno = devno;
+                    css_subch_assign(cssid, ssid, schid, devno, sch);
+                    found = true;
+                    break;
+                }
+            }
+            if (found) {
+                break;
+            }
+        }
+        if (!found) {
+            ret = -ENODEV;
+            error_report("Virtual channel subsystem is full!");
+            goto out_err;
+        }
+        trace_virtio_ccw_new_device(cssid, ssid, schid, devno,
+                                    "auto-configured");
+    }
+
+    /* Build initial schib. */
+    css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
+
+    sch->ccw_cb = virtio_ccw_cb;
+
+    /* Build senseid data. */
+    memset(&sch->id, 0, sizeof(SenseId));
+    sch->id.reserved = 0xff;
+    sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
+    sch->id.cu_model = dev->vdev->device_id;
+
+    virtio_bind_device(vdev, &virtio_ccw_bindings, DEVICE(dev));
+    /* Only the first 32 feature bits are used. */
+    dev->host_features[0] = vdev->get_features(vdev, dev->host_features[0]);
+    dev->host_features[0] |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
+    dev->host_features[0] |= 0x1 << VIRTIO_F_BAD_FEATURE;
+
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
+                          parent->hotplugged, 1);
+    return 0;
+
+out_err:
+    dev->sch = NULL;
+    g_free(sch);
+    return ret;
+}
+
+static int virtio_ccw_exit(VirtioCcwData *dev)
+{
+    SubchDev *sch = dev->sch;
+
+    if (sch) {
+        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+        g_free(sch);
+    }
+    dev->indicators = 0;
+    return 0;
+}
+
+static int virtio_ccw_net_init(VirtioCcwData *dev)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_net_init((DeviceState *)dev, &dev->nic, &dev->net);
+    if (!vdev) {
+        return -1;
+    }
+
+    return virtio_ccw_device_init(dev, vdev);
+}
+
+static int virtio_ccw_net_exit(VirtioCcwData *dev)
+{
+    virtio_net_exit(dev->vdev);
+    return virtio_ccw_exit(dev);
+}
+
+static int virtio_ccw_blk_init(VirtioCcwData *dev)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_blk_init((DeviceState *)dev, &dev->blk);
+    if (!vdev) {
+        return -1;
+    }
+
+    return virtio_ccw_device_init(dev, vdev);
+}
+
+static int virtio_ccw_blk_exit(VirtioCcwData *dev)
+{
+    virtio_blk_exit(dev->vdev);
+    blockdev_mark_auto_del(dev->blk.conf.bs);
+    return virtio_ccw_exit(dev);
+}
+
+static int virtio_ccw_serial_init(VirtioCcwData *dev)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_serial_init((DeviceState *)dev, &dev->serial);
+    if (!vdev) {
+        return -1;
+    }
+
+    return virtio_ccw_device_init(dev, vdev);
+}
+
+static int virtio_ccw_serial_exit(VirtioCcwData *dev)
+{
+    virtio_serial_exit(dev->vdev);
+    return virtio_ccw_exit(dev);
+}
+
+static int virtio_ccw_balloon_init(VirtioCcwData *dev)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_balloon_init((DeviceState *)dev);
+    if (!vdev) {
+        return -1;
+    }
+
+    return virtio_ccw_device_init(dev, vdev);
+}
+
+static int virtio_ccw_balloon_exit(VirtioCcwData *dev)
+{
+    virtio_balloon_exit(dev->vdev);
+    return virtio_ccw_exit(dev);
+}
+
+static int virtio_ccw_scsi_init(VirtioCcwData *dev)
+{
+    VirtIODevice *vdev;
+
+    vdev = virtio_scsi_init((DeviceState *)dev, &dev->scsi);
+    if (!vdev) {
+        return -1;
+    }
+
+    return virtio_ccw_device_init(dev, vdev);
+}
+
+static int virtio_ccw_scsi_exit(VirtioCcwData *dev)
+{
+    virtio_scsi_exit(dev->vdev);
+    return virtio_ccw_exit(dev);
+}
+
+/* DeviceState to VirtioCcwData. Note: used on datapath,
+ * be careful and test performance if you change this.
+ */
+static inline VirtioCcwData *to_virtio_ccw_data_fast(DeviceState *d)
+{
+    return container_of(d, VirtioCcwData, parent_obj);
+}
+
+/* DeviceState to VirtioCcwData. TODO: use QOM. */
+static inline VirtioCcwData *to_virtio_ccw_data(DeviceState *d)
+{
+    return container_of(d, VirtioCcwData, parent_obj);
+}
+
+static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
+{
+    VirtioCcwData *dev = to_virtio_ccw_data_fast(d);
+    SubchDev *sch = dev->sch;
+    uint64_t indicators;
+
+    if (vector >= 128) {
+        return;
+    }
+
+    if (vector < VIRTIO_PCI_QUEUE_MAX) {
+        indicators = ldq_phys(dev->indicators);
+        set_bit(vector, &indicators);
+        stq_phys(dev->indicators, indicators);
+    } else {
+        vector = 0;
+        indicators = ldq_phys(dev->indicators2);
+        set_bit(vector, &indicators);
+        stq_phys(dev->indicators2, indicators);
+    }
+
+    css_conditional_io_interrupt(sch);
+
+}
+
+static unsigned virtio_ccw_get_features(DeviceState *d)
+{
+    VirtioCcwData *dev = to_virtio_ccw_data(d);
+
+    /* Only the first 32 feature bits are used. */
+    return dev->host_features[0];
+}
+
+/**************** Virtio-ccw Bus Device Descriptions *******************/
+
+static const VirtIOBindings virtio_ccw_bindings = {
+    .notify = virtio_ccw_notify,
+    .get_features = virtio_ccw_get_features,
+};
+
+static Property virtio_ccw_net_properties[] = {
+    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
+    DEFINE_VIRTIO_NET_FEATURES(VirtioCcwData, host_features[0]),
+    DEFINE_NIC_PROPERTIES(VirtioCcwData, nic),
+    DEFINE_PROP_UINT32("x-txtimer", VirtioCcwData,
+                       net.txtimer, TX_TIMER_INTERVAL),
+    DEFINE_PROP_INT32("x-txburst", VirtioCcwData,
+                      net.txburst, TX_BURST),
+    DEFINE_PROP_STRING("tx", VirtioCcwData, net.tx),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->init = virtio_ccw_net_init;
+    k->exit = virtio_ccw_net_exit;
+    dc->props = virtio_ccw_net_properties;
+}
+
+static const TypeInfo virtio_ccw_net = {
+    .name          = "virtio-net-ccw",
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init    = virtio_ccw_net_class_init,
+};
+
+static Property virtio_ccw_blk_properties[] = {
+    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
+    DEFINE_BLOCK_PROPERTIES(VirtioCcwData, blk.conf),
+    DEFINE_PROP_STRING("serial", VirtioCcwData, blk.serial),
+#ifdef __linux__
+    DEFINE_PROP_BIT("scsi", VirtioCcwData, blk.scsi, 0, true),
+#endif
+    DEFINE_VIRTIO_BLK_FEATURES(VirtioCcwData, host_features[0]),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->init = virtio_ccw_blk_init;
+    k->exit = virtio_ccw_blk_exit;
+    dc->props = virtio_ccw_blk_properties;
+}
+
+static const TypeInfo virtio_ccw_blk = {
+    .name          = "virtio-blk-ccw",
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init    = virtio_ccw_blk_class_init,
+};
+
+static Property virtio_ccw_serial_properties[] = {
+    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
+    DEFINE_PROP_UINT32("max_ports", VirtioCcwData, serial.max_virtserial_ports,
+                       31),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwData, host_features[0]),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->init = virtio_ccw_serial_init;
+    k->exit = virtio_ccw_serial_exit;
+    dc->props = virtio_ccw_serial_properties;
+}
+
+static const TypeInfo virtio_ccw_serial = {
+    .name          = "virtio-serial-ccw",
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init    = virtio_ccw_serial_class_init,
+};
+
+static Property virtio_ccw_balloon_properties[] = {
+    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
+    DEFINE_VIRTIO_COMMON_FEATURES(VirtioCcwData, host_features[0]),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->init = virtio_ccw_balloon_init;
+    k->exit = virtio_ccw_balloon_exit;
+    dc->props = virtio_ccw_balloon_properties;
+}
+
+static const TypeInfo virtio_ccw_balloon = {
+    .name          = "virtio-balloon-ccw",
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init    = virtio_ccw_balloon_class_init,
+};
+
+static Property virtio_ccw_scsi_properties[] = {
+    DEFINE_PROP_STRING("devno", VirtioCcwData, bus_id),
+    DEFINE_VIRTIO_SCSI_PROPERTIES(VirtioCcwData, host_features[0], scsi),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->init = virtio_ccw_scsi_init;
+    k->exit = virtio_ccw_scsi_exit;
+    dc->props = virtio_ccw_scsi_properties;
+}
+
+static const TypeInfo virtio_ccw_scsi = {
+    .name          = "virtio-scsi-ccw",
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init    = virtio_ccw_scsi_class_init,
+};
+
+static int virtio_ccw_busdev_init(DeviceState *dev)
+{
+    VirtioCcwData *_dev = (VirtioCcwData *)dev;
+    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
+
+    virtio_ccw_bus_new(&_dev->bus, _dev);
+
+    return _info->init(_dev);
+}
+
+static int virtio_ccw_busdev_exit(DeviceState *dev)
+{
+    VirtioCcwData *_dev = (VirtioCcwData *)dev;
+    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
+
+    return _info->exit(_dev);
+}
+
+static int virtio_ccw_busdev_unplug(DeviceState *dev)
+{
+    VirtioCcwData *_dev = (VirtioCcwData *)dev;
+    SubchDev *sch = _dev->sch;
+
+    /*
+     * We should arrive here only for device_del, since we don't support
+     * direct hot(un)plug of channels, but only through virtio.
+     */
+    assert(sch != NULL);
+    /* Subchannel is now disabled and no longer valid. */
+    sch->curr_status.pmcw.flags &= ~(PMCW_FLAGS_MASK_ENA |
+                                     PMCW_FLAGS_MASK_DNV);
+
+    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid, 1, 0);
+
+    object_unparent(OBJECT(dev));
+    qdev_free(dev);
+    return 0;
+}
+
+static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->init = virtio_ccw_busdev_init;
+    dc->exit = virtio_ccw_busdev_exit;
+    dc->unplug = virtio_ccw_busdev_unplug;
+    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+
+}
+
+static const TypeInfo virtio_ccw_device_info = {
+    .name = TYPE_VIRTIO_CCW_DEVICE,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(VirtioCcwData),
+    .class_init = virtio_ccw_device_class_init,
+    .class_size = sizeof(VirtIOCCWDeviceClass),
+    .abstract = true,
+};
+
+/***************** Virtual-css Bus Bridge Device ********************/
+/* Only required to have the virtio bus as child in the system bus */
+
+static int virtual_css_bridge_init(SysBusDevice *dev)
+{
+    /* nothing */
+    return 0;
+}
+
+static void virtual_css_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+
+    k->init = virtual_css_bridge_init;
+    dc->no_user = 1;
+}
+
+static const TypeInfo virtual_css_bridge_info = {
+    .name          = "virtual-css-bridge",
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SysBusDevice),
+    .class_init    = virtual_css_bridge_class_init,
+};
+
+/* virtio-ccw-bus */
+
+void virtio_ccw_bus_new(VirtioBusState *bus, VirtioCcwData *dev)
+{
+    DeviceState *qdev = DEVICE(dev);
+    BusState *qbus;
+
+    qbus_create_inplace((BusState *)bus, TYPE_VIRTIO_CCW_BUS, qdev, NULL);
+    qbus = BUS(bus);
+    qbus->allow_hotplug = 0;
+}
+
+static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
+{
+    VirtioBusClass *k = VIRTIO_BUS_CLASS(klass);
+    BusClass *bus_class = BUS_CLASS(klass);
+
+    bus_class->max_dev = 1;
+    k->notify = virtio_ccw_notify;
+    k->get_features = virtio_ccw_get_features;
+}
+
+static const TypeInfo virtio_ccw_bus_info = {
+    .name = TYPE_VIRTIO_CCW_BUS,
+    .parent = TYPE_VIRTIO_BUS,
+    .instance_size = sizeof(VirtioCcwBusState),
+    .class_init = virtio_ccw_bus_class_init,
+};
+
+static void virtio_ccw_register(void)
+{
+    type_register_static(&virtio_ccw_bus_info);
+    type_register_static(&virtual_css_bus_info);
+    type_register_static(&virtio_ccw_device_info);
+    type_register_static(&virtio_ccw_serial);
+    type_register_static(&virtio_ccw_blk);
+    type_register_static(&virtio_ccw_net);
+    type_register_static(&virtio_ccw_balloon);
+    type_register_static(&virtio_ccw_scsi);
+    type_register_static(&virtual_css_bridge_info);
+}
+type_init(virtio_ccw_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
new file mode 100644
index 0000000..87c0e6d
--- /dev/null
+++ b/hw/s390x/virtio-ccw.h
@@ -0,0 +1,94 @@
+/*
+ * virtio ccw target definitions
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <hw/virtio-blk.h>
+#include <hw/virtio-net.h>
+#include <hw/virtio-serial.h>
+#include <hw/virtio-scsi.h>
+#include <hw/virtio-bus.h>
+
+#define VIRTUAL_CSSID 0xfe
+
+#define VIRTIO_CCW_CU_TYPE 0x3832
+#define VIRTIO_CCW_CHPID_TYPE 0x32
+
+#define CCW_CMD_SET_VQ       0x13
+#define CCW_CMD_VDEV_RESET   0x33
+#define CCW_CMD_READ_FEAT    0x12
+#define CCW_CMD_WRITE_FEAT   0x11
+#define CCW_CMD_READ_CONF    0x22
+#define CCW_CMD_WRITE_CONF   0x21
+#define CCW_CMD_WRITE_STATUS 0x31
+#define CCW_CMD_SET_IND      0x43
+#define CCW_CMD_SET_CONF_IND 0x53
+#define CCW_CMD_READ_VQ_CONF 0x32
+
+#define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
+#define VIRTIO_CCW_DEVICE(obj) \
+     OBJECT_CHECK(VirtioCcwData, (obj), TYPE_VIRTIO_CCW_DEVICE)
+#define VIRTIO_CCW_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(VirtIOCCWDeviceClass, (klass), TYPE_VIRTIO_CCW_DEVICE)
+#define VIRTIO_CCW_DEVICE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(VirtIOCCWDeviceClass, (obj), TYPE_VIRTIO_CCW_DEVICE)
+
+typedef struct VirtioBusState VirtioCcwBusState;
+typedef struct VirtioBusClass VirtioCcwBusClass;
+
+#define TYPE_VIRTIO_CCW_BUS "virtio-ccw-bus"
+#define VIRTIO_CCW_BUS(obj) \
+     OBJECT_CHECK(VirtioCcwBus, (obj), TYPE_VIRTIO_CCW_BUS)
+#define VIRTIO_CCW_BUS_GET_CLASS(obj) \
+    OBJECT_CHECK(VirtioCcwBusState, (obj), TYPE_VIRTIO_CCW_BUS)
+#define VIRTIO_CCW_BUS_CLASS(klass) \
+    OBJECT_CLASS_CHECK(VirtioCcwBusClass, klass, TYPE_VIRTIO_CCW_BUS)
+
+typedef struct VirtioCcwData VirtioCcwData;
+
+void virtio_ccw_bus_new(VirtioBusState *bus, VirtioCcwData *dev);
+
+typedef struct VirtIOCCWDeviceClass {
+    DeviceClass parent_class;
+    int (*init)(VirtioCcwData *dev);
+    int (*exit)(VirtioCcwData *dev);
+} VirtIOCCWDeviceClass;
+
+/* Change here if we want to support more feature bits. */
+#define VIRTIO_CCW_FEATURE_SIZE 1
+
+struct VirtioCcwData {
+    DeviceState parent_obj;
+    SubchDev *sch;
+    VirtIODevice *vdev;
+    char *bus_id;
+    VirtIOBlkConf blk;
+    NICConf nic;
+    uint32_t host_features[VIRTIO_CCW_FEATURE_SIZE];
+    virtio_serial_conf serial;
+    virtio_net_conf net;
+    VirtIOSCSIConf scsi;
+    VirtioBusState bus;
+    /* Guest provided values: */
+    hwaddr indicators;
+    hwaddr indicators2;
+};
+
+/* virtual css bus type */
+typedef struct VirtualCssBus {
+    BusState parent_obj;
+} VirtualCssBus;
+
+#define TYPE_VIRTUAL_CSS_BUS "virtual-css-bus"
+#define VIRTUAL_CSS_BUS(obj) \
+     OBJECT_CHECK(VirtualCssBus, (obj), TYPE_VIRTUAL_CSS_BUS)
+
+VirtualCssBus *virtual_css_bus_init(void);
+void virtio_ccw_device_update_status(SubchDev *sch);
+VirtIODevice *virtio_ccw_get_vdev(SubchDev *sch);
diff --git a/trace-events b/trace-events
index bbed1cd..8796426 100644
--- a/trace-events
+++ b/trace-events
@@ -1074,3 +1074,7 @@ css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02
 css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
 css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
 css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
+
+# hw/s390x/virtio-ccw.c
+virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
+virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
-- 
1.7.12.4
