From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 4/5] s390: Virtual channel subsystem support for !KVM.
Date: Tue,  4 Sep 2012 17:13:52 +0200
Message-ID: <1346771633-53081-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provide css support for the !KVM case as well.

This includes the following:
- Handling of instruction intercepts for I/O instructions.
- Extended channel subsystem functions, like monitoring.
- Support for injecting I/O interrupts and machine checks.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---

Changes v1->v2:
- coding style

---
 hw/s390x/css.c           | 749 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/css.h           |  26 ++
 target-s390x/cpu.h       | 157 +++++++++-
 target-s390x/helper.c    | 140 +++++++++
 target-s390x/ioinst.c    | 696 +++++++++++++++++++++++++++++++++++++++++++
 target-s390x/ioinst.h    |  35 ++-
 target-s390x/kvm.c       | 164 ++++++++++-
 target-s390x/op_helper.c |  22 +-
 8 files changed, 1961 insertions(+), 28 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index a671e28..3aab586 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -17,6 +17,12 @@
 #include "cpu.h"
 #include "ioinst.h"
 #include "css.h"
+#include "virtio-ccw.h"
+
+typedef struct CrwContainer {
+    CRW crw;
+    QTAILQ_ENTRY(CrwContainer) sibling;
+} CrwContainer;
 
 typedef struct ChpInfo {
     uint8_t in_use;
@@ -35,6 +41,13 @@ typedef struct CssImage {
 } CssImage;
 
 typedef struct ChannelSubSys {
+    QTAILQ_HEAD(, CrwContainer) pending_crws;
+    bool do_crw_mchk;
+    bool crws_lost;
+    uint8_t max_cssid;
+    uint8_t max_ssid;
+    bool chnmon_active;
+    uint64_t chnmon_area;
     CssImage *css[MAX_CSSID + 1];
     uint8_t default_cssid;
 } ChannelSubSys;
@@ -60,6 +73,76 @@ int css_create_css_image(uint8_t cssid, bool default_image)
     return 0;
 }
 
