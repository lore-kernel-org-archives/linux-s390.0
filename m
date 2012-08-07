From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/5] s390: Virtual channel subsystem support.
Date: Tue,  7 Aug 2012 16:52:50 +0200
Message-ID: <1344351173-2716-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1344351173-2716-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provide a mechanism for qemu to provide fully virtual subchannels to
the guest. In the KVM case, this relies on the kernel's css support.
The !KVM case is not yet supported.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/Makefile.objs     |   1 +
 hw/s390x/css.c             | 440 +++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/css.h             |  62 +++++++
 target-s390x/Makefile.objs |   2 +-
 target-s390x/cpu.h         | 108 +++++++++++
 target-s390x/ioinst.c      |  38 ++++
 target-s390x/ioinst.h      | 173 ++++++++++++++++++
 target-s390x/kvm.c         | 101 +++++++++++
 8 files changed, 924 insertions(+), 1 deletion(-)
 create mode 100644 hw/s390x/css.c
 create mode 100644 hw/s390x/css.h
 create mode 100644 target-s390x/ioinst.c
 create mode 100644 target-s390x/ioinst.h

diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index dcdcac8..93b41fb 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y = s390-virtio-bus.o s390-virtio.o
 
 obj-y := $(addprefix ../,$(obj-y))
+obj-y += css.o
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
new file mode 100644
index 0000000..7941c44
--- /dev/null
+++ b/hw/s390x/css.c
@@ -0,0 +1,440 @@
+/*
+ * Channel subsystem base support.
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu-thread.h"
+#include "qemu-queue.h"
+#include <hw/qdev.h>
+#include "kvm.h"
+#include "cpu.h"
+#include "ioinst.h"
+#include "css.h"
+
+struct chp_info {
+    uint8_t in_use;
+    uint8_t type;
+};
+
+static struct chp_info chpids[MAX_CSSID + 1][MAX_CHPID + 1];
+
+static css_subch_cb_func css_subch_cb;
+
+int css_set_subch_cb(css_subch_cb_func func)
+{
+    if (func && css_subch_cb) {
+        return -EBUSY;
+    }
+    css_subch_cb = func;
+    return 0;
+}
+
+static void css_inject_io_interrupt(SubchDev *sch, uint8_t func)
+{
+    s390_io_interrupt(sch->cssid, sch->ssid, sch->schid, &sch->curr_status.scsw,
+                      &sch->curr_status.pmcw, &sch->sense_data, 0,
+                      sch->curr_status.pmcw.isc, sch->curr_status.pmcw.intparm,
+                      func);
+}
+
+void css_conditional_io_interrupt(SubchDev *sch)
+{
+    s390_io_interrupt(sch->cssid, sch->ssid, sch->schid, &sch->curr_status.scsw,
+                      &sch->curr_status.pmcw, &sch->sense_data, 1,
+                      sch->curr_status.pmcw.isc, sch->curr_status.pmcw.intparm, 0);
+}
+
+static void sch_handle_clear_func(SubchDev *sch)
+{
+    struct pmcw *p = &sch->curr_status.pmcw;
+    struct scsw *s = &sch->curr_status.scsw;
+    int path;
+
+    /* Path management: In our simple css, we always choose the only path. */
+    path = 0x80;
+
+    /* Reset values prior to 'issueing the clear signal'. */
+    p->lpum = 0;
+    p->pom = 0xff;
+    s->pno = 0;
+
+    /* We always 'attempt to issue the clear signal', and we always succeed. */
+    sch->orb = NULL;
+    sch->channel_prog = NULL;
+    sch->last_cmd = NULL;
+    s->actl &= ~SCSW_ACTL_CLEAR_PEND;
+    s->stctl |= SCSW_STCTL_STATUS_PEND;
+
+    s->dstat = 0;
+    s->cstat = 0;
+    p->lpum = path;
+
+}
+
+static void sch_handle_halt_func(SubchDev *sch)
+{
+
+    struct pmcw *p = &sch->curr_status.pmcw;
+    struct scsw *s = &sch->curr_status.scsw;
+    int path;
+
+    /* Path management: In our simple css, we always choose the only path. */
+    path = 0x80;
+
+    /* We always 'attempt to issue the halt signal', and we always succeed. */
+    sch->orb = NULL;
+    sch->channel_prog = NULL;
+    sch->last_cmd = NULL;
+    s->actl &= ~SCSW_ACTL_HALT_PEND;
+    s->stctl |= SCSW_STCTL_STATUS_PEND;
+
+    if ((s->actl & (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) ||
+        !((s->actl & SCSW_ACTL_START_PEND) ||
+          (s->actl & SCSW_ACTL_SUSP))) {
+        s->dstat = SCSW_DSTAT_DEVICE_END;
+    }
+    s->cstat = 0;
+    p->lpum = path;
+
+}
+
+static int css_interpret_ccw(SubchDev *sch, struct ccw1 *ccw)
+{
+    int ret;
+    bool check_len;
+    int len;
+    int i;
+
+    if (!ccw) {
+        return -EIO;
+    }
+
+    /* Check for invalid command codes. */
+    if ((ccw->cmd_code & 0x0f) == 0) {
+        return -EINVAL;
+    }
+    if (((ccw->cmd_code & 0x0f) == CCW_CMD_TIC) &&
+        ((ccw->cmd_code & 0xf0) != 0)) {
+        return -EINVAL;
+    }
+
+    if (ccw->flags & CCW_FLAG_SUSPEND) {
+        return -ERESTART;
+    }
+
+    check_len = !((ccw->flags & CCW_FLAG_SLI) && !(ccw->flags & CCW_FLAG_DC));
+
+    /* Look at the command. */
+    switch (ccw->cmd_code) {
+    case CCW_CMD_NOOP:
+        /* Nothing to do. */
+        ret = 0;
+        break;
+    case CCW_CMD_BASIC_SENSE:
+        if (check_len) {
+            if (ccw->count != sizeof(sch->sense_data)) {
+                ret = -EINVAL;
+                break;
+            }
+        }
+        len = MIN(ccw->count, sizeof(sch->sense_data));
+        cpu_physical_memory_write(ccw->cda, sch->sense_data, len);
+        sch->curr_status.scsw.count = ccw->count - len;
+        memset(sch->sense_data, 0, sizeof(sch->sense_data));
+        ret = 0;
+        break;
+    case CCW_CMD_SENSE_ID:
+    {
+        uint8_t sense_bytes[256];
+
+        /* Sense ID information is device specific. */
+        memcpy(sense_bytes, &sch->id, sizeof(sense_bytes));
+        if (check_len) {
+            if (ccw->count != sizeof(sense_bytes)) {
+                ret = -EINVAL;
+                break;
+            }
+        }
+        len = MIN(ccw->count, sizeof(sense_bytes));
+        /*
+         * Only indicate 0xff in the first sense byte if we actually
+         * have enough place to store at least bytes 0-3.
+         */
+        if (len >= 4) {
+            stb_phys(ccw->cda, 0xff);
+        } else {
+            stb_phys(ccw->cda, 0);
+        }
+        i = 1;
+        for (i = 1; i < len - 1; i++) {
+            stb_phys(ccw->cda + i, sense_bytes[i]);
+        }
+        sch->curr_status.scsw.count = ccw->count - len;
+        ret = 0;
+        break;
+    }
+    case CCW_CMD_TIC:
+        if (sch->last_cmd->cmd_code == CCW_CMD_TIC) {
+            ret = -EINVAL;
+            break;
+        }
+        if (ccw->flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
+            ret = -EINVAL;
+            break;
+        }
+        sch->channel_prog = qemu_get_ram_ptr(ccw->cda);
+        ret = sch->channel_prog ? -EAGAIN : -EFAULT;
+        break;
+    default:
+        if (sch->ccw_cb) {
+            /* Handle device specific commands. */
+            ret = sch->ccw_cb(sch, ccw);
+        } else {
+            ret = -EOPNOTSUPP;
+        }
+        break;
+    }
+    sch->last_cmd = ccw;
+    if (ret == 0) {
+        if (ccw->flags & CCW_FLAG_CC) {
+            sch->channel_prog += 8;
+            ret = -EAGAIN;
+        }
+    }
+
+    return ret;
+}
+
+static void sch_handle_start_func(SubchDev *sch)
+{
+
+    struct pmcw *p = &sch->curr_status.pmcw;
+    struct scsw *s = &sch->curr_status.scsw;
+    struct orb *orb = sch->orb;
+    int path;
+    int ret;
+
+    /* Path management: In our simple css, we always choose the only path. */
+    path = 0x80;
+
+    if (!s->actl & SCSW_ACTL_SUSP) {
+        /* Look at the orb and try to execute the channel program. */
+        p->intparm = orb->intparm;
+        if (!(orb->lpm & path)) {
+            /* Generate a deferred cc 3 condition. */
+            s->cc = 3;
+            s->stctl = (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
+            return;
+        }
+    } else {
+        s->actl &= ~(SCSW_ACTL_SUSP | SCSW_ACTL_RESUME_PEND);
+    }
+    sch->last_cmd = NULL;
+    do {
+        ret = css_interpret_ccw(sch, sch->channel_prog);
+        switch (ret) {
+        case -EAGAIN:
+            /* ccw chain, continue processing */
+            break;
+        case 0:
+            /* success */
+            s->actl &= ~SCSW_ACTL_START_PEND;
+            s->stctl = SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                SCSW_STCTL_STATUS_PEND;
+            s->dstat = SCSW_DSTAT_CHANNEL_END | SCSW_DSTAT_DEVICE_END;
+            break;
+        case -EOPNOTSUPP:
+            /* unsupported command, generate unit check (command reject) */
+            s->actl &= ~SCSW_ACTL_START_PEND;
+            s->dstat = SCSW_DSTAT_UNIT_CHECK;
+            /* Set sense bit 0 in ecw0. */
+            sch->sense_data[0] = 0x80;
+            s->stctl = SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            break;
+        case -EFAULT:
+            /* memory problem, generate channel data check */
+            s->actl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_DATA_CHECK;
+            s->stctl = SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            break;
+        case -EBUSY:
+            /* subchannel busy, generate deferred cc 1 */
+            s->cc = 1;
+            s->stctl = SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            break;
+        case -ERESTART:
+            /* channel program has been suspended */
+            s->actl &= ~SCSW_ACTL_START_PEND;
+            s->actl |= SCSW_ACTL_SUSP;
+            break;
+        default:
+            /* error, generate channel program check */
+            s->actl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_PROG_CHECK;
+            s->stctl = SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            break;
+        }
+    } while (ret == -EAGAIN);
+
+}
+
+int css_handle_sch_io(uint32_t sch_id, uint8_t func, uint64_t orb, void *scsw,
+                      void *pmcw)
+{
+    SubchDev *sch;
+    int cssid;
+    int ssid;
+    int schid;
+    int m;
+    int ret;
+    int notify = 0;
+
+    ret = ioinst_disassemble_sch_ident(sch_id, &m, &cssid, &ssid, &schid);
+    if (ret) {
+        return ret;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (!sch) {
+        return -ENODEV;
+    }
+    qemu_mutex_lock(&sch->mutex);
+    memcpy(&sch->curr_status.pmcw, pmcw, sizeof(struct pmcw));
+    switch (func) {
+    case CSS_DO_CSCH:
+        memcpy(&sch->curr_status.scsw, scsw, sizeof(struct scsw));
+        /* fallthrough */
+    case CSS_DO_CSCH_SIMPLE:
+        sch_handle_clear_func(sch);
+        notify = 1;
+        break;
+    case CSS_DO_HSCH:
+        memcpy(&sch->curr_status.scsw, scsw, sizeof(struct scsw));
+        /* fallthrough */
+    case CSS_DO_HSCH_SIMPLE:
+        sch_handle_halt_func(sch);
+        notify = 1;
+        break;
+    case CSS_DO_SSCH:
+        memcpy(&sch->curr_status.scsw, scsw, sizeof(struct scsw));
+        sch->orb = qemu_get_ram_ptr(orb);
+        sch->channel_prog = qemu_get_ram_ptr(sch->orb->cpa);
+        /* fallthrough */
+    case CSS_DO_SSCH_SIMPLE:
+        sch_handle_start_func(sch);
+        notify = 1;
+        break;
+    case CSS_DO_RSCH:
+        memcpy(&sch->curr_status.scsw, scsw, sizeof(struct scsw));
+        sch_handle_start_func(sch);
+        notify = 1;
+        break;
+    case CSS_DO_XSCH:
+        sch->orb = NULL;
+        sch->channel_prog = NULL;
+        sch->last_cmd = NULL;
+        break;
+    }
+    if (notify) {
+        css_inject_io_interrupt(sch, func);
+    }
+    qemu_mutex_unlock(&sch->mutex);
+    return 0;
+}
+
+static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
+{
+    if (cssid > MAX_CSSID) {
+        return -EINVAL;
+    }
+    if (chpids[cssid][chpid].in_use) {
+        return -EEXIST;
+    }
+    chpids[cssid][chpid].in_use = 1;
+    chpids[cssid][chpid].type = type;
+
+    s390_chp_hotplug(cssid, chpid, type, 1, 1);
+
+    return 0;
+}
+
+void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type)
+{
+    struct pmcw *p = &sch->curr_status.pmcw;
+    struct scsw *s = &sch->curr_status.scsw;
+    int i;
+
+    memset(p, 0, sizeof(struct pmcw));
+    p->dnv = 1;
+    p->dev = sch->devno;
+    /* single path */
+    p->pim = 0x80;
+    p->pom = 0xff;
+    p->pam = 0x80;
+    p->chpid[0] = chpid;
+    if (!chpids[sch->cssid][chpid].in_use) {
+        css_add_virtual_chpid(sch->cssid, chpid, type);
+    }
+
+    memset(s, 0, sizeof(struct scsw));
+    sch->curr_status.mba = 0;
+    for (i = 0; i < 4; i++) {
+        sch->curr_status.mda[i] = 0;
+    }
+}
+
+SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid, uint16_t schid)
+{
+    return css_subch_cb ? css_subch_cb(m, cssid, ssid, schid) : NULL;
+}
+
+static void css_init(void)
+{
+    css_subch_cb = NULL;
+}
+machine_init(css_init);
+
+void css_reset_sch(SubchDev *sch)
+{
+    struct pmcw *p = &sch->curr_status.pmcw;
+
+    p->intparm = 0;
+    p->isc = 0;
+    p->ena = 0;
+    p->lm = 0;
+    p->mme = 0;
+    p->mp = 0;
+    p->tf = 0;
+    p->dnv = 1;
+    p->dev = sch->devno;
+    p->pim = 0x80;
+    p->lpm = p->pim;
+    p->pnom = 0;
+    p->lpum = 0;
+    p->mbi = 0;
+    p->pom = 0xff;
+    p->pam = 0x80;
+    p->mbfc = 0;
+    p->xmwme = 0;
+    p->csense = 0;
+
+    memset(&sch->curr_status.scsw, 0, sizeof(sch->curr_status.scsw));
+    sch->curr_status.mba = 0;
+
+    sch->channel_prog = NULL;
+    sch->last_cmd = NULL;
+    sch->orb = NULL;
+}
+
+void css_reset(void)
+{
+    /* Nothing for now. */
+}
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
new file mode 100644
index 0000000..b8a95cc
--- /dev/null
+++ b/hw/s390x/css.h
@@ -0,0 +1,62 @@
+/*
+ * Channel subsystem structures and definitions.
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef CSS_H
+#define CSS_H
+
+#include "ioinst.h"
+
+/* Channel subsystem constants. */
+#define MAX_SCHID 65535
+#define MAX_SSID 3
+#define MAX_CSSID 254 /* 255 is reserved */
+#define MAX_CHPID 255
+
+#define MAX_CIWS 8
+
+struct senseid {
+    /* common part */
+    uint32_t  reserved:8;    /* always 0x'FF' */
+    uint32_t  cu_type:16;    /* control unit type */
+    uint32_t  cu_model:8;    /* control unit model */
+    uint32_t  dev_type:16;   /* device type */
+    uint32_t  dev_model:8;   /* device model */
+    uint32_t  unused:8;      /* padding byte */
+    /* extended part */
+    uint32_t ciw[MAX_CIWS];  /* variable # of CIWs */
+};
+
+struct SubchDev {
+    /* channel-subsystem related things: */
+    uint8_t cssid;
+    uint8_t ssid;
+    uint16_t schid;
+    uint16_t devno;
+    struct schib curr_status;
+    uint8_t sense_data[32];
+    struct ccw1 *channel_prog;
+    struct ccw1 *last_cmd;
+    struct orb *orb;
+    QemuMutex mutex;
+    /* transport-provided data: */
+    int (*ccw_cb) (SubchDev *, struct ccw1 *);
+    struct senseid id;
+    void *driver_data;
+};
+
+typedef SubchDev *(*css_subch_cb_func)(uint8_t m, uint8_t cssid, uint8_t ssid,
+                                       uint16_t schid);
+int css_set_subch_cb(css_subch_cb_func func);
+void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
+void css_reset(void);
+void css_reset_sch(SubchDev *sch);
+
+#endif
diff --git a/target-s390x/Makefile.objs b/target-s390x/Makefile.objs
index 262747f..cb05241 100644
--- a/target-s390x/Makefile.objs
+++ b/target-s390x/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y += translate.o op_helper.o helper.o cpu.o
-obj-$(CONFIG_SOFTMMU) += machine.o
+obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o
 obj-$(CONFIG_KVM) += kvm.o
 
 $(obj)/op_helper.o: QEMU_CFLAGS += $(HELPER_CFLAGS)
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index c30ac3a..c09fa61 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -336,6 +336,23 @@ static inline unsigned s390_del_running_cpu(CPUS390XState *env)
 void cpu_lock(void);
 void cpu_unlock(void);
 
+typedef struct SubchDev SubchDev;
+struct orb;
+
+#ifndef CONFIG_USER_ONLY
+SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid, uint16_t schid);
+void css_conditional_io_interrupt(SubchDev *sch);
+#else
+static inline SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
+                                       uint16_t schid)
+{
+    return NULL;
+}
+static inline void css_conditional_io_interrupt(SubchDev *sch)
+{
+}
+#endif
+
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 {
     env->aregs[0] = newtls >> 32;
@@ -996,4 +1013,95 @@ static inline void cpu_pc_from_tb(CPUS390XState *env, TranslationBlock* tb)
     env->psw.addr = tb->pc;
 }
 
