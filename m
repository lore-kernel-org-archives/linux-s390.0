Return-Path: <linux-kernel-owner+w=401wt.eu-S1755463AbZCRPjv@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
From: John Stultz <johnstul@us.ibm.com>
In-Reply-To: <20090318102825.32c821f3@skybase>
References: <200903080230.10099.elendil@planet.nl>
	 <1236817822.7680.148.camel@localhost.localdomain>
	 <1236818863.7680.156.camel@localhost.localdomain>
	 <200903121805.48041.elendil@planet.nl>
	 <1237343170.6160.131.camel@localhost> <1237344897.6160.136.camel@localhost>
	 <20090318102825.32c821f3@skybase>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 08:39:18 -0700
Message-Id: <1237390758.32698.4.camel@jstultz-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Frans Pop <elendil@planet.nl>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-03-18 at 10:28 +0100, Martin Schwidefsky wrote:
> On Tue, 17 Mar 2009 19:54:57 -0700
> john stultz <johnstul@us.ibm.com> wrote:
> 
> > Martin: I'm not sure if the problem here is the __div64_32
> > implementation or if the emulator is doing something wrong here. Might
> > need some help from you in sorting this out.
> 
> __div64_31 is incorrect. Patch and description see below.
> 
> How long did you debug this until you finally got down to div64 as the
> cause of this? It must have taken you hours!

:) Yea, not counting s390 environment ramp up. 

Thanks for the quick turnaround on the fix!

-john
