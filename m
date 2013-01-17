From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 07/12] s390: Add channel I/O instructions.
Date: Thu, 17 Jan 2013 15:23:52 +0100
Message-ID: <1358432637-42512-8-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Provide handlers for (most) channel I/O instructions.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu.h    | 101 ++++++++
 target-s390x/ioinst.c | 673 ++++++++++++++++++++++++++++++++++++++++++++++++++
 target-s390x/ioinst.h |  16 ++
 trace-events          |   6 +
 4 files changed, 796 insertions(+)

diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index 97f70f3..cf5334e 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -130,6 +130,8 @@ typedef struct CPUS390XState {
     QEMUTimer *tod_timer;
 
     QEMUTimer *cpu_timer;
+
+    uint8_t chsc_page[TARGET_PAGE_SIZE];
 } CPUS390XState;
 
 #include "cpu-qom.h"
@@ -144,6 +146,9 @@ static inline void cpu_clone_regs(CPUS390XState *env, target_ulong newsp)
 }
 #endif
 
+/* distinguish between 24 bit and 31 bit addressing */
+#define HIGH_ORDER_BIT 0x80000000
+
 /* Interrupt Codes */
 /* Program Interrupts */
 #define PGM_OPERATION                   0x0001
@@ -327,6 +332,20 @@ void *s390_cpu_physical_memory_map(CPUS390XState *env, hwaddr addr, hwaddr len,
                                    int is_write);
 void s390_cpu_physical_memory_unmap(CPUS390XState *env, void *addr, hwaddr len,
                                     int is_write);
+static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb)
+{
+    hwaddr addr = 0;
+    uint8_t reg;
+
+    reg = ipb >> 28;
+    if (reg > 0) {
+        addr = env->regs[reg];
+    }
+    addr += (ipb >> 16) & 0xfff;
+
+    return addr;
+}
+
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
 
@@ -376,11 +395,93 @@ static inline unsigned s390_del_running_cpu(CPUS390XState *env)
 void cpu_lock(void);
 void cpu_unlock(void);
 
+typedef struct SubchDev SubchDev;
 typedef struct SCHIB SCHIB;
 typedef struct ORB ORB;
 typedef struct IRB IRB;
 typedef struct CRW CRW;
 
+static inline SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
+                                       uint16_t schid)
+{
+    return NULL;
+}
+static inline bool css_subch_visible(SubchDev *sch)
+{
+    return false;
+}
+static inline void css_conditional_io_interrupt(SubchDev *sch)
+{
+}
+static inline int css_do_stsch(SubchDev *sch, SCHIB *schib)
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
+static inline int css_do_tsch(SubchDev *sch, IRB *irb)
+{
+    return -ENODEV;
+}
+static inline int css_do_stcrw(CRW *crw)
+{
+    return 1;
+}
+static inline int css_do_tpi(uint64_t addr, int lowcore)
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
+static inline int css_enable_mcsse(void)
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
+
 static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
 {
     env->aregs[0] = newtls >> 32;
diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
index 06a16ee..0cb9569 100644
--- a/target-s390x/ioinst.c
+++ b/target-s390x/ioinst.c
@@ -13,6 +13,7 @@
 
 #include "cpu.h"
 #include "ioinst.h"
+#include "trace.h"
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
                                  int *schid)
