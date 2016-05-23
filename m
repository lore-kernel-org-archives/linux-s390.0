Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 May 2016 15:29:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: siginfo memory leak?
Message-ID: <20160523152921.11bf49d9@mschwide>
In-Reply-To: <20160523130538.GR2278@dhcp22.suse.cz>
References: <20160523111630.GN2278@dhcp22.suse.cz>
	<20160523144319.7579e75f@mschwide>
	<20160523130538.GR2278@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, LKML <linux-kernel@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 23 May 2016 15:05:38 +0200
Michal Hocko <mhocko@kernel.org> wrote:

> On Mon 23-05-16 14:43:19, Martin Schwidefsky wrote:
> > On Mon, 23 May 2016 13:16:30 +0200
> [...]
> > > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > > index 791a4146052c..41913fac14e4 100644
> > > --- a/arch/s390/mm/fault.c
> > > +++ b/arch/s390/mm/fault.c
> > > @@ -248,6 +248,7 @@ static noinline void do_sigsegv(struct pt_regs *regs, int si_code)
> > >  	si.si_signo = SIGSEGV;
> > >  	si.si_code = si_code;
> > >  	si.si_addr = (void __user *)(regs->int_parm_long & __FAIL_ADDR_MASK);
> > > +	si.si_errno = 0;
> > >  	force_sig_info(SIGSEGV, &si, current);
> > >  }
> > > 
> > 
> > The other for place where s390 calls force_sig_info are correct.
> > Only do_sigsegv misses the clear of si_errno.
> 
> I can send a full patch with the proper changelog but I am really
> wondering whether we can plug this in a more systematic way. If you
> prefer a small s390 specific I will do it right away though. Same
> applies to x86 one.

Why not fix the bug with a small patch and then provide the "big"
solution? A potential information leak is not good ..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
