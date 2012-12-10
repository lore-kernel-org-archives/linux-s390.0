From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 6/8] s390: Wire up channel I/O in kvm.
Date: Mon, 10 Dec 2012 11:29:28 +0100
Message-ID: <20121210112928.660d3d5b@BR9GNB5Z>
References: <1354884626-15060-1-git-send-email-cornelia.huck@de.ibm.com>
	<1354884626-15060-7-git-send-email-cornelia.huck@de.ibm.com>
	<F8BFFCBB-8137-4C48-BE74-43A9CE6387FA@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <F8BFFCBB-8137-4C48-BE74-43A9CE6387FA@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 10 Dec 2012 10:40:15 +0100
Alexander Graf <agraf@suse.de> wrote:

> 
> 
> On 07.12.2012, at 13:50, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > Trigger the code for our virtual css in case of instruction
> > intercepts for I/O instructions.
> > 
> > Handle the tsch exit for the subchannel-related part of tsch.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> > target-s390x/cpu.h |  11 +++
> > target-s390x/kvm.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++++++---
> > 2 files changed, 244 insertions(+), 13 deletions(-)
> > 
> > diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
> > index eb24c6b..1d21ca8 100644
> > --- a/target-s390x/cpu.h
> > +++ b/target-s390x/cpu.h
> > @@ -1178,6 +1178,13 @@ uint32_t set_cc_nz_f64(float64 v);
> > /* misc_helper.c */
> > void program_interrupt(CPUS390XState *env, uint32_t code, int ilc);
> > 
> > +#ifdef CONFIG_KVM
> > +int kvm_s390_io_interrupt(CPUS390XState *env, uint16_t subchannel_id,
> > +                          uint16_t subchannel_nr, uint32_t io_int_parm,
> > +                          uint32_t io_int_word);
> > +int kvm_s390_crw_mchk(CPUS390XState *env);
> > +void kvm_s390_enable_css_support(CPUS390XState *env);
> > +#else
> > static inline int kvm_s390_io_interrupt(CPUS390XState *env,
> >                                         uint16_t subchannel_id,
> >                                         uint16_t subchannel_nr,
> > @@ -1190,6 +1197,10 @@ static inline int kvm_s390_crw_mchk(CPUS390XState *env)
> > {
> >     return -EOPNOTSUPP;
> > }
> > +static inline void kvm_s390_enable_css_support(CPUS390XState *env)
> > +{
> > +}
> > +#endif
> > 
> > static inline void s390_io_interrupt(CPUS390XState *env,
> >                                      uint16_t subchannel_id,
> > diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
> > index 94de764..c9a4a7d 100644
> > --- a/target-s390x/kvm.c
> > +++ b/target-s390x/kvm.c
> > @@ -30,6 +30,7 @@
> > #include "kvm.h"
> > #include "cpu.h"
> > #include "device_tree.h"
> > +#include "ioinst.h"
> > 
> > /* #define DEBUG_KVM */
> > 
> > @@ -43,9 +44,27 @@
> > 
> > #define IPA0_DIAG                       0x8300
> > #define IPA0_SIGP                       0xae00
> > -#define IPA0_PRIV                       0xb200
> > +#define IPA0_B2                         0xb200
> > +#define IPA0_B9                         0xb900
> > +#define IPA0_EB                         0xeb00
> > 
> > #define PRIV_SCLP_CALL                  0x20
> > +#define PRIV_CSCH                       0x30
> > +#define PRIV_HSCH                       0x31
> > +#define PRIV_MSCH                       0x32
> > +#define PRIV_SSCH                       0x33
> > +#define PRIV_STSCH                      0x34
> > +#define PRIV_TSCH                       0x35
> > +#define PRIV_TPI                        0x36
> > +#define PRIV_SAL                        0x37
> > +#define PRIV_RSCH                       0x38
> > +#define PRIV_STCRW                      0x39
> > +#define PRIV_STCPS                      0x3a
> > +#define PRIV_RCHP                       0x3b
> > +#define PRIV_SCHM                       0x3c
> > +#define PRIV_CHSC                       0x5f
> > +#define PRIV_SIGA                       0x74
> > +#define PRIV_XSCH                       0x76
> > #define DIAG_KVM_HYPERCALL              0x500
> > #define DIAG_KVM_BREAKPOINT             0x501
> > 
> > @@ -350,10 +369,120 @@ static int kvm_sclp_service_call(CPUS390XState *env, struct kvm_run *run,
> >     return 0;
> > }
> > 
> > -static int handle_priv(CPUS390XState *env, struct kvm_run *run, uint8_t ipa1)
> > +static int kvm_handle_css_inst(CPUS390XState *env, struct kvm_run *run,
> > +                               uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
> > +{
> > +    int r = 0;
> > +    int no_cc = 0;
> > +
> > +    if (ipa0 != 0xb2) {
> > +        /* Not handled for now. */
> > +        return -1;
> > +    }
> > +    cpu_synchronize_state(env);
> > +    switch (ipa1) {
> > +    case PRIV_XSCH:
> > +        r = ioinst_handle_xsch(env, env->regs[1]);
> > +        break;
> > +    case PRIV_CSCH:
> > +        r = ioinst_handle_csch(env, env->regs[1]);
> > +        break;
> > +    case PRIV_HSCH:
> > +        r = ioinst_handle_hsch(env, env->regs[1]);
> > +        break;
> > +    case PRIV_MSCH:
> > +        r = ioinst_handle_msch(env, env->regs[1], run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_SSCH:
> > +        r = ioinst_handle_ssch(env, env->regs[1], run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_STCRW:
> > +        r = ioinst_handle_stcrw(env, run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_STSCH:
> > +        r = ioinst_handle_stsch(env, env->regs[1], run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_TSCH:
> > +        /* We should only get tsch via KVM_EXIT_S390_TSCH. */
> > +        fprintf(stderr, "Spurious tsch intercept\n");
> > +        break;
> > +    case PRIV_CHSC:
> > +        r = ioinst_handle_chsc(env, run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_TPI:
> > +        /* This should have been handled by kvm already. */
> > +        fprintf(stderr, "Spurious tpi intercept\n");
> > +        break;
> > +    case PRIV_SCHM:
> > +        no_cc = 1;
> > +        r = ioinst_handle_schm(env, env->regs[1], env->regs[2],
> > +                               run->s390_sieic.ipb);
> > +        break;
> > +    case PRIV_RSCH:
> > +        r = ioinst_handle_rsch(env, env->regs[1]);
> > +        break;
> > +    case PRIV_RCHP:
> > +        r = ioinst_handle_rchp(env, env->regs[1]);
> > +        break;
> > +    case PRIV_STCPS:
> > +        /* We do not provide this instruction, it is suppressed. */
> > +        no_cc = 1;
> > +        r = 0;
> > +        break;
> > +    case PRIV_SAL:
> > +        no_cc = 1;
> > +        r = ioinst_handle_sal(env, env->regs[1]);
> > +        break;
> > +    default:
> > +        r = -1;
> > +        break;
> > +    }
> > +
> > +    if (r >= 0) {
> > +        if (!no_cc) {
> > +            setcc(env, r);
> > +        }
> > +        r = 0;
> > +    } else if (r < -1) {
> > +        r = 0;
> > +    }
> > +    return r;
> > +}
> > +
> > +static int is_ioinst(uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
> > +{
> > +    int ret = 0;
> > +
> > +    switch (ipa0) {
> > +    case 0xb2:
> > +        if (((ipa1 >= 0x30) && (ipa1 <= 0x3c)) ||
> > +            (ipa1 == 0x5f) ||
> > +            (ipa1 == 0x74) ||
> > +            (ipa1 == 0x76)) {
> 
> Just make this a switch. You can the also use defines for the instruction names :).

I thought I could get away with ranges, but the I/O instructions are
unfortunately too dispersed. I'll change that to a switch and see how
that looks.

> 
> Alex
> 
> > +            ret = 1;
> > +        }
> > +        break;
> > +    case 0xb9:
> > +        if (ipa1 == 0x9c) {
> > +            ret = 1;
> > +        }
> > +        break;
> > +    case 0xeb:
> > +        if (ipb == 0x8a) {
> > +            ret = 1;
> > +        }
> > +        break;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static int handle_priv(CPUS390XState *env, struct kvm_run *run,
> > +                       uint8_t ipa0, uint8_t ipa1)
> > {
> >     int r = 0;
> >     uint16_t ipbh0 = (run->s390_sieic.ipb & 0xffff0000) >> 16;
> > +    uint8_t ipb = run->s390_sieic.ipb & 0xff;
> > 
> >     dprintf("KVM: PRIV: %d\n", ipa1);
> >     switch (ipa1) {
> > @@ -361,8 +490,16 @@ static int handle_priv(CPUS390XState *env, struct kvm_run *run, uint8_t ipa1)
> >             r = kvm_sclp_service_call(env, run, ipbh0);
> >             break;
> >         default:
> > -            dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
> > -            r = -1;
> > +            if (is_ioinst(ipa0, ipa1, ipb)) {
> > +                r = kvm_handle_css_inst(env, run, ipa0, ipa1, ipb);
> > +                if (r == -1) {
> > +                    setcc(env, 3);
> > +                    r = 0;
> > +                }
> > +            } else {
> > +                dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
> > +                r = -1;
> > +            }
> >             break;
> >     }
> > 
> > @@ -500,15 +637,17 @@ static int handle_instruction(CPUS390XState *env, struct kvm_run *run)
> > 
> >     dprintf("handle_instruction 0x%x 0x%x\n", run->s390_sieic.ipa, run->s390_sieic.ipb);
> >     switch (ipa0) {
> > -        case IPA0_PRIV:
> > -            r = handle_priv(env, run, ipa1);
> > -            break;
> > -        case IPA0_DIAG:
> > -            r = handle_diag(env, run, ipb_code);
> > -            break;
> > -        case IPA0_SIGP:
> > -            r = handle_sigp(env, run, ipa1);
> > -            break;
> > +    case IPA0_B2:
> > +    case IPA0_B9:
> > +    case IPA0_EB:
> > +        r = handle_priv(env, run, ipa0 >> 8, ipa1);
> > +        break;
> > +    case IPA0_DIAG:
> > +        r = handle_diag(env, run, ipb_code);
> > +        break;
> > +    case IPA0_SIGP:
> > +        r = handle_sigp(env, run, ipa1);
> > +        break;
> >     }
> > 
> >     if (r < 0) {
> > @@ -565,6 +704,38 @@ static int handle_intercept(CPUS390XState *env)
> >     return r;
> > }
> > 
> > +static int handle_tsch(CPUS390XState *env, struct kvm_run *run, int dequeued,
> > +                       uint16_t subchannel_id, uint16_t subchannel_nr,
> > +                       uint32_t io_int_parm, uint32_t io_int_word)
> > +{
> > +    int ret;
> > +
> > +    cpu_synchronize_state(env);
> > +    ret = ioinst_handle_tsch(env, env->regs[1], run->s390_tsch.ipb);
> > +    if (ret >= 0) {
> > +        /* Success; set condition code. */
> > +        setcc(env, ret);
> > +        ret = 0;
> > +    } else if (ret < -1) {
> > +        /*
> > +         * Failure.
> > +         * If an I/O interrupt had been dequeued, we have to reinject it.
> > +         */
> > +        if (dequeued) {
> > +            uint32_t type = ((subchannel_id & 0xff00) << 24) |
> > +                ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
> > +
> > +            kvm_s390_interrupt_internal(env, type,
> > +                                        ((uint32_t)subchannel_id << 16)
> > +                                        | subchannel_nr,
> > +                                        ((uint64_t)io_int_parm << 32)
> > +                                        | io_int_word, 1);
> > +        }
> > +        ret = 0;
> > +    }
> > +    return ret;
> > +}
> > +
> > int kvm_arch_handle_exit(CPUS390XState *env, struct kvm_run *run)
> > {
> >     int ret = 0;
> > @@ -576,6 +747,13 @@ int kvm_arch_handle_exit(CPUS390XState *env, struct kvm_run *run)
> >         case KVM_EXIT_S390_RESET:
> >             qemu_system_reset_request();
> >             break;
> > +        case KVM_EXIT_S390_TSCH:
> > +            ret = handle_tsch(env, run, run->s390_tsch.dequeued,
> > +                              run->s390_tsch.subchannel_id,
> > +                              run->s390_tsch.subchannel_nr,
> > +                              run->s390_tsch.io_int_parm,
> > +                              run->s390_tsch.io_int_word);
> > +            break;
> >         default:
> >             fprintf(stderr, "Unknown KVM exit: %d\n", run->exit_reason);
> >             break;
> > @@ -601,3 +779,45 @@ int kvm_arch_on_sigbus(int code, void *addr)
> > {
> >     return 1;
> > }
> > +
> > +int kvm_s390_io_interrupt(CPUS390XState *env, uint16_t subchannel_id,
> > +                          uint16_t subchannel_nr, uint32_t io_int_parm,
> > +                          uint32_t io_int_word)
> > +{
> > +    uint32_t type;
> > +
> > +    if (!kvm_enabled()) {
> > +        return -EOPNOTSUPP;
> > +    }
> > +
> > +    type = ((subchannel_id & 0xff00) << 24) |
> > +        ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
> > +    kvm_s390_interrupt_internal(env, type,
> > +                                ((uint32_t)subchannel_id << 16) | subchannel_nr,
> > +                                ((uint64_t)io_int_parm << 32) | io_int_word, 1);
> > +    return 0;
> > +}
> > +
> > +int kvm_s390_crw_mchk(CPUS390XState *env)
> > +{
> > +    if (!kvm_enabled()) {
> > +        return -EOPNOTSUPP;
> > +    }
> > +
> > +    kvm_s390_interrupt_internal(env, KVM_S390_MCHK, 1 << 28,
> > +                                0x00400f1d40330000, 1);
> > +    return 0;
> > +}
> > +
> > +void kvm_s390_enable_css_support(CPUS390XState *env)
> > +{
> > +    struct kvm_enable_cap cap = {};
> > +    int r;
> > +
> > +    /* Activate host kernel channel subsystem support. */
> > +    if (kvm_enabled()) {
> > +        cap.cap = KVM_CAP_S390_CSS_SUPPORT;
> > +        r = kvm_vcpu_ioctl(env, KVM_ENABLE_CAP, &cap);
> > +        assert(r == 0);
> > +    }
> > +}
> > -- 
> > 1.7.12.4
> > 
> 
