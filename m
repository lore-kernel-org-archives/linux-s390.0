Return-Path: <linux-kernel-owner+w=401wt.eu-S1752369AbZCLHvA@vger.kernel.org>
Date: Thu, 12 Mar 2009 08:50:34 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
In-Reply-To: <1236823066.7680.178.camel@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.0903120849270.29264@localhost.localdomain>
References: <200903080230.10099.elendil@planet.nl>  <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>  <200903111703.41663.elendil@planet.nl>  <1236817822.7680.148.camel@localhost.localdomain>  <1236818863.7680.156.camel@localhost.localdomain>
  <alpine.LFD.2.00.0903120201040.29264@localhost.localdomain> <1236823066.7680.178.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Frans Pop <elendil@planet.nl>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Mar 2009, john stultz wrote:
> Maybe a different way of expressing what we're calculating is the
> following:
> 
> xtime.tv_nsec = (clock->xtime_nsec + (1<<clock->shift)) >> clock->shift
> clock->xtime_nsec = (1<<clock->shift) 
> 			- (clock->xtime_nsec &((1<<clock->shift)-1)
> 
> In other words: The rounded up portion - the masked remainder in
> xtime_nsec.
> 
> Does that make sense?

Yes, now that my brain works again. I knew I was missing something.

You are definitely right: math _is_ hard :)

    tglx
