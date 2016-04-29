From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Subject: [PATCH RFC 9/9] s390x/css: ccws translation infrastructure
Date: Fri, 29 Apr 2016 14:13:23 +0200
Message-ID: <1461932003-23830-10-git-send-email-renxiaof@linux.vnet.ibm.com>
References: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1461932003-23830-1-git-send-email-renxiaof@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Implement a basic infrastructure of handling channel I/O instruction
interception for passed through devices:
1. Branch the code path of instruction interception handling by
   SubChannel type.
2. For a passed through device, issue the ORB to do ccw translation
   and perform an I/O operation.
3. Inject an I/O interrupt to notify guest the I/O result.
4. Assign different condition code based on the I/O result, or
   trigger a program check.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/css.c        | 130 ++++++++++++++++++++++++++++++++++++++++++++------
 hw/s390x/css.h        |   8 ++++
 hw/s390x/s390-ccw.c   |  12 +++++
 hw/s390x/virtio-ccw.c |   1 +
 target-s390x/ioinst.c |   9 ++++
 5 files changed, 145 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 5d02ad3..a46e63b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -463,7 +463,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     return ret;
 }
 
-static void sch_handle_start_func(SubchDev *sch, ORB *orb)
+static void sch_handle_start_func_virtual(SubchDev *sch, ORB *orb)
 {
 
     PMCW *p = &sch->curr_status.pmcw;
@@ -558,13 +558,79 @@ static void sch_handle_start_func(SubchDev *sch, ORB *orb)
 
 }
 
+static void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
+{
+    dest->flags = cpu_to_be16(src->flags);
+    dest->ctrl = cpu_to_be16(src->ctrl);
+    dest->cpa = cpu_to_be32(src->cpa);
+    dest->dstat = src->dstat;
+    dest->cstat = src->cstat;
+    dest->count = cpu_to_be16(src->count);
+}
+
+static int sch_handle_start_func_passthrough(SubchDev *sch, ORB *orb)
+{
+
+    PMCW *p = &sch->curr_status.pmcw;
+    SCSW *s = &sch->curr_status.scsw;
+    int ret;
+
+    if (!(s->ctrl & SCSW_ACTL_SUSP)) {
+        assert(orb != NULL);
+        p->intparm = orb->intparm;
+    }
+
+    /* Prepare the irb for the guest. */
+    memset(&sch->irb, 0, sizeof(IRB));
+
+    /*
+     * TODO:
+     * Only support prefetch enable mode.
+     * Only support 64bit addressing idal.
+     */
+    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
+        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
+        return -EINVAL;
+    }
+
+    ret = s390_ccw_cmd_request(orb, &sch->irb, s, sch->driver_data);
+    switch (ret) {
+    case 0:
+        /* Update control block via irb. */
+        copy_scsw_to_guest(s, &sch->irb.scsw);
+        break;
+    case -EBUSY:
+        break;
+    case -ENODEV:
+        break;
+    case -EACCES:
+        /* Let's reflect an inaccessible host device by cc 3. */
+        ret = -ENODEV;
+        break;
+    case -ENOMEM:
+       /* No memory, generate deferred cc 1. */
+       s->flags &= ~SCSW_FLAGS_MASK_CC;
+       s->flags |= (1 << 8);
+       s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+       s->ctrl |= SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+       break;
+    default:
+       /* All other return codes will trigger a program check,
+        * or set cc to 1.
+        */
+       break;
+    };
+
+    return ret;
+}
+
 /*
  * On real machines, this would run asynchronously to the main vcpus.
  * We might want to make some parts of the ssch handling (interpreting
  * read/writes) asynchronous later on if we start supporting more than
  * our current very simple devices.
  */
-static void do_subchannel_work(SubchDev *sch, ORB *orb)
+static void do_subchannel_work_virtual(SubchDev *sch, ORB *orb)
 {
 
     SCSW *s = &sch->curr_status.scsw;
@@ -574,7 +640,7 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
     } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
         sch_handle_halt_func(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
-        sch_handle_start_func(sch, orb);
+        sch_handle_start_func_virtual(sch, orb);
     } else {
         /* Cannot happen. */
         return;
@@ -582,6 +648,51 @@ static void do_subchannel_work(SubchDev *sch, ORB *orb)
     css_inject_io_interrupt(sch);
 }
 
