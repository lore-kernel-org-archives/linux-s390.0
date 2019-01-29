Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 14:23:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
 <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris>
 <20190129103557.GF28485@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de>
Message-Id: <20190129132303.GE26906@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 29, 2019 at 02:03:01PM +0100, Thomas Gleixner wrote:
> On Tue, 29 Jan 2019, Peter Zijlstra wrote:
> 
> > On Tue, Jan 29, 2019 at 11:24:09AM +0100, Heiko Carstens wrote:
> > 
> > > Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
> > > patch. And now I am trying to reproduce with linux-next 20190129 +
> > > your patch and it doesn't trigger. Did I miss a patch which is only in
> > > linux-next which could fix this?
> > > 
> > 
> > I'm forever confused on what patch is where; but -ESRCH makes me thing
> > maybe you lost this one:
> > 
> > ---
> > 
> > commit da791a667536bf8322042e38ca85d55a78d3c273
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Mon Dec 10 14:35:14 2018 +0100
> 
> That's in Linus tree already ...

Yes, for some reason it's hardly reproducible now. It did hit once
after an hour, but (of course) without tracing enabled... still
trying.
