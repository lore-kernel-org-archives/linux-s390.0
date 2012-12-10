From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/8] s390: Add channel I/O instructions.
Date: Mon, 10 Dec 2012 10:00:16 +0100
Message-ID: <7024DD5C-C290-48C8-A1F2-8C8831011D1C@suse.de>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com> <1354884626-15060-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1354884626-15060-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 07.12.2012, at 13:50, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Provide handlers for (most) channel I/O instructions.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> target-s390x/cpu.h    |  87 +++++++
> target-s390x/ioinst.c | 694 +++++++++++++++++++++++++++++++++++++++++++++++++-
> target-s390x/ioinst.h |  16 ++
> trace-events          |   6 +
> 4 files changed, 796 insertions(+), 7 deletions(-)
> 
> diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
> index 73bfc20..bc119f8 100644
> --- a/target-s390x/cpu.h
> +++ b/target-s390x/cpu.h
> @@ -127,6 +127,8 @@ typedef struct CPUS390XState {
>     QEMUTimer *tod_timer;
> 
>     QEMUTimer *cpu_timer;
> +
> +    void *chsc_page;
> } CPUS390XState;
> 
> #include "cpu-qom.h"
> @@ -363,6 +365,91 @@ static inline unsigned s390_del_running_cpu(CPUS390XState *env)
> void cpu_lock(void);
> void cpu_unlock(void);
> 
> +typedef struct SubchDev SubchDev;
> +typedef struct SCHIB SCHIB;
> +typedef struct ORB ORB;
> +
> +static inline SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
> +                                       uint16_t schid)
> +{
> +    return NULL;
> +}
> +static inline bool css_subch_visible(SubchDev *sch)
> +{
> +    return false;
> +}
> +static inline void css_conditional_io_interrupt(SubchDev *sch)
> +{
> +}
> +static inline int css_do_stsch(SubchDev *sch, uint64_t addr)
> +{
> +    return -ENODEV;
> +}
> +static inline bool css_schid_final(uint8_t cssid, uint8_t ssid, uint16_t schid)
> +{
> +    return true;
> +}
> +static inline int css_do_msch(SubchDev *sch, SCHIB *schib)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_xsch(SubchDev *sch)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_csch(SubchDev *sch)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_hsch(SubchDev *sch)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_ssch(SubchDev *sch, ORB *orb)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_tsch(SubchDev *sch, uint64_t addr)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_stcrw(uint64_t addr)
> +{
> +    return 1;
> +}
> +static inline int css_do_tpi(uint64_t addr, int lowcore)
> +{
> +    return 0;
> +}
> +static inline int css_collect_chp_desc(int m, uint8_t cssid, uint8_t f_chpid,
> +                                       int rfmt, uint8_t l_chpid, void *buf)
> +{
> +    return 0;
> +}
> +static inline void css_do_schm(uint8_t mbk, int update, int dct, uint64_t mbo)
> +{
> +}
> +static inline int css_enable_mss(void)
> +{
> +    return -EINVAL;
> +}
> +static inline int css_enable_mcsse(void)
> +{
> +    return -EINVAL;
> +}
> +static inline int css_do_rsch(SubchDev *sch)
> +{
> +    return -ENODEV;
> +}
> +static inline int css_do_rchp(uint8_t cssid, uint8_t chpid)
> +{
> +    return -ENODEV;
> +}
> +static inline bool css_present(uint8_t cssid)
> +{
> +    return false;
> +}
> +
> static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
> {
>     env->aregs[0] = newtls >> 32;
> diff --git a/target-s390x/ioinst.c b/target-s390x/ioinst.c
> index 8577b2c..60ce985 100644
> --- a/target-s390x/ioinst.c
> +++ b/target-s390x/ioinst.c
> @@ -15,14 +15,19 @@
> 
> #include "cpu.h"
> #include "ioinst.h"
> +#include "trace.h"
> 
> -#ifdef DEBUG_IOINST
> -#define dprintf(fmt, ...) \
> -    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
> -#else
> -#define dprintf(fmt, ...) \
> -    do { } while (0)
> -#endif
> +/* Special handling for the prefix page. */
> +static void *s390_get_address(CPUS390XState *env, ram_addr_t guest_addr)
> +{
> +    if (guest_addr < 8192) {
> +        guest_addr += env->psa;
> +    } else if ((env->psa <= guest_addr) && (guest_addr < env->psa + 8192)) {
> +        guest_addr -= env->psa;
> +    }
> +
> +    return qemu_get_ram_ptr(guest_addr);

Do we actually need this?

> +}
> 
> int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
>                                  int *schid)
> @@ -44,3 +49,678 @@ int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
>     *schid = value & IOINST_SCHID_NR;
>     return 0;
> }
> +
> +int ioinst_handle_xsch(CPUS390XState *env, uint64_t reg1)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("xsch", cssid, ssid, schid);
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_xsch(sch);
> +    }
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EBUSY:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        cc = 1;
> +        break;
> +    }
> +
> +    return cc;
> +}
> +
> +int ioinst_handle_csch(CPUS390XState *env, uint64_t reg1)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("csch", cssid, ssid, schid);
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_csch(sch);
> +    }
> +    if (ret == -ENODEV) {
> +        cc = 3;
> +    } else {
> +        cc = 0;
> +    }
> +    return cc;
> +}
> +
> +int ioinst_handle_hsch(CPUS390XState *env, uint64_t reg1)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("hsch", cssid, ssid, schid);
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_hsch(sch);
> +    }
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EBUSY:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        cc = 1;
> +        break;
> +    }
> +
> +    return cc;
> +}
> +
> +static int ioinst_schib_valid(SCHIB *schib)
> +{
> +    if ((schib->pmcw.flags & PMCW_FLAGS_MASK_INVALID) ||
> +        (schib->pmcw.chars & PMCW_CHARS_MASK_INVALID)) {
> +        return 0;
> +    }
> +    /* Disallow extended measurements for now. */
> +    if (schib->pmcw.chars & PMCW_CHARS_MASK_XMWME) {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
> +int ioinst_handle_msch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    SCHIB *schib;
> +    uint64_t addr;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("msch", cssid, ssid, schid);
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;

This adds the upper bits twice. Are you sire that's correct?

> +    schib = s390_get_address(env, addr);
> +    if (!schib) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    if (!ioinst_schib_valid(schib)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_msch(sch, schib);
> +    }
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EBUSY:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        cc = 1;
> +        break;
> +    }
> +
> +    return cc;
> +}
> +
> +static int ioinst_orb_valid(ORB *orb)
> +{
> +    if ((orb->ctrl0 & ORB_CTRL0_MASK_INVALID) ||
> +        (orb->ctrl1 & ORB_CTRL1_MASK_INVALID)) {
> +        return 0;
> +    }
> +    if ((orb->cpa & 0x80000000) != 0)

What is this bit's name?

> {
> +        return 0;
> +    }
> +    return 1;
> +}
> +
> +int ioinst_handle_ssch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    ORB *orb;
> +    uint64_t addr;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("ssch", cssid, ssid, schid);
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;