+static int do_subchannel_work_passthrough(SubchDev *sch, ORB *orb)
+{
+    int ret;
+    SCSW *s = &sch->curr_status.scsw;
+
+    if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
+        /* TODO: Clear handling */
+        sch_handle_clear_func(sch);
+        ret = 0;
+    } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
+        /* TODO: Halt handling */
+        sch_handle_halt_func(sch);
+        ret = 0;
+    } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
+        ret = sch_handle_start_func_passthrough(sch, orb);
+    } else {
+        /* Cannot happen. */
+        return -ENODEV;
+    }
+
+    css_inject_io_interrupt(sch);
+
+    return ret;
+}
+
+static int do_subchannel_work(SubchDev *sch, ORB *orb)
+{
+    int ret;
+
+    switch (sch->type) {
+    case SUBCH_TYPE_VIRTUAL:
+        do_subchannel_work_virtual(sch, orb);
+        ret = 0;
+        break;
+    case SUBCH_TYPE_PASSTHROUGH:
+        ret = do_subchannel_work_passthrough(sch, orb);
+        break;
+    default:
+        assert(false);
+        ret = -EINVAL;
+    };
+
+    return ret;
+}
+
 static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
 {
     int i;
@@ -602,16 +713,6 @@ static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
     dest->chars = cpu_to_be32(src->chars);
 }
 
-static void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
-{
-    dest->flags = cpu_to_be16(src->flags);
-    dest->ctrl = cpu_to_be16(src->ctrl);
-    dest->cpa = cpu_to_be32(src->cpa);
-    dest->dstat = src->dstat;
-    dest->cstat = src->cstat;
-    dest->count = cpu_to_be16(src->count);
-}
-
 static void copy_schib_to_guest(SCHIB *dest, const SCHIB *src)
 {
     int i;
@@ -898,8 +999,7 @@ int css_do_ssch(SubchDev *sch, ORB *orb)
     s->ctrl |= (SCSW_FCTL_START_FUNC | SCSW_ACTL_START_PEND);
     s->flags &= ~SCSW_FLAGS_MASK_PNO;
 
-    do_subchannel_work(sch, orb);
-    ret = 0;
+    ret = do_subchannel_work(sch, orb);
 
 out:
     return ret;
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index c280226..5f16edc 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -76,6 +76,8 @@ struct SubchDev {
     uint8_t ssid;
     uint16_t schid;
     uint16_t devno;
+    uint8_t type;
+    IRB irb;
     SCHIB curr_status;
     uint8_t sense_data[32];
     hwaddr channel_prog;
@@ -99,6 +101,11 @@ typedef struct IndAddr {
     QTAILQ_ENTRY(IndAddr) sibling;
 } IndAddr;
 
+enum {
+    SUBCH_TYPE_VIRTUAL      = 0,
+    SUBCH_TYPE_PASSTHROUGH  = 1,
+};
+
 IndAddr *get_indicator(hwaddr ind_addr, int len);
 void release_indicator(AdapterInfo *adapter, IndAddr *indicator);
 int map_indicator(AdapterInfo *adapter, IndAddr *indicator);
@@ -123,6 +130,7 @@ void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 void css_adapter_interrupt(uint8_t isc);
 int css_sch_build_schib(SubchDev *sch, const char *hschid);
+int s390_ccw_cmd_request(ORB *orb, IRB *irb, SCSW *scsw, void *data);
 
 #define CSS_IO_ADAPTER_VIRTIO 1
 int css_register_io_adapter(uint8_t type, uint8_t isc, bool swap,
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 7b378f9..ed6f242 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -18,6 +18,17 @@
 #include "s390-ccw-bus.h"
 #include "s390-ccw.h"
 
+int s390_ccw_cmd_request(ORB *orb, IRB *irb, SCSW *scsw, void *data)
+{
+    S390CCWDevice *cdev = data;
+
+    if (cdev->handle_request) {
+        return cdev->handle_request(orb, irb, scsw, data);
+    } else {
+        return -ENOSYS;
+    }
+}
+
 static void s390_ccw_realize(S390CCWDevice *cdev, Error **errp)
 {
     unsigned int cssid, ssid, devno, schid;
@@ -89,6 +100,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, Error **errp)
     sch->cssid = cssid;
     sch->ssid = ssid;
     sch->devno = devno;
+    sch->type = SUBCH_TYPE_PASSTHROUGH;
 
     cdev->sch = NULL;
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d51642d..621befb 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -758,6 +758,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     sch->channel_prog = 0x0;
     sch->last_cmd_valid = false;
     sch->thinint_active = false;
+    sch->type = SUBCH_TYPE_VIRTUAL;
     /*
      * Use a device number if provided. Otherwise, fall back to subchannel
      * number.
diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
index 142ff93..59f15af 100644
--- a/target-s390x/ioinst.c
+++ b/target-s390x/ioinst.c
@@ -244,6 +244,15 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
     case -EBUSY:
         cc = 2;
         break;
+    case -EFAULT:
+        /*
+         * TODO:
+         * I'm wondering whether there is something better
+         * to do for us here (like setting some device or
+         * subchannel status).
+         */
+        program_interrupt(env, PGM_ADDRESSING, 4);
+        return;
     case 0:
         cc = 0;
         break;
-- 
2.6.6
