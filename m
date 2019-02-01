Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Fri, 1 Feb 2019 17:12:27 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20190131170653.spnrxsiblkssleyd@linutronix.de>
Message-Id: <20190201161227.GG3770@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 31, 2019 at 06:06:53PM +0100, Sebastian Sewior wrote:
> On 2019-01-31 17:52:28 [+0100], Heiko Carstens wrote:
> > ...nevertheless Stefan and I looked through the lovely disassembly of
> > _pthread_mutex_lock_full() to verify if the compiler barriers are
> > actually doing what they are supposed to do. The generated code
> > however does look correct.
> > So, it must be something different.
> 
> would it make sense to use one locking function instead all three (lock,
> try-lock, timed) in the test case to figure out if this is related to
> one of the locking function?

I tried all three variants, but it seems to be close to impossible to
re-create then. I had a single fail when using only the trylock
variant, but I wouldn't say that means anything.

Only if all three variants run in parallel it seems to be quite
reliably reproducible, even though sometimes it still takes an hour.
