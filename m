Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 14:03:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190129103557.GF28485@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris> <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 29 Jan 2019, Peter Zijlstra wrote:

> On Tue, Jan 29, 2019 at 11:24:09AM +0100, Heiko Carstens wrote:
> 
> > Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
> > patch. And now I am trying to reproduce with linux-next 20190129 +
> > your patch and it doesn't trigger. Did I miss a patch which is only in
> > linux-next which could fix this?
> > 
> 
> I'm forever confused on what patch is where; but -ESRCH makes me thing
> maybe you lost this one:
> 
> ---
> 
> commit da791a667536bf8322042e38ca85d55a78d3c273
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Mon Dec 10 14:35:14 2018 +0100

That's in Linus tree already ...