+int css_handle_sch_io(uint32_t sch_id, uint8_t func, uint64_t orb, void *scsw,
+                      void *pmcw);
+#ifdef CONFIG_KVM
+int kvm_s390_sch_hotplug(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                         uint16_t devno, void *data, int hotplugged, int add,
+                         int virtual);
+int kvm_s390_chp_hotplug(uint8_t cssid, uint8_t chpid, uint8_t type, int add,
+                         int virtual);
+int kvm_s390_io_interrupt(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                          void *scsw, void *pmcw, void *sense,
+                          int unsolicited, uint8_t func);
+void kvm_s390_enable_css_support(CPUS390XState *env);
+#else
+static inline int kvm_s390_sch_hotplug(uint8_t cssid, uint8_t ssid,
+                                       uint16_t schid, uint16_t devno,
+                                       void *data, int hotplugged, int add,
+                                       int virtual)
+{
+    return -EOPNOTSUPP;
+}
+static inline int kvm_s390_chp_hotplug(uint8_t cssid, uint8_t chpid,
+                                       uint8_t type, int add, int virtual)
+{
+    return -EOPNOTSUPP;
+}
+static inline int kvm_s390_io_interrupt(uint8_t cssid, uint8_t ssid,
+                                        uint16_t schid, void *scsw, void *pmcw,
+                                        void *sense, int unsolicited, uint8_t func)
+{
+    return -EOPNOTSUPP;
+}
+static inline void kvm_s390_enable_css_support(CPUS390XState *env)
+{
+}
+#endif
+
+static inline void s390_sch_hotplug(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                                    uint16_t devno, void *data, int hotplugged,
+                                    int add, int virtual)
+{
+    int ret;
+
+    ret = kvm_s390_sch_hotplug(cssid, ssid, schid, devno, data, hotplugged,
+                               add, virtual);
+    if (ret == -EOPNOTSUPP) {
+        fprintf(stderr, "Hotplugging subchannels not supported\n");
+    }
+}
+
+static inline void s390_chp_hotplug(uint8_t cssid, uint8_t chpid, uint8_t type,
+                                    int add, int virtual)
+{
+    int ret;
+
+    ret = kvm_s390_chp_hotplug(cssid, chpid, type, add, virtual);
+    if (ret == -EOPNOTSUPP) {
+        fprintf(stderr, "Hotplugging chpids not supported\n");
+    }
+}
+
+static inline void s390_io_interrupt(uint8_t cssid, uint8_t ssid,
+                                     uint16_t schid, void *scsw, void *pmcw,
+                                     void *sense, int unsolicited,
+                                     uint8_t isc, uint32_t intparm, uint8_t func)
+{
+    int ret;
+
+    ret = kvm_s390_io_interrupt(cssid, ssid, schid, scsw, pmcw, sense,
+                                unsolicited, func);
+    if (ret == -EOPNOTSUPP) {
+        fprintf(stderr, "Injecting I/O interrupts not supported\n");
+    }
+}
+
+#ifdef CONFIG_KVM
+#define CSS_DO_CSCH SCH_DO_CSCH
+#define CSS_DO_HSCH SCH_DO_HSCH
+#define CSS_DO_SSCH SCH_DO_SSCH
+#define CSS_DO_RSCH SCH_DO_RSCH
+#define CSS_DO_XSCH SCH_DO_XSCH
+#else
+#define CSS_DO_CSCH 0
+#define CSS_DO_HSCH 1
+#define CSS_DO_SSCH 2
+#define CSS_DO_RSCH 3
+#define CSS_DO_XSCH 4
+#endif
+#define CSS_DO_CSCH_SIMPLE 0xf0
+#define CSS_DO_HSCH_SIMPLE 0xf1
+#define CSS_DO_SSCH_SIMPLE 0xf2
+
 #endif
diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
new file mode 100644
index 0000000..8f358d5
--- /dev/null
+++ b/target-s390x/ioinst.c
@@ -0,0 +1,38 @@
+/*
+ * I/O instructions for S/390
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include "cpu.h"
+#include "ioinst.h"
+
+int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
+                                 int *schid)
+{
+    if (!(value & 0x00010000)) {
+        return -EINVAL;
+    }
+    if (!(value & 0x00080000)) {
+        if (value & 0xff000000) {
+            return -EINVAL;
+        }
+        *cssid = 0;
+        *m = 0;
+    } else {
+        *cssid = (value & 0xff000000) >> 24;
+        *m = 1;
+    }
+    *ssid = (value & 0x00060000) >> 17;
+    *schid = value & 0x0000ffff;
+    return 0;
+}
diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
new file mode 100644
index 0000000..79628b4
--- /dev/null
+++ b/target-s390x/ioinst.h
@@ -0,0 +1,173 @@
+/*
+ * S/390 channel I/O instructions
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+*/
+
+#ifndef IOINST_S390X_H
+#define IOINST_S390X_H
+
+/*
+ * Channel I/O related definitions, as defined in the Principles
+ * Of Operation (and taken from the Linux implementation).
+ */
+
+/* subchannel status word (command mode only) */
+struct scsw {
+    uint32_t key:4;
+    uint32_t sctl:1;
+    uint32_t eswf:1;
+    uint32_t cc:2;
+    uint32_t fmt:1;
+    uint32_t pfch:1;
+    uint32_t isic:1;
+    uint32_t alcc:1;
+    uint32_t ssi:1;
+    uint32_t zcc:1;
+    uint32_t ectl:1;
+    uint32_t pno:1;
+    uint32_t res:1;
+    uint32_t fctl:3;
+    uint32_t actl:7;
+    uint32_t stctl:5;
+    uint32_t cpa;
+    uint32_t dstat:8;
+    uint32_t cstat:8;
+    uint32_t count:16;
+};
+
+/* path management control word */
+struct pmcw {
+    uint32_t intparm;
+    uint32_t qf:1;
+    uint32_t w:1;
+    uint32_t isc:3;
+    uint32_t zeroes0:3;
+    uint32_t ena:1;
+    uint32_t lm:2;
+    uint32_t mme:2;
+    uint32_t mp:1;
+    uint32_t tf:1;
+    uint32_t dnv:1;
+    uint32_t dev:16;
+    uint8_t  lpm;
+    uint8_t  pnom;
+    uint8_t  lpum;
+    uint8_t  pim;
+    uint16_t mbi;
+    uint8_t  pom;
+    uint8_t  pam;
+    uint8_t  chpid[8];
+    uint32_t zeroes1:8;
+    uint32_t st:3;
+    uint32_t zeroes2:18;
+    uint32_t mbfc:1;
+    uint32_t xmwme:1;
+    uint32_t csense:1;
+};
+
+/* subchannel information block */
+struct schib {
+    struct pmcw pmcw;
+    struct scsw scsw;
+    uint64_t mba;
+    uint8_t mda[4];
+};
+
+/* interruption response block */
+struct irb {
+    struct scsw scsw;
+    uint32_t esw[5];
+    uint32_t ecw[8];
+    uint32_t emw[8];
+};
+
+/* operation request block */
+struct orb {
+    uint32_t intparm;
+    uint32_t key:4;
+    uint32_t spnd:1;
+    uint32_t str:1;
+    uint32_t mod:1;
+    uint32_t sync:1;
+    uint32_t fmt:1;
+    uint32_t pfch:1;
+    uint32_t isic:1;
+    uint32_t alcc:1;
+    uint32_t ssic:1;
+    uint32_t zero0:1;
+    uint32_t c64:1;
+    uint32_t i2k:1;
+    uint32_t lpm:8;
+    uint32_t ils:1;
+    uint32_t midaw:1;
+    uint32_t zero1:5;
+    uint32_t orbx:1;
+    uint32_t cpa;
+};
+
+/* channel command word (type 1) */
+struct ccw1 {
+    uint8_t cmd_code;
+    uint8_t flags;
+    uint16_t count;
+    uint32_t cda;
+};
+
+#define CCW_FLAG_DC              0x80
+#define CCW_FLAG_CC              0x40
+#define CCW_FLAG_SLI             0x20
+#define CCW_FLAG_SKIP            0x10
+#define CCW_FLAG_PCI             0x08
+#define CCW_FLAG_IDA             0x04
+#define CCW_FLAG_SUSPEND         0x02
+
+#define CCW_CMD_NOOP             0x03
+#define CCW_CMD_BASIC_SENSE      0x04
+#define CCW_CMD_TIC              0x08
+#define CCW_CMD_SENSE_ID         0xe4
+
+#define SCSW_FCTL_CLEAR_FUNC     0x1
+#define SCSW_FCTL_HALT_FUNC      0x2
+#define SCSW_FCTL_START_FUNC     0x4
+
+#define SCSW_ACTL_SUSP           0x1
+#define SCSW_ACTL_DEVICE_ACTIVE  0x2
+#define SCSW_ACTL_SUBCH_ACTIVE   0x4
+#define SCSW_ACTL_CLEAR_PEND     0x8
+#define SCSW_ACTL_HALT_PEND      0x10
+#define SCSW_ACTL_START_PEND     0x20
+#define SCSW_ACTL_RESUME_PEND    0x40
+
+#define SCSW_STCTL_STATUS_PEND   0x1
+#define SCSW_STCTL_SECONDARY     0x2
+#define SCSW_STCTL_PRIMARY       0x4
+#define SCSW_STCTL_INTERMEDIATE  0x8
+#define SCSW_STCTL_ALERT         0x10
+
+#define SCSW_DSTAT_ATTENTION     0x80
+#define SCSW_DSTAT_STAT_MOD      0x40
+#define SCSW_DSTAT_CU_END        0x20
+#define SCSW_DSTAT_BUSY          0x10
+#define SCSW_DSTAT_CHANNEL_END   0x08
+#define SCSW_DSTAT_DEVICE_END    0x04
+#define SCSW_DSTAT_UNIT_CHECK    0x02
+#define SCSW_DSTAT_UNIT_EXCEP    0x01
+
+#define SCSW_CSTAT_PCI           0x80
+#define SCSW_CSTAT_INCORR_LEN    0x40
+#define SCSW_CSTAT_PROG_CHECK    0x20
+#define SCSW_CSTAT_PROT_CHECK    0x10
+#define SCSW_CSTAT_DATA_CHECK    0x08
+#define SCSW_CSTAT_CHN_CTRL_CHK  0x04
+#define SCSW_CSTAT_INTF_CTRL_CHK 0x02
+#define SCSW_CSTAT_CHAIN_CHECK   0x01
+
+int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
+                                 int *schid);
+#endif
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 47008c2..e4cde14 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -26,6 +26,7 @@
 
 #include "qemu-common.h"
 #include "qemu-timer.h"
