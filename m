Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-9-pasha.tatashin@oracle.com> <ddda16df-cca6-8b9d-6f66-6ff5ecc21a03@redhat.com>
In-Reply-To: <ddda16df-cca6-8b9d-6f66-6ff5ecc21a03@redhat.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 18 Jul 2018 09:33:36 -0400
Message-ID: <CAGM2reY_uf2C2ox4kEmTSuSDm1PbXazTYHuT4shYiZ3WK3vTdQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/25] x86/kvmclock: Avoid TSC recalibration
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: pbonzini@redhat.com
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

Thank you Paolo for letting me know. I will remove this patch from the
series, or it can be removed by whomever adds the series.

Thank you,
Pavel
On Wed, Jul 18, 2018 at 7:14 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/07/2018 04:21, Pavel Tatashin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > If the host gives us a TSC rate, assume it is good and don't try and
> > recalibrate things against virtual timer hardware.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  arch/x86/kernel/kvmclock.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> > index ed170171fe49..da0ede8ac8f6 100644
> > --- a/arch/x86/kernel/kvmclock.c
> > +++ b/arch/x86/kernel/kvmclock.c
> > @@ -141,7 +141,16 @@ static inline void kvm_sched_clock_init(bool stable)
> >   */
> >  static unsigned long kvm_get_tsc_khz(void)
> >  {
> > -     return pvclock_tsc_khz(this_cpu_pvti());
> > +     unsigned long tsc_khz = pvclock_tsc_khz(this_cpu_pvti());
> > +
> > +     /*
> > +      * TSC frequency is reported by the host; calibration against (virtual)
> > +      * HPET/PM-timer in a guest is dodgy and pointless since the host
> > +      * already did it for us where required.
> > +      */
> > +     setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +
> > +     return tsc_khz;
> >  }
> >
> >  static void kvm_get_preset_lpj(void)
> >
>
> This patch (really a similar one) has just been sent to Linus.
>
> Paolo
