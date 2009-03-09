Return-Path: <linux-kernel-owner+w=401wt.eu-S1753805AbZCIPn1@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.29-rc7,s390] System goes into endless loop during boot or logon
Date: Mon, 9 Mar 2009 16:43:11 +0100
References: <200903080835.14032.elendil@planet.nl> <200903090253.34173.elendil@planet.nl> <1236587118.8389.20.camel@laptop>
In-Reply-To: <1236587118.8389.20.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903091643.13803.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-s390@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Monday 09 March 2009, Peter Zijlstra wrote:
> On Mon, 2009-03-09 at 02:53 +0100, Frans Pop wrote:
> > Follow-up to an issue reported on the linux-s390 list, seen in the
> > Hercules S/390 emulator.
> >
> > On Sunday 08 March 2009, Frans Pop wrote:
> > > Well, not quite. It does boot successfully and I do get a login
> > > prompt. I can also login on the console or connect with SSH, but in
> > > both cases the system again gets into some loop before I actually
> > > get a shell prompt.
> >
> > During the bisection series the system would sometimes enter the loop
> > during the boot procedure, before I tried to logon. After it enters
> > the loop one processor just goes racing at 100%.
>
> Where? Do you have NMI watchdog output, or even sysrq-t?

Hmmm. Your commit log message for ca109491f612aab5c8152207631c0444f63da97f 
does explicitly mention the risk of an infinite loop, as does a comment 
in hrtimer_enqueue_reprogram().

Any chance the cause is there? Any way to test for that?

Cheers,
FJP