Same logic as above. Please combine.

> +    orb = s390_get_address(env, addr);
> +    if (!orb) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    if (!ioinst_orb_valid(orb)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_ssch(sch, orb);
> +    }
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EBUSY:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        cc = 1;
> +        break;
> +    }

In fact I've seen this one multiple times too now. Please extract the retval->cc conversion into a function.

> +
> +    return cc;
> +}
> +
> +int ioinst_handle_stcrw(CPUS390XState *env, uint32_t ipb)
> +{
> +    CRW *crw;
> +    uint64_t addr;
> +    int cc;
> +
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;
> +    crw = s390_get_address(env, addr);
> +    if (!crw) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    if (addr < 8192) {
> +        addr += env->psa;
> +    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +        addr -= env->psa;
> +    }

Eh :)

> +    cc = css_do_stcrw(addr);
> +    /* 0 - crw stored, 1 - zeroes stored */
> +    return cc;
> +}
> +
> +int ioinst_handle_stsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    uint64_t addr;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("stsch", cssid, ssid, schid);
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;
> +    if (addr < 8192) {
> +        addr += env->psa;
> +    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +        addr -= env->psa;
> +    }
> +    if (!qemu_get_ram_ptr(addr)) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch) {
> +        if (css_subch_visible(sch)) {
> +            css_do_stsch(sch, addr);
> +            cc = 0;
> +        } else {
> +            /* Indicate no more subchannels in this css/ss */
> +            cc = 3;
> +        }
> +    } else {
> +        if (css_schid_final(cssid, ssid, schid)) {
> +            cc = 3; /* No more subchannels in this css/ss */
> +        } else {
> +            int i;
> +
> +            /* Store an empty schib. */
> +            for (i = 0; i < sizeof(SCHIB); i++) {
> +                stb_phys(addr + i, 0);
> +            }
> +            cc = 0;
> +        }
> +    }
> +    return cc;
> +}
> +
> +int ioinst_handle_tsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    IRB *irb;
> +    uint64_t addr;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("tsch", cssid, ssid, schid);
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;
> +    irb = s390_get_address(env, addr);
> +    if (!irb) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        if (addr < 8192) {
> +            addr += env->psa;
> +        } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +            addr -= env->psa;
> +        }
> +        ret = css_do_tsch(sch, addr);
> +        /* 0 - status pending, 1 - not status pending */
> +        cc = ret;
> +    } else {
> +        cc = 3;
> +    }
> +    return cc;
> +}
> +
> +typedef struct ChscReq {
> +    uint16_t len;
> +    uint16_t command;
> +    uint32_t param0;
> +    uint32_t param1;
> +    uint32_t param2;
> +} QEMU_PACKED ChscReq;
> +
> +typedef struct ChscResp {
> +    uint16_t len;
> +    uint16_t code;
> +    uint32_t param;
> +    char data[0];
> +} QEMU_PACKED ChscResp;
> +
> +#define CHSC_SCPD 0x0002
> +#define CHSC_SCSC 0x0010
> +#define CHSC_SDA  0x0031
> +
> +static void ioinst_handle_chsc_scpd(ChscReq *req, ChscResp *res)
> +{
> +    uint16_t resp_code;
> +    int rfmt;
> +    uint16_t cssid;
> +    uint8_t f_chpid, l_chpid;
> +    int desc_size;
> +    int m;
> +
> +    rfmt = (req->param0 & 0x00000f00) >> 8;
> +    if ((rfmt == 0) ||  (rfmt == 1)) {
> +        rfmt = (req->param0 & 0x10000000) >> 28;

Too many magic numbers.

> +    }
> +    if ((req->len != 0x0010) || (req->param0 & 0xc000f000) ||
> +        (req->param1 & 0xffffff00) || req->param2) {
> +        resp_code = 0x0003;
> +        goto out_err;
> +    }
> +    if (req->param0 & 0x0f000000) {
> +        resp_code = 0x0007;
> +        goto out_err;
> +    }
> +    cssid = (req->param0 & 0x00ff0000) >> 16;
> +    m = req->param0 & 0x20000000;
> +    if (cssid != 0) {
> +        if (!m || !css_present(cssid)) {
> +            resp_code = 0x0008;
> +            goto out_err;
> +        }
> +    }
> +    f_chpid = req->param0 & 0x000000ff;
> +    l_chpid = req->param1 & 0x000000ff;
> +    if (l_chpid < f_chpid) {
> +        resp_code = 0x0003;
> +        goto out_err;
> +    }
> +    desc_size = css_collect_chp_desc(m, cssid, f_chpid, l_chpid, rfmt,
> +                                     &res->data);
> +    res->code = 0x0001;
> +    res->len = 8 + desc_size;
> +    res->param = rfmt;
> +    return;
> +
> +  out_err:
> +    res->code = resp_code;
> +    res->len = 8;
> +    res->param = rfmt;
> +}
> +
> +static void ioinst_handle_chsc_scsc(ChscReq *req, ChscResp *res)
> +{
> +    uint8_t cssid;
> +    uint16_t resp_code;
> +    uint32_t general_chars[510];
> +    uint32_t chsc_chars[508];
> +
> +    if (req->param0 & 0x000f0000) {
> +        resp_code = 0x0007;
> +        goto out_err;
> +    }
> +    cssid = (req->param0 & 0x0000ff00) >> 8;
> +    if (cssid != 0) {
> +        if (!(req->param0 & 0x20000000) || !css_present(cssid)) {
> +            resp_code = 0x0008;
> +            goto out_err;
> +        }
> +    }
> +    if ((req->param0 & 0xdff000ff) || req->param1 || req->param2) {
> +        resp_code = 0x0003;
> +        goto out_err;
> +    }
> +    res->code = 0x0001;
> +    res->len = 4080;
> +    res->param = 0;
> +
> +    memset(general_chars, 0, sizeof(general_chars));
> +    memset(chsc_chars, 0, sizeof(chsc_chars));
> +
> +    general_chars[0] = 0x03000000;
> +    general_chars[1] = 0x00059000;
> +
> +    chsc_chars[0] = 0x40000000;
> +    chsc_chars[3] = 0x00040000;
> +
> +    memcpy(res->data, general_chars, sizeof(general_chars));
> +    memcpy(res->data + sizeof(general_chars), chsc_chars, sizeof(chsc_chars));
> +    return;
> +
> +  out_err:
> +    res->code = resp_code;
> +    res->len = 8;
> +    res->param = 0;
> +}
> +
> +#define CHSC_SDA_OC_MCSSE 0x0
> +#define CHSC_SDA_OC_MSS 0x2
> +static void ioinst_handle_chsc_sda(ChscReq *req, ChscResp *res)
> +{
> +    uint16_t resp_code = 0x0001;
> +    uint16_t oc;
> +    int ret;
> +
> +    if ((req->len != 0x0400) || (req->param0 & 0xf0ff0000)) {
> +        resp_code = 0x0003;
> +        goto out;
> +    }
> +
> +    if (req->param0 & 0x0f000000) {
> +        resp_code = 0x0007;
> +        goto out;
> +    }
> +
> +    oc = req->param0 & 0x0000ffff;
> +    switch (oc) {
> +    case CHSC_SDA_OC_MCSSE:
> +        ret = css_enable_mcsse();
> +        if (ret == -EINVAL) {
> +            resp_code = 0x0101;
> +            goto out;
> +        }
> +        break;
> +    case CHSC_SDA_OC_MSS:
> +        ret = css_enable_mss();
> +        if (ret == -EINVAL) {
> +            resp_code = 0x0101;
> +            goto out;
> +        }
> +        break;
> +    default:
> +        resp_code = 0x0003;
> +        goto out;
> +    }
> +
> +out:
> +    res->code = resp_code;
> +    res->len = 8;
> +    res->param = 0;
> +}
> +
> +static void ioinst_handle_chsc_unimplemented(ChscResp *res)
> +{
> +    res->len = 8;
> +    res->code = 0x0004;
> +    res->param = 0;
> +}
> +
> +int ioinst_handle_chsc(CPUS390XState *env, uint32_t ipb)
> +{
> +    ChscReq *req;
> +    ChscResp *res;
> +    uint64_t addr;
> +    int reg;
> +
> +    trace_ioinst("chsc");
> +    reg = (ipb >> 20) & 0x00f;
> +    addr = env->regs[reg];
> +    req = s390_get_address(env, addr);
> +    if (!req) {
> +        program_interrupt(env, PGM_SPECIFICATION, 2);
> +        return -EIO;
> +    }
> +    if (!env->chsc_page) {
> +        env->chsc_page = g_malloc0(TARGET_PAGE_SIZE);

Just make it an actual part of the struct, no need for the extra allocation.

Alex

> +    } else {
> +        memset(env->chsc_page, 0, TARGET_PAGE_SIZE);
> +    }
> +    res = env->chsc_page;
> +    trace_ioinst_chsc_cmd(req->command, req->len);
> +    switch (req->command) {
> +    case CHSC_SCSC:
> +        ioinst_handle_chsc_scsc(req, res);
> +        break;
> +    case CHSC_SCPD:
> +        ioinst_handle_chsc_scpd(req, res);
> +        break;
> +    case CHSC_SDA:
> +        ioinst_handle_chsc_sda(req, res);
> +        break;
> +    default:
> +        ioinst_handle_chsc_unimplemented(res);
> +        break;
> +    }
> +    if (addr < 8192) {
> +        addr += env->psa;
> +    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +        addr -= env->psa;
> +    }
> +    cpu_physical_memory_write(addr + req->len, res, res->len);
> +    return 0;
> +}
> +
> +int ioinst_handle_tpi(CPUS390XState *env, uint32_t ipb)
> +{
> +    uint64_t addr;
> +    int lowcore;
> +
> +    trace_ioinst("tpi");
> +    addr = ipb >> 28;
> +    if (addr > 0) {
> +        addr = env->regs[addr];
> +    }
> +    addr += (ipb & 0xfff0000) >> 16;
> +    lowcore = addr ? 0 : 1;
> +    if (addr < 8192) {
> +        addr += env->psa;
> +    } else if ((env->psa <= addr) && (addr < env->psa + 8192)) {
> +        addr -= env->psa;
> +    }
> +    return css_do_tpi(addr, lowcore);
> +}
> +
> +int ioinst_handle_schm(CPUS390XState *env, uint64_t reg1, uint64_t reg2,
> +                       uint32_t ipb)
> +{
> +    uint8_t mbk;
> +    int update;
> +    int dct;
> +
> +    trace_ioinst("schm");
> +
> +    if (reg1 & 0x000000000ffffffc) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +
> +    mbk = (reg1 & 0x00000000f0000000) >> 28;
> +    update = (reg1 & 0x0000000000000002) >> 1;
> +    dct = reg1 & 0x0000000000000001;
> +
> +    if (update && (reg2 & 0x0000000000000fff)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +
> +    css_do_schm(mbk, update, dct, update ? reg2 : 0);
> +
> +    return 0;
> +}
> +
> +int ioinst_handle_rsch(CPUS390XState *env, uint64_t reg1)
> +{
> +    int cssid, ssid, schid, m;
> +    SubchDev *sch;
> +    int ret = -ENODEV;
> +    int cc;
> +
> +    if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    trace_ioinst_sch_id("rsch", cssid, ssid, schid);
> +    sch = css_find_subch(m, cssid, ssid, schid);
> +    if (sch && css_subch_visible(sch)) {
> +        ret = css_do_rsch(sch);
> +    }
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EINVAL:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        cc = 1;
> +        break;
> +    }
> +
> +    return cc;
> +
> +}
> +
> +int ioinst_handle_rchp(CPUS390XState *env, uint64_t reg1)
> +{
> +    int cc;
> +    uint8_t cssid;
> +    uint8_t chpid;
> +    int ret;
> +
> +    if (reg1 & 0xff00ff00) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +
> +    cssid = (reg1 >> 16) & 0xff;
> +    chpid = reg1 & 0xff;
> +
> +    trace_ioinst_chp_id("rchp", cssid, chpid);
> +
> +    ret = css_do_rchp(cssid, chpid);
> +
> +    switch (ret) {
> +    case -ENODEV:
> +        cc = 3;
> +        break;
> +    case -EBUSY:
> +        cc = 2;
> +        break;
> +    case 0:
> +        cc = 0;
> +        break;
> +    default:
> +        /* Invalid channel subsystem. */
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +
> +    return cc;
> +}
> +
> +int ioinst_handle_sal(CPUS390XState *env, uint64_t reg1)
> +{
> +    /* We do not provide address limit checking, so let's suppress it. */
> +    if (env->regs[1] & 0x000000008000ffff) {
> +        program_interrupt(env, PGM_OPERAND, 2);
> +        return -EIO;
> +    }
> +    return 0;
> +}
> diff --git a/target-s390x/ioinst.h b/target-s390x/ioinst.h
> index b5b4a03..e5f54f5 100644
> --- a/target-s390x/ioinst.h
> +++ b/target-s390x/ioinst.h
> @@ -204,4 +204,20 @@ typedef struct CRW {
> 
> int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
>                                  int *schid);
> +int ioinst_handle_xsch(CPUS390XState *env, uint64_t reg1);
> +int ioinst_handle_csch(CPUS390XState *env, uint64_t reg1);
> +int ioinst_handle_hsch(CPUS390XState *env, uint64_t reg1);
> +int ioinst_handle_msch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
> +int ioinst_handle_ssch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
> +int ioinst_handle_stcrw(CPUS390XState *env, uint32_t ipb);
> +int ioinst_handle_stsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
> +int ioinst_handle_tsch(CPUS390XState *env, uint64_t reg1, uint32_t ipb);
> +int ioinst_handle_chsc(CPUS390XState *env, uint32_t ipb);
> +int ioinst_handle_tpi(CPUS390XState *env, uint32_t ipb);
> +int ioinst_handle_schm(CPUS390XState *env, uint64_t reg1, uint64_t reg2,
> +                       uint32_t ipb);
> +int ioinst_handle_rsch(CPUS390XState *env, uint64_t reg1);
> +int ioinst_handle_rchp(CPUS390XState *env, uint64_t reg1);
> +int ioinst_handle_sal(CPUS390XState *env, uint64_t reg1);
> +
> #endif
> diff --git a/trace-events b/trace-events
> index 6c6cbf1..af50c68 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -1022,3 +1022,9 @@ spapr_pci_rtas_ibm_change_msi(unsigned func, unsigned req) "func %u, requested %
> spapr_pci_rtas_ibm_query_interrupt_source_number(unsigned ioa, unsigned intr) "queries for #%u, IRQ%u"
> spapr_pci_msi_write(uint64_t addr, uint64_t data, uint32_t dt_irq) "@%"PRIx64"<=%"PRIx64" IRQ %u"
> spapr_pci_lsi_set(const char *busname, int pin, uint32_t irq) "%s PIN%d IRQ %u"
> +
> +# target-s390x/ioinst.c
> +ioinst(const char *insn) "IOINST: %s"
> +ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
> +ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
> +ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
> -- 
> 1.7.12.4
> 