+static void css_write_phys_pmcw(uint32_t addr, PMCW *pmcw)
+{
+    int i;
+    uint32_t offset = 0;
+    struct copy_pmcw {
+        uint32_t intparm;
+        uint16_t flags;
+        uint16_t devno;
+        uint8_t lpm;
+        uint8_t pnom;
+        uint8_t lpum;
+        uint8_t pim;
+        uint16_t mbi;
+        uint8_t pom;
+        uint8_t pam;
+        uint8_t chpid[8];
+        uint32_t chars;
+    } *copy;
+
+    copy = (struct copy_pmcw *)pmcw;
+    stl_phys(addr + offset, copy->intparm);
+    offset += sizeof(copy->intparm);
+    stw_phys(addr + offset, copy->flags);
+    offset += sizeof(copy->flags);
+    stw_phys(addr + offset, copy->devno);
+    offset += sizeof(copy->devno);
+    stb_phys(addr + offset, copy->lpm);
+    offset += sizeof(copy->lpm);
+    stb_phys(addr + offset, copy->pnom);
+    offset += sizeof(copy->pnom);
+    stb_phys(addr + offset, copy->lpum);
+    offset += sizeof(copy->lpum);
+    stb_phys(addr + offset, copy->pim);
+    offset += sizeof(copy->pim);
+    stw_phys(addr + offset, copy->mbi);
+    offset += sizeof(copy->mbi);
+    stb_phys(addr + offset, copy->pom);
+    offset += sizeof(copy->pom);
+    stb_phys(addr + offset, copy->pam);
+    offset += sizeof(copy->pam);
+    for (i = 0; i < 8; i++) {
+        stb_phys(addr + offset, copy->chpid[i]);
+        offset += sizeof(copy->chpid[i]);
+    }
+    stl_phys(addr + offset, copy->chars);
+}
+
+static void css_write_phys_scsw(uint32_t addr, SCSW *scsw)
+{
+    uint32_t offset = 0;
+    struct copy_scsw {
+        uint32_t flags;
+        uint32_t cpa;
+        uint8_t dstat;
+        uint8_t cstat;
+        uint16_t count;
+    } *copy;
+
+    copy = (struct copy_scsw *)scsw;
+    stl_phys(addr + offset, copy->flags);
+    offset += sizeof(copy->flags);
+    stl_phys(addr + offset, copy->cpa);
+    offset += sizeof(copy->cpa);
+    stb_phys(addr + offset, copy->dstat);
+    offset += sizeof(copy->dstat);
+    stb_phys(addr + offset, copy->cstat);
+    offset += sizeof(copy->cstat);
+    stw_phys(addr + offset, copy->count);
+}
+
 static void css_inject_io_interrupt(SubchDev *sch, uint8_t func)
 {
     s390_io_interrupt(sch->cssid, sch->ssid, sch->schid, &sch->curr_status.scsw,
@@ -375,6 +458,543 @@ int css_handle_sch_io(uint32_t sch_id, uint8_t func, uint64_t orb, void *scsw,
     return 0;
 }
 
+/*
+ * This function should run asynchronously to the I/O instructions in order
+ * to match the implementation on real machines. For this simple virtual
+ * css it is fine to run the I/O work synchronously instead since it won't
+ * call out to real hardware.
+ * Note: This is only used in the !KVM case.
+ */
+static void do_subchannel_work(SubchDev *sch)
+{
+
+    SCSW *s = &sch->curr_status.scsw;
+    uint8_t func;
+
+    if (s->fctl & SCSW_FCTL_CLEAR_FUNC) {
+        func = CSS_DO_CSCH_SIMPLE;
+    } else if (s->fctl & SCSW_FCTL_HALT_FUNC) {
+        func = CSS_DO_HSCH_SIMPLE;
+    } else if (s->fctl & SCSW_FCTL_START_FUNC) {
+        func = CSS_DO_SSCH_SIMPLE;
+    } else {
+        /* Cannot happen. */
+        return;
+    }
+    css_handle_sch_io((sch->cssid << 24) | (1 << 29) | (sch->ssid << 16) |
+                      (1 << 16) | sch->schid,
+                      func, 0, NULL, NULL);
+}
+
+/* The various css_do_<instr> functions are only hit when KVM is not active. */
+
+int css_do_stsch(SubchDev *sch, uint32_t addr)
+{
+    int i;
+    uint32_t offset = 0;
+
+    qemu_mutex_lock(&sch->mutex);
+    /* Use current status. */
+    css_write_phys_pmcw(addr, &sch->curr_status.pmcw);
+    offset += sizeof(PMCW);
+    css_write_phys_scsw(addr + offset, &sch->curr_status.scsw);
+    offset += sizeof(SCSW);
+    stq_phys(addr + offset, sch->curr_status.mba);
+    offset += sizeof(sch->curr_status.mba);
+    for (i = 0; i < 4; i++) {
+        stb_phys(addr + offset, sch->curr_status.mda[i]);
+        offset += sizeof(sch->curr_status.mda[i]);
+    }
+    qemu_mutex_unlock(&sch->mutex);
+    return 0;
+}
+
+int css_do_msch(SubchDev *sch, SCHIB *schib)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!sch->curr_status.pmcw.dnv) {
+        ret = 0;
+        goto out;
+    }
+
+    if (s->stctl & SCSW_STCTL_STATUS_PEND) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
+    if (s->fctl &
+        (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
+        ret = -EBUSY;
+        goto out;
+    }
+
+    /* Only update the program-modifiable fields. */
+    p->ena = schib->pmcw.ena;
+    p->intparm = schib->pmcw.intparm;
+    p->isc = schib->pmcw.isc;
+    p->mp = schib->pmcw.mp;
+    p->lpm = schib->pmcw.lpm;
+    p->pom = schib->pmcw.pom;
+    p->lm = schib->pmcw.lm;
+    p->csense = schib->pmcw.csense;
+
+    p->mme = schib->pmcw.mme;
+    p->mbi = schib->pmcw.mbi;
+    p->mbfc = schib->pmcw.mbfc;
+    sch->curr_status.mba = schib->mba;
+
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_xsch(SubchDev *sch)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    if (!s->fctl || (s->fctl != SCSW_FCTL_START_FUNC) ||
+        (!(s->actl &
+           (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
+        (s->actl & SCSW_ACTL_SUBCH_ACTIVE)) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
+    if (s->stctl != 0) {
+        ret = -EBUSY;
+        goto out;
+    }
+
+    /* Cancel the current operation. */
+    s->fctl &= ~SCSW_FCTL_START_FUNC;
+    s->actl &= ~(SCSW_ACTL_RESUME_PEND|SCSW_ACTL_START_PEND|SCSW_ACTL_SUSP);
+    sch->channel_prog = NULL;
+    sch->last_cmd = NULL;
+    sch->orb = NULL;
+    s->dstat = 0;
+    s->cstat = 0;
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_csch(SubchDev *sch)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    /* Trigger the clear function. */
+    s->fctl = SCSW_FCTL_CLEAR_FUNC;
+    s->actl = SCSW_ACTL_CLEAR_PEND;
+
+    do_subchannel_work(sch);
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_hsch(SubchDev *sch)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    if ((s->stctl == SCSW_STCTL_STATUS_PEND) ||
+        (s->stctl & (SCSW_STCTL_PRIMARY |
+                     SCSW_STCTL_SECONDARY |
+                     SCSW_STCTL_ALERT))) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
+    if (s->fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
+        ret = -EBUSY;
+        goto out;
+    }
+
+    /* Trigger the halt function. */
+    s->fctl |= SCSW_FCTL_HALT_FUNC;
+    s->fctl &= ~SCSW_FCTL_START_FUNC;
+    if ((s->actl == (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) &&
+        (s->stctl == SCSW_STCTL_INTERMEDIATE)) {
+        s->stctl &= ~SCSW_STCTL_STATUS_PEND;
+    }
+    s->actl |= SCSW_ACTL_HALT_PEND;
+
+    do_subchannel_work(sch);
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+static void css_update_chnmon(SubchDev *sch)
+{
+    if (!sch->curr_status.pmcw.mme) {
+        /* Not active. */
+        return;
+    }
+    if (sch->curr_status.pmcw.mbfc) {
+        /* Format 1, per-subchannel area. */
+        struct cmbe *cmbe;
+
+        cmbe = qemu_get_ram_ptr(sch->curr_status.mba);
+        if (cmbe) {
+            cmbe->ssch_rsch_count++;
+        }
+    } else {
+        /* Format 0, global area. */
+        struct cmb *cmb;
+        uint32_t offset;
+
+        offset = sch->curr_status.pmcw.mbi << 5;
+        cmb = qemu_get_ram_ptr(channel_subsys->chnmon_area + offset);
+        if (cmb) {
+            cmb->ssch_rsch_count++;
+        }
+    }
+}
+
+int css_do_ssch(SubchDev *sch, ORB *orb)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    if (s->stctl & SCSW_STCTL_STATUS_PEND) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
+    if (s->fctl & (SCSW_FCTL_START_FUNC |
+                   SCSW_FCTL_HALT_FUNC |
+                   SCSW_FCTL_CLEAR_FUNC)) {
+        ret = -EBUSY;
+        goto out;
+    }
+
+    /* If monitoring is active, update counter. */
+    if (channel_subsys->chnmon_active) {
+        css_update_chnmon(sch);
+        css_inject_io_interrupt(sch, CSS_DO_SSCH_SIMPLE);
+    }
+    sch->orb = orb;
+    sch->channel_prog = qemu_get_ram_ptr(orb->cpa);
+    /* Trigger the start function. */
+    s->fctl |= SCSW_FCTL_START_FUNC;
+    s->actl |= SCSW_ACTL_START_PEND;
+    s->pno = 0;
+
+    do_subchannel_work(sch);
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_tsch(SubchDev *sch, uint32_t addr)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    uint8_t stctl;
+    uint8_t fctl;
+    uint8_t actl;
+    IRB irb;
+    int ret;
+    int i;
+    uint32_t offset = 0;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    stctl = s->stctl;
+    fctl = s->fctl;
+    actl = s->actl;
+
+    /* Prepare the irb for the guest. */
+    memset(&irb, 0, sizeof(IRB));
+
+    /* Copy scsw from current status. */
+    memcpy(&irb.scsw, s, sizeof(SCSW));
+    if (stctl & SCSW_STCTL_STATUS_PEND) {
+        if (s->cstat & (SCSW_CSTAT_DATA_CHECK |
+                        SCSW_CSTAT_CHN_CTRL_CHK |
+                        SCSW_CSTAT_INTF_CTRL_CHK)) {
+            irb.scsw.eswf = 1;
+            irb.esw[0] = 0x04804000;
+        } else {
+            irb.esw[0] = 0x00800000;
+        }
+        /* If a unit check is pending, copy sense data. */
+        if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) && p->csense) {
+            irb.scsw.eswf = 1;
+            irb.scsw.ectl = 1;
+            memcpy(irb.ecw, sch->sense_data, sizeof(sch->sense_data));
+            irb.esw[1] = 0x02000000 | (sizeof(sch->sense_data) << 8);
+        }
+    }
+    /* Store the irb to the guest. */
+    css_write_phys_scsw(addr + offset, &irb.scsw);
+    offset += sizeof(SCSW);
+    for (i = 0; i < 5; i++) {
+        stl_phys(addr + offset, irb.esw[i]);
+        offset += sizeof(irb.esw[i]);
+    }
+    for (i = 0; i < 8; i++) {
+        stl_phys(addr + offset, irb.ecw[i]);
+        offset += sizeof(irb.ecw[i]);
+    }
+    for (i = 0; i < 8; i++) {
+        stl_phys(addr + offset, irb.emw[i]);
+        offset += sizeof(irb.emw[i]);
+    }
+
+    /* Clear conditions on subchannel, if applicable. */
+    if (stctl & SCSW_STCTL_STATUS_PEND) {
+        s->stctl = 0;
+        if ((stctl != (SCSW_STCTL_INTERMEDIATE | SCSW_STCTL_STATUS_PEND)) ||
+            ((fctl & SCSW_FCTL_HALT_FUNC) &&
+             (actl & SCSW_ACTL_SUSP))) {
+            s->fctl = 0;
+        }
+        if (stctl != (SCSW_STCTL_INTERMEDIATE | SCSW_STCTL_STATUS_PEND)) {
+            s->pno = 0;
+            s->actl &= ~(SCSW_ACTL_RESUME_PEND |
+                         SCSW_ACTL_START_PEND |
+                         SCSW_ACTL_HALT_PEND |
+                         SCSW_ACTL_CLEAR_PEND |
+                         SCSW_ACTL_SUSP);
+        } else {
+            if ((actl & SCSW_ACTL_SUSP) &&
+                (fctl & SCSW_FCTL_START_FUNC)) {
+                s->pno = 0;
+                if (fctl & SCSW_FCTL_HALT_FUNC) {
+                    s->actl &= ~(SCSW_ACTL_RESUME_PEND |
+                                 SCSW_ACTL_START_PEND |
+                                 SCSW_ACTL_HALT_PEND |
+                                 SCSW_ACTL_CLEAR_PEND |
+                                 SCSW_ACTL_SUSP);
+                } else {
+                    s->actl &= ~SCSW_ACTL_RESUME_PEND;
+                }
+            }
+        }
+        /* Clear pending sense data. */
+        if (p->csense) {
+            memset(sch->sense_data, 0 , sizeof(sch->sense_data));
+        }
+    }
+
+    ret = ((stctl & SCSW_STCTL_STATUS_PEND) == 0);
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_stcrw(uint32_t addr)
+{
+    CrwContainer *crw_cont;
+    int ret;
+
+    crw_cont = QTAILQ_FIRST(&channel_subsys->pending_crws);
+    if (crw_cont) {
+        QTAILQ_REMOVE(&channel_subsys->pending_crws, crw_cont, sibling);
+        stl_phys(addr, *(uint32_t *)&crw_cont->crw);
+        g_free(crw_cont);
+        ret = 0;
+    } else {
+        /* List was empty, turn crw machine checks on again. */
+        stl_phys(addr, 0);
+        channel_subsys->do_crw_mchk = true;
+        ret = 1;
+    }
+
+    return ret;
+}
+
+int css_do_tpi(uint32_t addr, int lowcore)
+{
+    /* No pending interrupts for !KVM. */
+    return 0;
+ }
+
+int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
+                         int rfmt, void *buf)
+{
+    int i, desc_size;
+    uint32_t words[8];
+    CssImage *css;
+
+    if (m && !cssid) {
+        css = channel_subsys->css[channel_subsys->default_cssid];
+    } else {
+        css = channel_subsys->css[cssid];
+    }
+    if (!css) {
+        return 0;
+    }
+    desc_size = 0;
+    for (i = f_chpid; i <= l_chpid; i++) {
+        if (css->chpids[i].in_use) {
+            if (rfmt == 0) {
+                words[0] = 0x80000000 | (css->chpids[i].type << 8) | i;
+                words[1] = 0;
+                memcpy(buf + desc_size, words, 8);
+                desc_size += 8;
+            } else if (rfmt == 1) {
+                words[0] = 0x80000000 | (css->chpids[i].type << 8) | i;
+                words[1] = 0;
+                words[2] = 0;
+                words[3] = 0;
+                words[4] = 0;
+                words[5] = 0;
+                words[6] = 0;
+                words[7] = 0;
+                memcpy(buf + desc_size, words, 32);
+                desc_size += 32;
+            }
+        }
+    }
+    return desc_size;
+}
+
+void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
+{
+    /* dct is currently ignored (not really meaningful for our devices) */
+    /* TODO: Don't ignore mbk. */
+    /* TODO: Will need serialization with ssch when we are multithreaded. */
+    if (update && !channel_subsys->chnmon_active) {
+        /* Enable measuring. */
+        channel_subsys->chnmon_area = mbo;
+        channel_subsys->chnmon_active = true;
+    }
+    if (!update && channel_subsys->chnmon_active) {
+        /* Disable measuring. */
+        channel_subsys->chnmon_area = 0;
+        channel_subsys->chnmon_active = false;
+    }
+}
+
+int css_do_rsch(SubchDev *sch)
+{
+    SCSW *s = &sch->curr_status.scsw;
+    PMCW *p = &sch->curr_status.pmcw;
+    int ret;
+
+    qemu_mutex_lock(&sch->mutex);
+
+    if (!p->dnv || !p->ena) {
+        ret = -ENODEV;
+        goto out;
+    }
+
+    if (s->stctl & SCSW_STCTL_STATUS_PEND) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
+    if ((s->fctl != SCSW_FCTL_START_FUNC) ||
+        (s->actl & SCSW_ACTL_RESUME_PEND) ||
+        (!(s->actl & SCSW_ACTL_SUSP))) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    /* If monitoring is active, update counter. */
+    if (channel_subsys->chnmon_active) {
+        css_update_chnmon(sch);
+    }
+
+    s->actl |= SCSW_ACTL_RESUME_PEND;
+    do_subchannel_work(sch);
+    ret = 0;
+
+out:
+    qemu_mutex_unlock(&sch->mutex);
+    return ret;
+}
+
+int css_do_rchp(uint8_t cssid, uint8_t chpid)
+{
+    if (cssid > channel_subsys->max_cssid) {
+        return -EINVAL;
+    }
+
+    if (!channel_subsys->css[cssid]->chpids[chpid].in_use) {
+        return -ENODEV;
+    }
+
+    /* We don't really use a channel path, so we're done here. */
+    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, channel_subsys->max_cssid > 0 ? 1 : 0,
+                  chpid);
+    if (channel_subsys->max_cssid > 0) {
+        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 0, cssid << 8);
+    }
+    return 0;
+}
+
+bool css_schid_final(uint8_t cssid, uint8_t ssid, uint16_t schid)
+{
+    SubchSet *set;
+
+    if (cssid > MAX_CSSID || ssid > MAX_SSID || !channel_subsys->css[cssid] ||
+        !channel_subsys->css[cssid]->sch_set[ssid]) {
+        return true;
+    }
+    set = channel_subsys->css[cssid]->sch_set[ssid];
+    return schid > find_last_bit(set->schids_used,
+                                 (MAX_SCHID + 1) / sizeof(unsigned long));
+}
+
 static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
 {
     CssImage *css;
@@ -485,15 +1105,124 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devn
     }
 }
 
