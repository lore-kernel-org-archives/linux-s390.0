From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 3/8] s390: I/O interrupt and machine check injection.
Date: Mon, 10 Dec 2012 11:27:26 +0100
Message-ID: <20121210112726.0697bc4f@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-4-git-send-email-cornelia.huck@de.ibm.com>
	<82610216-94CA-44E8-B3CE-EB94886CECFC@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <82610216-94CA-44E8-B3CE-EB94886CECFC@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 10 Dec 2012 09:20:57 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> On 07.12.2012, at 13:50, Cornelia Huck wrote:
> 
> > I/O interrupts are queued per isc. Only crw pending machine checks
> > are supported.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > target-s390x/cpu.h    |  67 +++++++++++++++++++++++
> > target-s390x/helper.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > 2 files changed, 212 insertions(+)
> > 
> > diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
> > index 0f9a1f7..73bfc20 100644
> > --- a/target-s390x/cpu.h
> > +++ b/target-s390x/cpu.h
> > @@ -47,6 +47,11 @@
> > #define MMU_USER_IDX 1
> > 
> > #define MAX_EXT_QUEUE 16
> > +#define MAX_IO_QUEUE 16
> > +#define MAX_MCHK_QUEUE 16
> > +
> > +#define PSW_MCHK_MASK 0x0004000000000000
> > +#define PSW_IO_MASK 0x0200000000000000
> > 
> > typedef struct PSW {
> >     uint64_t mask;
> > @@ -59,6 +64,17 @@ typedef struct ExtQueue {
> >     uint32_t param64;
> > } ExtQueue;
> > 
> > +typedef struct IOQueue {
> > +    uint16_t id;
> > +    uint16_t nr;
> > +    uint32_t parm;
> > +    uint32_t word;
> > +} IOQueue;
> > +
> > +typedef struct MchkQueue {
> > +    uint16_t type;
> > +} MchkQueue;
> > +
> > typedef struct CPUS390XState {
> >     uint64_t regs[16];	/* GP registers */
> > 
> > @@ -88,8 +104,16 @@ typedef struct CPUS390XState {
> > 
> >     int pending_int;
> >     ExtQueue ext_queue[MAX_EXT_QUEUE];
> > +    IOQueue io_queue[MAX_IO_QUEUE][8];
> > +    MchkQueue mchk_queue[MAX_MCHK_QUEUE];
> > 
> >     int ext_index;
> > +    int io_index[8];
> > +    int mchk_index;
> > +
> > +    uint64_t ckc;
> > +    uint64_t cputm;
> > +    uint32_t todpr;
> > 
> >     CPU_COMMON
> > 
> > @@ -364,12 +388,16 @@ static inline void cpu_set_tls(CPUS390XState *env, target_ulong newtls)
> > #define EXCP_EXT 1 /* external interrupt */
> > #define EXCP_SVC 2 /* supervisor call (syscall) */
> > #define EXCP_PGM 3 /* program interruption */
> > +#define EXCP_IO  7 /* I/O interrupt */
> > +#define EXCP_MCHK 8 /* machine check */
> > 
> > #endif /* CONFIG_USER_ONLY */
> > 
> > #define INTERRUPT_EXT        (1 << 0)
> > #define INTERRUPT_TOD        (1 << 1)
> > #define INTERRUPT_CPUTIMER   (1 << 2)
> > +#define INTERRUPT_IO         (1 << 3)
> > +#define INTERRUPT_MCHK       (1 << 4)
> > 
> > /* Program Status Word.  */
> > #define S390_PSWM_REGNUM 0
> > @@ -977,6 +1005,45 @@ static inline void cpu_inject_ext(CPUS390XState *env, uint32_t code, uint32_t pa
> >     cpu_interrupt(env, CPU_INTERRUPT_HARD);
> > }
> > 
> > +static inline void cpu_inject_io(CPUS390XState *env, uint16_t subchannel_id,
> > +                                 uint16_t subchannel_number,
> > +                                 uint32_t io_int_parm, uint32_t io_int_word)
> > +{
> > +    int isc = ffs(io_int_word << 2) - 1;
> > +
> > +    if (env->io_index[isc] == MAX_IO_QUEUE - 1) {
> > +        /* ugh - can't queue anymore. Let's drop. */
> > +        return;
> > +    }
> > +
> > +    env->io_index[isc]++;
> > +    assert(env->io_index[isc] < MAX_IO_QUEUE);
> > +
> > +    env->io_queue[env->io_index[isc]][isc].id = subchannel_id;
> > +    env->io_queue[env->io_index[isc]][isc].nr = subchannel_number;
> > +    env->io_queue[env->io_index[isc]][isc].parm = io_int_parm;
> > +    env->io_queue[env->io_index[isc]][isc].word = io_int_word;
> > +
> > +    env->pending_int |= INTERRUPT_IO;
> > +    cpu_interrupt(env, CPU_INTERRUPT_HARD);
> > +}
> > +
> > +static inline void cpu_inject_crw_mchk(CPUS390XState *env)
> > +{
> > +    if (env->mchk_index == MAX_MCHK_QUEUE - 1) {
> > +        /* ugh - can't queue anymore. Let's drop. */
> > +        return;
> > +    }
> > +
> > +    env->mchk_index++;
> > +    assert(env->mchk_index < MAX_MCHK_QUEUE);
> > +
> > +    env->mchk_queue[env->mchk_index].type = 1;
> > +
> > +    env->pending_int |= INTERRUPT_MCHK;
> > +    cpu_interrupt(env, CPU_INTERRUPT_HARD);
> > +}
> > +
> > static inline bool cpu_has_work(CPUState *cpu)
> > {
> >     CPUS390XState *env = &S390_CPU(cpu)->env;
> > diff --git a/target-s390x/helper.c b/target-s390x/helper.c
> > index b7b812a..4ff148d 100644
> > --- a/target-s390x/helper.c
> > +++ b/target-s390x/helper.c
> > @@ -574,12 +574,144 @@ static void do_ext_interrupt(CPUS390XState *env)
> >     load_psw(env, mask, addr);
> > }
> > 
> > +static void do_io_interrupt(CPUS390XState *env)
> > +{
> > +    uint64_t mask, addr;
> > +    LowCore *lowcore;
> > +    hwaddr len = TARGET_PAGE_SIZE;
> > +    IOQueue *q;
> > +    uint8_t isc;
> > +    int disable = 1;
> > +    int found = 0;
> > +
> > +    if (!(env->psw.mask & PSW_MASK_IO)) {
> > +        cpu_abort(env, "I/O int w/o I/O mask\n");
> > +    }
> > +
> > +    for (isc = 0; isc < 8; isc++) {
> > +        if (env->io_index[isc] < 0) {
> > +            continue;
> > +        }
> > +        if (env->io_index[isc] > MAX_IO_QUEUE) {
> > +            cpu_abort(env, "I/O queue overrun for isc %d: %d\n",
> > +                      isc, env->io_index[isc]);
> > +        }
> > +
> > +        q = &env->io_queue[env->io_index[isc]][isc];
> > +        if (!(env->cregs[6] & q->word)) {
> > +            disable = 0;
> > +            continue;
> > +        }
> > +        found = 1;
> > +        lowcore = cpu_physical_memory_map(env->psa, &len, 1);
> 
> This one is missing a check whether len >= sizeof(*lowcore) :).

Yes, since do_ext_interrupt which I copy/pasted this from does as
well :) Will add.

> 
> > +
> > +        lowcore->subchannel_id = cpu_to_be16(q->id);
> > +        lowcore->subchannel_nr = cpu_to_be16(q->nr);
> > +        lowcore->io_int_parm = cpu_to_be32(q->parm);
> > +        lowcore->io_int_word = cpu_to_be32(q->word);
> > +        lowcore->io_old_psw.mask = cpu_to_be64(get_psw_mask(env));
> > +        lowcore->io_old_psw.addr = cpu_to_be64(env->psw.addr);
> > +        mask = be64_to_cpu(lowcore->io_new_psw.mask);
> > +        addr = be64_to_cpu(lowcore->io_new_psw.addr);
> > +
> > +        cpu_physical_memory_unmap(lowcore, len, 1, len);
> > +
> > +        env->io_index[isc]--;
> > +        if (env->io_index >= 0) {
> > +            disable = 0;
> > +        }
> > +        break;
> > +    }
> > +
> > +    if (disable) {
> > +        env->pending_int &= ~INTERRUPT_IO;
> > +    }
> > +
> > +    if (found) {
> > +        DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
> > +                env->psw.mask, env->psw.addr);
> > +        load_psw(env, mask, addr);
> > +    }
> > +}
> > +
> > +static void do_mchk_interrupt(CPUS390XState *env)
> > +{
> > +    uint64_t mask, addr;
> > +    LowCore *lowcore;
> > +    hwaddr len = TARGET_PAGE_SIZE;
> > +    MchkQueue *q;
> > +    int i;
> > +
> > +    if (!(env->psw.mask & PSW_MASK_MCHECK)) {
> > +        cpu_abort(env, "Machine check w/o mchk mask\n");
> > +    }
> > +
> > +    if (env->mchk_index < 0 || env->mchk_index > MAX_MCHK_QUEUE) {
> > +        cpu_abort(env, "Mchk queue overrun: %d\n", env->mchk_index);
> > +    }
> > +
> > +    q = &env->mchk_queue[env->mchk_index];
> > +
> > +    if (q->type != 1) {
> 
> What is type 1?

Something that should be MCHK_TYPE_CRW or so :)

> 
> > +        /* Don't know how to handle this... */
> > +        cpu_abort(env, "Unknown machine check type %d\n", q->type);
> > +    }
> > +    if (!(env->cregs[14] & (1 << 28))) {
> 
> Please create a #define for this one :)

OK

> 
> > +        /* CRW machine checks disabled */
> > +        return;
> > +    }
> > +
> > +    lowcore = cpu_physical_memory_map(env->psa, &len, 1);
> 
> Check missing again.