+#include "qemu-thread.h"
 #include "sysemu.h"
 #include "kvm.h"
 #include "cpu.h"
@@ -110,6 +111,7 @@ int kvm_arch_put_registers(CPUS390XState *env, int level)
 
     env->kvm_run->psw_addr = env->psw.addr;
     env->kvm_run->psw_mask = env->psw.mask;
+    env->kvm_run->s.regs.prefix = env->psa;
 
     return ret;
 }
@@ -131,6 +133,7 @@ int kvm_arch_get_registers(CPUS390XState *env)
 
     env->psw.addr = env->kvm_run->psw_addr;
     env->psw.mask = env->kvm_run->psw_mask;
+    env->psa = env->kvm_run->s.regs.prefix;
 
     return 0;
 }
@@ -506,6 +509,13 @@ int kvm_arch_handle_exit(CPUS390XState *env, struct kvm_run *run)
         case KVM_EXIT_S390_RESET:
             qemu_system_reset_request();
             break;
+        case KVM_EXIT_S390_SCH_IO:
+            ret = css_handle_sch_io(run->s390_sch_io.sch_id,
+                                    run->s390_sch_io.func,
+                                    run->s390_sch_io.orb,
+                                    run->s390_sch_io.scsw,
+                                    run->s390_sch_io.pmcw);
+            break;
         default:
             fprintf(stderr, "Unknown KVM exit: %d\n", run->exit_reason);
             break;
