From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2 4/5] s390: Virtual channel subsystem support for !KVM.
Date: Wed, 19 Sep 2012 18:22:50 +0200
Message-ID: <27EB947C-9FE2-45AF-ADBD-EC9897190573@suse.de>
References: <1346771633-53081-1-git-send-email-cornelia.huck@de.ibm.com> <1346771633-53081-5-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1346771633-53081-5-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


On 04.09.2012, at 17:13, Cornelia Huck wrote:

> Provide css support for the !KVM case as well.

As mentioned in my previous reply to the kvm side of this, I don't see any reason why we should split the code at such a high level. Why can't KVM and !KVM share the same code? If we run into performance issues, we can still think about moving the CCW subsystem into the kernel.

> 
> This includes the following:
> - Handling of instruction intercepts for I/O instructions.
> - Extended channel subsystem functions, like monitoring.
> - Support for injecting I/O interrupts and machine checks.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
> 
> Changes v1->v2:
> - coding style
> 
> ---
> hw/s390x/css.c           | 749 ++++++++++++++++++++++++++++++++++++++++++++++-
> hw/s390x/css.h           |  26 ++
> target-s390x/cpu.h       | 157 +++++++++-
> target-s390x/helper.c    | 140 +++++++++
> target-s390x/ioinst.c    | 696 +++++++++++++++++++++++++++++++++++++++++++
> target-s390x/ioinst.h    |  35 ++-
> target-s390x/kvm.c       | 164 ++++++++++-
> target-s390x/op_helper.c |  22 +-
> 8 files changed, 1961 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index a671e28..3aab586 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -17,6 +17,12 @@
> #include "cpu.h"
> #include "ioinst.h"
> #include "css.h"
> +#include "virtio-ccw.h"
> +
> +typedef struct CrwContainer {
> +    CRW crw;
> +    QTAILQ_ENTRY(CrwContainer) sibling;
> +} CrwContainer;
> 
> typedef struct ChpInfo {
>     uint8_t in_use;
> @@ -35,6 +41,13 @@ typedef struct CssImage {
> } CssImage;
> 
> typedef struct ChannelSubSys {
> +    QTAILQ_HEAD(, CrwContainer) pending_crws;
> +    bool do_crw_mchk;
> +    bool crws_lost;
> +    uint8_t max_cssid;
> +    uint8_t max_ssid;
> +    bool chnmon_active;
> +    uint64_t chnmon_area;
>     CssImage *css[MAX_CSSID + 1];
>     uint8_t default_cssid;
> } ChannelSubSys;
> @@ -60,6 +73,76 @@ int css_create_css_image(uint8_t cssid, bool default_image)
>     return 0;
> }
> 
> +static void css_write_phys_pmcw(uint32_t addr, PMCW *pmcw)
> +{
> +    int i;
> +    uint32_t offset = 0;
> +    struct copy_pmcw {
> +        uint32_t intparm;
> +        uint16_t flags;
> +        uint16_t devno;
> +        uint8_t lpm;
> +        uint8_t pnom;
> +        uint8_t lpum;
> +        uint8_t pim;
> +        uint16_t mbi;
> +        uint8_t pom;
> +        uint8_t pam;
> +        uint8_t chpid[8];
> +        uint32_t chars;
> +    } *copy;
> +
> +    copy = (struct copy_pmcw *)pmcw;
> +    stl_phys(addr + offset, copy->intparm);
> +    offset += sizeof(copy->intparm);
> +    stw_phys(addr + offset, copy->flags);
> +    offset += sizeof(copy->flags);
> +    stw_phys(addr + offset, copy->devno);
> +    offset += sizeof(copy->devno);
> +    stb_phys(addr + offset, copy->lpm);
> +    offset += sizeof(copy->lpm);
> +    stb_phys(addr + offset, copy->pnom);
> +    offset += sizeof(copy->pnom);
> +    stb_phys(addr + offset, copy->lpum);
> +    offset += sizeof(copy->lpum);
> +    stb_phys(addr + offset, copy->pim);
> +    offset += sizeof(copy->pim);
> +    stw_phys(addr + offset, copy->mbi);
> +    offset += sizeof(copy->mbi);
> +    stb_phys(addr + offset, copy->pom);
> +    offset += sizeof(copy->pom);
> +    stb_phys(addr + offset, copy->pam);
> +    offset += sizeof(copy->pam);
> +    for (i = 0; i < 8; i++) {
> +        stb_phys(addr + offset, copy->chpid[i]);
> +        offset += sizeof(copy->chpid[i]);
> +    }
> +    stl_phys(addr + offset, copy->chars);

You're probably better off copying everything in one go, either through cpu_physical_memory_rw or cpu_physical_memory_map + cpu_physical_memory_unmap. Beware of endianness though :).

> +}
> +
> +static void css_write_phys_scsw(uint32_t addr, SCSW *scsw)
> +{
> +    uint32_t offset = 0;
> +    struct copy_scsw {
> +        uint32_t flags;
> +        uint32_t cpa;
> +        uint8_t dstat;
> +        uint8_t cstat;
> +        uint16_t count;
> +    } *copy;
> +
> +    copy = (struct copy_scsw *)scsw;
> +    stl_phys(addr + offset, copy->flags);
> +    offset += sizeof(copy->flags);
> +    stl_phys(addr + offset, copy->cpa);
> +    offset += sizeof(copy->cpa);
> +    stb_phys(addr + offset, copy->dstat);
> +    offset += sizeof(copy->dstat);
> +    stb_phys(addr + offset, copy->cstat);
> +    offset += sizeof(copy->cstat);
> +    stw_phys(addr + offset, copy->count);
> +}
> +
> static void css_inject_io_interrupt(SubchDev *sch, uint8_t func)
> {
>     s390_io_interrupt(sch->cssid, sch->ssid, sch->schid, &sch->curr_status.scsw,
> @@ -375,6 +458,543 @@ int css_handle_sch_io(uint32_t sch_id, uint8_t func, uint64_t orb, void *scsw,
>     return 0;
> }
> 
> +/*
> + * This function should run asynchronously to the I/O instructions in order
> + * to match the implementation on real machines. For this simple virtual
> + * css it is fine to run the I/O work synchronously instead since it won't
> + * call out to real hardware.
> + * Note: This is only used in the !KVM case.
> + */
> +static void do_subchannel_work(SubchDev *sch)
> +{
> +
> +    SCSW *s = &sch->curr_status.scsw;
> +    uint8_t func;
> +
> +    if (s->fctl & SCSW_FCTL_CLEAR_FUNC) {
> +        func = CSS_DO_CSCH_SIMPLE;
> +    } else if (s->fctl & SCSW_FCTL_HALT_FUNC) {
> +        func = CSS_DO_HSCH_SIMPLE;
> +    } else if (s->fctl & SCSW_FCTL_START_FUNC) {
> +        func = CSS_DO_SSCH_SIMPLE;
> +    } else {
> +        /* Cannot happen. */
> +        return;
> +    }
> +    css_handle_sch_io((sch->cssid << 24) | (1 << 29) | (sch->ssid << 16) |
> +                      (1 << 16) | sch->schid,
> +                      func, 0, NULL, NULL);
> +}
> +
> +/* The various css_do_<instr> functions are only hit when KVM is not active. */
> +
> +int css_do_stsch(SubchDev *sch, uint32_t addr)
> +{
> +    int i;
> +    uint32_t offset = 0;
> +
> +    qemu_mutex_lock(&sch->mutex);

Locks in QEMU code are usually wrong ;).

> +    /* Use current status. */
> +    css_write_phys_pmcw(addr, &sch->curr_status.pmcw);
> +    offset += sizeof(PMCW);
> +    css_write_phys_scsw(addr + offset, &sch->curr_status.scsw);
> +    offset += sizeof(SCSW);
> +    stq_phys(addr + offset, sch->curr_status.mba);
> +    offset += sizeof(sch->curr_status.mba);
> +    for (i = 0; i < 4; i++) {
> +        stb_phys(addr + offset, sch->curr_status.mda[i]);
> +        offset += sizeof(sch->curr_status.mda[i]);
> +    }
> +    qemu_mutex_unlock(&sch->mutex);
> +    return 0;
> +}
> +
> +int css_do_msch(SubchDev *sch, SCHIB *schib)
> +{
> +    SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
> +    int ret;
> +
> +    qemu_mutex_lock(&sch->mutex);
> +
> +    if (!sch->curr_status.pmcw.dnv) {
> +        ret = 0;
> +        goto out;
> +    }
> +
> +    if (s->stctl & SCSW_STCTL_STATUS_PEND) {
> +        ret = -EINPROGRESS;
> +        goto out;
> +    }
> +
> +    if (s->fctl &
> +        (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
> +        ret = -EBUSY;
> +        goto out;
> +    }
> +
> +    /* Only update the program-modifiable fields. */
> +    p->ena = schib->pmcw.ena;
> +    p->intparm = schib->pmcw.intparm;
> +    p->isc = schib->pmcw.isc;
> +    p->mp = schib->pmcw.mp;
> +    p->lpm = schib->pmcw.lpm;
> +    p->pom = schib->pmcw.pom;
> +    p->lm = schib->pmcw.lm;
> +    p->csense = schib->pmcw.csense;
> +
> +    p->mme = schib->pmcw.mme;
> +    p->mbi = schib->pmcw.mbi;
> +    p->mbfc = schib->pmcw.mbfc;
> +    sch->curr_status.mba = schib->mba;
> +
> +    ret = 0;
> +
> +out:
> +    qemu_mutex_unlock(&sch->mutex);
> +    return ret;
> +}
> +
> +int css_do_xsch(SubchDev *sch)
> +{
> +    SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
> +    int ret;
> +
> +    qemu_mutex_lock(&sch->mutex);
> +
> +    if (!p->dnv || !p->ena) {
> +        ret = -ENODEV;
> +        goto out;
> +    }
> +
> +    if (!s->fctl || (s->fctl != SCSW_FCTL_START_FUNC) ||
> +        (!(s->actl &
> +           (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
> +        (s->actl & SCSW_ACTL_SUBCH_ACTIVE)) {
> +        ret = -EINPROGRESS;
> +        goto out;
> +    }
> +
> +    if (s->stctl != 0) {
> +        ret = -EBUSY;
> +        goto out;
> +    }
> +
> +    /* Cancel the current operation. */
> +    s->fctl &= ~SCSW_FCTL_START_FUNC;
> +    s->actl &= ~(SCSW_ACTL_RESUME_PEND|SCSW_ACTL_START_PEND|SCSW_ACTL_SUSP);
> +    sch->channel_prog = NULL;
> +    sch->last_cmd = NULL;
> +    sch->orb = NULL;
> +    s->dstat = 0;
> +    s->cstat = 0;
> +    ret = 0;
> +
> +out:
> +    qemu_mutex_unlock(&sch->mutex);
> +    return ret;
> +}
> +
> +int css_do_csch(SubchDev *sch)
> +{
> +    SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
> +    int ret;
> +
> +    qemu_mutex_lock(&sch->mutex);
> +
> +    if (!p->dnv || !p->ena) {
> +        ret = -ENODEV;
> +        goto out;
> +    }
> +
> +    /* Trigger the clear function. */
> +    s->fctl = SCSW_FCTL_CLEAR_FUNC;
> +    s->actl = SCSW_ACTL_CLEAR_PEND;
> +
> +    do_subchannel_work(sch);
> +    ret = 0;
> +
> +out:
> +    qemu_mutex_unlock(&sch->mutex);
> +    return ret;
> +}
> +
> +int css_do_hsch(SubchDev *sch)
> +{
> +    SCSW *s = &sch->curr_status.scsw;
> +    PMCW *p = &sch->curr_status.pmcw;
> +    int ret;
> +
> +    qemu_mutex_lock(&sch->mutex);
> +
> +    if (!p->dnv || !p->ena) {
> +        ret = -ENODEV;
> +        goto out;
> +    }
> +
> +    if ((s->stctl == SCSW_STCTL_STATUS_PEND) ||
> +        (s->stctl & (SCSW_STCTL_PRIMARY |
> +                     SCSW_STCTL_SECONDARY |
> +                     SCSW_STCTL_ALERT))) {
> +        ret = -EINPROGRESS;
> +        goto out;
> +    }
> +
> +    if (s->fctl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
> +        ret = -EBUSY;
> +        goto out;
> +    }
> +
> +    /* Trigger the halt function. */
> +    s->fctl |= SCSW_FCTL_HALT_FUNC;
> +    s->fctl &= ~SCSW_FCTL_START_FUNC;
> +    if ((s->actl == (SCSW_ACTL_SUBCH_ACTIVE | SCSW_ACTL_DEVICE_ACTIVE)) &&
> +        (s->stctl == SCSW_STCTL_INTERMEDIATE)) {
> +        s->stctl &= ~SCSW_STCTL_STATUS_PEND;
> +    }
> +    s->actl |= SCSW_ACTL_HALT_PEND;
> +
> +    do_subchannel_work(sch);
> +    ret = 0;
> +
> +out:
> +    qemu_mutex_unlock(&sch->mutex);
> +    return ret;
> +}
> +
> +static void css_update_chnmon(SubchDev *sch)
> +{
> +    if (!sch->curr_status.pmcw.mme) {
> +        /* Not active. */
> +        return;
> +    }
> +    if (sch->curr_status.pmcw.mbfc) {
> +        /* Format 1, per-subchannel area. */
> +        struct cmbe *cmbe;
> +
> +        cmbe = qemu_get_ram_ptr(sch->curr_status.mba);

get_ram_ptr shouldn't be used. Better use cpu_physical_memory_map and unmap.


Alex