Perhaps we want {map,unmap}_lowcore() functions?

> 
> > +
> > +    for (i = 0; i < 16; i++) {
> > +        lowcore->floating_pt_save_area[i] = cpu_to_be64(env->fregs[i].ll);
> > +        lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
> > +        lowcore->access_regs_save_area[i] = cpu_to_be32(env->aregs[i]);
> > +        lowcore->cregs_save_area[i] = cpu_to_be64(env->cregs[i]);
> > +    }
> > +    lowcore->prefixreg_save_area = cpu_to_be32(env->psa);
> > +    lowcore->fpt_creg_save_area = cpu_to_be32(env->fpc);
> > +    lowcore->tod_progreg_save_area = cpu_to_be32(env->todpr);
> > +    lowcore->cpu_timer_save_area[0] = cpu_to_be32(env->cputm >> 32);
> > +    lowcore->cpu_timer_save_area[1] =
> > +        cpu_to_be32(env->cputm & 0x00000000ffffffff);
> 
> cpu_to_be32((uint32_t)env->cputm)

Can change that.

> 
> > +    lowcore->clock_comp_save_area[0] = cpu_to_be32(env->ckc >> 32);
> > +    lowcore->clock_comp_save_area[1] =
> > +        cpu_to_be32(env->ckc & 0x00000000ffffffff);
> > +
> > +    lowcore->mcck_interruption_code[0] = cpu_to_be32(0x00400f1d);
> > +    lowcore->mcck_interruption_code[1] = cpu_to_be32(0x40330000);
> > +    lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
> > +    lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
> > +    mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
> > +    addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
> > +
> > +    cpu_physical_memory_unmap(lowcore, len, 1, len);
> > +
> > +    env->mchk_index--;
> > +    if (env->mchk_index == -1) {
> > +        env->pending_int &= ~INTERRUPT_MCHK;
> > +    }
> > +
> > +    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
> > +            env->psw.mask, env->psw.addr);
> > +
> > +    load_psw(env, mask, addr);
> > +}
> > +
> > void do_interrupt(CPUS390XState *env)
> > {
> >     qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
> >                   __func__, env->exception_index, env->psw.addr);
> > 
> >     s390_add_running_cpu(env);
> > +    /* handle machine checks */
> > +    if ((env->psw.mask & PSW_MASK_MCHECK) &&
> > +        (env->exception_index == -1)) {
> > +        if (env->pending_int & INTERRUPT_MCHK) {
> > +            env->exception_index = EXCP_MCHK;
> > +        }
> > +    }
> >     /* handle external interrupts */
> >     if ((env->psw.mask & PSW_MASK_EXT) &&
> >         env->exception_index == -1) {
> > @@ -598,6 +730,13 @@ void do_interrupt(CPUS390XState *env)
> >             env->pending_int &= ~INTERRUPT_TOD;
> >         }
> >     }
> > +    /* handle I/O interrupts */
> > +    if ((env->psw.mask & PSW_MASK_IO) &&
> > +        (env->exception_index == -1)) {
> > +        if (env->pending_int & INTERRUPT_IO) {
> > +            env->exception_index = EXCP_IO;
> > +        }
> > +    }
> > 
> >     switch (env->exception_index) {
> >     case EXCP_PGM:
> > @@ -609,6 +748,12 @@ void do_interrupt(CPUS390XState *env)
> >     case EXCP_EXT:
> >         do_ext_interrupt(env);
> >         break;
> > +    case EXCP_IO:
> > +        do_io_interrupt(env);
> > +        break;
> > +    case EXCP_MCHK:
> > +        do_mchk_interrupt(env);
> > +        break;
> >     }
> >     env->exception_index = -1;
> > 
> > -- 
> > 1.7.12.4
> > 
> 
