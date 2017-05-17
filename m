From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v8 10/13] s390x/css: introduce and realize ccw-request callback
Date: Wed, 17 May 2017 02:48:10 +0200
Message-ID: <20170517004813.58227-11-bjsdjshi@linux.vnet.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

Introduce a new callback on subchannel to handle ccw-request.
Realize the callback in vfio-ccw device. Besides, resort to
the event notifier handler to handling the ccw-request results.
1. Pread the I/O results via MMIO region.
2. Update the scsw info to guest.
3. Inject an I/O interrupt to notify guest the I/O result.

Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c              |  4 +--
 hw/vfio/ccw.c               | 85 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h      |  2 ++
 include/hw/s390x/s390-ccw.h |  1 +
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a8aed9cb3a..462a768f9e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -259,7 +259,7 @@ uint16_t css_build_subchannel_id(SubchDev *sch)
     return css_do_build_subchannel_id(sch->cssid, sch->ssid);
 }
 
-static void css_inject_io_interrupt(SubchDev *sch)
+void css_inject_io_interrupt(SubchDev *sch)
 {
     uint8_t isc = (sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ISC) >> 11;
 
@@ -671,7 +671,7 @@ static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
     dest->chars = cpu_to_be32(src->chars);
 }
 
-static void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
+void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 {
     dest->flags = cpu_to_be16(src->flags);
     dest->ctrl = cpu_to_be16(src->ctrl);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 689a7724b6..007ce435f1 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -47,6 +47,36 @@ struct VFIODeviceOps vfio_ccw_ops = {
     .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
 };
 
+static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
+{
+    S390CCWDevice *cdev = data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_io_region *region = vcdev->io_region;
+    int ret;
+
+    QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
+    QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
+    QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
+
+    memset(region, 0, sizeof(*region));
+
+    memcpy(region->orb_area, orb, sizeof(ORB));
+    memcpy(region->scsw_area, scsw, sizeof(SCSW));
+
+again:
+    ret = pwrite(vcdev->vdev.fd, region,
+                 vcdev->io_region_size, vcdev->io_region_offset);
+    if (ret != vcdev->io_region_size) {
+        if (errno == EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
+        return -errno;
+    }
+
+    return region->ret_code;
+}
+
 static void vfio_ccw_reset(DeviceState *dev)
 {
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
@@ -59,10 +89,62 @@ static void vfio_ccw_reset(DeviceState *dev)
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
+    struct ccw_io_region *region = vcdev->io_region;
+    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    SubchDev *sch = ccw_dev->sch;
+    SCSW *s = &sch->curr_status.scsw;
+    IRB irb;
+    int size;
 
     if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
         return;
     }
+
+    size = pread(vcdev->vdev.fd, region, vcdev->io_region_size,
+                 vcdev->io_region_offset);
+    if (size == -1) {
+        switch (errno) {
+        case ENODEV:
+            /* Generate a deferred cc 3 condition. */
+            s->flags |= SCSW_FLAGS_MASK_CC;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
+            goto read_err;
+        case EFAULT:
+            /* Memory problem, generate channel data check. */
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_DATA_CHECK;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                       SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            goto read_err;
+        default:
+            /* Error, generate channel program check. */
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_PROG_CHECK;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                       SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            goto read_err;
+        }
+    } else if (size != vcdev->io_region_size) {
+        /* Information transfer error, generate channel-control check. */
+        s->ctrl &= ~SCSW_ACTL_START_PEND;
+        s->cstat = SCSW_CSTAT_CHN_CTRL_CHK;
+        s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+        s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                   SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+        goto read_err;
+    }
+
+    memcpy(&irb, region->irb_area, sizeof(IRB));
+
+    /* Update control block via irb. */
+    copy_scsw_to_guest(s, &irb.scsw);
+
+read_err:
+    css_inject_io_interrupt(sch);
 }
 
 static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
@@ -318,6 +400,7 @@ static const VMStateDescription vfio_ccw_vmstate = {
 static void vfio_ccw_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     dc->props = vfio_ccw_properties;
     dc->vmsd = &vfio_ccw_vmstate;
@@ -325,6 +408,8 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
     dc->realize = vfio_ccw_realize;
     dc->unrealize = vfio_ccw_unrealize;
     dc->reset = vfio_ccw_reset;
+
+    cdc->handle_request = vfio_ccw_handle_request;
 }
 
 static const TypeInfo vfio_ccw_info = {
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 60ff83e9c1..a932f91edb 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -137,6 +137,8 @@ void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
 int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id);
 unsigned int css_find_free_chpid(uint8_t cssid);
 uint16_t css_build_subchannel_id(SubchDev *sch);
+void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
+void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index b58d8e9ca3..9f45cf1347 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -33,6 +33,7 @@ typedef struct S390CCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
     void (*unrealize)(S390CCWDevice *dev, Error **errp);
+    int (*handle_request) (ORB *, SCSW *, void *);
 } S390CCWDeviceClass;
 
 #endif
-- 
2.11.2