@@ -34,3 +35,675 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
     *schid = IOINST_SCHID_NR(value);
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
+    trace_ioinst_sch_id("xsch", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+    trace_ioinst_sch_id("csch", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+    trace_ioinst_sch_id("hsch", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+    if ((schib->pmcw.flags & PMCW_FLAGS_MASK_INVALID) ||
+        (schib->pmcw.chars & PMCW_CHARS_MASK_INVALID)) {
+        return 0;
+    }
+    /* Disallow extended measurements for now. */
+    if (schib->pmcw.chars & PMCW_CHARS_MASK_XMWME) {
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
+    uint64_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    trace_ioinst_sch_id("msch", cssid, ssid, schid);
+    addr = decode_basedisp_s(env, ipb);
+    schib = s390_cpu_physical_memory_map(env, addr, sizeof(*schib), 0);
+    if (!schib) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (!ioinst_schib_valid(schib)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        cc = -EIO;
+        goto out;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+out:
+    s390_cpu_physical_memory_unmap(env, schib, sizeof(*schib), 0);
+    return cc;
+}
+
+static int ioinst_orb_valid(ORB *orb)
+{
+    if ((orb->ctrl0 & ORB_CTRL0_MASK_INVALID) ||
+        (orb->ctrl1 & ORB_CTRL1_MASK_INVALID)) {
+        return 0;
+    }
+    if ((orb->cpa & HIGH_ORDER_BIT) != 0) {
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
+    uint64_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    trace_ioinst_sch_id("ssch", cssid, ssid, schid);
+    addr = decode_basedisp_s(env, ipb);
+    orb = s390_cpu_physical_memory_map(env, addr, sizeof(*orb), 0);
+    if (!orb) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    if (!ioinst_orb_valid(orb)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        cc = -EIO;
+        goto out;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+out:
+    s390_cpu_physical_memory_unmap(env, orb, sizeof(*orb), 0);
+    return cc;
+}
+
+int ioinst_handle_stcrw(CPUS390XState *env, uint32_t ipb)
+{
+    CRW *crw;
+    uint64_t addr;
+    int cc;
+
+    addr = decode_basedisp_s(env, ipb);
+    crw = s390_cpu_physical_memory_map(env, addr, sizeof(*crw), 1);
+    if (!crw) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    cc = css_do_stcrw(crw);
+    /* 0 - crw stored, 1 - zeroes stored */
+    s390_cpu_physical_memory_unmap(env, crw, sizeof(*crw), 1);
+    return cc;
+}
+
+int ioinst_handle_stsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    uint64_t addr;
+    int cc;
+    SCHIB *schib;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    trace_ioinst_sch_id("stsch", cssid, ssid, schid);
+    addr = decode_basedisp_s(env, ipb);
+    schib = s390_cpu_physical_memory_map(env, addr, sizeof(*schib), 1);
+    if (!schib) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch) {
+        if (css_subch_visible(sch)) {
+            css_do_stsch(sch, schib);
+            cc = 0;
+        } else {
+            /* Indicate no more subchannels in this css/ss */
+            cc = 3;
+        }
+    } else {
+        if (css_schid_final(cssid, ssid, schid)) {
+            cc = 3; /* No more subchannels in this css/ss */
+        } else {
+            /* Store an empty schib. */
+            memset(schib, 0, sizeof(*schib));
+            cc = 0;
+        }
+    }
+    s390_cpu_physical_memory_unmap(env, schib, sizeof(*schib), 1);
+    return cc;
+}
+
+int ioinst_handle_tsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
+{
+    int cssid, ssid, schid, m;
+    SubchDev *sch;
+    IRB *irb;
+    uint64_t addr;
+    int ret = -ENODEV;
+    int cc;
+
+    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    trace_ioinst_sch_id("tsch", cssid, ssid, schid);
+    addr = decode_basedisp_s(env, ipb);
+    irb = s390_cpu_physical_memory_map(env, addr, sizeof(*irb), 1);
+    if (!irb) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
+        ret = css_do_tsch(sch, irb);
+        /* 0 - status pending, 1 - not status pending */
+        cc = ret;
+    } else {
+        cc = 3;
+    }
+    s390_cpu_physical_memory_unmap(env, irb, sizeof(*irb), 1);
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
+#define CHSC_SCPD_0_M 0x20000000
+#define CHSC_SCPD_0_C 0x10000000
+#define CHSC_SCPD_0_FMT 0x0f000000
+#define CHSC_SCPD_0_CSSID 0x00ff0000
+#define CHSC_SCPD_0_RFMT 0x00000f00
+#define CHSC_SCPD_0_RES 0xc000f000
+#define CHSC_SCPD_1_RES 0xffffff00
+#define CHSC_SCPD_01_CHPID 0x000000ff
+static void ioinst_handle_chsc_scpd(ChscReq *req, ChscResp *res)
+{
+    uint16_t resp_code;
+    int rfmt;
+    uint16_t cssid;
+    uint8_t f_chpid, l_chpid;
+    int desc_size;
+    int m;
+
+    rfmt = (req->param0 & CHSC_SCPD_0_RFMT) >> 8;
+    if ((rfmt == 0) ||  (rfmt == 1)) {
+        rfmt = !!(req->param0 & CHSC_SCPD_0_C);
+    }
+    if ((req->len != 0x0010) || (req->param0 & CHSC_SCPD_0_RES) ||
+        (req->param1 & CHSC_SCPD_1_RES) || req->param2) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+    if (req->param0 & CHSC_SCPD_0_FMT) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+    cssid = (req->param0 & CHSC_SCPD_0_CSSID) >> 16;
+    m = req->param0 & CHSC_SCPD_0_M;
+    if (cssid != 0) {
+        if (!m || !css_present(cssid)) {
+            resp_code = 0x0008;
+            goto out_err;
+        }
+    }
+    f_chpid = req->param0 & CHSC_SCPD_01_CHPID;
+    l_chpid = req->param1 & CHSC_SCPD_01_CHPID;
+    if (l_chpid < f_chpid) {
+        resp_code = 0x0003;
+        goto out_err;
+    }
+    desc_size = css_collect_chp_desc(m, cssid, f_chpid, l_chpid, rfmt,
+                                     &res->data);
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
+#define CHSC_SCSC_0_M 0x20000000
+#define CHSC_SCSC_0_FMT 0x000f0000
+#define CHSC_SCSC_0_CSSID 0x0000ff00
+#define CHSC_SCSC_0_RES 0xdff000ff
+static void ioinst_handle_chsc_scsc(ChscReq *req, ChscResp *res)
+{
+    uint8_t cssid;
+    uint16_t resp_code;
+    uint32_t general_chars[510];
+    uint32_t chsc_chars[508];
+
+    if (req->param0 & CHSC_SCSC_0_FMT) {
+        resp_code = 0x0007;
+        goto out_err;
+    }
+    cssid = (req->param0 & CHSC_SCSC_0_CSSID) >> 8;
+    if (cssid != 0) {
+        if (!(req->param0 & CHSC_SCSC_0_M) || !css_present(cssid)) {
+            resp_code = 0x0008;
+            goto out_err;
+        }
+    }
+    if ((req->param0 & CHSC_SCSC_0_RES) || req->param1 || req->param2) {
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
+#define CHSC_SDA_0_FMT 0x0f000000
+#define CHSC_SDA_0_OC 0x0000ffff
+#define CHSC_SDA_0_RES 0xf0ff0000
+#define CHSC_SDA_OC_MCSSE 0x0
+#define CHSC_SDA_OC_MSS 0x2
+static void ioinst_handle_chsc_sda(ChscReq *req, ChscResp *res)
+{
+    uint16_t resp_code = 0x0001;
+    uint16_t oc;
+    int ret;
+
+    if ((req->len != 0x0400) || (req->param0 & CHSC_SDA_0_RES)) {
+        resp_code = 0x0003;
+        goto out;
+    }
+
+    if (req->param0 & CHSC_SDA_0_FMT) {
+        resp_code = 0x0007;
+        goto out;
+    }
+
+    oc = req->param0 & CHSC_SDA_0_OC;
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
+    uint16_t len;
+
+    trace_ioinst("chsc");
+    reg = (ipb >> 20) & 0x00f;
+    addr = env->regs[reg];
+    /* Page boundary? */
+    if (addr & 0xfff) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    req = s390_cpu_physical_memory_map(env, addr, TARGET_PAGE_SIZE, 0);
+    if (!req) {
+        program_interrupt(env, PGM_SPECIFICATION, 2);
+        return -EIO;
+    }
+    len = req->len;
+    /* Length field valid? */
+    if ((len < 16) || (len > 4088) || (len & 7)) {
+        s390_cpu_physical_memory_unmap(env, req, TARGET_PAGE_SIZE, 0);
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    memset(env->chsc_page, 0, TARGET_PAGE_SIZE);
+    res = (void *)env->chsc_page;
+    trace_ioinst_chsc_cmd(req->command, req->len);
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
+    s390_cpu_physical_memory_unmap(env, req, TARGET_PAGE_SIZE, 0);
+    cpu_physical_memory_write(addr + req->len, res, res->len);
+    return 0;
+}
+
+int ioinst_handle_tpi(CPUS390XState *env, uint32_t ipb)
+{
+    uint64_t addr;
+    int lowcore;
+
+    trace_ioinst("tpi");
+    addr = decode_basedisp_s(env, ipb);
+    lowcore = addr ? 0 : 1;
+    if (addr < 8192) {
+        addr += env->psa;
+    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
+        addr -= env->psa;
+    }
+    return css_do_tpi(addr, lowcore);
+}
+
+#define SCHM_REG1_RES(_reg) (_reg & 0x000000000ffffffc)
+#define SCHM_REG1_MBK(_reg) ((_reg & 0x00000000f0000000) >> 28)
+#define SCHM_REG1_UPD(_reg) ((_reg & 0x0000000000000002) >> 1)
+#define SCHM_REG1_DCT(_reg) (_reg & 0x0000000000000001)
+
+int ioinst_handle_schm(CPUS390XState *env, uint64_t reg1, uint64_t reg2,
+                       uint32_t ipb)
+{
+    uint8_t mbk;
+    int update;
+    int dct;
+
+    trace_ioinst("schm");
+
+    if (SCHM_REG1_RES(reg1)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    mbk = SCHM_REG1_MBK(reg1);
+    update = SCHM_REG1_UPD(reg1);
+    dct = SCHM_REG1_DCT(reg1);
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
+    trace_ioinst_sch_id("rsch", cssid, ssid, schid);
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (sch && css_subch_visible(sch)) {
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
+#define RCHP_REG1_RES(_reg) (_reg & 0x00000000ff00ff00)
+#define RCHP_REG1_CSSID(_reg) ((_reg & 0x0000000000ff0000) >> 16)
+#define RCHP_REG1_CHPID(_reg) (_reg & 0x00000000000000ff)
+int ioinst_handle_rchp(CPUS390XState *env, uint64_t reg1)
+{
+    int cc;
+    uint8_t cssid;
+    uint8_t chpid;
+    int ret;
+
+    if (RCHP_REG1_RES(reg1)) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+
+    cssid = RCHP_REG1_CSSID(reg1);
+    chpid = RCHP_REG1_CHPID(reg1);
+
+    trace_ioinst_chp_id("rchp", cssid, chpid);
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
+#define SAL_REG1_INVALID(_reg) (_reg & 0x0000000080000000)
+int ioinst_handle_sal(CPUS390XState *env, uint64_t reg1)
+{
+    /* We do not provide address limit checking, so let's suppress it. */
+    if (SAL_REG1_INVALID(reg1) || reg1 & 0x000000000000ffff) {
+        program_interrupt(env, PGM_OPERAND, 2);
+        return -EIO;
+    }
+    return 0;
+}
diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
index 5580d91..fdc50e3 100644
--- a/target-s390x/ioinst.h
+++ b/target-s390x/ioinst.h
@@ -204,4 +204,20 @@ struct CRW {
 
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
diff --git a/trace-events b/trace-events
index 6eabbac..266cfd6 100644
--- a/trace-events
+++ b/trace-events
@@ -1051,3 +1051,9 @@ xics_set_irq_lsi(int srcno, int nr) "set_irq_lsi: srcno %d [irq %#x]"
 xics_ics_write_xive(int nr, int srcno, int server, uint8_t priority) "ics_write_xive: irq %#x [src %d] server %#x prio %#x"
 xics_ics_reject(int nr, int srcno) "reject irq %#x [src %d]"
 xics_ics_eoi(int nr) "ics_eoi: irq %#x"
+
+# target-s390x/ioinst.c
+ioinst(const char *insn) "IOINST: %s"
+ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
+ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
+ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
-- 
1.7.12.4