-
 bool css_present(uint8_t cssid)
 {
     return (channel_subsys->css[cssid] != NULL);
 }
 
+void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
+{
+    CrwContainer *crw_cont;
+
+    /* TODO: Maybe use a static crw pool? */
+    crw_cont = g_try_malloc0(sizeof(CrwContainer));
+    if (!crw_cont) {
+        channel_subsys->crws_lost = true;
+        return;
+    }
+    crw_cont->crw.rsc = rsc;
+    crw_cont->crw.erc = erc;
+    crw_cont->crw.c = chain;
+    crw_cont->crw.rsid = rsid;
+    crw_cont->crw.r = channel_subsys->crws_lost ? 1 : 0;
+    channel_subsys->crws_lost = false;
+
+    QTAILQ_INSERT_TAIL(&channel_subsys->pending_crws, crw_cont, sibling);
+
+    if (channel_subsys->do_crw_mchk) {
+        channel_subsys->do_crw_mchk = false;
+        /* Inject crw pending machine check. */
+        if (!kvm_enabled()) {
+            S390CPU *cpu = s390_cpu_addr2state(0);
+            cpu_inject_crw_mchk(&cpu->env);
+        }
+    }
+}
+
+void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                           int hotplugged, int add)
+{
+    uint8_t guest_cssid;
+    bool chain_crw;
+
+    if (add && !hotplugged) {
+        return;
+    }
+    if (channel_subsys->max_cssid == 0) {
+        /* Default cssid shows up as 0. */
+        guest_cssid = (cssid == channel_subsys->default_cssid) ? 0 : cssid;
+    } else {
+        /* Show real cssid to the guest. */
+        guest_cssid = cssid;
+    }
+    /*
+     * Only notify for higher subchannel sets/channel subsystems if the
+     * guest has enabled it.
+     */
+    if ((ssid > channel_subsys->max_ssid) ||
+        (guest_cssid > channel_subsys->max_cssid) ||
+        ((channel_subsys->max_cssid == 0) &&
+         (cssid != channel_subsys->default_cssid))) {
+        return;
+    }
+    chain_crw = (channel_subsys->max_ssid > 0) || (channel_subsys->max_cssid > 0);
+    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, chain_crw ? 1 : 0, schid);
+    if (chain_crw) {
+        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0,
+                      (guest_cssid << 8) | (ssid << 4));
+    }
+}
+
+void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
+{
+    /* TODO */
+}
+
+void css_inject_io(uint8_t cssid, uint8_t ssid, uint16_t schid, uint8_t isc,
+                   uint32_t intparm, int unsolicited)
+{
+    S390CPU *cpu = s390_cpu_addr2state(0);
+
+    if (unsolicited) {
+        SubchDev *sch = css_find_subch(1, cssid, ssid, schid);
+        /*
+         * If the subchannel is not currently status pending, make it pending
+         * with alert status.
+         */
+        if (sch && !(sch->curr_status.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
+            sch->curr_status.scsw.stctl =
+                SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            /* Inject an I/O interrupt. */
+            cpu_inject_io(&cpu->env,
+                          (channel_subsys->max_cssid > 0) ? sch->cssid : 0,
+                          sch->ssid, sch->schid, sch->curr_status.pmcw.isc,
+                          sch->curr_status.pmcw.intparm);
+        }
+    } else {
+        cpu_inject_io(&cpu->env, (channel_subsys->max_cssid > 0) ? cssid : 0, ssid,
+                      schid, isc, intparm);
+    }
+}
+
+int css_enable_mcsse(void)
+{
+    channel_subsys->max_cssid = MAX_CSSID;
+    return 0;
+}
+
+int css_enable_mss(void)
+{
+    channel_subsys->max_ssid = MAX_SSID;
+    return 0;
+}
+
 static void css_init(void)
 {
     channel_subsys = g_malloc0(sizeof(*channel_subsys));
+    QTAILQ_INIT(&channel_subsys->pending_crws);
+    channel_subsys->do_crw_mchk = true;
+    channel_subsys->crws_lost = false;
+    channel_subsys->chnmon_active = false;
 }
 machine_init(css_init);
 
@@ -531,5 +1260,21 @@ void css_reset_sch(SubchDev *sch)
 
 void css_reset(void)
 {
-    /* Nothing for now. */
+    CrwContainer *crw_cont;
+
+    /* Clean up monitoring. */
+    channel_subsys->chnmon_active = false;
+    channel_subsys->chnmon_area = 0;
+
+    /* Clear pending CRWs. */
+    while ((crw_cont = QTAILQ_FIRST(&channel_subsys->pending_crws))) {
+        QTAILQ_REMOVE(&channel_subsys->pending_crws, crw_cont, sibling);
+        g_free(crw_cont);
+    }
+    channel_subsys->do_crw_mchk = true;
+    channel_subsys->crws_lost = false;
+
+    /* Reset maximum ids. */
+    channel_subsys->max_cssid = 0;
+    channel_subsys->max_ssid = 0;
 }
diff --git a/hw/s390x/css.h b/hw/s390x/css.h
index 6876633..b71f6a2 100644
--- a/hw/s390x/css.h
+++ b/hw/s390x/css.h
@@ -34,6 +34,31 @@ typedef struct SenseId {
     uint32_t ciw[MAX_CIWS];  /* variable # of CIWs */
 } QEMU_PACKED SenseId;
 
+/* Channel measurements, from linux/drivers/s390/cio/cmf.c. */
+struct cmb {
+    uint16_t ssch_rsch_count;
+    uint16_t sample_count;
+    uint32_t device_connect_time;
+    uint32_t function_pending_time;
+    uint32_t device_disconnect_time;
+    uint32_t control_unit_queuing_time;
+    uint32_t device_active_only_time;
+    uint32_t reserved[2];
+};
+
+struct cmbe {
+    uint32_t ssch_rsch_count;
+    uint32_t sample_count;
+    uint32_t device_connect_time;
+    uint32_t function_pending_time;
+    uint32_t device_disconnect_time;
+    uint32_t control_unit_queuing_time;
+    uint32_t device_active_only_time;
+    uint32_t device_busy_time;
+    uint32_t initial_command_response_time;
+    uint32_t reserved[7];
+};
+
 struct SubchDev {
     /* channel-subsystem related things: */
     uint8_t cssid;
@@ -59,5 +84,6 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devn
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
+void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
 
 #endif
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index c072e1d..6830952 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -47,6 +47,11 @@
 #define MMU_USER_IDX 1
 
 #define MAX_EXT_QUEUE 16
+#define MAX_IO_QUEUE 16
+#define MAX_MCHK_QUEUE 16
+
+#define PSW_MCHK_MASK 0x0004000000000000
+#define PSW_IO_MASK 0x0200000000000000
 
 typedef struct PSW {
     uint64_t mask;
@@ -59,6 +64,17 @@ typedef struct ExtQueue {
     uint32_t param64;
 } ExtQueue;
 
+typedef struct IOQueue {
+    uint16_t id;
+    uint16_t nr;
+    uint32_t parm;
+    uint32_t word;
+} IOQueue;
+
+typedef struct MchkQueue {
+    uint16_t type;
+} MchkQueue;
+
 typedef struct CPUS390XState {
     uint64_t regs[16];	/* GP registers */
 
@@ -88,8 +104,12 @@ typedef struct CPUS390XState {
 
     int pending_int;
     ExtQueue ext_queue[MAX_EXT_QUEUE];
+    IOQueue io_queue[MAX_IO_QUEUE][8];
+    MchkQueue mchk_queue[MAX_MCHK_QUEUE];
 
     int ext_index;
+    int io_index[8];
+    int mchk_index;
 
     CPU_COMMON
 
@@ -103,6 +123,8 @@ typedef struct CPUS390XState {
     QEMUTimer *tod_timer;
 
     QEMUTimer *cpu_timer;
+
+    void *chsc_page;
 } CPUS390XState;
 
 #include "cpu-qom.h"
@@ -278,6 +300,7 @@ void s390x_translate_init(void);
 int cpu_s390x_exec(CPUS390XState *s);
 void cpu_s390x_close(CPUS390XState *s);
 void do_interrupt (CPUS390XState *env);
+void program_interrupt(CPUS390XState *env, uint32_t code, int ilc);
 
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
@@ -346,6 +369,23 @@ typedef struct ORB ORB;
 #ifndef CONFIG_USER_ONLY
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid, uint16_t schid);
 void css_conditional_io_interrupt(SubchDev *sch);
+int css_do_stsch(SubchDev *sch, uint32_t addr);
+bool css_schid_final(uint8_t cssid, uint8_t ssid, uint16_t schid);
+int css_do_msch(SubchDev *sch, SCHIB *schib);
+int css_do_xsch(SubchDev *sch);
+int css_do_csch(SubchDev *sch);
+int css_do_hsch(SubchDev *sch);
+int css_do_ssch(SubchDev *sch, ORB *orb);
+int css_do_tsch(SubchDev *sch, uint32_t addr);
+int css_do_stcrw(uint32_t addr);
+int css_do_tpi(uint32_t addr, int lowcore);
+int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid, uint8_t l_chpid,
+                         int rfmt, void *buf);
+void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo);
+int css_enable_mcsse(void);
+int css_enable_mss(void);
+int css_do_rsch(SubchDev *sch);
+int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
 #else
 static inline SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
@@ -356,6 +396,70 @@ static inline SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
 static inline void css_conditional_io_interrupt(SubchDev *sch)
 {
 }
+static inline int css_do_stsch(SubchDev *sch, uint32_t addr)
+{
+    return -ENODEV;
+}
+static inline bool css_schid_final(uint8_t cssid, uint8_t ssid, uint16_t schid)
+{
+    return true;
+}
+static inline int css_do_msch(SubchDev *sch, SCHIB *schib)
+{
+    return -ENODEV;
+}
+static inline int css_do_xsch(SubchDev *sch)
+{
+    return -ENODEV;
+}
+static inline int css_do_csch(SubchDev *sch)
+{
+    return -ENODEV;
+}
+static inline int css_do_hsch(SubchDev *sch)
+{
+    return -ENODEV;
+}
+static inline int css_do_ssch(SubchDev *sch, ORB *orb)
+{
+    return -ENODEV;
+}
+static inline int css_do_tsch(SubchDev *sch, uint32_t addr)
+{
+    return -ENODEV;
+}
+static inline int css_do_stcrw(uint32_t addr)
+{
+    return 1;
+}
+static inline int css_do_tpi(uint32_t addr, int lowcore)
+{
+    return 0;
+}
+static inline int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid,
+                                       int rfmt, uint8_t l_chpid, void *buf)
+{
+    return 0;
+}
+static inline void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
+{
+}
+static inline int css_enable_mss(void)
+{
+    return -EINVAL;
+}
+static inline int css_do_rsch(SubchDev *sch)
+{
+    return -ENODEV;
+}
+static inline int css_do_rchp(uint8_t cssid, uint8_t chpid)
+{
+    return -ENODEV;
+}
+static inline bool css_present(uint8_t cssid)
+{
+    return false;
+}
 #endif
 
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
@@ -383,12 +487,16 @@ static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 #define EXCP_EXT 1 /* external interrupt */
 #define EXCP_SVC 2 /* supervisor call (syscall) */
 #define EXCP_PGM 3 /* program interruption */
+#define EXCP_IO  7 /* I/O interrupt */
+#define EXCP_MCHK 8 /* machine check */
 
 #endif /* CONFIG_USER_ONLY */
 
 #define INTERRUPT_EXT        (1 << 0)
 #define INTERRUPT_TOD        (1 << 1)
 #define INTERRUPT_CPUTIMER   (1 << 2)
+#define INTERRUPT_IO         (1 << 3)
+#define INTERRUPT_MCHK       (1 << 4)
 
 /* Program Status Word.  */
 #define S390_PSWM_REGNUM 0
@@ -1007,6 +1115,44 @@ static inline void cpu_inject_ext(CPUS390XState *env, uint32_t code, uint32_t pa
     cpu_interrupt(env, CPU_INTERRUPT_HARD);
 }
 
+static inline void cpu_inject_io(CPUS390XState *env, uint8_t cssid,
+                                 uint8_t ssid, uint16_t schid, uint8_t isc,
+                                 uint32_t intparm)
+{
+    if (env->io_index[isc] == MAX_IO_QUEUE - 1) {
+        /* ugh - can't queue anymore. Let's drop. */
+        return;
+    }
+
+    env->io_index[isc]++;
+    assert(env->io_index[isc] < MAX_IO_QUEUE);
+
+    env->io_queue[env->io_index[isc]][isc].id = (cssid != 0) ?
+        (cssid << 8) | (1 << 3) | (ssid << 2) | 1 : (ssid << 2) | 1;
+    env->io_queue[env->io_index[isc]][isc].nr = schid;
+    env->io_queue[env->io_index[isc]][isc].parm = intparm;
+    env->io_queue[env->io_index[isc]][isc].word = (0x80 >> isc) << 24;
+
+    env->pending_int |= INTERRUPT_IO;
+    cpu_interrupt(env, CPU_INTERRUPT_HARD);
+}
+
+static inline void cpu_inject_crw_mchk(CPUS390XState *env)
+{
+    if (env->mchk_index == MAX_MCHK_QUEUE - 1) {
+        /* ugh - can't queue anymore. Let's drop. */
+        return;
+    }
+
+    env->mchk_index++;
+    assert(env->mchk_index < MAX_MCHK_QUEUE);
+
+    env->mchk_queue[env->mchk_index].type = 1;
+
+    env->pending_int |= INTERRUPT_MCHK;
+    cpu_interrupt(env, CPU_INTERRUPT_HARD);
+}
+
 static inline bool cpu_has_work(CPUS390XState *env)
 {
     return (env->interrupt_request & CPU_INTERRUPT_HARD) &&
@@ -1020,6 +1166,11 @@ static inline void cpu_pc_from_tb(CPUS390XState *env, TranslationBlock* tb)
 
 int css_handle_sch_io(uint32_t sch_id, uint8_t func, uint64_t orb, void *scsw,
                       void *pmcw);
+void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
+                           int hotplugged, int add);
+void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
+void css_inject_io(uint8_t cssid, uint8_t ssid, uint16_t schid, uint8_t isc,
+                   uint32_t intparm, int unsolicited);
 #ifdef CONFIG_KVM
 int kvm_s390_sch_hotplug(uint8_t cssid, uint8_t ssid, uint16_t schid,
                          uint16_t devno, void *data, int hotplugged, int add,
@@ -1068,7 +1219,7 @@ static inline void s390_sch_hotplug(uint8_t cssid, uint8_t ssid, uint16_t schid,
     ret = kvm_s390_sch_hotplug(cssid, ssid, schid, devno, data, hotplugged,
                                add, virtual);
     if (ret == -EOPNOTSUPP) {
-        fprintf(stderr, "Hotplugging subchannels not supported\n");
+        css_generate_sch_crws(cssid, ssid, schid, hotplugged, add);
     }
 }
 
@@ -1079,7 +1230,7 @@ static inline void s390_chp_hotplug(uint8_t cssid, uint8_t chpid, uint8_t type,
 
     ret = kvm_s390_chp_hotplug(cssid, chpid, type, add, virtual);
     if (ret == -EOPNOTSUPP) {
-        fprintf(stderr, "Hotplugging chpids not supported\n");
+        css_generate_chp_crws(cssid, chpid);
     }
 }
 
@@ -1093,7 +1244,7 @@ static inline void s390_io_interrupt(uint8_t cssid, uint8_t ssid,
     ret = kvm_s390_io_interrupt(cssid, ssid, schid, scsw, pmcw, sense,
                                 unsolicited, func);
     if (ret == -EOPNOTSUPP) {
-        fprintf(stderr, "Injecting I/O interrupts not supported\n");
+        css_inject_io(cssid, ssid, schid, isc, intparm, unsolicited);
     }
 }
 
diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index d0a1180..d759adf 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -571,12 +571,139 @@ static void do_ext_interrupt(CPUS390XState *env)
     load_psw(env, mask, addr);
 }
 
+static void do_io_interrupt(CPUS390XState *env)
+{
+    uint64_t mask, addr;
+    LowCore *lowcore;
+    target_phys_addr_t len = TARGET_PAGE_SIZE;
+    IOQueue *q;
+    uint8_t isc;
+    int disable = 1;
+    int found = 0;
+
+    if (!(env->psw.mask & PSW_MASK_IO)) {
+        cpu_abort(env, "I/O int w/o I/O mask\n");
+    }
+
+
+    for (isc = 0; isc < 8; isc++) {
+        if (env->io_index[isc] < 0) {
+            continue;
+        }
+        if (env->io_index[isc] > MAX_IO_QUEUE) {
+            cpu_abort(env, "I/O queue overrun for isc %d: %d\n",
+                      isc, env->io_index[isc]);
+        }
+
+        q = &env->io_queue[env->io_index[isc]][isc];
+        if (!(env->cregs[6] & q->word)) {
+            disable = 0;
+            continue;
+        }
+        found = 1;
+        lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+
+        lowcore->subchannel_id = cpu_to_be16(q->id);
+        lowcore->subchannel_nr = cpu_to_be16(q->nr);
+        lowcore->io_int_parm = cpu_to_be32(q->parm);
+        lowcore->io_int_word = cpu_to_be32(q->word);
+        lowcore->io_old_psw.mask = cpu_to_be64(get_psw_mask(env));
+        lowcore->io_old_psw.addr = cpu_to_be64(env->psw.addr);
+        mask = be64_to_cpu(lowcore->io_new_psw.mask);
+        addr = be64_to_cpu(lowcore->io_new_psw.addr);
+
+        cpu_physical_memory_unmap(lowcore, len, 1, len);
+
+        env->io_index[isc]--;
+        if (env->io_index >= 0) {
+            disable = 0;
+        }
+        break;
+    }
+
+    if (disable) {
+        env->pending_int &= ~INTERRUPT_IO;
+    }
+    if (found) {
+        DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
+                env->psw.mask, env->psw.addr);
+
+        load_psw(env, mask, addr);
+    }
+}
+
+static void do_mchk_interrupt(CPUS390XState *env)
+{
+    uint64_t mask, addr;
+    LowCore *lowcore;
+    target_phys_addr_t len = TARGET_PAGE_SIZE;
+    MchkQueue *q;
+    int i;
+
+    if (!(env->psw.mask & PSW_MASK_MCHECK)) {
+        cpu_abort(env, "Machine check w/o mchk mask\n");
+    }
+
+    if (env->mchk_index < 0 || env->mchk_index > MAX_MCHK_QUEUE) {
+        cpu_abort(env, "Mchk queue overrun: %d\n", env->mchk_index);
+    }
+
+    q = &env->mchk_queue[env->mchk_index];
+
+    if (q->type != 1) {
+        /* Don't know how to handle this... */
+        cpu_abort(env, "Unknown machine check type %d\n", q->type);
+    }
+    if (!(env->cregs[14] & (1 << 28))) {
+        /* CRW machine checks disabled */
+        return;
+    }
+
+    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
+
+    for (i = 0; i < 16; i++) {
+        lowcore->floating_pt_save_area[i] = cpu_to_be64(env->fregs[i].ll);
+        lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
+        lowcore->access_regs_save_area[i] = cpu_to_be32(env->aregs[i]);
+        lowcore->cregs_save_area[i] = cpu_to_be64(env->cregs[i]);
+    }
+    lowcore->prefixreg_save_area = cpu_to_be32(env->psa);
+    lowcore->fpt_creg_save_area = cpu_to_be32(env->fpc);
+    /* TODO: some clock/timer related stuff missing here */
+
+    lowcore->mcck_interruption_code[0] = cpu_to_be32(0x00400f1d);
+    lowcore->mcck_interruption_code[1] = cpu_to_be32(0x40330000);
+    lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
+    lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
+    mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
+    addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
+
+    cpu_physical_memory_unmap(lowcore, len, 1, len);
+
+    env->mchk_index--;
+    if (env->mchk_index == -1) {
+        env->pending_int &= ~INTERRUPT_MCHK;
+    }
+
+    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
+            env->psw.mask, env->psw.addr);
+
+    load_psw(env, mask, addr);
+}
+
 void do_interrupt (CPUS390XState *env)
 {
     qemu_log("%s: %d at pc=%" PRIx64 "\n", __FUNCTION__, env->exception_index,
              env->psw.addr);
 
     s390_add_running_cpu(env);
+    /* handle machine checks */
+    if ((env->psw.mask & PSW_MASK_MCHECK) &&
+        (env->exception_index == -1)) {
+        if (env->pending_int & INTERRUPT_MCHK) {
+            env->exception_index = EXCP_MCHK;
+        }
+    }
     /* handle external interrupts */
     if ((env->psw.mask & PSW_MASK_EXT) &&
         env->exception_index == -1) {
@@ -595,6 +722,13 @@ void do_interrupt (CPUS390XState *env)
             env->pending_int &= ~INTERRUPT_TOD;
         }
     }
