Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 13:55:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PREEMPT-RT] [PATCH] s390/cpum_sf: Remove superfluous SMP
 function call
Message-ID: <20160405115543.GE6890@osiris>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160405115129.GE30124@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: rcochran@linutronix.de
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 05, 2016 at 01:51:29PM +0200, rcochran@linutronix.de wrote:
> On Tue, Apr 05, 2016 at 01:36:38PM +0200, Heiko Carstens wrote:
> > On Tue, Apr 05, 2016 at 01:23:36PM +0200, Heiko Carstens wrote:
> > > Subsequently, in this case, the setup_pmc_cpu() call will be executed on
> > > the wrong cpu.
> > 
> > .. or to illustrate this behaviour: the following patch (white space
> > damaged due to copy-paste) results in the following:
> 
> I guess you are missing the following commit?
> 
> 
> commit 1cf4f629d9d246519a1e76c021806f2a51ddba4d
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Fri Feb 26 18:43:39 2016 +0000
> 
>     cpu/hotplug: Move online calls to hotplugged cpu

No. It's included. I'm using latest Linus' master tree with git head being
1e1e5ce78ff0 "Merge tag 'linux-kselftest-4.6-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest"

# uname -a
Linux p2345007 4.6.0-rc2-00042-g1e1e5ce78ff0-dirty #3 SMP PREEMPT Tue Apr 5 13:30:02 CEST 2016 s390x s390x s390x GNU/Linux