@@ -531,3 +541,94 @@ int kvm_arch_on_sigbus(int code, void *addr)
 {
     return 1;
 }
+
+int kvm_s390_sch_hotplug(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                         uint16_t devno, void *data, int hotplugged, int add,
+                         int virtual)
+{
+    struct kvm_s390_sch_info sch_info;
+    S390CPU *cpu = s390_cpu_addr2state(0);
+    int ret;
+
+    if (!kvm_enabled()) {
+        return -EOPNOTSUPP;
+    }
+
+    /* Notify the kernel. */
+    sch_info.cssid = cssid;
+    sch_info.ssid = ssid;
+    sch_info.schid = schid;
+    sch_info.devno = devno;
+    memcpy(&sch_info.schib, data, sizeof(sch_info.schib));
+    sch_info.hotplugged = hotplugged;
+    sch_info.add = add;
+    sch_info.virtual = virtual;
+    ret = kvm_vm_ioctl(cpu->env.kvm_state, KVM_S390_CCW_HOTPLUG, &sch_info);
+    assert(ret == 0);
+    return ret;
+}
+
+int kvm_s390_chp_hotplug(uint8_t cssid, uint8_t chpid, uint8_t type, int add,
+                         int virtual)
+{
+    S390CPU *cpu = s390_cpu_addr2state(0);
+    struct kvm_s390_chp_info chpid_info;
+    int ret;
+
+    if (!kvm_enabled()) {
+        return -EOPNOTSUPP;
+    }
+
+    /* Notify the kernel. */
+    chpid_info.cssid = cssid;
+    chpid_info.chpid = chpid;
+    chpid_info.type = type;
+    chpid_info.add = 1;
+    chpid_info.virtual = 1;
+    ret = kvm_vm_ioctl(cpu->env.kvm_state, KVM_S390_CHP_HOTPLUG, &chpid_info);
+    assert(ret == 0);
+    return ret;
+}
+
+int kvm_s390_io_interrupt(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                          void *scsw, void *pmcw, void *sense,
+                          int unsolicited, uint8_t func)
+{
+    S390CPU *cpu = s390_cpu_addr2state(0);
+    struct kvm_css_notify notify;
+    int ret;
+
+    if (!kvm_enabled()) {
+        return -EOPNOTSUPP;
+    }
+
+    notify.cssid = cssid;
+    notify.ssid = ssid;
+    notify.schid = schid;
+    if (!unsolicited) {
+        memcpy(&notify.scsw, scsw, sizeof(notify.scsw));
+        memcpy(&notify.pmcw, pmcw, sizeof(notify.pmcw));
+        memcpy(&notify.sense_data, sense, sizeof(notify.sense_data));
+        notify.func = func;
+    }
+    notify.unsolicited = unsolicited;
+    ret = kvm_vcpu_ioctl(&cpu->env, KVM_S390_CSS_NOTIFY, &notify);
+    assert(ret == 0);
+    return ret;
+}
+
+void kvm_s390_enable_css_support(CPUS390XState *env)
+{
+    struct kvm_enable_cap cap = {};
+    int r;
+
+    /* Activate host kernel channel subsystem support. */
+    if (kvm_enabled()) {
+        /* One CPU has to run */
+        s390_add_running_cpu(env);
+
+        cap.cap = KVM_CAP_S390_CSS_SUPPORT;
+        r = kvm_vcpu_ioctl(env, KVM_ENABLE_CAP, &cap);
+        assert(r == 0);
+    }
+}
-- 
1.7.11.4