+    /* handle I/O interrupts */
+    if ((env->psw.mask & PSW_MASK_IO) &&
+        (env->exception_index == -1)) {
+        if (env->pending_int & INTERRUPT_IO) {
+            env->exception_index = EXCP_IO;
+        }
+    }
 
     switch (env->exception_index) {
     case EXCP_PGM:
@@ -606,6 +740,12 @@ void do_interrupt (CPUS390XState *env)
     case EXCP_EXT:
         do_ext_interrupt(env);
         break;
+    case EXCP_IO:
+        do_io_interrupt(env);
+        break;
+    case EXCP_MCHK:
+        do_mchk_interrupt(env);
+        break;
     }
     env->exception_index = -1;
 
diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
index 8f358d5..443eda1 100644
--- a/target-s390x/ioinst.c
+++ b/target-s390x/ioinst.c
@@ -16,6 +16,26 @@
 #include "cpu.h"
 #include "ioinst.h"
 
+#ifdef DEBUG_IOINST
+#define dprintf(fmt, ...) \
+    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
+#else
+#define dprintf(fmt, ...) \
+    do { } while (0)
+#endif
+
+/* Special handling for the prefix page. */
+static void *s390_get_address(CPUS390XState *env, ram_addr_t guest_addr)
+{
+    if (guest_addr < 8192) {
+        guest_addr += env->psa;
+    } else if ((env->psa <= guest_addr) && (guest_addr < env->psa + 8192)) {
+        guest_addr -= env->psa;
+    }
+
+    return qemu_get_ram_ptr(guest_addr);
+}
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
 {
@@ -36,3 +56,679 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
     *schid = value & 0x0000ffff;
     return 0;
 }
