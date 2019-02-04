Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 4 Feb 2019 12:40:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
 <20190131165228.GA32680@osiris>
 <20190131170653.spnrxsiblkssleyd@linutronix.de>
 <20190201161227.GG3770@osiris>
 <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
 <20190202091043.GA3381@osiris>
 <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
 <20190202112006.GB3381@osiris>
 <alpine.DEB.2.21.1902031718170.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902031718170.8200@nanos.tec.linutronix.de>
Message-Id: <20190204114009.GA3687@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Feb 03, 2019 at 05:30:39PM +0100, Thomas Gleixner wrote:
> On Sat, 2 Feb 2019, Heiko Carstens wrote:
> > I added a barrier between those two and now the code looks like this:
> > 
> > 140:   a5 1b 00 01             oill    %r1,1
> > 144:   e3 10 a0 e0 00 24       stg     %r1,224(%r10)
> > 14a:   e5 48 a0 f0 00 00       mvghi   240(%r10),0
> > 
> > Looks like this was a one instruction race...
> 
> Fun. JFYI, I said that I reversed the stores in glibc and on my x86 test VM
> it took more than _3_ days to trigger. But the good news is, that the trace
> looks exactly like the ones you provided. So it looks we are on the right
> track.
> 
> > I'll try to reproduce with the patch below (sprinkling compiler
> > barriers just like the other files have).
> 
> Looks about right.

The test case now runs since two days without failures. So it looks like you
found the bug! Thank you for debugging this!

My glibc patch missed at lease one place where I should have added another
barrier, but the current version was good enough for the test case ;)

Stefan Liebler is kind enough to take care that this will be fixed in glibc.

Thanks!
