Return-Path: <linux-kernel-owner+w=401wt.eu-S1761138AbZCTTRT@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.29-rc7,s390] SOLVED -- System goes into endless loop during boot or logon
Date: Fri, 20 Mar 2009 20:17:00 +0100
References: <200903080835.14032.elendil@planet.nl> <200903080853.10704.elendil@planet.nl> <200903090253.34173.elendil@planet.nl>
In-Reply-To: <200903090253.34173.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903202017.01888.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Monday 09 March 2009, Frans Pop wrote:
> Follow-up to an issue reported on the linux-s390 list, seen in the
> Hercules S/390 emulator.
>
> On Sunday 08 March 2009, Frans Pop wrote:
> > Well, not quite. It does boot successfully and I do get a login
> > prompt. I can also login on the console or connect with SSH, but in
> > both cases the system again gets into some loop before I actually get
> > a shell prompt.
>
> During the bisection series the system would sometimes enter the loop
> during the boot procedure, before I tried to logon. After it enters the
> loop one processor just goes racing at 100%.
>
> I've bisected this to the following set of three patches:
> commit ca109491f612aab5c8152207631c0444f63da97f
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Tue Nov 25 12:43:51 2008 +0100
>     hrtimer: removing all ur callback modes
> commit 37810659ea7d9572c5ac284ade272f806ef8f788
>     hrtimer: removing all ur callback modes, fix hotplug
> commit a0a99b227da57f81319dd239bc4de811b0f530ec
>     hrtimer: removing all ur callback modes, fix
>
> I've not tried to bisect between these patches as the last two are
> fixes. If needed I can do though.

Just for the record, this issue was solved with the following commit (that 
also fixed the hang I saw during boot with 2.6.28):

commit 4fa81ed27781a12f6303b9263056635ae74e3e21
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed Mar 18 13:27:32 2009 +0100
    [S390] __div64_31 broken for CONFIG_MARCH_G5