+
+int ioinst_handle_xsch(CPUS390XState *env, uint64_t reg1)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: xsch (%x.%x.%04x)\n", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_xsch(sch);
+    }
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EBUSY:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        cc = 1;
+        break;
+    }
+
+    return cc;
+}
+
+int ioinst_handle_csch(CPUS390XState *env, uint64_t reg1)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: csch (%x.%x.%04x)\n", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_csch(sch);
+    }
+    if (ret == -ENODEV) {
+        cc = 3;
+    } else {
+        cc = 0;
+    }
+    return cc;
+}
+
+int ioinst_handle_hsch(CPUS390XState *env, uint64_t reg1)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: hsch (%x.%x.%04x)\n", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_hsch(sch);
+    }
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EBUSY:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        cc = 1;
+        break;
+    }
+
+    return cc;
+}
+
+static int ioinst_schib_valid(SCHIB *schib)
+{
+    if ((schib->pmcw.zeroes0 & 0x3) != 0) {
+        return 0;
+    }
+    if ((schib->pmcw.zeroes1 != 0) || (schib->pmcw.zeroes2 != 0)) {
+        return 0;
+    }
+    /* Disallow extended measurements for now. */
+    if (schib->pmcw.xmwme) {
+        return 0;
+    }
+    return 1;
+}
+
+int ioinst_handle_msch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    SCHIB *schib;
+    uint32_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: msch (%x.%x.%04x)\n", cssid, ssid, schid);
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    schib = s390_get_address(env, addr);
+    if (!schib) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (!ioinst_schib_valid(schib)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_msch(sch, schib);
+    }
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EBUSY:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        cc = 1;
+        break;
+    }
+
+    return cc;
+}
+
+static int ioinst_orb_valid(ORB *orb)
+{
+    if (orb->zero0 != 0) {
+        return 0;
+    }
+    if (orb->zero1 != 0) {
+        return 0;
+    }
+    if ((orb->cpa & 0x80000000) != 0) {
+        return 0;
+    }
+    return 1;
+}
+
+int ioinst_handle_ssch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    ORB *orb;
+    uint32_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: ssch (%x.%x.%04x)\n", cssid, ssid, schid);
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    orb = s390_get_address(env, addr);
+    if (!orb) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (!ioinst_orb_valid(orb)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_ssch(sch, orb);
+    }
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EBUSY:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        cc = 1;
+        break;
+    }
+
+    return cc;
+}
+
+int ioinst_handle_stcrw(CPUS390XState *env, uint32_t ipb)
+{
+    CRW *crw;
+    uint32_t addr;
+    int cc;
+
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    crw = s390_get_address(env, addr);
+    if (!crw) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (addr < 8192) {
+        addr += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        addr -= env->psa;
+    }
+    cc = css_do_stcrw(addr);
+    /* 0 - crw stored, 1 - zeroes stored */
+    return cc;
+}
+
+int ioinst_handle_stsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    uint32_t addr;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: stsch (%x.%x.%04x)\n", cssid, ssid, schid);
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    if (addr < 8192) {
+        addr += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        addr -= env->psa;
+    }
+    if (!qemu_get_ram_ptr(addr)) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        css_do_stsch(sch, addr);
+        cc = 0;
+    } else {
+        if (css_schid_final(cssid, ssid, schid)) {
+            cc = 3; /* No more subchannels in this css/ss */
+        } else {
+            int i;
+
+            /* Store an empty schib. */
+            for (i = 0; i < sizeof(SCHIB); i++) {
+                stb_phys(addr + i, 0);
+            }
+            cc = 0;
+        }
+    }
+    return cc;
+}
+
+int ioinst_handle_tsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    IRB *irb;
+    uint32_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: tsch (%x.%x.%04x)\n", cssid, ssid, schid);
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    irb = s390_get_address(env, addr);
+    if (!irb) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        if (addr < 8192) {
+            addr += env->psa;
+        } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+            addr -= env->psa;
+        }
+        ret = css_do_tsch(sch, addr);
+        /* 0 - status pending, 1 - not status pending */
+        cc = ret;
+    } else {
+        cc = 3;
+    }
+    return cc;
+}
+
+typedef struct ChscReq {
+    uint16_t len;
+    uint16_t command;
+    uint32_t param0;
+    uint32_t param1;
+    uint32_t param2;
+} QEMU_PACKED ChscReq;
+
+typedef struct ChscResp {
+    uint16_t len;
+    uint16_t code;
+    uint32_t param;
+    char data[0];
+} QEMU_PACKED ChscResp;
+
+#define CHSC_SCPD 0x0002
+#define CHSC_SCSC 0x0010
+#define CHSC_SDA  0x0031
+
+static void ioinst_handle_chsc_scpd(ChscReq *req, ChscResp *res)
+{
+    uint16_t resp_code;
+    int rfmt;
+    uint16_t cssid;
+    uint8_t f_chpid, l_chpid;
+    int desc_size;
+    int m;
+
+    rfmt = (req->param0 & 0x00000f00) >> 8;
+    if ((rfmt == 0) ||  (rfmt == 1)) {
+        rfmt = (req->param0 & 0x10000000) >> 28;
+    }
+    if ((req->len != 0x0010) || (req->param0 & 0xc000f000) ||
+        (req->param1 & 0xffffff00) || req->param2) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+    if (req->param0 & 0x0f000000) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+    cssid = (req->param0 & 0x00ff0000) >> 16;
+    m = req->param0 & 0x20000000;
+    if (cssid != 0) {
+        if (!m || !css_present(cssid)) {
+            resp_code = 0x0008;
+            goto out_err;
+        }
+    }
+    f_chpid = req->param0 & 0x000000ff;
+    l_chpid = req->param1 & 0x000000ff;
+    if (l_chpid < f_chpid) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+    desc_size = css_collect_chp_desc(m, cssid, f_chpid, l_chpid, rfmt, &res->data);
+    res->code = 0x0001;
+    res->len = 8 + desc_size;
+    res->param = rfmt;
+    return;
+
+  out_err:
+    res->code = resp_code;
+    res->len = 8;
+    res->param = rfmt;
+}
+
+static void ioinst_handle_chsc_scsc(ChscReq *req, ChscResp *res)
+{
+    uint8_t cssid;
+    uint16_t resp_code;
+    uint32_t general_chars[510];
+    uint32_t chsc_chars[508];
+
+    if (req->param0 & 0x000f0000) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+    cssid = (req->param0 & 0x0000ff00) >> 8;
+    if (cssid != 0) {
+        if (!(req->param0 & 0x20000000) || !css_present(cssid)) {
+            resp_code = 0x0008;
+            goto out_err;
+        }
+    }
+    if ((req->param0 & 0xdff000ff) || req->param1 || req->param2) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+    res->code = 0x0001;
+    res->len = 4080;
+    res->param = 0;
+
+    memset(general_chars, 0, sizeof(general_chars));
+    memset(chsc_chars, 0, sizeof(chsc_chars));
+
+    general_chars[0] = 0x03000000;
+    general_chars[1] = 0x00059000;
+
+    chsc_chars[0] = 0x40000000;
+    chsc_chars[3] = 0x00040000;
+
+    memcpy(res->data, general_chars, sizeof(general_chars));
+    memcpy(res->data + sizeof(general_chars), chsc_chars, sizeof(chsc_chars));
+    return;
+
+  out_err:
+    res->code = resp_code;
+    res->len = 8;
+    res->param = 0;
+}
+
+#define CHSC_SDA_OC_MCSSE 0x0
+#define CHSC_SDA_OC_MSS 0x2
+static void ioinst_handle_chsc_sda(ChscReq *req, ChscResp *res)
+{
+    uint16_t resp_code = 0x0001;
+    uint16_t oc;
+    int ret;
+
+    if ((req->len != 0x0400) || (req->param0 & 0xf0ff0000)) {
+        resp_code = 0x0003;
+        goto out;
+    }
+
+    if (req->param0 & 0x0f000000) {
+        resp_code = 0x0007;
+        goto out;
+    }
+
+    oc = req->param0 & 0x0000ffff;
+    switch (oc) {
+    case CHSC_SDA_OC_MCSSE:
+        ret = css_enable_mcsse();
+        if (ret == -EINVAL) {
+            resp_code = 0x0101;
+            goto out;
+        }
+        break;
+    case CHSC_SDA_OC_MSS:
+        ret = css_enable_mss();
+        if (ret == -EINVAL) {
+            resp_code = 0x0101;
+            goto out;
+        }
+        break;
+    default:
+        resp_code = 0x0003;
+        goto out;
+    }
+
+out:
+    res->code = resp_code;
+    res->len = 8;
+    res->param = 0;
+}
+
+static void ioinst_handle_chsc_unimplemented(ChscResp *res)
+{
+    res->len = 8;
+    res->code = 0x0004;
+    res->param = 0;
+}
+
+int ioinst_handle_chsc(CPUS390XState *env, uint32_t ipb)
+{
+    ChscReq *req;
+    ChscResp *res;
+    uint64_t addr;
+    int reg;
+    int i;
+
+    dprintf("%s\n", "IOINST: CHSC");
+    reg = (ipb >> 20) & 0x00f;
+    addr = env->regs[reg];
+    req = s390_get_address(env, addr);
+    if (!req) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (!env->chsc_page) {
+        env->chsc_page = g_malloc0(TARGET_PAGE_SIZE);
+    } else {
+        memset(env->chsc_page, 0, TARGET_PAGE_SIZE);
+    }
+    res = env->chsc_page;
+    dprintf("IOINST: CHSC: command 0x%04x, len=0x%04x\n",
+            req->command, req->len);
+    switch (req->command) {
+    case CHSC_SCSC:
+        ioinst_handle_chsc_scsc(req, res);
+        break;
+    case CHSC_SCPD:
+        ioinst_handle_chsc_scpd(req, res);
+        break;
+    case CHSC_SDA:
+        ioinst_handle_chsc_sda(req, res);
+        break;
+    default:
+        ioinst_handle_chsc_unimplemented(res);
+        break;
+    }
+    if (addr < 8192) {
+        addr += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        addr -= env->psa;
+    }
+    for (i = 0; i < res->len; i++) {
+        stb_phys(addr + req->len + i, *(uint8_t *)(res + i));
+    }
+    return 0;
+}
+
+int ioinst_handle_tpi(CPUS390XState *env, uint32_t ipb)
+{
+    uint32_t addr;
+    int lowcore;
+
+    dprintf("%s\n", "IOINST: tpi");
+    addr = ipb >> 28;
+    if (addr > 0) {
+        addr = env->regs[addr];
+    }
+    addr += (ipb & 0xfff0000) >> 16;
+    lowcore = addr ? 0 : 1;
+    if (addr < 8192) {
+        addr += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        addr -= env->psa;
+    }
+    return css_do_tpi(addr, lowcore);
+}
+
+int ioinst_handle_schm(CPUS390XState *env, uint64_t reg1, uint64_t reg2,
+                       uint32_t ipb)
+{
+    uint8_t mbk;
+    int update;
+    int dct;
+
+    dprintf("%s\n", "IOINST: schm");
+
+    if (reg1 & 0x000000000ffffffc) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    mbk = (reg1 & 0x00000000f0000000) >> 28;
+    update = (reg1 & 0x0000000000000002) >> 1;
+    dct = reg1 & 0x0000000000000001;
+
+    if (update && (reg2 & 0x0000000000000fff)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    css_do_schm(mbk, update, dct, update ? reg2 : 0);
+
+    return 0;
+}
+
+int ioinst_handle_rsch(CPUS390XState *env, uint64_t reg1)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    dprintf("IOINST: rsch (%x.%x.%04x)\n", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        ret = css_do_rsch(sch);
+    }
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EINVAL:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        cc = 1;
+        break;
+    }
+
+    return cc;
+
+}
+
+int ioinst_handle_rchp(CPUS390XState *env, uint64_t reg1)
+{
+    int cc;
+    uint8_t cssid;
+    uint8_t chpid;
+    int ret;
+
+    if (reg1 & 0xff00ff00) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    cssid = (reg1 >> 16) & 0xff;
+    chpid = reg1 & 0xff;
+    dprintf("IOINST: rchp (%x.%02x)\n", cssid, chpid);
+
+    ret = css_do_rchp(cssid, chpid);
+
+    switch (ret) {
+    case -ENODEV:
+        cc = 3;
+        break;
+    case -EBUSY:
+        cc = 2;
+        break;
+    case 0:
+        cc = 0;
+        break;
+    default:
+        /* Invalid channel subsystem. */
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    return cc;
+}
+
+int ioinst_handle_sal(CPUS390XState *env, uint64_t reg1)
+{
+    /* We do not provide address limit checking, so let's suppress it. */
+    if (env->regs[1] & 0x000000008000ffff) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    return 0;
+}
diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
index c1377ca..4860d4c 100644
--- a/target-s390x/ioinst.h
+++ b/target-s390x/ioinst.h
@@ -11,7 +11,6 @@
 
 #ifndef IOINST_S390X_H
 #define IOINST_S390X_H
-
 /*
  * Channel I/O related definitions, as defined in the Principles
  * Of Operation (and taken from the Linux implementation).
@@ -168,6 +167,40 @@ typedef struct CCW1 {
 #define SCSW_CSTAT_INTF_CTRL_CHK 0x02
 #define SCSW_CSTAT_CHAIN_CHECK   0x01
 
+typedef struct CRW {
+    uint16_t zero0:1;
+    uint16_t s:1;
+    uint16_t r:1;
+    uint16_t c:1;
+    uint16_t rsc:4;
+    uint16_t a:1;
+    uint16_t zero1:1;
+    uint16_t erc:6;
+    uint16_t rsid;
+} CRW;
+
+#define CRW_ERC_INIT 0x02
+#define CRW_ERC_IPI  0x04
+
+#define CRW_RSC_SUBCH 0x3
+#define CRW_RSC_CHP   0x4
+
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid);
+int ioinst_handle_xsch(CPUS390XState *env, uint64_t reg1);
+int ioinst_handle_csch(CPUS390XState *env, uint64_t reg1);
+int ioinst_handle_hsch(CPUS390XState *env, uint64_t reg1);
+int ioinst_handle_msch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
+int ioinst_handle_ssch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
+int ioinst_handle_stcrw(CPUS390XState *env, uint32_t ipb);
+int ioinst_handle_stsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
+int ioinst_handle_tsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
+int ioinst_handle_chsc(CPUS390XState *env, uint32_t ipb);
+int ioinst_handle_tpi(CPUS390XState *env, uint32_t ipb);
+int ioinst_handle_schm(CPUS390XState *env, uint64_t reg1, uint64_t reg2,
+                       uint32_t ipb);
+int ioinst_handle_rsch(CPUS390XState *env, uint64_t reg1);
+int ioinst_handle_rchp(CPUS390XState *env, uint64_t reg1);
+int ioinst_handle_sal(CPUS390XState *env, uint64_t reg1);
+
 #endif
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 9aab6a8..a3bf67a 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -31,6 +31,8 @@
 #include "kvm.h"
 #include "cpu.h"
 #include "device_tree.h"
+#include "trace.h"
+#include "ioinst.h"
 
 /* #define DEBUG_KVM */
 
@@ -44,9 +46,27 @@
 
 #define IPA0_DIAG                       0x8300
 #define IPA0_SIGP                       0xae00
-#define IPA0_PRIV                       0xb200
+#define IPA0_B2                         0xb200
+#define IPA0_B9                         0xb900
+#define IPA0_EB                         0xeb00
 
 #define PRIV_SCLP_CALL                  0x20
+#define PRIV_CSCH                       0x30
+#define PRIV_HSCH                       0x31
+#define PRIV_MSCH                       0x32
+#define PRIV_SSCH                       0x33
+#define PRIV_STSCH                      0x34
+#define PRIV_TSCH                       0x35
+#define PRIV_TPI                        0x36
+#define PRIV_SAL                        0x37
+#define PRIV_RSCH                       0x38
+#define PRIV_STCRW                      0x39
+#define PRIV_STCPS                      0x3a
+#define PRIV_RCHP                       0x3b
+#define PRIV_SCHM                       0x3c
+#define PRIV_CHSC                       0x5f
+#define PRIV_SIGA                       0x74
+#define PRIV_XSCH                       0x76
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -284,10 +304,118 @@ static int kvm_sclp_service_call(CPUS390XState *env, struct kvm_run *run,
     return 0;
 }
 
-static int handle_priv(CPUS390XState *env, struct kvm_run *run, uint8_t ipa1)
+static int kvm_handle_css_inst(CPUS390XState *env, struct kvm_run *run,
+                               uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
+{
+    int r = 0;
+    int no_cc = 0;
+
+    if (ipa0 != 0xb2) {
+        /* Not handled for now. */
+        return -1;
+    }
+    cpu_synchronize_state(env);
+    switch (ipa1) {
+    case PRIV_XSCH:
+        r = ioinst_handle_xsch(env, env->regs[1]);
+        break;
+    case PRIV_CSCH:
+        r = ioinst_handle_csch(env, env->regs[1]);
+        break;
+    case PRIV_HSCH:
+        r = ioinst_handle_hsch(env, env->regs[1]);
+        break;
+    case PRIV_MSCH:
+        r = ioinst_handle_msch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_SSCH:
+        r = ioinst_handle_ssch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_STCRW:
+        r = ioinst_handle_stcrw(env, run->s390_sieic.ipb);
+        break;
+    case PRIV_STSCH:
+        r = ioinst_handle_stsch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_TSCH:
+        r = ioinst_handle_tsch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_CHSC:
+        r = ioinst_handle_chsc(env, run->s390_sieic.ipb);
+        break;
+    case PRIV_TPI:
+        r = ioinst_handle_tpi(env, run->s390_sieic.ipb);
+        break;
+    case PRIV_SCHM:
+        no_cc = 1;
+        r = ioinst_handle_schm(env, env->regs[1], env->regs[2],
+                               run->s390_sieic.ipb);
+        break;
+    case PRIV_RSCH:
+        r = ioinst_handle_rsch(env, env->regs[1]);
+        break;
+    case PRIV_RCHP:
+        r = ioinst_handle_rchp(env, env->regs[1]);
+        break;
+    case PRIV_STCPS:
+        /* We do not provide this instruction, it is suppressed. */
+        no_cc = 1;
+        r = 0;
+        break;
+    case PRIV_SAL:
+        no_cc = 1;
+        r = ioinst_handle_sal(env, env->regs[1]);
+        break;
+    default:
+        r = -1;
+        break;
+    }
+
+    if (r >= 0) {
+        if (!no_cc) {
+            setcc(env, r);
+        }
+        r = 0;
+    } else if (r < -1) {
+        r = 0;
+    }
+    return r;
+}
+
+static int is_ioinst(uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
+{
+    int ret = 0;
+
+    switch (ipa0) {
+    case 0xb2:
+        if (((ipa1 >= 0x30) && (ipa1 <= 0x3c)) ||
+            (ipa1 == 0x5f) ||
+            (ipa1 == 0x74) ||
+            (ipa1 == 0x76)) {
+            ret = 1;
+        }
+        break;
+    case 0xb9:
+        if (ipa1 == 0x9c) {
+            ret = 1;
+        }
+        break;
+    case 0xeb:
+        if (ipb == 0x8a) {
+            ret = 1;
+        }
+        break;
+    }
+
+    return ret;
+}
+
+static int handle_priv(CPUS390XState *env, struct kvm_run *run,
+                       uint8_t ipa0, uint8_t ipa1)
 {
     int r = 0;
     uint16_t ipbh0 = (run->s390_sieic.ipb & 0xffff0000) >> 16;
+    uint8_t ipb = run->s390_sieic.ipb & 0xff;
 
     dprintf("KVM: PRIV: %d\n", ipa1);
     switch (ipa1) {
@@ -295,8 +423,16 @@ static int handle_priv(CPUS390XState *env, struct kvm_run *run, uint8_t ipa1)
             r = kvm_sclp_service_call(env, run, ipbh0);
             break;
         default:
-            dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
-            r = -1;
+            if (is_ioinst(ipa0, ipa1, ipb)) {
+                r = kvm_handle_css_inst(env, run, ipa0, ipa1, ipb);
+                if (r == -1) {
+                    setcc(env, 3);
+                    r = 0;
+                }
+            } else {
+                dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
+                r = -1;
+            }
             break;
     }
 
@@ -434,15 +570,17 @@ static int handle_instruction(CPUS390XState *env, struct kvm_run *run)
 
     dprintf("handle_instruction 0x%x 0x%x\n", run->s390_sieic.ipa, run->s390_sieic.ipb);
     switch (ipa0) {
-        case IPA0_PRIV:
-            r = handle_priv(env, run, ipa1);
-            break;
-        case IPA0_DIAG:
-            r = handle_diag(env, run, ipb_code);
-            break;
-        case IPA0_SIGP:
-            r = handle_sigp(env, run, ipa1);
-            break;
+    case IPA0_B2:
+    case IPA0_B9:
+    case IPA0_EB:
+        r = handle_priv(env, run, ipa0 >> 8, ipa1);
+        break;
+    case IPA0_DIAG:
+        r = handle_diag(env, run, ipb_code);
+        break;
+    case IPA0_SIGP:
+        r = handle_sigp(env, run, ipa1);
+        break;
     }
 
     if (r < 0) {
diff --git a/target-s390x/op_helper.c b/target-s390x/op_helper.c
index abc35dd..f7d41cd 100644
--- a/target-s390x/op_helper.c
+++ b/target-s390x/op_helper.c
@@ -2338,18 +2338,11 @@ void HELPER(tr)(uint32_t len, uint64_t array, uint64_t trans)
     }
 }
 
-#ifndef CONFIG_USER_ONLY
-
-void HELPER(load_psw)(uint64_t mask, uint64_t addr)
-{
-    load_psw(env, mask, addr);
-    cpu_loop_exit(env);
-}
-
-static void program_interrupt(CPUS390XState *env, uint32_t code, int ilc)
+void program_interrupt(CPUS390XState *env, uint32_t code, int ilc)
 {
     qemu_log("program interrupt at %#" PRIx64 "\n", env->psw.addr);
 
+#ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
 #ifdef CONFIG_KVM
         kvm_s390_interrupt(env, KVM_S390_PROGRAM_INT, code);
@@ -2360,6 +2353,17 @@ static void program_interrupt(CPUS390XState *env, uint32_t code, int ilc)
         env->exception_index = EXCP_PGM;
         cpu_loop_exit(env);
     }
+#else
+    cpu_abort(env, "Program check %x\n", code);
+#endif
+}
+
+#ifndef CONFIG_USER_ONLY
+
+void HELPER(load_psw)(uint64_t mask, uint64_t addr)
+{
+    load_psw(env, mask, addr);
+    cpu_loop_exit(env);
 }
 
 /*
-- 
1.7.11.5
